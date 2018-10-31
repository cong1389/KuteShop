using App.Core.Caching;
using App.Core.Utilities;
using App.Domain.Common;
using App.Domain.ContactInfors;
using App.Infra.Data.Common;
using App.Infra.Data.Repository.ContactInfors;
using App.Infra.Data.UOW.Interfaces;
using System.Collections.Generic;
using System.Text;

namespace App.Service.ContactInfors
{
    public class ContactInfoService : BaseService<ContactInformation>, IContactInfoService
    {
        private const string CacheKey = "db.ContactInfo.{0}";
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

        public ContactInformation GetById(int id, bool isCache = true)
        {
            ContactInformation contactInformation;

            if (isCache)
            {
                var sbKey = new StringBuilder();
                sbKey.AppendFormat(CacheKey, "GetById");
                sbKey.Append(id);

                var key = sbKey.ToString();
                contactInformation = _cacheManager.Get<ContactInformation>(key);
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

        public IEnumerable<ContactInformation> PagedList(SortingPagingBuilder sortbuBuilder, Paging page)
        {
            return _contactInfoRepository.PagedSearchList(sortbuBuilder, page);
        }

        public int Save()
        {
            return _unitOfWork.Commit();
        }

        public ContactInformation GetTypeAddress(int typeAddress, bool isCache = true)
        {
            ContactInformation contactInformation;

            if (isCache)
            {
                var sbKey = new StringBuilder();
                sbKey.AppendFormat(CacheKey, "GetTypeAddress");
                sbKey.Append(typeAddress);

                var key = sbKey.ToString();
                contactInformation = _cacheManager.Get<ContactInformation>(key);
                if (contactInformation == null)
                {
                    contactInformation = _contactInfoRepository.Get(x => x.Status == 1 && x.Type == typeAddress, true);
                    _cacheManager.Put(key, contactInformation);
                }
            }
            else
            {
                contactInformation = _contactInfoRepository.GetById(typeAddress);
            }


            return contactInformation;
        }

        public IEnumerable<ContactInformation> GetEnableOrDisables(bool enable = true, bool isCache = true)
        {
            if (!isCache)
            {
                return _contactInfoRepository.FindBy(x => x.Status == (enable ? (int)Status.Enable : (int)Status.Disable), true);
            }

            var sbKey = new StringBuilder();
            sbKey.AppendFormat(CacheKey, "GetEnableOrDisables");
            sbKey.Append(enable);

            var key = sbKey.ToString();

            var slideShows = _cacheManager.GetCollection<ContactInformation>(key);
            if (slideShows == null)
            {
                slideShows = _contactInfoRepository.FindBy(x => x.Status == (enable ? (int)Status.Enable : (int)Status.Disable), true);
                _cacheManager.Put(key, slideShows);
            }

            return slideShows;
        }
    }
}