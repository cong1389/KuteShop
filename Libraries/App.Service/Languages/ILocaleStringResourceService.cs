using App.Core.Utilities;
using App.Domain.Interfaces.Services;
using App.Domain.Languages;
using System.Collections.Generic;
using System.Linq;

namespace App.Service.Languages
{
    public interface ILocaleStringResourceService : IBaseService<LocaleStringResource>
    {
        void CreateLocaleStringResource(LocaleStringResource localeStringResource);

        LocaleStringResource GetByName(int languageId, string resourceName, bool isCache = true);

        IEnumerable<LocaleStringResource> PagedList(SortingPagingBuilder sortBuider, Paging page);

        int SaveLocaleStringResource();

        LocaleStringResource GetById(int id, bool isCache = true);

        IEnumerable<LocaleStringResource> GetByLanguageId(int languageId, bool isCache = true);

        IQueryable<LocaleStringResource> GetAll(int languageId);

        string GetResource(string resourceKey, int languageId = 0, bool logIfNotFound = true, string defaultValue = "", bool returnEmptyIfNotFound = false, bool isCache = true);

    }
}