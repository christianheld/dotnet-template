# .SYNOPSIS
# Inititalize the repository

Param(
    # The name of the new solution
    [Parameter(Mandatory = $true)]
    [string] $Name
)


Get-ChildItem -Recurse -Force *.csproj | ForEach-Object { dotnet sln remove $_ }

Remove-Item -Force -Recurse  .\src\NetProject
Remove-Item -Force -Recurse  .\src\WebApp

Remove-Item -Force -Recurse  .\tests\NetProject.Tests
Remove-Item -Force -Recurse  .\tests\WebApp.Tests

$solution = "$Name.sln"
Rename-Item -Path ./NetProject.sln -NewName $solution

$cakeScript = Get-Content .\build.cake
$cakeScript = $cakeScript.Replace(
    'string solution = "NetProject.sln";', 
    "string solution = ""$solution"";");

$cakeScript | Out-File "build.cake" -Encoding utf8NoBOM

Remove-Item .\init.ps1

Write-Output "Commit changes to git to complete initialization."