using App.Core.Utilities;
using App.Domain.Manufacturers;
using App.Infra.Data.Common;
using App.Infra.Data.Repository.Manufacturers;
using App.Infra.Data.UOW.Interfaces;
using System.Collections.Generic;

namespace App.Service.Manufacturers
{
    public class ManufacturerService : BaseService<Manufacturer>, IManufacturerService
	{
		private readonly IManufacturerRepository _manufacturerRepository;

	    public ManufacturerService(IUnitOfWork unitOfWork, IManufacturerRepository manufacturerRepository) : base(unitOfWork, manufacturerRepository)
		{
		    _manufacturerRepository = manufacturerRepository;
		}

		public IEnumerable<Manufacturer> PagedList(SortingPagingBuilder sortbuBuilder, Paging page)
		{
			return _manufacturerRepository.PagedSearchList(sortbuBuilder, page);
		}

		public IEnumerable<Manufacturer> PagedListByMenu(SortingPagingBuilder sortBuider, Paging page)
		{
			return _manufacturerRepository.PagedSearchListByMenu(sortBuider, page);
		}
	}
}