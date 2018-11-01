using App.Core.Utilities;
using App.Domain.Interfaces.Services;
using App.Domain.Manufacturers;
using System.Collections.Generic;

namespace App.Service.Manufacturers
{
    public interface IManufacturerService : IBaseService<Manufacturer>
	{
		IEnumerable<Manufacturer> PagedList(SortingPagingBuilder sortBuider, Paging page);

		IEnumerable<Manufacturer> PagedListByMenu(SortingPagingBuilder sortBuider, Paging page);
	}
}