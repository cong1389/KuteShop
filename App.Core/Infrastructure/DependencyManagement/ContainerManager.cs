using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using App.Core.ComponentModel;
using App.Core.Extensions;
using Autofac;

namespace App.Core.Infrastructure.DependencyManagement
{
    public class ContainerManager
    {
	    private readonly IContainer _container;
	    private readonly ConcurrentDictionary<Type, FastActivator> _cachedActivators = new ConcurrentDictionary<Type, FastActivator>();

		public ContainerManager(IContainer container)
        {
            _container = container;
        }

        public IContainer Container
        {
            get { return _container; }
        }
        public ILifetimeScope Scope()
        {
            var scope = _container.Resolve<ILifetimeScopeAccessor>().GetLifetimeScope(null);
            return scope ?? _container;
        }

        public bool TryResolve(Type serviceType, ILifetimeScope scope, out object instance)
        {
            instance = null;

            try
            {
                return (scope ?? Scope()).TryResolve(serviceType, out instance);
            }
            catch
            {
                return false;
            }
        }

        public bool TryResolve<T>(ILifetimeScope scope, out T instance)
        {
            instance = default(T);

            try
            {
                return (scope ?? Scope()).TryResolve<T>(out instance);
            }
            catch
            {
                return false;
            }
        }


	    public object ResolveUnregistered(Type type, ILifetimeScope scope = null)
	    {
		    FastActivator activator;
		    object[] parameterInstances = null;

		    if (!_cachedActivators.TryGetValue(type, out activator))
		    {
			    var constructors = type.GetConstructors(BindingFlags.Public | BindingFlags.Instance | BindingFlags.DeclaredOnly);
			    foreach (var constructor in constructors)
			    {
				    var parameterTypes = constructor.GetParameters().Select(p => p.ParameterType).ToArray();
				    if (TryResolveAll(parameterTypes, out parameterInstances, scope))
				    {
					    activator = new FastActivator(constructor);
					    _cachedActivators.TryAdd(type, activator);
					    break;
				    }
			    }
		    }

		    if (activator != null)
		    {
			    if (parameterInstances == null)
			    {
				    TryResolveAll(activator.ParameterTypes, out parameterInstances, scope);
			    }

			    if (parameterInstances != null)
			    {
				    return activator.Activate(parameterInstances);
			    }
		    }

		    throw new Exception();
	    }

	    private bool TryResolveAll(Type[] types, out object[] instances, ILifetimeScope scope = null)
	    {
		    instances = null;

		    try
		    {
			    var instances2 = new object[types.Length];

			    for (int i = 0; i < types.Length; i++)
			    {
				    var service = Resolve(types[i], scope);
				    if (service == null)
				    {
					    return false;
				    }

				    instances2[i] = service;
			    }

			    instances = instances2;
			    return true;
		    }
		    catch (Exception)
		    {
			    return false;
		    }
	    }

	    public object Resolve(Type type, ILifetimeScope scope = null)
	    {
		    return (scope ?? Scope()).Resolve(type);
	    }
	}
}
