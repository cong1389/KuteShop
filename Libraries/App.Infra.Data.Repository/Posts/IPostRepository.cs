using System.Collections.Generic;
using App.Core.Utilities;
using App.Domain.Interfaces.Repository;
using App.Domain.Posts;

namespace App.Infra.Data.Repository.Posts
{
	public interface IPostRepository : IRepositoryBase<Post>
	{
		Post GetById(int id);

		IEnumerable<Post> PagedList(Paging page);

		IEnumerable<Post> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);

		IEnumerable<Post> PagedSearchListByMenu(SortingPagingBuilder sortBuider, Paging page);
	}
}