del *.tgz /s /q
del *.tar /s /q

cd fhir.tx.support\fhir.tx.support.r2 
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..
pause

cd fhir.tx.support\fhir.tx.support.r3 
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..
pause

cd fhir.tx.support\fhir.tx.support.r4 
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..
pause

cd fhir.test.data\fhir.test.data.r2 
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..
pause

cd fhir.test.data\fhir.test.data.r3 
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..
pause

cd fhir.test.data\fhir.test.data.r4 
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..
pause

cd hl7.fhir.rX\hl7.fhir.r2.core
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..
pause

cd hl7.fhir.rX\hl7.fhir.r2.elements
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..
pause

cd hl7.fhir.rX\hl7.fhir.r2.examples
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..
pause

cd hl7.fhir.rX\hl7.fhir.r2.expansions
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..
pause

cd hl7.fhir.rX\hl7.fhir.r2b.core
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..
pause

cd hl7.fhir.rX\hl7.fhir.r2b.examples
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..
pause

cd hl7.fhir.rX\hl7.fhir.r2b.expansions
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..
pause

cd hl7.fhir.rX\hl7.fhir.r3.core
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..
pause

cd hl7.fhir.rX\hl7.fhir.r3.elements
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..
pause

cd hl7.fhir.rX\hl7.fhir.r3.examples
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..
pause

cd hl7.fhir.rX\hl7.fhir.r3.expansions
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..
pause

cd hl7.fhir.rX\hl7.fhir.r4.core
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..
pause

cd hl7.fhir.rX\hl7.fhir.r4.elements
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..
pause

cd hl7.fhir.rX\hl7.fhir.r4.examples
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..
pause

cd hl7.fhir.rX\hl7.fhir.r4.expansions
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..

pause

del *.tar /s /q

xcopy fhir.test.data\*.tgz upload\fhir.test.data /S
xcopy fhir.tx.support\*.tgz upload\fhir.tx.support /S
xcopy hl7.fhir.rX\*.tgz upload\hl7.fhir.rX /S

pause