using System.Web.Mvc;
using System.Web.Routing;
using SmartStore.Web.Framework.Routing;

namespace App.GoogleAnalytics
{
    public partial class RouteProvider : IRouteProvider
    {
        public void RegisterRoutes(RouteCollection routes)
        {
            routes.MapRoute("App.GoogleAnalytics",
                 "Plugins/App.GoogleAnalytics/{action}",
                 new { controller = "WidgetsGoogleAnalytics", action = "Configure" },
                 new[] { "App.GoogleAnalytics.Controllers" }
            )
			.DataTokens["area"] = "App.GoogleAnalytics";
        }

        public int Priority
        {
            get
            {
                return 0;
            }
        }
    }
}
