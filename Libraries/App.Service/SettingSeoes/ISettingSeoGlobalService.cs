using App.Core.Utilities;
using App.Domain.Interfaces.Services;
using App.Domain.SettingSeoes;
using System.Collections.Generic;

namespace App.Service.SettingSeoes
{
    public interface ISettingSeoGlobalService : IBaseService<SettingSeoGlobal>
	{
		SettingSeoGlobal GetById(int id);

		IEnumerable<SettingSeoGlobal> PagedList(SortingPagingBuilder sortBuider, Paging page);

	    SettingSeoGlobal GetEnableOrDisable(bool enable = true, bool isCache = true);

	}
}