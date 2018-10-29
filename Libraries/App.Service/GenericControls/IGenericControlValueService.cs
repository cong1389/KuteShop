using System.Collections.Generic;
using App.Core.Utilities;
using App.Domain.GenericControls;
using App.Domain.Interfaces.Services;

namespace App.Service.GenericControls
{
	public interface IGenericControlValueService : IBaseService<GenericControlValue>
	{
		GenericControlValue GetById(int id, bool isCache = true);

        IEnumerable<GenericControlValue> GetByEntityId(int entityId);

        IEnumerable<GenericControlValue> PagedList(SortingPagingBuilder sortBuider, Paging page);
	}
}