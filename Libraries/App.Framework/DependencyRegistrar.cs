using System;
using System.Linq;
using App.Core.Extensions;
using App.Core.Infrastructure;
using App.Core.Infrastructure.DependencyManagement;
using App.Core.Plugins;
using App.Core.Plugins.Providers;
using App.Core.Utilities;
using App.Framework.Ioc;
using App.Framework.Plugins;
using App.Service.Authentication.External;
using App.Service.Cms;
using App.Service.ShippingMethods;
using Autofac;
using Autofac.Builder;
using Autofac.Integration.Mvc;

namespace App.Framework
{
    public class DependencyRegistrar : IDependencyRegistrar
    {
        public virtual void Register(ContainerBuilder builder, ITypeFinder typeFinder, bool isActiveModule)
        {
            // plugins
            var pluginFinder = new PluginFinder();
            builder.RegisterInstance(pluginFinder).As<IPluginFinder>().SingleInstance();
            builder.RegisterType<PluginMediator>();

            builder.RegisterModule(new WebModule(typeFinder));
            builder.RegisterModule(new ProvidersModule(typeFinder, pluginFinder));

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

    public class ProvidersModule : Module
    {
        private readonly ITypeFinder _typeFinder;
        private readonly IPluginFinder _pluginFinder;

        public ProvidersModule(ITypeFinder typeFinder, IPluginFinder pluginFinder)
        {
            _typeFinder = typeFinder;
            _pluginFinder = pluginFinder;
        }

        protected override void Load(ContainerBuilder builder)
        {
            builder.RegisterType<ProviderManager>().As<IProviderManager>().InstancePerRequest();

            //if (!DataSettings.DatabaseIsInstalled())
            //    return;

            var providerTypes = _typeFinder.FindClassesOfType<IProvider>(ignoreInactivePlugins: true).ToList();

            foreach (var type in providerTypes)
            {
                var pluginDescriptor = _pluginFinder.GetPluginDescriptorByAssembly(type.Assembly);
                var groupName = ProviderTypeToKnownGroupName(type);
                var systemName = GetSystemName(type, pluginDescriptor);
                var friendlyName = GetFriendlyName(type, pluginDescriptor);
                var displayOrder = GetDisplayOrder(type, pluginDescriptor);
                var dependentWidgets = GetDependentWidgets(type);
                var resPattern = (pluginDescriptor != null ? "Plugins" : "Providers") + ".{1}.{0}"; // e.g. Plugins.FriendlyName.MySystemName
                var settingPattern = (pluginDescriptor != null ? "Plugins" : "Providers") + ".{0}.{1}"; // e.g. Plugins.MySystemName.DisplayOrder
                var isConfigurable = typeof(IConfigurable).IsAssignableFrom(type);
                var isEditable = typeof(IUserEditable).IsAssignableFrom(type);
                var isHidden = GetIsHidden(type);
                //var exportFeature = GetExportFeature(type);

                var registration = builder.RegisterType(type).Named<IProvider>(systemName).InstancePerRequest().PropertiesAutowired(PropertyWiringOptions.None);
                registration.WithMetadata<ProviderMetadata>(m =>
                {
                    m.For(em => em.PluginDescriptor, pluginDescriptor);
                    m.For(em => em.GroupName, groupName);
                    m.For(em => em.SystemName, systemName);
                    m.For(em => em.ResourceKeyPattern, resPattern);
                    m.For(em => em.SettingKeyPattern, settingPattern);
                    m.For(em => em.FriendlyName, friendlyName.Item1);
                    m.For(em => em.Description, friendlyName.Item2);
                    m.For(em => em.DisplayOrder, displayOrder);
                    m.For(em => em.DependentWidgets, dependentWidgets);
                    m.For(em => em.IsConfigurable, isConfigurable);
                    m.For(em => em.IsEditable, isEditable);
                    m.For(em => em.IsHidden, isHidden);
                    //m.For(em => em.ExportFeatures, exportFeature);
                });

                // register specific provider type
                RegisterAsSpecificProvider<IShippingRateComputationMethod>(type, systemName, registration);
                RegisterAsSpecificProvider<IExternalAuthenticationMethod>(type, systemName, registration);
            }
        }

        private bool GetIsHidden(Type type)
        {
            var attr = type.GetAttribute<IsHiddenAttribute>(false);
            if (attr != null)
            {
                return attr.IsHidden;
            }

            return false;
        }

        private string[] GetDependentWidgets(Type type)
        {
            if (!typeof(IWidget).IsAssignableFrom(type))
            {
                // don't let widgets depend on other widgets
                var attr = type.GetAttribute<DependentWidgetsAttribute>(false);
                if (attr != null)
                {
                    return attr.WidgetSystemNames;
                }
            }

            return new string[] { };
        }

        private int GetDisplayOrder(Type type, PluginDescriptor descriptor)
        {
            var attr = type.GetAttribute<DisplayOrderAttribute>(false);
            if (attr != null)
            {
                return attr.DisplayOrder;
            }

            if (typeof(IPlugin).IsAssignableFrom(type) && descriptor != null)
            {
                return descriptor.DisplayOrder;
            }

            return 0;
        }

        private Tuple<string/*Name*/, string/*Description*/> GetFriendlyName(Type type, PluginDescriptor descriptor)
        {
            string name = null;
            string description = name;

            var attr = type.GetAttribute<FriendlyNameAttribute>(false);
            if (attr != null)
            {
                name = attr.Name;
                description = attr.Description;
            }
            else if (typeof(IPlugin).IsAssignableFrom(type) && descriptor != null)
            {
                name = descriptor.FriendlyName;
                description = descriptor.Description;
            }
            else
            {
                name = Inflector.Titleize(type.Name);
                //throw Error.Application("The 'FriendlyNameAttribute' must be applied to a provider type if the provider does not implement 'IPlugin' (provider type: {0}, plugin: {1})".FormatInvariant(type.FullName, descriptor != null ? descriptor.SystemName : "-"));
            }

            return new Tuple<string, string>(name, description);
        }

        private string GetSystemName(Type type, PluginDescriptor descriptor)
        {
            var attr = type.GetAttribute<SystemNameAttribute>(false);
            if (attr != null)
            {
                return attr.Name;
            }

            if (typeof(IPlugin).IsAssignableFrom(type) && descriptor != null)
            {
                return descriptor.SystemName;
            }

            return type.FullName;
            //throw Error.Application("The 'SystemNameAttribute' must be applied to a provider type if the provider does not implement 'IPlugin' (provider type: {0}, plugin: {1})".FormatInvariant(type.FullName, descriptor != null ? descriptor.SystemName : "-"));
        }

        private string ProviderTypeToKnownGroupName(Type implType)
        {
            if (typeof(IShippingRateComputationMethod).IsAssignableFrom(implType))
            {
                return "Shipping";
            }
            else if (typeof(IExternalAuthenticationMethod).IsAssignableFrom(implType))
            {
                return "Security";
            }


            return null;
        }

        private void RegisterAsSpecificProvider<T>(Type implType, string systemName, IRegistrationBuilder<object, ConcreteReflectionActivatorData, SingleRegistrationStyle> registration) where T : IProvider
        {
            if (typeof(T).IsAssignableFrom(implType))
            {
                try
                {
                    registration.As<T>().Named<T>(systemName);
                    registration.WithMetadata<ProviderMetadata>(m =>
                    {
                        m.For(em => em.ProviderType, typeof(T));
                    });
                }
                catch (Exception) { }
            }
        }
    }

}
