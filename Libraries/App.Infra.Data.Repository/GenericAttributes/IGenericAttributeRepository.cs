using System.Collections.Generic;
using App.Core.Utilities;
using App.Domain.GenericAttributes;
using App.Domain.Interfaces.Repository;

namespace App.Infra.Data.Repository.GenericAttributes
{
	public interface IGenericAttributeRepository : IRepositoryBase<GenericAttribute>
	{
		GenericAttribute GetAttributeById(int id);

		IEnumerable<GenericAttribute> PagedList(Paging page);

		IEnumerable<GenericAttribute> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);
	}
}