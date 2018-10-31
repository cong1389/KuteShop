using App.Core.Localization;

namespace App.Service.Languages
{
    public interface ITextService
    {
        LocalizedString Get(string key, params object[] args);
    }
}
