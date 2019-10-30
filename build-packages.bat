del *.tgz /s /q
del *.tar /s /q

cd fhir.tx.support\fhir.tx.support.r2 
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..

cd fhir.tx.support\fhir.tx.support.r3 
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..

cd fhir.tx.support\fhir.tx.support.r4 
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..

cd fhir.test.data\fhir.test.data.r2 
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..

cd fhir.test.data\fhir.test.data.r3 
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..

cd fhir.test.data\fhir.test.data.r4 
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar
cd ..\..

cd hl7.fhir.rX\hl7.fhir.r2.core
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip hl7.fhir.r2.core.tgz package.tar
cd ..\..

cd hl7.fhir.rX\hl7.fhir.r2.elements
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip hl7.fhir.r2.elements.tgz package.tar
cd ..\..

cd hl7.fhir.rX\hl7.fhir.r2.examples
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip hl7.fhir.r2.examples.tgz package.tar
cd ..\..

cd hl7.fhir.rX\hl7.fhir.r2.expansions
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip hl7.fhir.r2.expansions.tgz package.tar
cd ..\..

cd hl7.fhir.rX\hl7.fhir.r2b.core
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip hl7.fhir.r2b.core.tgz package.tar
cd ..\..

cd hl7.fhir.rX\hl7.fhir.r2b.examples
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip hl7.fhir.r2b.examples.tgz package.tar
cd ..\..

cd hl7.fhir.rX\hl7.fhir.r2b.expansions
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip hl7.fhir.r2b.expansions.tgz package.tar
cd ..\..

cd hl7.fhir.rX\hl7.fhir.r3.core
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip hl7.fhir.r3.core.tgz package.tar
cd ..\..

cd hl7.fhir.rX\hl7.fhir.r3.elements
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip hl7.fhir.r3.elements.tgz package.tar
cd ..\..

cd hl7.fhir.rX\hl7.fhir.r3.examples
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip hl7.fhir.r3.examples.tgz package.tar
cd ..\..

cd hl7.fhir.rX\hl7.fhir.r3.expansions
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip hl7.fhir.r3.expansions.tgz package.tar
cd ..\..

cd hl7.fhir.rX\hl7.fhir.r4.core
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip hl7.fhir.r4.core.tgz package.tar
cd ..\..

cd hl7.fhir.rX\hl7.fhir.r4.elements
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip hl7.fhir.r4.elements.tgz package.tar
cd ..\..

cd hl7.fhir.rX\hl7.fhir.r4.examples
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip hl7.fhir.r4.examples.tgz package.tar
cd ..\..

cd hl7.fhir.rX\hl7.fhir.r4.expansions
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip hl7.fhir.r4.expansions.tgz package.tar
cd ..\..


del *.tar /s /q

xcopy fhir.test.data\*.tgz upload\fhir.test.data /S
xcopy fhir.tx.support\*.tgz upload\fhir.tx.support /S
copy hl7.fhir.rX\hl7.fhir.r2.core\hl7.fhir.r2.core.tgz upload\hl7.fhir.r2
copy hl7.fhir.rX\hl7.fhir.r2.examples\hl7.fhir.r2.examples.tgz upload\hl7.fhir.r2
copy hl7.fhir.rX\hl7.fhir.r2.elements\hl7.fhir.r2.elements.tgz upload\hl7.fhir.r2
copy hl7.fhir.rX\hl7.fhir.r2.expansions\hl7.fhir.r2.expansions.tgz upload\hl7.fhir.r2

copy hl7.fhir.rX\hl7.fhir.r2b.core\hl7.fhir.r2b.core.tgz upload\hl7.fhir.r2b
copy hl7.fhir.rX\hl7.fhir.r2b.examples\hl7.fhir.r2b.examples.tgz upload\hl7.fhir.r2b
copy hl7.fhir.rX\hl7.fhir.r2b.expansions\hl7.fhir.r2b.expansions.tgz upload\hl7.fhir.r2b

copy hl7.fhir.rX\hl7.fhir.r3.core\hl7.fhir.r3.core.tgz upload\hl7.fhir.r3
copy hl7.fhir.rX\hl7.fhir.r3.examples\hl7.fhir.r3.examples.tgz upload\hl7.fhir.r3
copy hl7.fhir.rX\hl7.fhir.r3.elements\hl7.fhir.r3.elements.tgz upload\hl7.fhir.r3
copy hl7.fhir.rX\hl7.fhir.r3.expansions\hl7.fhir.r3.expansions.tgz upload\hl7.fhir.r3

copy hl7.fhir.rX\hl7.fhir.r4.core\hl7.fhir.r4.core.tgz upload\hl7.fhir.r4
copy hl7.fhir.rX\hl7.fhir.r4.examples\hl7.fhir.r4.examples.tgz upload\hl7.fhir.r4
copy hl7.fhir.rX\hl7.fhir.r4.elements\hl7.fhir.r4.elements.tgz upload\hl7.fhir.r4
copy hl7.fhir.rX\hl7.fhir.r4.expansions\hl7.fhir.r4.expansions.tgz upload\hl7.fhir.r4

pause