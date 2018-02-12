using System.Collections.Generic;
using App.Core.Utils;
using App.Domain.Entities.Data;
using App.Infra.Data.Common;
using App.Infra.Data.Repository.Step;
using App.Infra.Data.UOW.Interfaces;

namespace App.Service.Step
{
	public class FlowStepService : BaseService<FlowStep>, IFlowStepService
	{
		private readonly IFlowStepRepository _flowStepRepository;

	    public FlowStepService(IUnitOfWork unitOfWork, IFlowStepRepository flowStepRepository) : base(unitOfWork, flowStepRepository)
		{
		    _flowStepRepository = flowStepRepository;
		}

		public IEnumerable<FlowStep> PagedList(SortingPagingBuilder sortbuBuilder, Paging page)
		{
			return _flowStepRepository.PagedSearchList(sortbuBuilder, page);
		}

		public IEnumerable<FlowStep> PagedListByMenu(SortingPagingBuilder sortBuider, Paging page)
		{
			return _flowStepRepository.PagedSearchListByMenu(sortBuider, page);
		}
	}
}