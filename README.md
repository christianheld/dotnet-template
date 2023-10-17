# .NET Template
This is my personal, opinionated template for new .NET projects.

## Template Details
The project layout is inspired by the [.NET Project Structure](https://gist.github.com/davidfowl/ed7564297c61fe9ab814) gist.

### Configuration files
* Explicit `global.json`, `nuget.config`
* `Directory.Build.props` and `tests/Directory.Build.props` for cross-project configuration

### Automatic versioning
This project uses [GitVersion](https://gitversion.net/) in *Mainline* mode. Using the MSBuild Task.
GitVersion will also be installed by Cake to display Version in the Setup phase

> WARNING:
> 
> **GitFlow**: If you use GitFlow then make sure run `.\tools\dotnet-gitversion.exe init` or `./tools/dotnet-gitversion init` and update the `GitVersion.yaml`
> accordingly
> 
> **Mainline**: Do not set the `next-version` property in mainline mode. Use `git tag` instead to 
> pin versions

## Getting Started

Run `init.ps1` to rename solution and remove sample code

```ps
.\init.ps1 -SolutionName SolutionName
```
