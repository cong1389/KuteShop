using App.Core.Utilities;
using App.Domain.Posts;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;
using System.Collections.Generic;
using System.Linq;

namespace App.Infra.Data.Repository.Posts
{
    public class PostGalleryRepository : RepositoryBase<PostGallery>, IPostGalleryRepository
	{

        public PostGalleryRepository(IDbFactory dbFactory) : base(dbFactory)
		{
        }

        public PostGallery GetById(int id)
        {
            var postGallery = FindBy(x => x.Id == id).FirstOrDefault();
            
            return postGallery;
        }

        protected override IOrderedQueryable<PostGallery> GetDefaultOrder(IQueryable<PostGallery> query)
        {
            var postGallery =
                from p in query
                orderby p.Id
                select p;
            return postGallery;
        }

        public IEnumerable<PostGallery> PagedList(Paging page)
        {
            return GetAllPagedList(page).ToList();
        }    }
}