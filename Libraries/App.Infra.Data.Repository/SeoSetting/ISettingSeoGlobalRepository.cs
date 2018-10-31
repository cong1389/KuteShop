using App.Core.Utilities;
using App.Domain.Interfaces.Repository;
using App.Domain.SettingSeoes;
using System.Collections.Generic;

namespace App.Infra.Data.Repository.SeoSetting
{
    public interface ISettingSeoGlobalRepository : IRepositoryBase<SettingSeoGlobal>
	{
		SettingSeoGlobal GetById(int id);

		IEnumerable<SettingSeoGlobal> PagedList(Paging page);

		IEnumerable<SettingSeoGlobal> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);
	}
}