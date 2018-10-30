using App.Core.Utilities;
using App.Domain.Interfaces.Services;
using System.Collections.Generic;

namespace App.Service.Attribute
{
    public interface IAttributeService : IBaseService<Domain.Entities.Attribute.Attribute>
    {
        Domain.Entities.Attribute.Attribute GetById(int id, bool isCache = true);

        IEnumerable<Domain.Entities.Attribute.Attribute> PagedList(SortingPagingBuilder sortBuider, Paging page);
    }
}