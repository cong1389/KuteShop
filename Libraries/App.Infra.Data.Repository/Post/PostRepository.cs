using System.Collections.Generic;
using System.Linq;
using App.Core.Utilities;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;

namespace App.Infra.Data.Repository.Post
{
    public class PostRepository : RepositoryBase<App.Domain.Posts.Post>, IPostRepository
	{

        public PostRepository(IDbFactory dbFactory) : base(dbFactory)
		{
        }

	    public App.Domain.Posts.Post GetById(int id)
        {
            var post = FindBy(x => x.Id == id).FirstOrDefault();
            
            return post;
		}

		protected override IOrderedQueryable<App.Domain.Posts.Post> GetDefaultOrder(IQueryable<App.Domain.Posts.Post> query)
		{
			var posts = 
				from p in query
				orderby p.Id
				select p;
			return posts;
		}

		public IEnumerable<App.Domain.Posts.Post> PagedList(Paging page)
		{
			return GetAllPagedList(page).ToList();
		}

		public IEnumerable<App.Domain.Posts.Post> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
		{
			var expression = PredicateBuilder.True<App.Domain.Posts.Post>();
			if (!string.IsNullOrEmpty(sortBuider.Keywords))
			{
				expression = expression.And(x =>
				    x.Title.ToLower().Contains(sortBuider.Keywords.ToLower()) ||
				    x.ProductCode.Contains(sortBuider.Keywords.ToLower()));
			}
			return FindAndSort(expression, sortBuider.Sorts, page);
		}

		public IEnumerable<App.Domain.Posts.Post> PagedSearchListByMenu(SortingPagingBuilder sortBuider, Paging page)
		{
			var expression = PredicateBuilder.True<App.Domain.Posts.Post>();
			if (!string.IsNullOrEmpty(sortBuider.Keywords))
			{
				expression = expression.And(x => x.VirtualCategoryId.Contains(sortBuider.Keywords) && x.Status == 1);
			}
			return FindAndSort(expression, sortBuider.Sorts, page);
		}
	}
}