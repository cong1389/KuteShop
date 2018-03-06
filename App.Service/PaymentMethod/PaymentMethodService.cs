using System.Collections.Generic;
using System.Text;
using App.Core.Caching;
using App.Core.Extensions;
using App.Core.Utils;
using App.Domain.Entities.Payments;
using App.Infra.Data.Common;
using App.Infra.Data.Repository.PaymentMethodes;
using App.Infra.Data.UOW.Interfaces;

namespace App.Service.PaymentMethodes
{
    public class PaymentMethodService : BaseService<PaymentMethod>, IPaymentMethodService
    {
        private const string CachePaymentmethodKey = "db.PaymentMethod.{0}";
        private readonly ICacheManager _cacheManager;

        private readonly IPaymentMethodRepository _paymentMethodRepository;

        public PaymentMethodService(IUnitOfWork unitOfWork, IPaymentMethodRepository paymentMethodRepository
            , ICacheManager cacheManager) : base(unitOfWork, paymentMethodRepository)
        {
            _paymentMethodRepository = paymentMethodRepository;
            _cacheManager = cacheManager;
        }

        public PaymentMethod GetById(int id)
        {
            StringBuilder sbKey = new StringBuilder();
            sbKey.AppendFormat(CachePaymentmethodKey, "GetBySeoUrl");
            sbKey.AppendFormat("-{0}", id);

            string key = sbKey.ToString();
            PaymentMethod paymentMethod = _cacheManager.Get<PaymentMethod>(key);

            if (paymentMethod != null) return paymentMethod;

            paymentMethod = _paymentMethodRepository.GetById(id);
            _cacheManager.Put(key, paymentMethod);

            return paymentMethod;
        }
        public PaymentMethod GetBySystemName(string systemName)
        {
            StringBuilder sbKey = new StringBuilder();
            sbKey.AppendFormat(CachePaymentmethodKey, "GetBySystemName");

            if (systemName.HasValue())
                sbKey.AppendFormat("-{0}", systemName);

            string key = sbKey.ToString();
            PaymentMethod paymentMethod = _cacheManager.Get<PaymentMethod>(key);

            if (paymentMethod != null) return paymentMethod;

            paymentMethod = _paymentMethodRepository.Get(x => x.PaymentMethodSystemName == systemName);

            _cacheManager.Put(key, paymentMethod);

            return paymentMethod;
        }

        public IEnumerable<PaymentMethod> PagedList(SortingPagingBuilder sortbuBuilder, Paging page)
        {
            return _paymentMethodRepository.PagedSearchList(sortbuBuilder, page);
        }
    }
}