using System.Linq;
using App.Domain.Posts;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;

namespace App.Infra.Data.RepositoryAsync.Posts
{
    public class PostRepositoryAsync : RepositoryBaseAsync<Post>, IPostRepositoryAsync
	{
		public PostRepositoryAsync(IDbFactory dbFactory) : base(dbFactory)
		{
		}

		protected override IOrderedQueryable<Post> GetDefaultOrder(IQueryable<Post> query)
		{
			return 
				from p in query
				orderby p.Id
				select p;
		}
	}
}