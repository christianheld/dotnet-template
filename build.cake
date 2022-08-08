#tool "nuget:?package=ReportGenerator&version=5.1.9"

///////////////////////////////////////////////////////////////////////////////
// ARGUMENTS
///////////////////////////////////////////////////////////////////////////////

var target = Argument("target", "Default");
var configuration = Argument("configuration", "Release");

var dotNetVerbosity = DotNetVerbosity.Minimal;
var msBuildSettings = new DotNetMSBuildSettings()
        .SetMaxCpuCount(0);

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

Task("Compile")
    .IsDependentOn("RestorePackages")
    .Does(() =>
{
    DotNetBuild(
        "./NetProject.sln",
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
      "./NetProject.sln",
      new DotNetTestSettings
      {
         Configuration = configuration,
         NoRestore = true,
         NoBuild = true,
         Verbosity = dotNetVerbosity,
         Collectors = { "XPlat Code Coverage" }
      }
   );

   ReportGenerator(
        new GlobPattern("./tests/**/TestResults/**/*.xml"),
        "./artifacts/TestResults");
});


Task("Default")
   .IsDependentOn("CleanArtifacts")
   .IsDependentOn("Test");

RunTarget(target);