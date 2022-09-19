# .SYNOPSIS
# Inititalize the repository

Param(
    # The name of the new solution
    [Parameter(Mandatory = $true)]
    [string] $SolutionName,

    # The project type, used for dotent new
    [Parameter(Mandatory = $true)]
    [string] $ProjectType,

    [Parameter(Mandatory = $true)]
    [string] $ProjectName
)


Get-ChildItem -Recurse -Force *.csproj | ForEach-Object { dotnet sln remove $_ }

Remove-Item -Force -Recurse  .\src\NetProject
Remove-Item -Force -Recurse  .\src\WebApp

Remove-Item -Force -Recurse  .\tests\NetProject.Tests
Remove-Item -Force -Recurse  .\tests\WebApp.Tests

$solution = "$SolutionName.sln"
Rename-Item -Path ./NetProject.sln -NewName $solution

mkdir ".\src\$ProjectName"
mkdir ".\tests\$ProjectName.Tests"

Push-Location ".\src\$ProjectName"
dotnet new $ProjectType
Pop-Location

Push-Location ".\tests\$ProjectName.Tests"
dotnet new xunit
dotnet add reference "..\..\src\$ProjectName"
Pop-Location

Get-ChildItem -Recurse *.csproj | ForEach-Object { dotnet sln add $_ }

$cakeScript = Get-Content .\build.cake
$cakeScript = $cakeScript.Replace(
    'string solution = "NetProject.sln";', 
    "string solution = ""$solution"".sln;");

$cakeScript | Out-File "build.cake" -Encoding utf8NoBOM

# Remove-Item .\init.ps1

Write-Output "Commit changes to git to complete initialization."