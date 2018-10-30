using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Text;
using App.Core.Caching;
using App.Core.Extensions;
using App.Core.Utilities;
using App.Infra.Data.Common;
using App.Infra.Data.Repository.Post;
using App.Infra.Data.UOW.Interfaces;

namespace App.Service.Post
{
    public class PostService : BaseService<App.Domain.Posts.Post>, IPostService
    {
        private const string CacheKey = "db.Post.{0}";
        private readonly ICacheManager _cacheManager;

        private readonly IPostRepository _postRepository;

        public PostService(IUnitOfWork unitOfWork, IPostRepository postRepository, ICacheManager cacheManager) : base(unitOfWork, postRepository)
        {
            _postRepository = postRepository;
            _cacheManager = cacheManager;
        }

        public App.Domain.Posts.Post GetById(int id, bool isCache = true)
        {
            var sbKey = new StringBuilder();
            sbKey.AppendFormat(CacheKey, "GetById");
            sbKey.Append(id);

            var key = sbKey.ToString();
            App.Domain.Posts.Post post;
            if (isCache)
            {
                post = _cacheManager.Get<App.Domain.Posts.Post>(key);
                if (post == null)
                {
                    post = _postRepository.GetById(id);
                    _cacheManager.Put(key, post);
                }
            }
            else
            {
                post = _postRepository.GetById(id);
            }

            return post;
        }

        public IEnumerable<App.Domain.Posts.Post> GetListSeoUrl(string seoUrl, bool isCache = true)
        {
            IEnumerable<App.Domain.Posts.Post> posts;

            if (isCache)
            {
                var sbKey = new StringBuilder();
                sbKey.AppendFormat(CacheKey, "GetListSeoUrl");

                if (seoUrl.HasValue())
                {
                    sbKey.AppendFormat("-{0}", seoUrl);
                }

                var key = sbKey.ToString();
                posts = _cacheManager.GetCollection<App.Domain.Posts.Post>(key);
                if (posts == null)
                {
                    posts = _postRepository.FindBy(x => x.SeoUrl.Equals(seoUrl));
                    _cacheManager.Put(key, posts);
                }
            }
            else
            {
                posts = _postRepository.FindBy(x => x.SeoUrl.Equals(seoUrl));
            }

            return posts;
        }

        public App.Domain.Posts.Post GetBySeoUrl(string seoUrl, bool @readonly = false)
        {
            var sbKey = new StringBuilder();
            sbKey.AppendFormat(CacheKey, "GetBySeoUrls");

            if (seoUrl.HasValue())
            {
                sbKey.AppendFormat("-{0}", seoUrl);
            }

            var key = sbKey.ToString();
            var post = _cacheManager.Get<App.Domain.Posts.Post>(key);
            if (post == null)
            {
                post = _postRepository.Get(x => x.SeoUrl.Equals(seoUrl), @readonly);
                _cacheManager.Put(key, post);
            }

            return post;
        }

        public IEnumerable<App.Domain.Posts.Post> PagedList(SortingPagingBuilder sortbuBuilder, Paging page)
        {
            return _postRepository.PagedSearchList(sortbuBuilder, page);
        }

        public IEnumerable<App.Domain.Posts.Post> PagedListByMenu(SortingPagingBuilder sortBuider, Paging page)
        {
            return _postRepository.PagedSearchListByMenu(sortBuider, page);
        }

        public IEnumerable<App.Domain.Posts.Post> GetBySort(
            Expression<Func<App.Domain.Posts.Post, bool>> expression, SortBuilder sortBuilder, Paging paging)
        {
            return FindAndSort(expression, sortBuilder, paging);
        }

        public IEnumerable<App.Domain.Posts.Post> GetByOption(string virtualCategoryId = null
            , bool? isDisplayHomePage = null
            , bool? isDiscount = null
            , int status = 1
            , bool isCache = true)
        {
            IEnumerable<App.Domain.Posts.Post> posts;
            var sbKey = new StringBuilder();
            sbKey.AppendFormat(CacheKey, "GetByOption");

            var expression = PredicateBuilder.True<App.Domain.Posts.Post>();
            sbKey.AppendFormat("-{0}", status);
            expression = expression.And(x => x.Status == status);

            if (virtualCategoryId.HasValue())
            {
                sbKey.AppendFormat("-{0}", virtualCategoryId);
                expression = expression.And(x => x.VirtualCategoryId.Contains(virtualCategoryId));
            }

            if (isDisplayHomePage != null)
            {
                //isDisplayHomePage
                sbKey.AppendFormat("-{0}", isDisplayHomePage);
                expression = expression.And(x => x.ShowOnHomePage == isDisplayHomePage);
            }

            if (isDiscount != null)
            {
                //isDiscount
                sbKey.AppendFormat("-{0}", isDiscount);
                expression = expression.And(x => x.Discount.HasValue && x.Discount > 0);
            }

            if (isCache)
            {
                var key = sbKey.ToString();
                posts = _cacheManager.GetCollection<App.Domain.Posts.Post>(key);
                if (posts == null)
                {
                    posts = FindBy(expression);
                    _cacheManager.Put(key, posts);
                }
            }
            else
            {
                posts = FindBy(expression);
            }

            return posts;
        }

    }
}