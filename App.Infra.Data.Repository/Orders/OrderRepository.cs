using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using App.Core.Utils;
using App.Domain.Interfaces.Repository;
using App.Domain.Orders;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;

namespace App.Infra.Data.Repository.Orderes
{
    public class OrderRepository : RepositoryBase<Order>, IOrderRepository, IRepositoryBase<Order>
    {
        public OrderRepository(IDbFactory dbFactory) : base(dbFactory)
        {
        }

        public Order GetById(int id)
        {
            Order order = FindBy(x => x.Id == id, false).FirstOrDefault();
            return order;
        }

        public IEnumerable<Order> GetByCustomerId(int customerId)
        {
            IEnumerable<Order> order = FindBy(x => x.CustomerId == customerId, false);
            return order;
        }

        protected override IOrderedQueryable<Order> GetDefaultOrder(IQueryable<Order> query)
        {
            IOrderedQueryable<Order> Order =
                from p in query
                orderby p.Id
                select p;
            return Order;
        }

        public IEnumerable<Order> PagedList(Paging page)
        {
            return GetAllPagedList(page).ToList();
        }

        public IEnumerable<Order> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
        {
            Expression<Func<Order, bool>> expression = PredicateBuilder.True<Order>();
            if (!string.IsNullOrEmpty(sortBuider.Keywords))
            {
                expression = expression.And(x => x.Id.ToString().ToLower().Contains(sortBuider.Keywords.ToLower()));
            }
            return FindAndSort(expression, sortBuider.Sorts, page);
        }
    }
}