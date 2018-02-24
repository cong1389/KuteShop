using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using App.Core.Utils;
using App.Domain.Interfaces.Repository;
using App.Domain.Shippings;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;

namespace App.Infra.Data.Repository.ShippingMethods
{
    public class ShippingMethodRepository : RepositoryBase<ShippingMethod>, IShippingMethodRepository, IRepositoryBase<ShippingMethod>
	{
		public ShippingMethodRepository(IDbFactory dbFactory) : base(dbFactory)
		{
		}

		public ShippingMethod GetById(int id)
		{
			ShippingMethod province = FindBy(x => x.Id == id, false).FirstOrDefault();
			return province;
		}

		protected override IOrderedQueryable<ShippingMethod> GetDefaultOrder(IQueryable<ShippingMethod> query)
		{
			IOrderedQueryable<ShippingMethod> ShippingMethod = 
				from p in query
				orderby p.Id
				select p;
			return ShippingMethod;
		}

		public IEnumerable<ShippingMethod> PagedList(Paging page)
		{
			return GetAllPagedList(page).ToList();
		}

		public IEnumerable<ShippingMethod> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
		{
			Expression<Func<ShippingMethod, bool>> expression = PredicateBuilder.True<ShippingMethod>();
			if (!string.IsNullOrEmpty(sortBuider.Keywords))
			{
				expression = expression.And(x => x.Name.ToLower().Contains(sortBuider.Keywords.ToLower()) || x.Description.ToLower().Contains(sortBuider.Keywords.ToLower()));
			}
			return FindAndSort(expression, sortBuider.Sorts, page);
		}
	}
}