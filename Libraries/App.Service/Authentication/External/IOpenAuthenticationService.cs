using System.Collections.Generic;
using App.Core.Plugins.Providers;

namespace App.Service.Authentication.External
{
    public interface IOpenAuthenticationService
    {
        IEnumerable<Provider<IExternalAuthenticationMethod>> LoadActiveExternalAuthenticationMethods();
        IEnumerable<Provider<IExternalAuthenticationMethod>> LoadAllExternalAuthenticationMethods();
    }
}