using App.Core.Utilities;
using App.Domain.Interfaces.Repository;
using App.Domain.Posts;
using System.Collections.Generic;

namespace App.Infra.Data.Repository.Posts
{
    public interface IPostGalleryRepository : IRepositoryBase<PostGallery>
	{
        PostGallery GetById(int id);

        IEnumerable<PostGallery> PagedList(Paging page);
    }
}