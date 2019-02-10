del *.tgz /s /q
del *.tar /s /q

cd fhir.tx.support\1.0.2 
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..

cd fhir.tx.support\3.0.1 
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..

cd fhir.tx.support\4.0.0 
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..

cd fhir.test.data\1.0.2 
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..

cd fhir.test.data\3.0.1 
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..

cd fhir.test.data\4.0.0 
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..

cd hl7.fhir.core\1.0.2 
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..

cd hl7.fhir.core\1.4.0
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..

cd hl7.fhir.core\3.0.1
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..

cd hl7.fhir.core\4.0.0
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..

cd hl7.fhir.core.gen\1.0.2 
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..

cd hl7.fhir.core.gen\1.4.0
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..

cd hl7.fhir.core.gen\3.0.1
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..

cd hl7.fhir.core.gen\4.0.0
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..

del *.tar /s /q

xcopy fhir.test.data\*.tgz upload\fhir.test.data /S
xcopy fhir.tx.support\*.tgz upload\fhir.tx.support /S
xcopy hl7.fhir.core\*.tgz upload\hl7.fhir.core /S
xcopy hl7.fhir.core.gen\*.tgz upload\hl7.fhir.core.gen /S

pause