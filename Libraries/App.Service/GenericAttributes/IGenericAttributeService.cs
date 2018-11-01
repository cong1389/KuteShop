using App.Core.Utilities;
using App.Domain.Interfaces.Services;
using System.Collections.Generic;
using App.Domain.GenericAttributes;

namespace App.Service.GenericAttributes
{
    public interface IGenericAttributeService : IBaseService<GenericAttribute>
    {
        void CreateGenericAttribute(GenericAttribute attribute);

        GenericAttribute GetById(int id, bool isCache = true);

        GenericAttribute GetByKey(int entityId, string keyGroup, string key, bool isCache = true);

        IEnumerable<GenericAttribute> PagedList(SortingPagingBuilder sortBuider, Paging page);

        void SaveGenericAttribute(int entityId, string keyGroup, string key, string value, int storeId = 0);
    }
}