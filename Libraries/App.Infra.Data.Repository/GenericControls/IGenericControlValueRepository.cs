using System.Collections.Generic;
using App.Core.Utilities;
using App.Domain.GenericControls;
using App.Domain.Interfaces.Repository;

namespace App.Infra.Data.Repository.GenericControls
{
	public interface IGenericControlValueRepository : IRepositoryBase<GenericControlValue>
	{
		GenericControlValue GetById(int id);

		IEnumerable<GenericControlValue> PagedList(Paging page);

		IEnumerable<GenericControlValue> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);
	}
}