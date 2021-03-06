﻿using App.Core.Infrastructure;
using App.Core.Infrastructure.DependencyManagement;
using App.FacebookAuth.Core;
using Autofac;

namespace App.FacebookAuth
{
    public class DependencyRegistrar : IDependencyRegistrar
    {
        public virtual void Register(ContainerBuilder builder, ITypeFinder typeFinder, bool isActiveModule)
        {
            builder.RegisterType<FacebookProviderAuthorizer>().As<IOAuthProviderFacebookAuthorizer>().InstancePerRequest();
        }

        public int Order => 1;
    }
}