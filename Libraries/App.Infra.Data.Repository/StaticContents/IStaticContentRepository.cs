using App.Core.Utilities;
using App.Domain.Interfaces.Repository;
using App.Domain.StaticContents;
using System.Collections.Generic;

namespace App.Infra.Data.Repository.StaticContents
{
    public interface IStaticContentRepository : IRepositoryBase<StaticContent>
	{
		StaticContent GetById(int id);

		IEnumerable<StaticContent> PagedList(Paging page);

		IEnumerable<StaticContent> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);

		IEnumerable<StaticContent> PagedSearchListByMenu(SortingPagingBuilder sortBuider, Paging page);
	}
}