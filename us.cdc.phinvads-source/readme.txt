Making new versions of this package:

* delete everything in \source and all value sets in ..\packages\us.cdc.phinvads\package (but not package.json!)
* go to https://phinvads.cdc.gov/vads/SearchVocab.action and then click on Browser all Value Sets
* Download All value sets as text
* Copy all the value sets from the zip into \source
* run /org.hl7.fhir.convertors/src/main/java/org/hl7/fhir/convertors/misc/PhinVadsImporter.java with 2 parameters
    \source 
    ..\packages\us.cdc.phinvads\package 
  (use the full directory names)
* then make a new entry in package-list.json (remove current=true for the last package)
* update the stated package version in ..\packages\us.cdc.phinvads\package\package.json  
* run the package release process

 