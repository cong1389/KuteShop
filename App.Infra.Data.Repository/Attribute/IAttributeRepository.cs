using App.Core.Utils;
using App.Domain.Interfaces.Repository;
using System.Collections.Generic;

namespace App.Infra.Data.Repository.Attribute
{
	public interface IAttributeRepository : IRepositoryBase<App.Domain.Entities.Attribute.Attribute>
	{
		App.Domain.Entities.Attribute.Attribute GetById(int Id);

		IEnumerable<App.Domain.Entities.Attribute.Attribute> PagedList(Paging page);

		IEnumerable<App.Domain.Entities.Attribute.Attribute> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);
	}
}