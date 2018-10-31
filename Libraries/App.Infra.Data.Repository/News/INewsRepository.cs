using System.Collections.Generic;
using App.Core.Utilities;
using App.Domain.Interfaces.Repository;

namespace App.Infra.Data.Repository.News
{
	public interface INewsRepository : IRepositoryBase<Domain.News.News>
	{
		Domain.News.News GetById(int id);

		IEnumerable<Domain.News.News> PagedList(Paging page);

		IEnumerable<Domain.News.News> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);

		IEnumerable<Domain.News.News> PagedSearchListByMenu(SortingPagingBuilder sortBuider, Paging page);
	}
}