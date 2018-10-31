using App.Core.Utilities;
using App.Domain.Interfaces.Services;
using App.Domain.Locations;
using System.Collections.Generic;

namespace App.Service.Locations
{
    public interface IDistrictService : IBaseService<District>
	{
		District GetById(int id);

		IEnumerable<District> GetByProvinceId(int provinceId);

		IEnumerable<District> PagedList(SortingPagingBuilder sortBuider, Paging page);
	}
}