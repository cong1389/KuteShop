using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Text;
using App.Core.Caching;
using App.Core.Extensions;
using App.Core.Utils;
using App.Infra.Data.Common;
using App.Infra.Data.Repository.Post;
using App.Infra.Data.UOW.Interfaces;

namespace App.Service.Post
{
    public class PostService : BaseService<Domain.Entities.Data.Post>, IPostService
    {
        private const string CachePostKey = "db.Post.{0}";
        private readonly ICacheManager _cacheManager;

        private readonly IPostRepository _postRepository;

        public PostService(IUnitOfWork unitOfWork, IPostRepository postRepository, ICacheManager cacheManager) : base(unitOfWork, postRepository)
        {
            _postRepository = postRepository;
            _cacheManager = cacheManager;
        }

        public Domain.Entities.Data.Post GetById(int id, bool isCache = true)
        {
            StringBuilder sbKey = new StringBuilder();
            sbKey.AppendFormat(CachePostKey, "GetById");
            sbKey.Append(id);

            string key = sbKey.ToString();
            Domain.Entities.Data.Post post = null;
            if (isCache)
            {
                post = _cacheManager.Get<Domain.Entities.Data.Post>(key);
                if (post == null)
                {
                    post = _postRepository.GetById(id);
                    _cacheManager.Put(key, post);
                }
            }
            else
                post = _postRepository.GetById(id);

            return post;
        }

        public IEnumerable<Domain.Entities.Data.Post> GetListSeoUrl(string seoUrl, bool isCache = true)
        {
            IEnumerable<Domain.Entities.Data.Post> posts;

            if (isCache)
            {
                StringBuilder sbKey = new StringBuilder();
                sbKey.AppendFormat(CachePostKey, "GetBySeoUrl");

                if (seoUrl.HasValue())
                {
                    sbKey.AppendFormat("-{0}", seoUrl);
                }

                string key = sbKey.ToString();
                posts = _cacheManager.GetCollection<Domain.Entities.Data.Post>(key);
                if (posts == null)
                {
                    posts = _postRepository.FindBy(x => x.SeoUrl.Equals(seoUrl));
                    _cacheManager.Put(key, posts);
                }
            }
            else
            {
                posts = _postRepository.FindBy(x => x.SeoUrl.Equals(seoUrl), false);
            }

            return posts;
        }

        public Domain.Entities.Data.Post GetBySeoUrl(string seoUrl, bool @readonly = false)
        {
            StringBuilder sbKey = new StringBuilder();
            sbKey.AppendFormat(CachePostKey, "GetBySeoUrl");

            if (seoUrl.HasValue())
            {
                sbKey.AppendFormat("-{0}", seoUrl);
            }

            string key = sbKey.ToString();
            Domain.Entities.Data.Post post = _cacheManager.Get<Domain.Entities.Data.Post>(key);
            if (post == null)
            {
                post = _postRepository.Get(x => x.SeoUrl.Equals(seoUrl), @readonly);
                _cacheManager.Put(key, post);
            }

            return post;
        }
        
        public IEnumerable<Domain.Entities.Data.Post> PagedList(SortingPagingBuilder sortbuBuilder, Paging page)
        {
            return _postRepository.PagedSearchList(sortbuBuilder, page);
        }

        public IEnumerable<Domain.Entities.Data.Post> PagedListByMenu(SortingPagingBuilder sortBuider, Paging page)
        {
            return _postRepository.PagedSearchListByMenu(sortBuider, page);
        }

        public IEnumerable<Domain.Entities.Data.Post> GetBySort(Expression<Func<Domain.Entities.Data.Post, bool>> expression, SortBuilder sortBuilder, Paging paging)
        {
            return FindAndSort(expression, sortBuilder, paging);
        }

        public IEnumerable<Domain.Entities.Data.Post> GetByOption(string virtualCategoryId = null
            , bool? isDisplayHomePage = null
            , int status = 1
            , bool isCache =true)
        {
            IEnumerable<Domain.Entities.Data.Post> posts;
            StringBuilder sbKey = new StringBuilder();
            sbKey.AppendFormat(CachePostKey, "GetByOption");

            Expression<Func<Domain.Entities.Data.Post, bool>> expression = PredicateBuilder.True<Domain.Entities.Data.Post>();
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
           
            if (isCache)
            {
               

                string key = sbKey.ToString();
                posts = _cacheManager.GetCollection<Domain.Entities.Data.Post>(key);
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