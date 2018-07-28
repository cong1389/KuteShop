using System;

namespace App.Core.Plugins
{
    [AttributeUsage(AttributeTargets.Class, AllowMultiple = false, Inherited = false)]
    public class DependentWidgetsAttribute : Attribute
    {
        public DependentWidgetsAttribute(params string[] widgetSystemNames)
        {
            WidgetSystemNames = widgetSystemNames;
        }

        public string[] WidgetSystemNames { get; private set; }
    }
}
