using App.Core.Utilities;
using App.Domain.Interfaces.Services;
using App.Domain.Slides;
using System.Collections.Generic;

namespace App.Service.Slide
{
    public interface ISlideShowService : IBaseService<SlideShow>
    {
        IEnumerable<SlideShow> PagedList(SortingPagingBuilder sortBuider, Paging page);
        IEnumerable<SlideShow> GetEnableOrDisables(bool enable = true, bool isCache = true);
    }
}