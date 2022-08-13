# .SYNOPSIS
# Inititalize the repository

Param(
    # The name of the new solution
    [Parameter(Mandatory = $true)]
    [string]$Name,

    # Use central package management (still in preview)
    [Parameter]
    [bool]$UseCentralPackageManagement = $false
)

Rename-Item -Path ./NetProject.sln -NewName $Name
Get-ChildItem -Recurse -Force *.csproj | ForEach-Object { dotnet sln remove $_ }

Remove-Item -Force -Recurse  .\src\NetProject
Remove-Item -Force -Recurse  .\src\WebApp

Remove-Item -Force -Recurse  .\tests\NetProject.Tests
Remove-Item -Force -Recurse  .\tests\WebApp.Tests

if (-not $UseCentralPackageManagement) {
    Remove-Item .\Directory.Packages.props
}

#Remove-Item -Force -Recurse .git
