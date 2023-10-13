
import xml.etree.ElementTree as ET
from itertools import product
import sys
import json

def parse_xml(file_path):
    tree = ET.parse(file_path)
    root = tree.getroot()

    pcs_tables = []
    for pcsTable in root.findall('pcsTable'):
        table_data = {
            "prefix": [],
            "rows": []
        }

        for axis in pcsTable.findall('axis'):
            axis_data = {
                "title": axis.find('title').text,
                "label": None
            }
            for label in axis.findall('label'):
                if axis_data["label"] != None:
                    raise "Unexpected label count"
                axis_data["label"] = {
                    "code": label.attrib['code'],
                    "label": label.text
                }
            table_data["prefix"].append(axis_data)

        for pcsRow in pcsTable.findall('pcsRow'):
            row_data = {
                "axes": []
            }

            for axis in pcsRow.findall('axis'):
                axis_data = {
                    "title": axis.find('title').text,
                    "labels": []
                }
                for label in axis.findall('label'):
                    axis_data["labels"].append({
                        "code": label.attrib['code'],
                        "label": label.text
                    })
                row_data["axes"].append(axis_data)

            table_data["rows"].append(row_data)

        pcs_tables.append(table_data)

    return pcs_tables

def generate_codes_and_displays(pcs_tables):
    for table in pcs_tables:
        prefix_code = "".join([axis["label"]["code"] for axis in table["prefix"]])
        table["prefix_code"] = prefix_code
        #print(table)
        display_table = [{"title": level["title"], "label": level["label"]["label"]} for level in table["prefix"]]
        for row in table["rows"]:
            cartesian_product = product(*[axis["labels"] for axis in row["axes"]])
            row_codes = [table["prefix_code"] + "".join([item["code"] for item in combo]) for combo in cartesian_product]
            row["codes"] = row_codes
            row["displays"] = []
            cartesian_product = product(*[axis["labels"] for axis in row["axes"]])
            for combo in cartesian_product:
                display = display_table + [{"title": axis["title"], "label": label["label"]} for axis, label in zip(row["axes"], combo)]
                row["displays"].append(display)

def concepts(pcs_tables):
    for table in pcs_tables:
        for row in table["rows"]:
            for code, display in zip(row["codes"], row["displays"]):
                concept = {
                    "display": ", ".join([f"{d['title']}={d['label']}" for d in display]),
                    "code": code
                }
                yield concept

if __name__ == "__main__":
    template = json.load(open("template.json"))
    print(template["url"])
    pcs_tables = parse_xml("icd10pcs_tables_2023.xml")
    generate_codes_and_displays(pcs_tables)
    template['concept'] = [x for x in concepts(pcs_tables)]
    json.dump(template, open("CodeSystem-icd10PCS.json", "w"), indent=2)
