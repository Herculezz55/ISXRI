@echo off
echo 1> Includes.txt 
for %%a in (*.dat) do (
>> __Includes.txt (
echo """#include "%%~na.h""""
)
)