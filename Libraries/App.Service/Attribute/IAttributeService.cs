using System.Collections.Generic;
using App.Core.Utilities;
using App.Domain.Interfaces.Services;
using Attribute = App.Domain.Attributes;

namespace App.Service.Attribute
{
    public interface IAttributeService : IBaseService<Domain.Attributes.Attribute>
    {
        Domain.Attributes.Attribute GetById(int id, bool isCache = true);

        IEnumerable<Domain.Attributes.Attribute> PagedList(SortingPagingBuilder sortBuider, Paging page);
    }
}