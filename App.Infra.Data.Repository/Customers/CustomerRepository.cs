using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using App.Core.Utils;
using App.Domain.Interfaces.Repository;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;
using Domain.Entities.Customers;

namespace App.Infra.Data.Repository.Customers
{
    public class CustomerRepository : RepositoryBase<Customer>, ICustomerRepository, IRepositoryBase<Customer>
	{
		public CustomerRepository(IDbFactory dbFactory) : base(dbFactory)
		{
		}

		public Customer GetById(int id)
		{
			Customer province = FindBy(x => x.Id == id).FirstOrDefault();
			return province;
		}

		protected override IOrderedQueryable<Customer> GetDefaultOrder(IQueryable<Customer> query)
		{
			IOrderedQueryable<Customer> Customer = 
				from p in query
				orderby p.Id
				select p;
			return Customer;
		}

		public IEnumerable<Customer> PagedList(Paging page)
		{
			return GetAllPagedList(page).ToList();
		}

		public IEnumerable<Customer> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
		{
			Expression<Func<Customer, bool>> expression = PredicateBuilder.True<Customer>();
			if (!string.IsNullOrEmpty(sortBuider.Keywords))
			{
				expression = expression.And(x => x.Username.ToLower().Contains(sortBuider.Keywords.ToLower()) || x.Email.ToLower().Contains(sortBuider.Keywords.ToLower()));
			}
			return FindAndSort(expression, sortBuider.Sorts, page);
		}
	}
}