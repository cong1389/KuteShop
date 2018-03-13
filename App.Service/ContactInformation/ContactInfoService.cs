using System.Collections.Generic;
using System.Text;
using App.Core.Caching;
using App.Core.Utils;
using App.Infra.Data.Common;
using App.Infra.Data.Repository.ContactInformation;
using App.Infra.Data.UOW.Interfaces;

namespace App.Service.ContactInformation
{
    public class ContactInfoService : BaseService<Domain.Entities.GlobalSetting.ContactInformation>, IContactInfoService
    {
        private const string CacheContactinfoKey = "db.ContactInfo.{0}";
        private readonly ICacheManager _cacheManager;

        private readonly IContactInfoRepository _contactInfoRepository;

        private readonly IUnitOfWork _unitOfWork;

        public ContactInfoService(IUnitOfWork unitOfWork, IContactInfoRepository contactInfoRepository
            , ICacheManager cacheManager) : base(unitOfWork, contactInfoRepository)
        {
            _unitOfWork = unitOfWork;
            _contactInfoRepository = contactInfoRepository;
            _cacheManager = cacheManager;
        }

        public Domain.Entities.GlobalSetting.ContactInformation GetById(int id, bool isCache = true)
        {
            Domain.Entities.GlobalSetting.ContactInformation contactInformation;

            if (isCache)
            {
                var sbKey = new StringBuilder();
                sbKey.AppendFormat(CacheContactinfoKey, "GetById");
                sbKey.Append(id);

                var key = sbKey.ToString();
                contactInformation = _cacheManager.Get<Domain.Entities.GlobalSetting.ContactInformation>(key);
                if (contactInformation == null)
                {
                    contactInformation = _contactInfoRepository.GetById(id);
                    _cacheManager.Put(key, contactInformation);
                }
            }
            else
            {
                contactInformation = _contactInfoRepository.GetById(id);
            }


            return contactInformation;
        }

        public IEnumerable<Domain.Entities.GlobalSetting.ContactInformation> PagedList(SortingPagingBuilder sortbuBuilder, Paging page)
        {
            return _contactInfoRepository.PagedSearchList(sortbuBuilder, page);
        }

        public int Save()
        {
            return _unitOfWork.Commit();
        }
    }
}