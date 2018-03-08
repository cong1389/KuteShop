using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using App.Core.Utils;
using App.Domain.Entities.GenericControl;
using App.Domain.Interfaces.Repository;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;

namespace App.Infra.Data.Repository.GenericControl
{
	public class GenericControlValueRepository : RepositoryBase<GenericControlValue>, IGenericControlValueRepository, IRepositoryBase<GenericControlValue>
	{
		public GenericControlValueRepository(IDbFactory dbFactory) : base(dbFactory)
		{
		}

		public GenericControlValue GetById(int Id)
		{
			GenericControlValue GenericControlValue = FindBy(x => x.Id == Id).FirstOrDefault();
			return GenericControlValue;
		}

		protected override IOrderedQueryable<GenericControlValue> GetDefaultOrder(IQueryable<GenericControlValue> query)
		{
			IOrderedQueryable<GenericControlValue> GenericControlValues = 
				from p in query
				orderby p.Id
				select p;
			return GenericControlValues;
		}

		public IEnumerable<GenericControlValue> PagedList(Paging page)
		{
			return GetAllPagedList(page).ToList();
		}

		public IEnumerable<GenericControlValue> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
		{
			Expression<Func<GenericControlValue, bool>> expression = PredicateBuilder.True<GenericControlValue>();
			if (!string.IsNullOrEmpty(sortBuider.Keywords))
			{
				expression = expression.And(x => x.ValueName.ToLower().Contains(sortBuider.Keywords.ToLower()) || x.Description.ToLower().Contains(sortBuider.Keywords.ToLower()) || x.GenericControl.Name.ToLower().Contains(sortBuider.Keywords.ToLower()));
			}
			return FindAndSort(expression, sortBuider.Sorts, page);
		}
	}
}