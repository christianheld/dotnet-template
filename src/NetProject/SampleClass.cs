namespace NetProject;

/// <summary>
/// This is an example class.
/// </summary>
public class SampleClass
{
    private readonly string _name;

    /// <summary>
    /// Initializes a new instance of the <see cref="SampleClass"/> class.
    /// </summary>
    /// <param name="name">The name for the greeting.</param>
    public SampleClass(string name)
    {
        _name = name;
    }

    /// <summary>
    /// Gets the greeting text.
    /// </summary>
    /// <returns>The greeting text.</returns>
    public string Greeting => $"Hello, {_name}";
}
