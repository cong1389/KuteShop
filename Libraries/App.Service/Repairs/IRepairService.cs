using System.Collections.Generic;
using App.Core.Utilities;
using App.Domain.Interfaces.Services;

namespace App.Service.Repairs
{
    public interface IRepairService : IBaseService<Domain.Repairs.Repair>
    {
        IEnumerable<Domain.Repairs.Repair> PagedList(SortingPagingBuilder sortBuider, Paging page);
    }
}