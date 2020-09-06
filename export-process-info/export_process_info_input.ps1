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

# ValueFromPipeline allows parameters to be passed in via pipeline 
# For example, the following creates a report for processes with >= 4000 handles
# "4000" | ./export_process_input

# Alias allows parameters to be recognized by altnerative names

# Write-Verbose will only output if script is run with -verbose parameter

[cmdletbinding()]
Param(
    [Parameter(ValueFromPipeline=$true, Mandatory=$true)][Alias("Handles")][string]$handle_input
)

# Use Write-Verbose to add terminal logs during code execution
Write-Verbose "Generating report..."

Get-Process | `
Select-Object Name, Id, @{name='CPU'; expression={$_.TotalProcessorTime}}, Handles | `
Where-Object Handles -ge $handle_input | `
Sort-Object -property Handles | `
Select-Object Name, Id, CPU, Handles | `
Export-Csv -Path result_input.csv -NoTypeInformation

Write-Verbose "Saving and opening CSV file..."

# Open csv
Start-Process result_input.csv