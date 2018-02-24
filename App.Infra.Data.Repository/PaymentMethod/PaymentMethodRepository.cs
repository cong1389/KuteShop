using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using App.Core.Utils;
using App.Domain.Entities.Payments;
using App.Domain.Interfaces.Repository;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;

namespace App.Infra.Data.Repository.PaymentMethodes
{
    public class PaymentMethodRepository : RepositoryBase<PaymentMethod>, IPaymentMethodRepository, IRepositoryBase<PaymentMethod>
	{
		public PaymentMethodRepository(IDbFactory dbFactory) : base(dbFactory)
		{
		}

		public PaymentMethod GetById(int id)
		{
			PaymentMethod province = FindBy(x => x.Id == id, false).FirstOrDefault();
			return province;
		}

		protected override IOrderedQueryable<PaymentMethod> GetDefaultOrder(IQueryable<PaymentMethod> query)
		{
			IOrderedQueryable<PaymentMethod> PaymentMethod = 
				from p in query
				orderby p.Id
				select p;
			return PaymentMethod;
		}

		public IEnumerable<PaymentMethod> PagedList(Paging page)
		{
			return GetAllPagedList(page).ToList();
		}

		public IEnumerable<PaymentMethod> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
		{
			Expression<Func<PaymentMethod, bool>> expression = PredicateBuilder.True<PaymentMethod>();
			if (!string.IsNullOrEmpty(sortBuider.Keywords))
			{
				expression = expression.And(x => x.PaymentMethodSystemName.ToLower().Contains(sortBuider.Keywords.ToLower()));
			}
			return FindAndSort(expression, sortBuider.Sorts, page);
		}
	}
}