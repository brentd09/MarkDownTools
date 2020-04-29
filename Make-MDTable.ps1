Param (
  [Parameter(Mandatory=$true)]
  [int]$NumberOfColumns
)

function New-MarkDownTable {
  Param(
    [string[]]$RawTableData,
    [int]$Columns
  )
  
   $Count = 0
  $Rows = $RawTableData.count / $Columns
  
  foreach ($Row in (0..($Rows-1))) {
    $Start = $Row * $Columns
    $End = $Start + $Columns - 1
    $RawTableData[$Start..$End] -join '|' 
    if ($Row -eq 0) {[string]('---|'*($Columns-1) + '---') }
  }
}

[string[]]$RawTable = (Get-Clipboard) -as [string[]] | Where-Object {$_ -match '\w'}
New-MarkDownTable -RawTableData $RawTable -Columns $NumberOfColumns | Set-Clipboard
"The Table can now be pasted in to the MarkDown document"