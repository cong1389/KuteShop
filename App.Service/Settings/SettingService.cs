using System;
using System.Collections;
using App.Core.Caching;
using App.Core.Utilities;
using App.Domain.Entities.Setting;
using App.Infra.Data.Common;
using App.Infra.Data.Repository.Settings;
using App.Infra.Data.UOW.Interfaces;
using System.Collections.Generic;
using System.Text;
using App.Core.ComponentModel;
using App.Core.ComponentModel.TypeConversion;
using App.Core.Configuration;
using App.Core.Extensions;

namespace App.Service.Settings
{
	public class SettingService : BaseService<Setting>, ISettingService
	{
		private const string CacheKey = "db.Setting.{0}";
		private readonly ICacheManager _cacheManager;
		private readonly ISettingRepository _settingRepository;

		public SettingService(IUnitOfWork unitOfWork, ISettingRepository settingRepository, ICacheManager cacheManager) :
			base(unitOfWork, settingRepository)
		{
			_settingRepository = settingRepository;
			_cacheManager = cacheManager;
		}

		public T LoadSetting<T>() where T : ISettings, new()
        {
			return (T)LoadSettingCore(typeof(T));
		}

		protected virtual ISettings LoadSettingCore(Type settingType)
		{
		    var settings = (ISettings)Activator.CreateInstance(settingType);

			var prefix = settingType.Name;

			foreach (var fastProp in FastProperty.GetProperties(settingType).Values)
			{
				var prop = fastProp.Property;

				// get properties we can read and write to
				if (!prop.CanWrite)
					continue;

				var key = prefix + "." + prop.Name;
				// load by store
				string setting = GetSettingByKey<string>(key,loadSharedValueIfNotFound: true);

				if (setting == null)
				{
					if (fastProp.IsSequenceType)
					{
						if ((fastProp.GetValue(settings) as IEnumerable) != null)
						{
							// Instance of IEnumerable<> was already created, most likely in the constructor of the settings concrete class.
							// In this case we shouldn't let the EnumerableConverter create a new instance but keep this one.
							continue;
						}
					}
					else
					{
						continue;
					}

				}

				var converter = TypeConverterFactory.GetConverter(prop.PropertyType);

				if (converter == null || !converter.CanConvertFrom(typeof(string)))
					continue;

				try
				{
					object value = converter.ConvertFrom(setting);

					// Set property
					fastProp.SetValue(settings, value);
				}
				catch (Exception ex)
				{
					var msg = "Could not convert setting '{0}' to type '{1}'".FormatInvariant(key, prop.PropertyType.Name);
				}
			}

			return settings;
		}

		public virtual void SetSetting<T>(string key, T value, bool cache = true)
		{
			var str = value.Convert<string>();
			
			var setting = GetSetting(key);
			if (setting != null)
			{
				// Update
				if (setting.Value != str)
				{
					setting.Value = str;
					Update(setting);
				}
			}
			else
			{
				// Insert
				var model = new Setting
				{
					Name = key.ToLowerInvariant(),
					Value = str,
					StoreId = 1
				};
				Update(model);
			}


		}

		public Setting GetSetting(string name, bool isCache = true)
		{
			Setting locale;

			if (isCache)
			{
				var sbKey = new StringBuilder();
				sbKey.AppendFormat(CacheKey, "GetByName");

				if (!string.IsNullOrEmpty(name))
				{
					sbKey.AppendFormat("-{0}", name);
				}

				var key = sbKey.ToString();
				locale = _cacheManager.Get<Setting>(key);
				if (locale == null)
				{
					locale = _settingRepository.Get(x => x.Name == name);
					_cacheManager.Put(key, locale);
				}
			}
			else
			{
				locale = _settingRepository.Get(x => x.Name == name);
			}

			return locale;
		}

		public virtual T GetSettingByKey<T>(
			string key,
			T defaultValue = default(T),
			int storeId = 0,
			bool loadSharedValueIfNotFound = false)
		{
			var settings = GetSetting(key);

			return settings.Value.Convert<T>();
		}

		public IEnumerable<Setting> PagedList(SortingPagingBuilder sortbuBuilder, Paging page)
		{
			return _settingRepository.PagedSearchList(sortbuBuilder, page);
		}
	}
}