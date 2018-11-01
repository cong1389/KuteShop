using App.Core.Caching;
using App.Core.Utilities;
using App.Domain.GenericAttributes;
using App.Infra.Data.Common;
using App.Infra.Data.Repository.GenericAttributes;
using App.Infra.Data.UOW.Interfaces;
using System.Collections.Generic;
using System.Text;

namespace App.Service.GenericAttributes
{
    public class GenericAttributeService : BaseService<GenericAttribute>, IGenericAttributeService
    {
        private const string CacheGenericattributeKey = "db.GenericAttribute.{0}";
        private readonly ICacheManager _cacheManager;
        private readonly IGenericAttributeRepository _genericAttributeRepository;

        public GenericAttributeService(IUnitOfWork unitOfWork, IGenericAttributeRepository genericAttributeRepository,
            ICacheManager cacheManager) : base(unitOfWork, genericAttributeRepository)
        {
            _genericAttributeRepository = genericAttributeRepository;
            _cacheManager = cacheManager;
        }

        public void CreateGenericAttribute(GenericAttribute genericAttribute)
        {
            _genericAttributeRepository.Add(genericAttribute);
        }

        public GenericAttribute GetById(int id, bool isCache = true)
        {
            GenericAttribute genericAttribute;

            if (isCache)
            {
                var sbKey = new StringBuilder();
                sbKey.AppendFormat(CacheGenericattributeKey, "GetById");
                sbKey.Append(id);

                var key = sbKey.ToString();
                genericAttribute = _cacheManager.Get<GenericAttribute>(key);
                if (genericAttribute == null)
                {
                    genericAttribute = _genericAttributeRepository.GetAttributeById(id);
                    _cacheManager.Put(key, genericAttribute);
                }
            }
            else
            {
                genericAttribute= _genericAttributeRepository.GetAttributeById(id);
            }

            return genericAttribute;
        }

        public GenericAttribute GetByKey(int entityId, string keyGroup, string key, bool isCache = true)
        {
            GenericAttribute attr;

            if (isCache)
            {
                var sbKey = new StringBuilder();
                sbKey.AppendFormat(CacheGenericattributeKey, "GetByKey");
                sbKey.Append(entityId);

                if (!string.IsNullOrWhiteSpace(keyGroup))
                {
                    sbKey.Append(keyGroup);
                }

                if (!string.IsNullOrWhiteSpace(key))
                {
                    sbKey.Append(key);
                }

                var keyCachare = sbKey.ToString();
                attr = _cacheManager.Get<GenericAttribute>(keyCachare);

                if (attr != null)
                {
                    return attr;
                }

                attr = _genericAttributeRepository
                    .Get(x =>
                        x.EntityId.Equals(entityId)
                        && x.KeyGroup.Equals(keyGroup)
                        && x.Key.Equals(key));

                _cacheManager.Put(keyCachare, attr);
            }
            else
            {
                attr = _genericAttributeRepository
               .Get(x =>
               x.EntityId.Equals(entityId)
                && x.KeyGroup.Equals(keyGroup)
                && x.Key.Equals(key));
            }

            return attr;
        }

        public IEnumerable<GenericAttribute> PagedList(SortingPagingBuilder sortbuBuilder, Paging page)
        {
            return _genericAttributeRepository.PagedSearchList(sortbuBuilder, page);
        }

        public void SaveGenericAttribute(int entityId, string keyGroup, string key, string value, int storeId = 0)
        {
            var objAttribute = new GenericAttribute
            {
                EntityId = entityId,
                KeyGroup = keyGroup,
                Key = key,
                Value = value,
                StoreId = storeId
            };

            var attribute = GetByKey(entityId, keyGroup, key);

            if (attribute == null)
            {
                if (!string.IsNullOrWhiteSpace(value))
                {
                    Create(objAttribute);
                }
            }
            else
            {
                //Không có value thì delete
                if (string.IsNullOrWhiteSpace(value))
                {
                    Delete(attribute);
                }
                else
                {
                    attribute.Value = value;
                    Update(attribute);
                }
            }
        }
    }
}