using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using App.Core.Utils;
using App.Domain.Entities.Brandes;
using App.Domain.Interfaces.Repository;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;

namespace App.Infra.Data.Repository.Brandes
{
	public class BrandRepository : RepositoryBase<Brand>, IBrandRepository, IRepositoryBase<Brand>
	{
		public BrandRepository(IDbFactory dbFactory) : base(dbFactory)
		{
		}

		public Brand GetById(int id)
		{
			Brand province = FindBy(x => x.Id == id, false).FirstOrDefault();
			return province;
		}

		protected override IOrderedQueryable<Brand> GetDefaultOrder(IQueryable<Brand> query)
		{
			IOrderedQueryable<Brand> Brand = 
				from p in query
				orderby p.Id
				select p;
			return Brand;
		}

		public IEnumerable<Brand> PagedList(Paging page)
		{
			return GetAllPagedList(page).ToList();
		}

		public IEnumerable<Brand> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
		{
			Expression<Func<Brand, bool>> expression = PredicateBuilder.True<Brand>();
			if (!string.IsNullOrEmpty(sortBuider.Keywords))
			{
				expression = expression.And(x => x.Name.ToLower().Contains(sortBuider.Keywords.ToLower()) || x.Description.ToLower().Contains(sortBuider.Keywords.ToLower()));
			}
			return FindAndSort(expression, sortBuider.Sorts, page);
		}
	}
}