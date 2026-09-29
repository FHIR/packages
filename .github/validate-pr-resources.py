#!/usr/bin/env python3
"""
Validate the FHIR resources changed in a PR with the HL7 Java validator.

For each added/modified file that is a FHIR resource (JSON with a resourceType,
or XML in the http://hl7.org/fhir namespace), find the package it belongs to
(nearest ancestor folder with a package.json), take the FHIR version from that
package.json, and validate all changed files in the package in one validator run,
with the package itself loaded as an IG so that cross-references resolve.

Usage:
  validate-pr-resources.py --validator validator_cli.jar --base <git-ref> [--head HEAD]
  validate-pr-resources.py --validator validator_cli.jar file-or-folder ...

Exit code is 1 if any error/fatal issues are reported, 0 otherwise.
When run under GitHub Actions, issues are emitted as annotations on the PR files
and a table is written to the job summary.
"""

import argparse
import json
import os
import re
import subprocess
import sys
import tempfile
from collections import defaultdict

REPO = os.path.abspath(os.getcwd())
NOT_RESOURCES = {"package.json", ".index.json", "package-list.json", "package-lock.json"}
# Packages that *are* the core spec - they're loaded by -version, don't load them again as an IG
CORE_PKG = re.compile(r"^(@hl7/)?hl7\.fhir\.(core|r[0-9b]+\.[a-z0-9]+)$")
GH = os.environ.get("GITHUB_ACTIONS") == "true"


def changed_files(base, head):
    out = subprocess.run(
        ["git", "diff", "--name-only", "--diff-filter=ACMR", "-z", base, head],
        check=True, capture_output=True, text=True).stdout
    return [f for f in out.split("\0") if f]


def is_resource(path):
    name = os.path.basename(path)
    if name in NOT_RESOURCES or not os.path.isfile(path):
        return False
    if name.endswith(".json"):
        try:
            with open(path, encoding="utf-8-sig") as f:
                d = json.load(f)
            return isinstance(d, dict) and "resourceType" in d
        except Exception:
            return True  # broken JSON - let the validator report it
    if name.endswith(".xml"):
        with open(path, "rb") as f:
            head = f.read(4096).decode("utf-8", "ignore")
        head = re.sub(r"<\?.*?\?>|<!--.*?-->", "", head, flags=re.S)
        m = re.search(r"<([A-Za-z][\w.]*)[^>]*>", head)
        return bool(m) and 'xmlns="http://hl7.org/fhir"' in m.group(0)
    return False


def find_package(path):
    d = os.path.dirname(os.path.abspath(path))
    while d.startswith(REPO) and d != REPO:
        if os.path.isfile(os.path.join(d, "package.json")):
            return d
        d = os.path.dirname(d)
    return None


def package_info(pkgdir):
    with open(os.path.join(pkgdir, "package.json"), encoding="utf-8-sig") as f:
        pj = json.load(f)
    versions = pj.get("fhirVersions") or []
    v = versions[0] if versions else None
    if not v:
        for dep, dv in (pj.get("dependencies") or {}).items():
            if re.match(r"^hl7\.fhir\.(r[0-9b]+\.)?core$", dep):
                v = dv
                break
    if v and "-" not in v:
        v = ".".join(v.split(".")[:2])  # 5.0.1 -> 5.0: let the validator pick the release
    return pj.get("name", "?"), v


def gh_escape(s, prop=False):
    s = s.replace("%", "%25").replace("\r", "%0D").replace("\n", "%0A")
    if prop:
        s = s.replace(":", "%3A").replace(",", "%2C")
    return s


def ext(el, url):
    for e in el.get("extension", []):
        if e.get("url", "").endswith(url):
            for k, val in e.items():
                if k.startswith("value"):
                    return val
    return None


def run_group(jar, pkgdir, name, version, files, outdir, summary):
    rel = os.path.relpath(pkgdir, REPO)
    print(f"\n::group::Validate {len(files)} file(s) in {rel} ({name}, FHIR {version})" if GH
          else f"\n=== {rel} ({name}, FHIR {version}): {len(files)} file(s)")
    out = os.path.join(outdir, re.sub(r"[^\w.-]", "_", rel) + ".json")
    cmd = ["java", os.environ.get("VALIDATOR_XMX", "-Xmx6g"), "-jar", jar, "-version", version]
    if not CORE_PKG.match(name):
        cmd += ["-ig", rel]
    if os.path.isfile(os.path.join(REPO, "advisor.txt")):
        cmd += ["-advisor-file", "advisor.txt"]
    cmd += ["-output", out] + files
    print(" ".join(cmd), flush=True)
    rc = subprocess.run(cmd).returncode
    if GH:
        print("::endgroup::")

    if not os.path.isfile(out):
        print(f"::error::Validator failed (exit {rc}) for {rel} - no output produced" if GH
              else f"ERROR: validator failed (exit {rc}) for {rel}")
        for f in files:
            summary.append((f, "-", "-", "-", "validator did not run"))
        return 1

    with open(out, encoding="utf-8") as fh:
        res = json.load(fh)
    oos = [e["resource"] for e in res.get("entry", [])] if res.get("resourceType") == "Bundle" else [res]
    total_errors = 0
    for oo in oos:
        fname = ext(oo, "operationoutcome-file") or (files[0] if len(files) == 1 else "?")
        counts = defaultdict(int)
        for iss in oo.get("issue", []):
            sev = iss.get("severity", "information")
            counts[sev] += 1
            msg = (iss.get("details") or {}).get("text") or iss.get("diagnostics") or ""
            loc = ", ".join(iss.get("expression") or iss.get("location") or [])
            line = ext(iss, "operationoutcome-issue-line")
            col = ext(iss, "operationoutcome-issue-col")
            if sev in ("error", "fatal") or (sev == "warning" and GH):
                if GH:
                    level = "error" if sev in ("error", "fatal") else "warning"
                    props = f"file={gh_escape(fname, True)}"
                    if line:
                        props += f",line={line}"
                    if col:
                        props += f",col={col}"
                    props += f",title={gh_escape('FHIR ' + sev + (': ' + loc if loc else ''), True)}"
                    print(f"::{level} {props}::{gh_escape(msg)}")
                elif sev in ("error", "fatal"):
                    print(f"  {sev.upper()} {fname}:{line or '?'} {loc}: {msg}")
        errs = counts["error"] + counts["fatal"]
        total_errors += errs
        summary.append((fname, errs, counts["warning"], counts["information"],
                        "❌" if errs else "✅"))
    return 1 if total_errors else 0


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--validator", required=True, help="path to validator_cli.jar")
    ap.add_argument("--base", help="git ref to diff against (e.g. the PR base commit)")
    ap.add_argument("--head", default="HEAD")
    ap.add_argument("--output-dir", default=None)
    ap.add_argument("files", nargs="*")
    a = ap.parse_args()

    jar = os.path.abspath(a.validator)
    cands = []
    for f in a.files:
        if os.path.isdir(f):
            for root, _, names in os.walk(f):
                cands += [os.path.join(root, n) for n in names]
        else:
            cands.append(f)
    if a.base:
        cands += changed_files(a.base, a.head)

    groups = defaultdict(list)
    skipped = []
    bad_pkgs = set()
    for f in sorted(set(cands)):
        if not is_resource(f):
            continue
        pkg = find_package(f)
        if not pkg:
            skipped.append((f, "not inside a package (no package.json)"))
            continue
        try:
            name, version = package_info(pkg)
        except Exception as e:
            bad_pkgs.add(os.path.relpath(pkg, REPO))
            skipped.append((f, f"cannot read {os.path.relpath(pkg, REPO)}/package.json: {e}"))
            continue
        if not version:
            skipped.append((f, f"no FHIR version in {os.path.relpath(pkg, REPO)}/package.json"))
            continue
        groups[(pkg, name, version)].append(os.path.relpath(os.path.abspath(f), REPO))

    for f, why in skipped:
        print(f"::warning file={gh_escape(f, True)}::Not validated: {why}" if GH
              else f"SKIP {f}: {why}")

    for p in sorted(bad_pkgs):
        print(f"::error file={gh_escape(p, True)}/package.json::package.json is not valid" if GH
              else f"ERROR: {p}/package.json is not valid")

    if not groups:
        print("No changed FHIR resources to validate.")
        write_summary([], skipped)
        return 1 if bad_pkgs else 0

    outdir = os.path.abspath(a.output_dir or tempfile.mkdtemp(prefix="fhir-val-"))
    os.makedirs(outdir, exist_ok=True)
    summary = []
    failed = 1 if bad_pkgs else 0
    for (pkg, name, version), files in sorted(groups.items()):
        failed |= run_group(jar, pkg, name, version, files, outdir, summary)

    write_summary(summary, skipped)
    print(f"\nValidation output in {outdir}")
    return failed


def write_summary(rows, skipped):
    path = os.environ.get("GITHUB_STEP_SUMMARY")
    lines = ["## FHIR validation of changed resources", ""]
    if rows:
        lines += ["| | File | Errors | Warnings | Info |", "|---|---|---|---|---|"]
        lines += [f"| {st} | `{f}` | {e} | {w} | {i} |" for f, e, w, i, st in rows]
    else:
        lines.append("No changed FHIR resources in this PR.")
    if skipped:
        lines += ["", "**Not validated:**", ""] + [f"- `{f}`: {why}" for f, why in skipped]
    text = "\n".join(lines) + "\n"
    if path:
        with open(path, "a", encoding="utf-8") as fh:
            fh.write(text)
    else:
        print("\n" + text)


if __name__ == "__main__":
    sys.exit(main())