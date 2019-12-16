del *.tgz /s /q
del *.tar /s /q

"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other xml
"C:\Program Files\7-Zip\7z.exe" a -tgzip package.tgz package.tar

del *.tar /s /q

pause