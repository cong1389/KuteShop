using System.Collections.Generic;
using System.Text;
using App.Core.Caching;
using App.Core.Utils;
using App.Domain.Entities.GlobalSetting;
using App.Infra.Data.Common;
using App.Infra.Data.Repository.SeoSetting;
using App.Infra.Data.UOW.Interfaces;

namespace App.Service.SeoSetting
{
	public class SettingSeoGlobalService : BaseService<SettingSeoGlobal>, ISettingSeoGlobalService
	{
        private const string CacheSettingseoglobalKey = "db.SettingSeoGlobal.{0}";
        private readonly ICacheManager _cacheManager;

        private readonly ISettingSeoGlobalRepository _settingSeoGlobalRepository;

	    public SettingSeoGlobalService(IUnitOfWork unitOfWork, ISettingSeoGlobalRepository settingSeoGlobalRepository
            , ICacheManager cacheManager) : base(unitOfWork, settingSeoGlobalRepository)
		{
		    _settingSeoGlobalRepository = settingSeoGlobalRepository;
            _cacheManager = cacheManager;

        }

		public SettingSeoGlobal GetById(int id)
		{
            var sbKey = new StringBuilder();
            sbKey.AppendFormat(CacheSettingseoglobalKey, "GetById");
            sbKey.Append(id);

            var key = sbKey.ToString();
            var settingSeoGlobal = _cacheManager.Get<SettingSeoGlobal>(key);
            if (settingSeoGlobal == null)
            {
                settingSeoGlobal = _settingSeoGlobalRepository.GetById(id);
                _cacheManager.Put(key, settingSeoGlobal);
            }

            return settingSeoGlobal;
		}

		public IEnumerable<SettingSeoGlobal> PagedList(SortingPagingBuilder sortbuBuilder, Paging page)
		{
			return _settingSeoGlobalRepository.PagedSearchList(sortbuBuilder, page);
		}
	}
}