using System.Collections.Generic;
using App.Core.Utilities;
using App.Domain.Entities.Data;
using App.Domain.Interfaces.Repository;
using App.Domain.Manufacturers;

namespace App.Infra.Data.Repository.Manufacturers
{
    public interface IManufacturerRepository : IRepositoryBase<Manufacturer>
	{
		IEnumerable<Manufacturer> PagedList(Paging page);

		IEnumerable<Manufacturer> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);

		IEnumerable<Manufacturer> PagedSearchListByMenu(SortingPagingBuilder sortBuider, Paging page);
	}
}