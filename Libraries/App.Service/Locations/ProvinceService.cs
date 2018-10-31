using App.Core.Utilities;
using App.Domain.Locations;
using App.Infra.Data.Common;
using App.Infra.Data.Repository.Locations;
using App.Infra.Data.UOW.Interfaces;
using System.Collections.Generic;

namespace App.Service.Locations
{
    public class ProvinceService : BaseService<Province>, IProvinceService
	{
		private readonly IProvinceRepository _provinceRepository;

	    public ProvinceService(IUnitOfWork unitOfWork, IProvinceRepository provinceRepository) : base(unitOfWork, provinceRepository)
		{
		    _provinceRepository = provinceRepository;
		}

		public Province GetById(int id)
		{
			return _provinceRepository.GetById(id);
		}

		public IEnumerable<Province> PagedList(SortingPagingBuilder sortbuBuilder, Paging page)
		{
			return _provinceRepository.PagedSearchList(sortbuBuilder, page);
		}
	}
}