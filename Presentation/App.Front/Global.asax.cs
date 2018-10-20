using System;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using App.Aplication;
using App.Core.Data;
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
            bool installed = DataSettings.DatabaseIsInstalled();

            if (installed)
            {
                //Remove all view engines
                ViewEngines.Engines.Clear();
            }
            // Initialize engine context
            EngineContext.Initialize(false);

            ModelBinders.Binders.Add(typeof(DateTime), new DateTimeModelBinder());
            ModelBinders.Binders.Add(typeof(DateTime?), new DateTimeModelBinder());

            // Register MVC areas
            AreaRegistration.RegisterAllAreas();

            //Bootstrapper.Run();

            // Fluent validation
            FluentValidationModelValidatorProvider.Configure(provider => provider.ValidatorFactory = new FluentValidationConfig());
            
            //if (installed)
            //{
                // register our themeable razor view engine we use
                ViewEngines.Engines.Add(new ThemeableRazorViewEngine());

                // Global filters
                RegisterGlobalFilters();

                RegisterClassMaps();
            //}
        }

        public static void RegisterClassMaps()
        {
            // register AutoMapper class maps
            AutoMapperConfiguration.Configure();
        }

        public static void RegisterGlobalFilters()
        {
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
        }

        private static void RegisterRoutes(RouteCollection routes, IEngine engine)
        {
            // register routes (core, admin, plugins, etc)
            var routePublisher = engine.Resolve<RoutePublisher>();
            routePublisher.RegisterRoutes(routes);
        }
    }
}
