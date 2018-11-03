using System.Web.Routing;

namespace App.Core.Plugins
{
    public interface IConfigurable
    {
        /// <summary>
        /// Gets a route for provider or plugin configuration
        /// </summary>
        /// <param name="actionName">Action name</param>
        /// <param name="controllerName">Controller name</param>
        /// <param name="routeValues">Route values</param>
        void GetConfigurationRoute(out string actionName, out string controllerName, out RouteValueDictionary routeValues);
    }
}
