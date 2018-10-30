using App.Core.Utilities;
using App.Domain.Brandes;
using App.Domain.Interfaces.Services;
using System.Collections.Generic;

namespace App.Service.Brandes
{
    public interface IBrandService : IBaseService<Brand>
	{
		Brand GetById(int id);

		IEnumerable<Brand> PagedList(SortingPagingBuilder sortBuider, Paging page);
	}
}