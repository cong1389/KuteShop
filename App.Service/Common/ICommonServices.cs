using App.Core.Caching;
using App.Service.LocaleStringResource;

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
    }
}
