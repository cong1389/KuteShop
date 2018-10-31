using App.Core.Utilities;
using App.Domain.Interfaces.Repository;
using App.Domain.Locations;
using System.Collections.Generic;

namespace App.Infra.Data.Repository.Locations
{
    public interface IDistrictRepository : IRepositoryBase<District>
	{
		District GetById(int id);

		IEnumerable<District> PagedList(Paging page);

		IEnumerable<District> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);
	}
}