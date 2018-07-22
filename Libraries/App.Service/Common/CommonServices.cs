using App.Core;
using App.Core.Caching;
using App.Service.LocaleStringResource;
using System;
using App.Service.Settings;

namespace App.Service.Common
{
    public class CommonServices : ICommonServices
    {
        private readonly Lazy<IWorkContext> _workContext;
        private readonly Lazy<ILocaleStringResourceService> _localization;
        private readonly Lazy<ICacheManager> _cacheManager;
        private readonly Lazy<IWebHelper> _webHelper;
        private readonly Lazy<ISettingService> _settings;

        public CommonServices(Lazy<IWorkContext> workContext, Lazy<ILocaleStringResourceService> localization,
            Lazy<ICacheManager> cacheManager, Lazy<IWebHelper> webHelper, Lazy<ISettingService> settings)
        {
            _workContext = workContext;
            _localization = localization;
            _cacheManager = cacheManager;
            _webHelper = webHelper;
            _settings = settings;
        }

        public IWorkContext WorkContext => _workContext.Value;

        public ILocaleStringResourceService Localization => _localization.Value;

        public ICacheManager Cache => _cacheManager.Value;

        public IWebHelper WebHelper => _webHelper.Value;

        public ISettingService Settings => _settings.Value;
    }
}
