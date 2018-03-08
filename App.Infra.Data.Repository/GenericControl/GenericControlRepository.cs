using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using App.Core.Utils;
using App.Domain.Interfaces.Repository;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;

namespace App.Infra.Data.Repository.GenericControl
{
	public class GenericControlRepository : RepositoryBase<Domain.Entities.GenericControl.GenericControl>, IGenericControlRepository, IRepositoryBase<Domain.Entities.GenericControl.GenericControl>
	{
		public GenericControlRepository(IDbFactory dbFactory) : base(dbFactory)
		{
		}

		public Domain.Entities.GenericControl.GenericControl GetById(int Id)
		{
			Domain.Entities.GenericControl.GenericControl GenericControl = FindBy(x => x.Id == Id).FirstOrDefault();
			return GenericControl;
		}

		protected override IOrderedQueryable<Domain.Entities.GenericControl.GenericControl> GetDefaultOrder(IQueryable<Domain.Entities.GenericControl.GenericControl> query)
		{
			IOrderedQueryable<Domain.Entities.GenericControl.GenericControl> GenericControls = 
				from p in query
				orderby p.Id
				select p;
			return GenericControls;
		}

		public IEnumerable<Domain.Entities.GenericControl.GenericControl> PagedList(Paging page)
		{
			return GetAllPagedList(page).ToList();
		}

		public IEnumerable<Domain.Entities.GenericControl.GenericControl> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
		{
			Expression<Func<Domain.Entities.GenericControl.GenericControl, bool>> expression = PredicateBuilder.True<Domain.Entities.GenericControl.GenericControl>();
			if (!string.IsNullOrEmpty(sortBuider.Keywords))
			{
				expression = expression.And(x => x.Name.ToLower().Contains(sortBuider.Keywords.ToLower()) || x.Description.ToLower().Contains(sortBuider.Keywords.ToLower()));
			}
			return FindAndSort(expression, sortBuider.Sorts, page);
		}
	}
}