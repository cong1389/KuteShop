using App.Domain.Galleries;
using App.Domain.Interfaces.Services;
using System.Collections.Generic;

namespace App.Service.Galleries
{
    public interface IGalleryService : IBaseService<GalleryImage>
    {
        GalleryImage GetById(int id, bool isCache = true);

        IEnumerable<GalleryImage> GetByOption(int? attributeValueId = null
           , int? postId = null
           , int status = 1
            , bool isCache = true);

    }
}