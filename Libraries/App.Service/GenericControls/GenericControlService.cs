using System.Collections.Generic;
using System.Text;
using App.Core.Caching;
using App.Core.Utilities;
using App.Infra.Data.Common;
using App.Infra.Data.Repository.GenericControls;
using App.Infra.Data.UOW.Interfaces;
using App.Domain.GenericControls;

namespace App.Service.GenericControls
{
    public class GenericControlService : BaseService<GenericControl>, IGenericControlService
    {
        private const string CacheGenericcontrolKey = "db.GenericControl.{0}";
        private readonly ICacheManager _cacheManager;

        private readonly IGenericControlRepository _attributeRepository;

        public GenericControlService(IUnitOfWork unitOfWork, IGenericControlRepository attributeRepository
            , ICacheManager cacheManager) : base(unitOfWork, attributeRepository)
        {
            _attributeRepository = attributeRepository;
            _cacheManager = cacheManager;
        }

        public GenericControl GetById(int id, bool isCache = true)
        {
            GenericControl genericControl;

            if (isCache)
            {
                var sbKey = new StringBuilder();
                sbKey.AppendFormat(CacheGenericcontrolKey, "GetById");
                sbKey.Append(id);

                var key = sbKey.ToString();
                genericControl = _cacheManager.Get<GenericControl>(key);
                if (genericControl == null)
                {
                    genericControl = _attributeRepository.GetById(id);
                    _cacheManager.Put(key, genericControl);
                }
            }
            else
            {
                genericControl = _attributeRepository.GetById(id);
            }
            
            return genericControl;
        }

        public IEnumerable<GenericControl> GetByMenuId(int menuId, bool isCache = true)
        {
            IEnumerable<GenericControl> genericControls;

            if (isCache)
            {
                var sbKey = new StringBuilder();
                sbKey.AppendFormat(CacheGenericcontrolKey, "GetByMenuId");
                sbKey.AppendFormat("-{0}", menuId);

                var key = sbKey.ToString();
                genericControls = _cacheManager.GetCollection<GenericControl>(key);
                if (genericControls == null)
                {
                    genericControls = _attributeRepository.FindBy(x => x.MenuId == menuId);
                    _cacheManager.Put(key, genericControls);
                }
            }
            else
            {
                genericControls = _attributeRepository.FindBy(x => x.MenuId == menuId);
            }

            return genericControls;
        }

        public IEnumerable<GenericControl> PagedList(SortingPagingBuilder sortbuBuilder, Paging page)
        {
            return _attributeRepository.PagedSearchList(sortbuBuilder, page);
        }
    }
}