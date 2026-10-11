# .NET Template
This is my personal, opinionated template for new .NET projects.

## Configuration files
* Explicit `global.json`, `nuget.config`
* `Directory.Build.props` and `tests/Directory.Build.props` for cross-project configuration
* `Directory.Packages.props` with [CPM}(https://learn.microsoft.com/en-us/nuget/consume-packages/central-package-management) disabled, because the .NET templates do not play well with CPM, yet. Turn on CPM once you have established the .NET projects.

## Testing
The `Cake.cs` Script is prepared for [XUnit v3](https://xunit.net/docs/getting-started/v3/getting-started) with MTP enabled.
You need to install following additional extension packages for the build script:
- Microsoft.Testing.Extensions.CodeCoverage
- Microsoft.Testing.Extensions.TrxReport

## Versioning
This project comes with [Nerdbank.GitVersioning](https://github.com/dotnet/Nerdbank.GitVersioning/)
for automatic versioning.

## Getting Started
Run `init.ps1` to rename solution and remove sample code

```ps
.\init.ps1 -Name SolutionName
```
