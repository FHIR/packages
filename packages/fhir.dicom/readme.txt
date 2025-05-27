The DICOM package is build by a conversion process. 
The process is:
* download the current DICOM release from ftp://medical.nema.org/MEDICAL/Dicom/Resources once the release is announced to an empty local directory
* run the java class org.hl7.fhir.convertors.misc.DicomPackageBuilder with the following parameters: 
  1. the local folder 
  2. your local folder for https://github.com/FHIR/packages/tree/master/packages/fhir.dicom
* make an entry in the dicom package-list.json file for the new release (and don't forget to remove the current label from the last release)
* now follow the standard release process for the packages repo
