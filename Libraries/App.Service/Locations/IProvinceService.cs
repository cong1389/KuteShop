using App.Core.Utilities;
using App.Domain.Interfaces.Services;
using App.Domain.Locations;
using System.Collections.Generic;

namespace App.Service.Locations
{
    public interface IProvinceService : IBaseService<Province>
	{
		Province GetById(int id);

		IEnumerable<Province> PagedList(SortingPagingBuilder sortBuider, Paging page);
	}
}