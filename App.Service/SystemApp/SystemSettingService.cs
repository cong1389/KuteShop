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
        private const string CacheSystemsettingKey = "db.SystemSetting.{0}";
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
            var sbKey = new StringBuilder();
            sbKey.AppendFormat(CacheSystemsettingKey, "GetById");
            sbKey.Append(id);

            var key = sbKey.ToString();
            SystemSetting systemSetting ;
            if (isCache)
            {
                systemSetting = _cacheManager.Get<SystemSetting>(key);
                if (systemSetting == null)
                {
                    systemSetting = _systemSettingRepository.GetById(id);
                    _cacheManager.Put(key, systemSetting);
                }
            }
            else
            {
                systemSetting = _systemSettingRepository.GetById(id);
            }           

            return systemSetting; 
        }

        public IEnumerable<SystemSetting> PagedList(SortingPagingBuilder sortbuBuilder, Paging page)
        {
            return _systemSettingRepository.PagedSearchList(sortbuBuilder, page);
        }
    }
}
