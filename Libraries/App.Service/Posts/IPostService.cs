using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using App.Core.Utilities;
using App.Domain.Interfaces.Services;

namespace App.Service.Posts
{
    public interface IPostService : IBaseService<App.Domain.Posts.Post>
    {
        App.Domain.Posts.Post GetById(int id, bool isCache = true);

        IEnumerable<App.Domain.Posts.Post> GetListSeoUrl(string seoUrl, bool isCache = true);

        App.Domain.Posts.Post GetBySeoUrl(string seoUrl, bool @readonly = false);

        IEnumerable<App.Domain.Posts.Post> PagedList(SortingPagingBuilder sortBuider, Paging page);

        IEnumerable<App.Domain.Posts.Post> PagedListByMenu(SortingPagingBuilder sortBuider, Paging page);

        IEnumerable<App.Domain.Posts.Post> GetBySort(Expression<Func<App.Domain.Posts.Post, bool>> expression, SortBuilder sortBuilder, Paging paging);

        IEnumerable<App.Domain.Posts.Post> GetByOption(string virtualCategoryId = null,
            bool? isDisplayHomePage = null, bool? isDiscount = null, int status = 1, bool isCache = true);

    }
}