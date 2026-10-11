[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, Position = 0)]
    [string]
    $SolutionName
)

$solution = "$SolutionName.slnx"

Rename-Item -Path ./Solution.slnx -NewName $solution

$cakeScript = Get-Content -Path ./cake.cs
$cakeScript = $cakeScript.Replace('string solution = "Solution.slnx";', "string solution = $solution;")
$cakeScript | Out-File "./cake.cs" -Encoding utf8NoBOM

mkdir -Force -Path src
mkdir -Force -Path tests

Remove-Item -Force -Recurse ./.git
git init
git add .
git commit -m "Hello, ${SolutionName}!";

Remove-Item ./init.ps1
