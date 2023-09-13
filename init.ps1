#!/usr/bin/env pwsh

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

function RemoveSampleProjects {
    Get-ChildItem -Recurse -Force *.csproj | ForEach-Object { dotnet sln remove $_ }
    
    Remove-Item -Force -Recurse  .\src\NetProject
    Remove-Item -Force -Recurse  .\src\WebApp
    
    Remove-Item -Force -Recurse  .\tests\NetProject.Tests
    Remove-Item -Force -Recurse  .\tests\WebApp.Tests
}

function CleanPackagesProps 
{
    $packageProps = [xml](Get-Content .\Directory.Packages.props)
    $packageProps.Project.RemoveChild($packageProps.Project.ItemGroup[1])
    $packageProps.Save("./Directory.Packages.props")
}

function RenameSolution {
    $solution = "$SolutionName.sln"
    Rename-Item -Path ./NetProject.sln -NewName $solution
    
    $cakeScript = Get-Content .\build.cake
    $cakeScript = $cakeScript.Replace(
        'string solution = "NetProject.sln";', 
        "string solution = ""$solution"";");
    
    $cakeScript | Out-File "build.cake" -Encoding utf8NoBOM
}

function CreateNewProject {
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
}

RemoveSampleProjects
CleanPackagesProps
RenameSolution
CreateNewProject

Remove-Item .\init.ps1

dotnet format

.\build.ps1

Write-Output "Commit changes to git to complete initialization."