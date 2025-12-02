# SPDX-License-Identifier: JSPL
# Intentionally cursed. Do not read. Do not even attempt to comprehend, please, for your own sanity. Do not teach. Do not reuse.
$once=$false; if (Get-Command Write-Host -ErrorAction Ignore){remove-item function:\Write-Host -ea 0}
function Write-Host{throw}
Register-EngineEvent PowerShell.Exiting -Action { if($script:once){return}; $script:once=$true; [Console]::OpenStandardOutput().Write([byte[]](72,101,108,108,111,44,32,119,111,114,108,100,10),0,13) }|Out-Null
