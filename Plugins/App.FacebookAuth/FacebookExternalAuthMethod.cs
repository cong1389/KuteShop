using App.Core.Plugins;
using App.Service.Authentication.External;
using System.Web.Routing;

namespace App.FacebookAuth
{
    public class FacebookExternalAuthMethod : BasePlugin, IExternalAuthenticationMethod, IConfigurable
    {
        public FacebookExternalAuthMethod()
        {
        }

        public static string SystemName => "App.FacebookAuth";

        public void GetConfigurationRoute(out string actionName, out string controllerName, out RouteValueDictionary routeValues)
        {
            actionName = "Configure";
            controllerName = "ExternalAuthFacebook";
            routeValues = new RouteValueDictionary(new { Namespaces = "App.FacebookAuth.Controllers", area = SystemName });
        }

        public void GetPublicInfoRoute(out string actionName, out string controllerName, out RouteValueDictionary routeValues)
        {
            actionName = "PublicInfo";
            controllerName = "ExternalAuthFacebook";
            routeValues = new RouteValueDictionary(new { Namespaces = "App.FacebookAuth.Controllers", area = SystemName });
        }

        /// <summary>
        /// Install plugin
        /// </summary>
        public override void Install()
        {
            base.Install();
        }

        public override void Uninstall()
        {
            base.Uninstall();
        }
    }
}