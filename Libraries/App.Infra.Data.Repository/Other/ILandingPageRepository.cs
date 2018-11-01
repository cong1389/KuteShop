using App.Core.Utilities;
using App.Domain.Interfaces.Repository;
using App.Domain.LandingPages;
using System.Collections.Generic;

namespace App.Infra.Data.Repository.Other
{
    public interface ILandingPageRepository : IRepositoryBase<LandingPage>
	{
		IEnumerable<LandingPage> PagedList(Paging page);

		IEnumerable<LandingPage> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);
	}
}