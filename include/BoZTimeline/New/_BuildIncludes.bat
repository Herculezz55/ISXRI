
for %%a in (*.dat) do (
>> __Includes.txt (
echo """#include "%%~na.h""""
)
)