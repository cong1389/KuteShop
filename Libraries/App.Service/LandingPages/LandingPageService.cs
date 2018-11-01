using App.Core.Utilities;
using App.Domain.LandingPages;
using App.Infra.Data.Common;
using App.Infra.Data.Repository.LandingPages;
using App.Infra.Data.UOW.Interfaces;
using System.Collections.Generic;

namespace App.Service.LandingPages
{
    public class LandingPageService : BaseService<LandingPage>, ILandingPageService
	{
		private readonly ILandingPageRepository _landingPageRepository;

	    public LandingPageService(IUnitOfWork unitOfWork, ILandingPageRepository landingPageRepository) : base(unitOfWork, landingPageRepository)
		{
		    _landingPageRepository = landingPageRepository;
		}

		public IEnumerable<LandingPage> PagedList(SortingPagingBuilder sortbuBuilder, Paging page)
		{
			return _landingPageRepository.PagedSearchList(sortbuBuilder, page);
		}
	}
}