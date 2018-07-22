using App.Core.Utilities;
using App.Domain.Entities.Setting;
using App.Domain.Interfaces.Services;
using System.Collections.Generic;
using App.Core.Configuration;

namespace App.Service.Settings
{
	public interface ISettingService : IBaseService<Setting>
	{
		void SetSetting<T>(string key, T value, bool cache = true);

	    T LoadSetting<T>() where T : ISettings, new();

        T GetSetting<T>(
			string key,
			T defaultValue = default(T),
			int storeId = 0,
			bool loadSharedValueIfNotFound = false);

		Setting GetSetting(int? id = null, string name = null, bool isCache = true);

		IEnumerable<Setting> PagedList(SortingPagingBuilder sortBuider, Paging page);
	}
}