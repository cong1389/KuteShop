using App.Core.Utilities;
using App.Domain.Interfaces.Repository;
using App.Domain.Systems;
using System.Collections.Generic;

namespace App.Infra.Data.Repository.Systems
{
    public interface ISystemSettingRepository : IRepositoryBase<SystemSetting>
	{
		SystemSetting GetById(int id);

		IEnumerable<SystemSetting> PagedList(Paging page);

		IEnumerable<SystemSetting> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);
	}
}