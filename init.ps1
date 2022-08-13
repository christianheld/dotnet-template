# .SYNOPSIS
# Inititalize the repository

Param(
    # The name of the new solution
    [Parameter(Mandatory = $true)]
    [string] $Name,

    # Use central package management (still in preview)
    [Parameter]
    [switch] $UseCentralPackageManagement
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


if (-not $UseCentralPackageManagement) {
    Remove-Item .\Directory.Packages.props

    $buildPropsFile = (Get-Item .\Directory.Build.props).FullName
    [xml]$buildProps = Get-Content $buildPropsFile
    $buildProps.DocumentElement.ItemGroup.PackageReference.SetAttribute("Version", "5.10.3")
    $buildProps.Save($buildPropsFile) 
}

Remove-Item .\init.ps1

Write-Output "Commit changes to git to complete initialization."