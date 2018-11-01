using App.Domain.Galleries;
using App.Domain.Interfaces.Repository;

namespace App.Infra.Data.Repository.Galleries
{
    public interface IGalleryRepository : IRepositoryBase<GalleryImage>
	{
		GalleryImage GetGalleryById(int id);
	}
}