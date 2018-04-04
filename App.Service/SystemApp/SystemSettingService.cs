using System.Collections.Generic;
using System.Text;
using App.Core.Caching;
using App.Core.Utils;
using App.Domain.Entities.GlobalSetting;
using App.Infra.Data.Common;
using App.Infra.Data.Repository.System;
using App.Infra.Data.UOW.Interfaces;

namespace App.Service.SystemApp
{
    public class SystemSettingService : BaseService<SystemSetting>, ISystemSettingService
    {
        private const string CacheKey = "db.SystemSetting.{0}";
        private readonly ICacheManager _cacheManager;

        private readonly ISystemSettingRepository _systemSettingRepository;

        public SystemSettingService(IUnitOfWork unitOfWork, ISystemSettingRepository systemSettingRepository
            , ICacheManager cacheManager) : base(unitOfWork, systemSettingRepository)
        {
            _systemSettingRepository = systemSettingRepository;
            _cacheManager = cacheManager;
        }

        public SystemSetting GetById(int id, bool isCache = true)
        {
            if (!isCache)
            {
                return _systemSettingRepository.GetById(id); 
            }

            var sbKey = new StringBuilder();
            sbKey.AppendFormat(CacheKey, "GetById");
            sbKey.Append(id);

            var key = sbKey.ToString();

            var systemSetting = _cacheManager.Get<SystemSetting>(key);
            if (systemSetting == null)
            {
                systemSetting = _systemSettingRepository.GetById(id);
                _cacheManager.Put(key, systemSetting);
            }

            return systemSetting; 
        }

        public SystemSetting GetEnableOrDisable(bool enable = true, bool isCache = true)
        {
            if (!isCache)
            {
                return _systemSettingRepository.Get(x => x.Status == (enable ? 1 : 0));
            }

            var sbKey = new StringBuilder();
            sbKey.AppendFormat(CacheKey, "GetEnableOrDisables");
            sbKey.Append(enable);

            var key = sbKey.ToString();

            var systemSetting = _cacheManager.Get<SystemSetting>(key);
            if (systemSetting == null)
            {
                systemSetting = _systemSettingRepository.Get(x => x.Status == (enable ? 1 : 0));
                _cacheManager.Put(key, systemSetting);
            }

            return systemSetting;
        }

        public IEnumerable<SystemSetting> GetEnableOrDisables(bool enable = true, bool isCache = true)
        {
            if (!isCache)
            {
                return _systemSettingRepository.FindBy(x => x.Status == (enable ? 1 : 0), true);
            }

            var sbKey = new StringBuilder();
            sbKey.AppendFormat(CacheKey, "GetEnableOrDisables");
            sbKey.Append(enable);

            var key = sbKey.ToString();

            var systemSettings = _cacheManager.GetCollection<SystemSetting>(key);
            if (systemSettings == null)
            {
                systemSettings = _systemSettingRepository.FindBy(x => x.Status == (enable ? 1 : 0), true);
                _cacheManager.Put(key, systemSettings);
            }

            return systemSettings;
        }
        
        public IEnumerable<SystemSetting> PagedList(SortingPagingBuilder sortbuBuilder, Paging page)
        {
            return _systemSettingRepository.PagedSearchList(sortbuBuilder, page);
        }
    }
}
