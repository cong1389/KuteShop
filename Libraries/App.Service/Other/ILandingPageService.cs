using App.Core.Utilities;
using App.Domain.Interfaces.Services;
using App.Domain.LandingPages;
using System.Collections.Generic;

namespace App.Service.Other
{
    public interface ILandingPageService : IBaseService<LandingPage>
	{
		IEnumerable<LandingPage> PagedList(SortingPagingBuilder sortBuider, Paging page);
	}
}