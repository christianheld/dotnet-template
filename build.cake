#tool "dotnet:?package=GitVersion.Tool&version=5.12.0"

///////////////////////////////////////////////////////////////////////////////
// ARGUMENTS
///////////////////////////////////////////////////////////////////////////////

string solution = "NetProject.sln";

var target = Argument("target", "Default");
var configuration = Argument("configuration", "Release");

var dotNetVerbosity = DotNetVerbosity.Minimal;
var msBuildSettings = new DotNetMSBuildSettings()
        .SetMaxCpuCount(0)
        .TreatAllWarningsAs(MSBuildTreatAllWarningsAs.Error)
        .WithArgumentCustomization(args => args.Append("-warnnotaserror:CS0618"));

Setup(context =>
{
    var version = context.GitVersion();

    context.Information($"Solution: {solution}");
    context.Information($"Version:  {version.FullSemVer}");
});

///////////////////////////////////////////////////////////////////////////////
// TASKS
///////////////////////////////////////////////////////////////////////////////

Task("CleanArtifacts")
    .Does(() =>
{
    CleanDirectory("./artifacts");
});

Task("Clean")
   .WithCriteria(c => HasArgument("rebuild"))
   .Does(() => 
{
   var objs = GetDirectories($"./**/obj");
   var bins = GetDirectories($"./**/bin");

   CleanDirectories(objs.Concat(bins));
});

Task("RestorePackages")
    .Does(() =>
{
    DotNetRestore(new DotNetRestoreSettings { Verbosity = dotNetVerbosity });
});

Task("CheckFormatting")
    .Does(() => 
{
    DotNetTool(
        "format", 
        new DotNetToolSettings()
            .WithArgumentCustomization(args => args
                .Append("whitespace")
                .Append("--verify-no-changes")));
});

Task("Compile")
    .IsDependentOn("CheckFormatting")
    .IsDependentOn("RestorePackages")
    .Does(() =>
{
    DotNetBuild(
        solution,
        new DotNetBuildSettings
        {
            Configuration = configuration,
            NoRestore = true,
            Verbosity = dotNetVerbosity,
            MSBuildSettings = msBuildSettings
        });
});

Task("Test")
    .IsDependentOn("Compile")
    .Does(() =>
{
    DotNetTest(
       solution,
       new DotNetTestSettings
       {
          Configuration = configuration,
          NoRestore = true,
          NoBuild = true,
          Verbosity = dotNetVerbosity,
          Collectors = { "XPlat Code Coverage" }
       }
    );
});

Task("Default")
   .IsDependentOn("CleanArtifacts")
   .IsDependentOn("Test");

RunTarget(target);
