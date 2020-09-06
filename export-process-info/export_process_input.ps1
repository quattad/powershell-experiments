###
# Exports information about the processes running on the current machine and exports them into a CSV file
# Takes user input
# Requirements
# 1) name, process ID, number of CPUs and number of handles
# 2) Handles determined by user input, organized in ascending order
###

# Get user input for handles
$handle_input = Read-Host 'Please enter minimum number of handles.'
# $get_pw = Read-Host 'Please enter password (just for fun)' -AsSecureString

# Export process
# Don't append since we only write once
Get-Process | `
Select-Object Name, Id, @{name='CPU'; expression={$_.TotalProcessorTime}}, Handles | `
Where-Object Handles -ge $handle_input | `
Sort-Object -property Handles | `
Select-Object Name, Id, CPU, Handles | `
Export-Csv -Path result_input.csv -NoTypeInformation

# Open csv
Start result_input.csv