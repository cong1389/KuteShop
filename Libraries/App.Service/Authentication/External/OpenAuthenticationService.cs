using App.Core.Plugins.Providers;
using System.Collections.Generic;

namespace App.Service.Authentication.External
{
    public class OpenAuthenticationService : IOpenAuthenticationService
    {
        private readonly IProviderManager _providerManager;

        //private readonly ExternalAuthenticationSettings _externalAuthenticationSettings;

        public OpenAuthenticationService(IProviderManager providerManager)
        {
            _providerManager = providerManager;
            //_externalAuthenticationSettings = externalAuthenticationSettings;
        }

        public virtual IEnumerable<Provider<IExternalAuthenticationMethod>> LoadActiveExternalAuthenticationMethods()
        {
            var allMethods = LoadAllExternalAuthenticationMethods();
            var activeMethods = allMethods;
             //.Where(p => _externalAuthenticationSettings.ActiveAuthenticationMethodSystemNames.Contains(p.Metadata.SystemName, StringComparer.InvariantCultureIgnoreCase));

            return activeMethods;
        }

        public virtual IEnumerable<Provider<IExternalAuthenticationMethod>> LoadAllExternalAuthenticationMethods()
        {
            return _providerManager.GetAllProviders<IExternalAuthenticationMethod>();
        }
    }
}
