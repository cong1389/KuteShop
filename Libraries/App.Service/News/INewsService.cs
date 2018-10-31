using System.Collections.Generic;
using App.Core.Utilities;
using App.Domain.Interfaces.Services;

namespace App.Service.News
{
    public interface INewsService : IBaseService<Domain.News.News>
    {
        Domain.News.News GetById(int id, bool isCache = true);

        IEnumerable<Domain.News.News> GetBySeoUrl(string seoUrl, bool isCache = true);

        IEnumerable<Domain.News.News> PagedList(SortingPagingBuilder sortBuider, Paging page);

        IEnumerable<Domain.News.News> PagedListByMenu(SortingPagingBuilder sortBuider, Paging page);

        IEnumerable<Domain.News.News> GetByOption(string virtualCategoryId = null
            , bool? isDisplayHomePage = null
           , bool? isVideo = null
           , int status = 1
           , bool isCache = true);

        IEnumerable<Domain.News.News> GetEnableOrDisables(bool enable = true, bool isCache = true);

        Domain.News.News GetEnableOrDisable(bool enable = true, bool isCache = true);
    }
}