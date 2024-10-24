# .NET Template
This is my personal, opinionated template for new .NET projects.

## Template Details
The project layout is inspired by the [.NET Project Structure](https://gist.github.com/davidfowl/ed7564297c61fe9ab814) gist.

### Configuration files
* Explicit `global.json`, `nuget.config`
* `Directory.Build.props` and `tests/Directory.Build.props` for cross-project configuration

### Automatic versioning
This project comes with [Nerdbank.GitVersioning](https://github.com/dotnet/Nerdbank.GitVersioning/)
for automatic versioning.

## Getting Started

Run `init.ps1` to rename solution and remove sample code

```ps
.\init.ps1 -Name SolutionName
```
