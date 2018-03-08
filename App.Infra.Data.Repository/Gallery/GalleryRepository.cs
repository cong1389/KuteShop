using System.Linq;
using App.Domain.Entities.Data;
using App.Domain.Interfaces.Repository;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;

namespace App.Infra.Data.Repository.Gallery
{
	public class GalleryRepository : RepositoryBase<GalleryImage>, IGalleryRepository, IRepositoryBase<GalleryImage>
	{
		public GalleryRepository(IDbFactory dbFactory) : base(dbFactory)
		{
		}

		protected override IOrderedQueryable<GalleryImage> GetDefaultOrder(IQueryable<GalleryImage> query)
		{
			IOrderedQueryable<GalleryImage> galleryImages = 
				from p in query
				orderby p.Id
				select p;
			return galleryImages;
		}

		public GalleryImage GetGalleryById(int id)
		{
			GalleryImage galleryImage = FindBy(x => x.Id == id).FirstOrDefault();
			return galleryImage;
		}
	}
}