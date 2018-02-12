using System.Collections.Generic;
using App.Core.Utils;
using App.Domain.Entities.Payments;
using App.Domain.Interfaces.Services;

namespace App.Service.PaymentMethodes
{
    public interface IPaymentMethodService : IBaseService<PaymentMethod>
	{
		PaymentMethod GetById(int id);

        PaymentMethod GetBySystemName(string systemName);

        IEnumerable<PaymentMethod> PagedList(SortingPagingBuilder sortBuider, Paging page);
	}
}