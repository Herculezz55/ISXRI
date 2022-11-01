
for %%i in (*.dat) do for /F "tokens=1*" %%j in ('find "" "%%i"') do (
>> __AddTLO.txt (
echo """if (tlo == "%%k")"""
echo """  pISInterface->AddTopLevelObject("%%k", TLO_%%~nk);"""
)
)