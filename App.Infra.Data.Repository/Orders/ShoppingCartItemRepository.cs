using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using App.Core.Utils;
using App.Domain.Entities.Orders;
using App.Domain.Interfaces.Repository;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;

namespace App.Infra.Data.Repository.Orders
{
    public class ShoppingCartItemRepository : RepositoryBase<ShoppingCartItem>, IShoppingCartItemRepository, IRepositoryBase<ShoppingCartItem>
    {
        public ShoppingCartItemRepository(IDbFactory dbFactory) : base(dbFactory)
        {
        }

        public ShoppingCartItem GetById(int Id)
        {
            ShoppingCartItem shopCart = FindBy(x => x.Id == Id, false).FirstOrDefault();
            return shopCart;
        }

        protected override IOrderedQueryable<ShoppingCartItem> GetDefaultOrder(IQueryable<ShoppingCartItem> query)
        {
            IOrderedQueryable<ShoppingCartItem> orders =
                from p in query
                orderby p.Id
                select p;
            return orders;
        }

        public IEnumerable<ShoppingCartItem> PagedList(Paging page)
		{
			return GetAllPagedList(page).ToList();
		}

		public IEnumerable<ShoppingCartItem> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
		{
			Expression<Func<ShoppingCartItem, bool>> expression = PredicateBuilder.True<ShoppingCartItem>();
			if (!string.IsNullOrEmpty(sortBuider.Keywords))
			{
				expression = expression.And(x =>x.CreatedDate.ToString("dd/MM/yyyy").ToLower().Contains(sortBuider.Keywords.ToLower()));
			}
			return FindAndSort(expression, sortBuider.Sorts, page);
		}
	}
}