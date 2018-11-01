using System.Collections.Generic;
using App.Core.Utilities;
using App.Domain.Interfaces.Repository;

namespace App.Infra.Data.Repository.Posts
{
	public interface IPostRepository : IRepositoryBase<App.Domain.Posts.Post>
	{
		App.Domain.Posts.Post GetById(int id);

		IEnumerable<App.Domain.Posts.Post> PagedList(Paging page);

		IEnumerable<App.Domain.Posts.Post> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);

		IEnumerable<App.Domain.Posts.Post> PagedSearchListByMenu(SortingPagingBuilder sortBuider, Paging page);
	}
}