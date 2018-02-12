using System.Collections.Generic;
using System.Text;
using App.Core.Caching;
using App.Core.Utils;
using App.Domain.Entities.GenericControl;
using App.Domain.Interfaces.Services;
using App.Infra.Data.Common;
using App.Infra.Data.Repository.GenericControl;
using App.Infra.Data.UOW.Interfaces;

namespace App.Service.GenericControl
{
    public class GenericControlValueService : BaseService<GenericControlValue>, IGenericControlValueService
    {
        private const string CacheGenericontrolvalueKey = "db.GenericControlValue.{0}";
        private readonly ICacheManager _cacheManager;

        private readonly IGenericControlValueRepository _attributeValueRepository;

        public GenericControlValueService(IUnitOfWork unitOfWork, IGenericControlValueRepository attributeValueRepository
            , ICacheManager cacheManager) : base(unitOfWork, attributeValueRepository)
        {
            _attributeValueRepository = attributeValueRepository;
            _cacheManager = cacheManager;
        }

        public GenericControlValue GetById(int id, bool isCache = true)
        {
            GenericControlValue genericControlValue;

            if (isCache)
            {
                StringBuilder sbKey = new StringBuilder();
                sbKey.AppendFormat(CacheGenericontrolvalueKey, "GetById");
                sbKey.Append(id);

                string key = sbKey.ToString();
                genericControlValue = _cacheManager.Get<GenericControlValue>(key);
                if (genericControlValue == null)
                {
                    genericControlValue = _attributeValueRepository.GetById(id);
                    _cacheManager.Put(key, genericControlValue);
                }
            }
            else
            {
                genericControlValue = _attributeValueRepository.GetById(id);
            }           

            return genericControlValue;
        }

        public IEnumerable<GenericControlValue> GetByEntityId(int entityId)
        {
            StringBuilder sbKey = new StringBuilder();
            sbKey.AppendFormat(CacheGenericontrolvalueKey, "GetByEntityId");
            sbKey.AppendFormat("-{0}", entityId);

            string key = sbKey.ToString();
            IEnumerable<GenericControlValue> genericControlValues = _cacheManager.GetCollection<GenericControlValue>(key);
            if (genericControlValues == null)
            {
                genericControlValues = _attributeValueRepository.FindBy(x => x.EntityId == entityId);
                _cacheManager.Put(key, genericControlValues);
            }

            return genericControlValues;
        }

        public IEnumerable<GenericControlValue> PagedList(SortingPagingBuilder sortbuBuilder, Paging page)
        {
            return _attributeValueRepository.PagedSearchList(sortbuBuilder, page);
        }
    }
}