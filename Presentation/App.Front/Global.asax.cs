using System;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using App.Aplication;
using App.Core.Infrastructure;
using App.Framework.FluentValidation;
using App.Framework.Mappings;
using App.Framework.Routing;
using App.Framework.Theme;
using FluentValidation.Mvc;

namespace App.Front
{
    public class MvcApplication : HttpApplication
    {
        protected void Application_Start()
        {
            // Initialize engine context
            EngineContext.Initialize(false);

            Bootstrapper.Run();

            // Remove all view engines
            ViewEngines.Engines.Clear();

            // register our themeable razor view engine we use
            ViewEngines.Engines.Add(new ThemeableRazorViewEngine());

            ModelBinders.Binders.Add(typeof(DateTime), new DateTimeModelBinder());
            ModelBinders.Binders.Add(typeof(DateTime?), new DateTimeModelBinder());

            // Fluent validation
            FluentValidationModelValidatorProvider.Configure(provider => provider.ValidatorFactory = new FluentValidationConfig());

            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);

            // register AutoMapper class maps
            AutoMapperConfiguration.Configure();
        }

        private static void RegisterRoutes(RouteCollection routes, IEngine engine)
        {
            // register routes (core, admin, plugins, etc)
            var routePublisher = engine.Resolve<RoutePublisher>();
            routePublisher.RegisterRoutes(routes);
        }
    }
}
