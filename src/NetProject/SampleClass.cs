namespace NetProject;

/// <summary>
/// This is an example class.
/// </summary>
/// <remarks>
/// Initializes a new instance of the <see cref="SampleClass"/> class.
/// </remarks>
/// <param name="name">The name for the greeting.</param>
internal class SampleClass(string name)
{
    /// <summary>
    /// Gets the greeting text.
    /// </summary>
    /// <returns>The greeting text.</returns>
    public string Greeting => $"Hello, {name}";
}
