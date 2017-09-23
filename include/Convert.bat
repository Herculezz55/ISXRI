@echo off
:: %1 is passcode
:: %2 is unencrypted script filename
:: %no is working directory
:: %3 is header/variable name
:: pushd %3
lscrypt -encrypt 3rtZdjv7 "%1.iss" tmp.txt
geninclude tmp.txt %1
del tmp.txt >nul
:: popd
