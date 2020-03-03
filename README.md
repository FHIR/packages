# FHIR packages

This repository contains the source for a nunber of FHIR packages 
the provide important implementation time support for FHIR implementers:

## Core FHIR Packages 

These packages are the master source for the FHIR NPM packages that 
represent the base FHIR specification

* ```hl7.fhir.core``` - wrapper package for the core specification, has multiple versions
* ```hl7.fhir.r[X].core``` - The base resources needed for validation, code generation etc. 
* ```hl7.fhir.r[X].corexml``` - The base resources in XML format instead of JSON (all the other packages have json)
* ```hl7.fhir.r[X].examples``` - All the examples in the spec (including all the core resources, with narrative)
* ```hl7.fhir.r[X].elements``` - A set of data element definitions for all the resources in the spec
* ```hl7.fhir.r[X].expansions``` - expansions for all the value sets used as enumerations in the spec - to help with code generation

All these packages are found under /hl7.fhir.rX

## Version Interconversion Packages

A set of resources that support implementers converting resources across versions.

* conversion - Resource and Search Parameter name mappings
* r3 - maps between R2 and R3 (both directions)
* r4 - maps between R3 and R4 (both directions)

All these resources are found under /interversion. They are distributed in the
packages ```hl7.fhir.xver.r4``` and ```hl7.fhir.xver.r3``` (both contain the same content, 
but in different FHIR versions)

The folder /packages also contains the source for ```hl7.fhir.xver-extensions```, a special package
that contains the source to allow the validator to validate cross-version extensions, as 
described in the R4 specification.

## Miscellaneous Packages

* ```fhir.test.data.r[X]``` - Contains useful test data (synthetic data from Synthea)
* ```fhir.tx.support.r[X]```- Contains useful support terminology resources for terminology servers
* ```hl7.fhir.pubpack``` - Special package that contains the images and other binary files used in FHIR Implementation Guides

These packages are in /packages

## Release Process

Pull requests are welcome. Updated versions of these packages are released in NPM by the 
FHIR Product Director. The core packages are under the authority of the FMG
