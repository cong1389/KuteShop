using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using App.Core.Infrastructure;
using App.Core.Infrastructure.DependencyManagement;
using App.Core.Plugins;
using App.Framework.Ioc;
using App.Framework.Plugins;
using Autofac;
using Autofac.Integration.Mvc;

namespace App.Framework
{
    public class DependencyRegistrar : IDependencyRegistrar
    {
        public virtual void Register(ContainerBuilder builder, ITypeFinder typeFinder, bool isActiveModule)
        {// plugins
            var pluginFinder = new PluginFinder();
            builder.RegisterInstance(pluginFinder).As<IPluginFinder>().SingleInstance();
            builder.RegisterType<PluginMediator>();

            builder.RegisterModule(new WebModule(typeFinder));

            builder.RegisterModule(new EFModule());
            builder.RegisterModule(new RepositoryModule());
            builder.RegisterModule(new IdentityModule());
            builder.RegisterModule(new ServiceModule());

           // builder.RegisterSource(new ViewRegistrationSource());
        }

        public int Order => -100;
    }

    public class WebModule : Module
    {
        private readonly ITypeFinder _typeFinder;

        public WebModule(ITypeFinder typeFinder)
        {
            _typeFinder = typeFinder;
        }

        protected override void Load(ContainerBuilder builder)
        {
            var foundAssemblies = _typeFinder.GetAssemblies(true).ToArray();

            // Filter provider
            builder.RegisterFilterProvider();

            // register all controllers
            builder.RegisterControllers(foundAssemblies);
        }
    }
}
