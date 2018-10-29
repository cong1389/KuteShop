using System.Collections.Generic;
using App.Core.Utilities;
using App.Domain.GenericControls;
using App.Domain.Interfaces.Repository;

namespace App.Infra.Data.Repository.GenericControls
{
    public interface IGenericControlRepository : IRepositoryBase<GenericControl>
	{
		GenericControl GetById(int id);

		IEnumerable<GenericControl> PagedList(Paging page);

		IEnumerable<GenericControl> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);
	}
}