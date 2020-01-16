@echo off

for %%i in (*.dat) do for /F "tokens=1*" %%j in ('find "" "%%i"') do echo """pISInterface->RemoveTopLevelObject("%%k");""" >>__RemoveTLO.txt