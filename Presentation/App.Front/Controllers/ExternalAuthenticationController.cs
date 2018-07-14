using App.Front.Models;
using App.Service.Authentication.External;
using System.Collections.Generic;
using System.Web.Mvc;
using System.Web.Routing;

namespace App.Front.Controllers
{
    public class ExternalAuthenticationController : Controller
    {
        private readonly IOpenAuthenticationService _openAuthenticationService;

        public ExternalAuthenticationController(IOpenAuthenticationService openAuthenticationService)
        {
            _openAuthenticationService = openAuthenticationService;
        }
        public ActionResult ExternalMethods()
        {
            var model = new List<ExternalAuthenticationMethodModel>();

            foreach (var eam in _openAuthenticationService.LoadActiveExternalAuthenticationMethods())
            {
                var eamModel = new ExternalAuthenticationMethodModel();

                string actionName;
                string controllerName;
                RouteValueDictionary routeValues;
                eam.Value.GetPublicInfoRoute(out actionName, out controllerName, out routeValues);
                eamModel.ActionName = actionName;
                eamModel.ControllerName = controllerName;
                eamModel.RouteValues = routeValues;

                model.Add(eamModel);
            }

            return PartialView(model);
        }
    }
}