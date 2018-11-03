using System.Web.Routing;

namespace App.Framework.Routing
{
    public interface IRouteProvider
    {
        void RegisterRoutes(RouteCollection routes);

        int Priority { get; }
    }
}
