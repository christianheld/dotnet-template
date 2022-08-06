# INSERT PROJECT NAME HERE
Introduction. What Problem is being solved by this project.


## Template Details
This Project has been created from a template and comes with opnionated configuration.

The project layout is inspired by David Fowler's famous [.NET Project Structure](https://gist.github.com/davidfowl/ed7564297c61fe9ab814) gist.

### Configuration files
This template contains explicit and opinionated configuration files, adjust or delete as needded

* Explicit `global.json`, `nuget.config`
* Central Package Versioning with `Directory.Packages.config` (Remove for project based versions)
* `Directory.Build.props` and `tests/Directory.Build.props` for cross-project configuration

### Autmatic versioning
This project uses [GitVersion](https://gitversion.net/) in *Mainline* mode. Both local tool and
MSBuild taks are included in the package.

> WARNING:
> 
> **GitFlow**: If you use GitFlow then make sure run `dotnet gitversion init` and update the `GitVersion.yaml`
> accordingly
> 
> **Mainline**: Do not set the `next-version` property in mainline mode. Use `git tag` instead to 
> pin versions



## Getting Started

### Requirements
.NET 6

### Build instructions
* How to build and run the project?
