<#
.Synopsis
   Creates a TOC for GitHub markdown docs
.DESCRIPTION
   To create the TOC first copy the raw markdown code 
   from the edit window in github and paste it into the 
   MarkDownDoc parameter this will then look for header2
   (for example: ## HeaderName) lines and create the TOC 
   at the top of the MD Doc this will then be added to 
   the paste buffer. You would then paste this into the 
   Github window and commit the changes to see the result.
.PARAMETER MarkDownDoc
   This takes the multi-line string that you copy from the 
   GitHub markdown raw code and creates the TOC from this.
.EXAMPLE
   New-MDTOC 
   This will prompt you for the markdown document
.NOTES
   General notes
     Created by: Brent Denny
     Created on: 28 Apr 2020
#>
param (
  [Parameter(Mandatory=$true)]
  [string]$MarkDownDoc
)
$MarkDownArray = $MarkDownDoc -split "`n"
$Headers = $MarkDownArray | Where-Object {$_ -match '##'}
Write-Output "# Table Of Contents" | Set-Clipboard
$Headers.trim('## ') -replace '(.+)','[$1](#$1)<BR>' -replace '(?<=\(\#.*)\s','-' | Set-Clipboard -Append
$MarkDownDoc | Set-Clipboard -Append
Write-Host -ForegroundColor Cyan "The Table of contents is in the Paste buffer now"

