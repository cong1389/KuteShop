using App.Domain.Interfaces.Services;
using App.Domain.Posts;
using System.Collections.Generic;

namespace App.Service.Posts
{
    public interface IPostGalleryService : IBaseService<PostGallery>
	{
        PostGallery GetById(int id, bool isCache = true);

        IEnumerable<PostGallery> GetByPostId(int postId, bool isCache = true);

        int GetMaxOrderDiplay(int postId);
    }
}