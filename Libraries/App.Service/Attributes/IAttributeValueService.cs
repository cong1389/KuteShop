using App.Core.Utilities;
using App.Domain.Entities.Attribute;
using App.Domain.Interfaces.Services;
using System.Collections.Generic;

namespace App.Service.Attributes
{
    public interface IAttributeValueService : IBaseService<AttributeValue>
    {
        AttributeValue GetById(int id, bool isCache = true);

        IEnumerable<AttributeValue> PagedList(SortingPagingBuilder sortBuider, Paging page);
    }
}