using System.Web.Mvc;

namespace App.Service.Common
{
    public static class ICommonServicesExtensions
    {
        public static TService Resolve<TService>(this ICommonServices services)
        {
            return DependencyResolver.Current.GetService<TService>();
        }
    }
}