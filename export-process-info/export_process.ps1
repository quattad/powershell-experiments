###
# Exports information about the processes running on the current machine and exports them into a CSV file
# We only want 
# 1) name, process ID, number of CPUs and number of handles
# 2) Handles > 100, organized in ascending order
###

# Works
Get-Process | `
Select-Object Name, Id, @{name='CPU'; expression={$_.TotalProcessorTime}}, Handles | `
Where Handles -ge 1000 | `
Sort-Object -property Handles | `
Select-Object Name, Id, CPU, Handles | `
Export-Csv -Path result.csv -Append -NoTypeInformation