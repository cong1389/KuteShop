using App.Domain.Entities.Data;
using App.Domain.Galleries;
using App.Domain.Interfaces.Repository;

namespace App.Infra.Data.Repository.Gallery
{
    public interface IGalleryRepository : IRepositoryBase<GalleryImage>
	{
		GalleryImage GetGalleryById(int id);
	}
}