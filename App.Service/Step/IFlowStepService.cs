using System.Collections.Generic;
using App.Core.Utils;
using App.Domain.Entities.Data;
using App.Domain.Interfaces.Services;

namespace App.Service.Step
{
	public interface IFlowStepService : IBaseService<FlowStep>
	{
		IEnumerable<FlowStep> PagedList(SortingPagingBuilder sortBuider, Paging page);

		IEnumerable<FlowStep> PagedListByMenu(SortingPagingBuilder sortBuider, Paging page);
	}
}