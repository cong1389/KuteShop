using App.Core.Utilities;
using App.Domain.Entities.Setting;
using App.Domain.Interfaces.Services;
using System.Collections.Generic;

namespace App.Service.Settings
{
	public interface ISettingService : IBaseService<Setting>
    {
        IEnumerable<Setting> PagedList(SortingPagingBuilder sortBuider, Paging page);
    }
}