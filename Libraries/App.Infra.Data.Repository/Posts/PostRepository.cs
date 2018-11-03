using System.Collections.Generic;
using System.Linq;
using App.Core.Utilities;
using App.Domain.Posts;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;

namespace App.Infra.Data.Repository.Posts
{
    public class PostRepository : RepositoryBase<Post>, IPostRepository
	{

        public PostRepository(IDbFactory dbFactory) : base(dbFactory)
		{
        }

	    public Post GetById(int id)
        {
            var post = FindBy(x => x.Id == id).FirstOrDefault();
            
            return post;
		}

		protected override IOrderedQueryable<Post> GetDefaultOrder(IQueryable<Post> query)
		{
			var posts = 
				from p in query
				orderby p.Id
				select p;
			return posts;
		}

		public IEnumerable<Post> PagedList(Paging page)
		{
			return GetAllPagedList(page).ToList();
		}

		public IEnumerable<Post> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
		{
			var expression = PredicateBuilder.True<Post>();
			if (!string.IsNullOrEmpty(sortBuider.Keywords))
			{
				expression = expression.And(x =>
				    x.Title.ToLower().Contains(sortBuider.Keywords.ToLower()) ||
				    x.ProductCode.Contains(sortBuider.Keywords.ToLower()));
			}
			return FindAndSort(expression, sortBuider.Sorts, page);
		}

		public IEnumerable<Post> PagedSearchListByMenu(SortingPagingBuilder sortBuider, Paging page)
		{
			var expression = PredicateBuilder.True<Post>();
			if (!string.IsNullOrEmpty(sortBuider.Keywords))
			{
				expression = expression.And(x => x.VirtualCategoryId.Contains(sortBuider.Keywords) && x.Status == 1);
			}
			return FindAndSort(expression, sortBuider.Sorts, page);
		}
	}
}