# AppDynamics-PerformanceCounterMonitor
AppDynamics standalone machine agent extension for Windows performance counters

This document instructs one on using the Performance Counter Monitor standalone machine agent extension in order to push performance counter metrics from a server for display in the AppDynamics metric browser as a custom metric.

Requirements:
Windows PowerShell 2.0+
Standalone machine agent from AppDynamics https://download.appdynamics.com

1. Download the standalone machine agent.  Unzip the file and configure host, port, application, tier, and node names, and SSL flag (Optional).  Full instructions:
https://docs.appdynamics.com/display/PRO40/Install+the+Standalone+Machine+Agent

2. Copy the PerformanceCounterMonitor folder to <MACHINE_AGENT_PATH>\monitors folder.

3. Choose which performance counters you want.  To get a full list of all performance counters available use:

(Get-Counter -ListSet *).paths

Note: Not all counters listed will have metrics.  Verify the counter path before adding to counterList.txt by running 

Get-counter “<COUNTER_PATH>”

For example:
Get-counter “\Processor(_Total)\% Processor Time”

If this command returns values with no exceptions, then it is safe to use in counterList.txt. 

4. Add the counters to counterList.txt.  Each line should contain a single performance counter path with no quotations.  counterList.txt contains 3 example counters.  Save counterList.txt.

4. Open and edit the file configureCounters.ps1.  Change the .txt file path to reflect the path of counterList.txt in PerformanceCounterMonitor folder to reflect its new location and save the file:
$memoryCounterPaths=get-content c:\ma5\MachineAgent\monitors\PerformanceCounterMonitor\counterList.txt

5. Open and edit startPowershell.bat.  Set the execution policy to allow startPowershell.bat to launch a Powershell command prompt.  The default is 
powershell.exe set-executionpolicy unrestricted

For more on execution policies, see
https://technet.microsoft.com/en-us/library/ee176961.aspx?f=255&MSPPError=-2147217396

Set the path to getCounters.ps1 and save the file.  The default is:
powershell.exe C:\MA5\MachineAgent\monitors\PerformanceCounterMonitor\getCounters.ps1

7. Run the startPowershell.bat and confirm metrics are reported with no exceptions.

8. Start the machine agent.
Java –jar <PATH_TO_MACHINE_AGENT_JAR>

9. Verify metrics are reporting in metric browser Analyze -> Metric Browser under Application Infrastructure Performance | <TIER_NAME> | Custom Metrics | <your_path>
It could take up to 5 minutes for values to first appear.

Note: once the metric path is created in the metric browser, there is no way to remove it, so be sure of the metric paths you want to use.

For a full list of performance counters, consult the documentation –
https://msdn.microsoft.com/en-us/library/w8f5kw2e(v=VS.80).aspx

Note: There are additional parameters you can specify in the last line beginning with “write-output... that control custom metric rollup.  The Controller has various qualifiers for how it processes a metric with regard to aggregation, time rollup and tier rollup.
 See sections on “Aggregation qualifier”, “time roll-up qualifier”, and “Cluster roll-up qualifier” for details:

https://docs.appdynamics.com/display/PRO40/Build+a+Monitoring+Extension+Using+Scripts

Any questions can be sent to 
aaron.jacobs@appdynamics.com
