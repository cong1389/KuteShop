using App.Core.Plugins.Providers;
using System.Web.Routing;

namespace App.Service.Authentication.External
{
    public partial interface IExternalAuthenticationMethod : IProvider, IUserEditable
    {
        /// <summary>
        /// Gets a route for displaying plugin in public store
        /// </summary>
        /// <param name="actionName">Action name</param>
        /// <param name="controllerName">Controller name</param>
        /// <param name="routeValues">Route values</param>
        void GetPublicInfoRoute(out string actionName, out string controllerName, out RouteValueDictionary routeValues);
    }
}
