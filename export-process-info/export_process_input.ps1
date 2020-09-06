<#
.SYNOPSIS
Exports information about the processes running on the current machine and exports them into a CSV file
.DESCRIPTION
Outputs name, process ID, number of CPUs and number of handles
Handles determined by user input, organized in ascending order
.PARAMETER handle
Minimum number of handles required
#>

# Export processes by prompting for user input for handles
# $handle_input = Read-Host 'Please enter minimum number of handles.'

# Get-Process | `
# Select-Object Name, Id, @{name='CPU'; expression={$_.TotalProcessorTime}}, Handles | `
# Where-Object Handles -ge $handle_input | `
# Sort-Object -property Handles | `
# Select-Object Name, Id, CPU, Handles | `
# Export-Csv -Path result_input.csv -NoTypeInformation

# Export processes by prompting for user input via parameter
Param(
    [Parameter(Mandatory=$true)][string]$handle_input
)
Get-Process | `
Select-Object Name, Id, @{name='CPU'; expression={$_.TotalProcessorTime}}, Handles | `
Where-Object Handles -ge $handle_input | `
Sort-Object -property Handles | `
Select-Object Name, Id, CPU, Handles | `
Export-Csv -Path result_input.csv -NoTypeInformation

# Open csv
Start result_input.csv