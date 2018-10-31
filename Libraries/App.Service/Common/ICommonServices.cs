using App.Core;
using App.Core.Caching;
using App.Service.Languages;
using App.Service.Settings;

namespace App.Service.Common
{
    public interface ICommonServices
    {
        IWorkContext WorkContext
        {
            get;
        }

        ILocaleStringResourceService Localization
        {
            get;
        }

        ICacheManager Cache
        {
            get;
        }

        ISettingService Settings { get; }

        IWebHelper WebHelper { get; }
    }
}
