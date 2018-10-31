using App.Core.Utilities;
using App.Domain.Interfaces.Repository;
using App.Domain.Locations;
using System.Collections.Generic;

namespace App.Infra.Data.Repository.Locations
{
    public interface IProvinceRepository : IRepositoryBase<Province>
	{
		Province GetById(int id);

		IEnumerable<Province> PagedList(Paging page);

		IEnumerable<Province> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);
	}
}