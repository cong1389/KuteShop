using App.Core.Utilities;
using App.Domain.Interfaces.Services;
using App.Domain.StaticContents;
using System.Collections.Generic;

namespace App.Service.StaticContents
{
    public interface IStaticContentService : IBaseService<StaticContent>
    {
        StaticContent GetById(int id, bool isCache = true);

        StaticContent GetStaticContent(int menuId, bool isCache = true);
        StaticContent GetStaticContent(int menuId, int status, bool isCache = true);

        IEnumerable<StaticContent> GetBySeoUrls(string seoUrl, int? status = null, bool isCache = true);

        IEnumerable<StaticContent> PagedList(SortingPagingBuilder sortBuider, Paging page);

        IEnumerable<StaticContent> GetStaticContents(int menuId, int status, bool isCache = true);
        IEnumerable<StaticContent> GetStaticContents(string virtualCategoryId, int status, bool isCache = true);

        IEnumerable<StaticContent> PagedListByMenu(SortingPagingBuilder sortBuider, Paging page);

        IEnumerable<StaticContent> GetEnableOrDisables(bool enable = true, bool isCache = true);

    }
}