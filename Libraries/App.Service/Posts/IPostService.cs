using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using App.Core.Utilities;
using App.Domain.Interfaces.Services;
using App.Domain.Posts;

namespace App.Service.Posts
{
    public interface IPostService : IBaseService<Post>
    {
        Post GetById(int id, bool isCache = true);

        IEnumerable<Post> GetListSeoUrl(string seoUrl, bool isCache = true);

        Post GetBySeoUrl(string seoUrl, bool @readonly = false);

        IEnumerable<Post> PagedList(SortingPagingBuilder sortBuider, Paging page);

        IEnumerable<Post> PagedListByMenu(SortingPagingBuilder sortBuider, Paging page);

        IEnumerable<Post> GetBySort(Expression<Func<Post, bool>> expression, SortBuilder sortBuilder, Paging paging);

        IEnumerable<Post> GetByOption(string virtualCategoryId = null,
            bool? isDisplayHomePage = null, bool? isDiscount = null, int status = 1, bool isCache = true);

    }
}