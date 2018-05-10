using System.Collections.Generic;
using System.Text;
using App.Core.Caching;
using App.Core.Extensions;
using App.Core.Utils;
using App.Domain.Common;
using App.Domain.Entities.Data;
using App.Infra.Data.Common;
using App.Infra.Data.Repository.Static;
using App.Infra.Data.UOW.Interfaces;

namespace App.Service.Static
{
    public class StaticContentService : BaseService<StaticContent>, IStaticContentService
    {
        private const string CacheKey = "db.StaticContent.{0}";
        private readonly ICacheManager _cacheManager;

        private readonly IStaticContentRepository _staticContentRepository;

        public StaticContentService(IUnitOfWork unitOfWork, IStaticContentRepository staticContentRepository, ICacheManager cacheManager) : base(unitOfWork, staticContentRepository)
        {
            _staticContentRepository = staticContentRepository;
            _cacheManager = cacheManager;
        }

        public StaticContent GetById(int id, bool isCache = true)
        {
            StaticContent staticContent;
            if (isCache)
            {
                var sbKey = new StringBuilder();
                sbKey.AppendFormat(CacheKey, "GetById");
                sbKey.Append(id);

                var key = sbKey.ToString();
                staticContent = _cacheManager.Get<StaticContent>(key);
                if (staticContent == null)
                {
                    staticContent = _staticContentRepository.GetById(id);
                    _cacheManager.Put(key, staticContent);
                }
            }
            else
            {
                staticContent = _staticContentRepository.GetById(id);
            }

            return staticContent;
        }

        public StaticContent GetStaticContent(int menuId, bool isCache = true)
        {
            StaticContent staticContent;

            if (isCache)
            {
                var sbKey = new StringBuilder();
                sbKey.AppendFormat(CacheKey, "GetStaticContent");
                sbKey.Append(menuId);

                var key = sbKey.ToString();

                staticContent = _cacheManager.Get<StaticContent>(key);
                if (staticContent == null)
                {
                    staticContent = _staticContentRepository.Get(x => x.MenuId == menuId, true);
                    _cacheManager.Put(key, staticContent);
                }
            }
            else
            {
                staticContent = _staticContentRepository.Get(x => x.MenuId == menuId, true);
            }

            return staticContent;
        }

        public StaticContent GetStaticContent(int menuId, int status, bool isCache = true)
        {
            StaticContent staticContent;

            if (isCache)
            {
                var sbKey = new StringBuilder();
                sbKey.AppendFormat(CacheKey, "GetStaticContent");
                sbKey.Append(menuId);

                var key = sbKey.ToString();

                staticContent = _cacheManager.Get<StaticContent>(key);
                if (staticContent == null)
                {
                    staticContent = _staticContentRepository.Get(x => x.MenuId == menuId && x.Status == status, true);
                    _cacheManager.Put(key, staticContent);
                }
            }
            else
            {
                staticContent = _staticContentRepository.Get(x => x.MenuId == menuId && x.Status == status, true);
            }

            return staticContent;
        }

        public IEnumerable<StaticContent> GetBySeoUrl(string seoUrl, bool isCache = true)
        {
            if (!isCache)
            {
                return _staticContentRepository.FindBy(x => x.SeoUrl.Equals(seoUrl));
            }

            var sbKey = new StringBuilder();
            sbKey.AppendFormat(CacheKey, "GetBySeoUrl");

            sbKey.AppendFormat("-{0}", seoUrl);

            var key = sbKey.ToString();

            var staticContents = _cacheManager.GetCollection<StaticContent>(key);
            if (staticContents == null)
            {
                staticContents = _staticContentRepository.FindBy(x => x.SeoUrl.Equals(seoUrl));
                _cacheManager.Put(key, staticContents);
            }

            return staticContents;
        }

        public IEnumerable<StaticContent> GetEnableOrDisables(bool enable = true, bool isCache = true)
        {
            if (!isCache)
            {
                return _staticContentRepository.FindBy(x => x.Status == (enable ? 1 : 0), true);
            }

            var sbKey = new StringBuilder();
            sbKey.AppendFormat(CacheKey, "GetEnableOrDisables");
            sbKey.Append(enable);

            var key = sbKey.ToString();

            var staticContents = _cacheManager.GetCollection<StaticContent>(key);
            if (staticContents == null)
            {
                staticContents = _staticContentRepository.FindBy(x => x.Status == (enable ? 1 : 0), true);
                _cacheManager.Put(key, staticContents);
            }

            return staticContents;
        }

        public IEnumerable<StaticContent> PagedList(SortingPagingBuilder sortbuBuilder, Paging page)
        {
            return _staticContentRepository.PagedSearchList(sortbuBuilder, page);
        }

        public IEnumerable<StaticContent> PagedListByMenu(SortingPagingBuilder sortBuider, Paging page)
        {
            return _staticContentRepository.PagedSearchListByMenu(sortBuider, page);
        }
    }
}