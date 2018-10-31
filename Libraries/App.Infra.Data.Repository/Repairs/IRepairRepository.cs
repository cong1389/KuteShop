using System.Collections.Generic;
using App.Core.Utilities;
using App.Domain.Entities.Data;
using App.Domain.Interfaces.Repository;
using App.Domain.Repairs;

namespace App.Infra.Data.Repository.Repairs
{
    public interface IRepairRepository : IRepositoryBase<Repair>
	{
		IEnumerable<Repair> PagedList(Paging page);

		IEnumerable<Repair> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);
	}
}