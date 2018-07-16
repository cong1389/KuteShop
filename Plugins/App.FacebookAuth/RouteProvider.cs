using App.Framework.Routing;
using System.Web.Mvc;
using System.Web.Routing;

namespace App.FacebookAuth
{
    public class RouteProvider : IRouteProvider
    {
        public void RegisterRoutes(RouteCollection routes)
        {
            routes.MapRoute("App.FacebookAuth",
                    "Plugins/App.FacebookAuth/{action}",
                    new { controller = "ExternalAuthFacebook" },
                    new[] { "App.FacebookAuth.Controllers" }
                )
                .DataTokens["area"] = FacebookExternalAuthMethod.SystemName;
        }

        public int Priority { get; } = 0;
    }
}