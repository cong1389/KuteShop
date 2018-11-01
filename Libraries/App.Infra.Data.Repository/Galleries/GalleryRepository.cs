using App.Domain.Galleries;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;
using System.Linq;

namespace App.Infra.Data.Repository.Galleries
{
    public class GalleryRepository : RepositoryBase<GalleryImage>, IGalleryRepository
	{
		public GalleryRepository(IDbFactory dbFactory) : base(dbFactory)
		{
		}

		protected override IOrderedQueryable<GalleryImage> GetDefaultOrder(IQueryable<GalleryImage> query)
		{
			var galleryImages = 
				from p in query
				orderby p.Id
				select p;
			return galleryImages;
		}

		public GalleryImage GetGalleryById(int id)
		{
			var galleryImage = FindBy(x => x.Id == id).FirstOrDefault();
			return galleryImage;
		}
	}
}