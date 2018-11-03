using System.Web.Routing;

namespace App.Front.Models
{
    public class ExternalAuthenticationMethodModel
    {
        public string ActionName { get; set; }
        public string ControllerName { get; set; }
        public RouteValueDictionary RouteValues { get; set; }
    }
}