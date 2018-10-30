using System.Linq;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;

namespace App.Infra.Data.RepositoryAsync.Post
{
    public class PostRepositoryAsync : RepositoryBaseAsync<App.Domain.Posts.Post>, IPostRepositoryAsync
	{
		public PostRepositoryAsync(IDbFactory dbFactory) : base(dbFactory)
		{
		}

		protected override IOrderedQueryable<App.Domain.Posts.Post> GetDefaultOrder(IQueryable<App.Domain.Posts.Post> query)
		{
			return 
				from p in query
				orderby p.Id
				select p;
		}
	}
}