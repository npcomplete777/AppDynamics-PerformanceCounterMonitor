@echo off
mode con:cols=140
powershell.exe set-executionpolicy unrestricted
powershell.exe C:\MA5\MachineAgent\monitors\PerformanceCounterMonitor\getCounters.ps1
