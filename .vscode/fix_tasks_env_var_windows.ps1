Write-Host "Fix environment variables in tasks.json for Windows host OS"

$a = Read-Host -Prompt "Input Git access token"

Write-Host "Git access token =" $a

Write-Host "Workspace path set to parent of current working directory"

$curDir = Get-Location
$b = Split-Path -Parent $curDir
$b = $b | foreach {$_.replace('/','\')}

Write-Host "Workspace path =" $b

$in = Get-Content "tasks.json"
$in | foreach {$_.replace('${GIT_ACCESS_TOKEN}',$a)} | foreach {$_.replace('${config:GIT_ACCESS_TOKEN}',$a)} | Out-File -encoding ASCII "tasks.json"
$in = Get-Content "tasks.json"
$in | foreach {$_.replace('${fileWorkspaceFolder}',$b)} | foreach {$_.replace('${WORKSPACE_PATH}',$b)} | Out-File -encoding ASCII "tasks.json"

Write-Host "File tasks.json fixed"
