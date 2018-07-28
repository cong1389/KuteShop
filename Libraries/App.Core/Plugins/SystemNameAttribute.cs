using System;

namespace App.Core.Plugins
{
    [AttributeUsage(AttributeTargets.Class, AllowMultiple = false, Inherited = false)]
    public sealed class SystemNameAttribute : Attribute
    {
        public SystemNameAttribute(string name)
        {
            Name = name;
        }

        public string Name { get; set; }
    }
}
