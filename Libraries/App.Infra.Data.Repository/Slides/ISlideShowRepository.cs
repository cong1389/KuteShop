using App.Core.Utilities;
using App.Domain.Interfaces.Repository;
using App.Domain.Slides;
using System.Collections.Generic;

namespace App.Infra.Data.Repository.Slides
{
    public interface ISlideShowRepository : IRepositoryBase<SlideShow>
	{
		IEnumerable<SlideShow> PagedList(Paging page);

		IEnumerable<SlideShow> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);
	}
}