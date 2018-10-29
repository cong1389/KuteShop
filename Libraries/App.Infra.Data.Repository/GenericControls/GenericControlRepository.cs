using System.Collections.Generic;
using System.Linq;
using App.Core.Utilities;
using App.Domain.GenericControls;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;

namespace App.Infra.Data.Repository.GenericControls
{
    public class GenericControlRepository : RepositoryBase<GenericControl>, IGenericControlRepository
	{
		public GenericControlRepository(IDbFactory dbFactory) : base(dbFactory)
		{
		}

		public GenericControl GetById(int id)
		{
			var genericControl = FindBy(x => x.Id == id).FirstOrDefault();
			return genericControl;
		}

		protected override IOrderedQueryable<GenericControl> GetDefaultOrder(IQueryable<GenericControl> query)
		{
			var genericControls = 
				from p in query
				orderby p.Id
				select p;
			return genericControls;
		}

		public IEnumerable<GenericControl> PagedList(Paging page)
		{
			return GetAllPagedList(page).ToList();
		}

		public IEnumerable<GenericControl> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
		{
			var expression = PredicateBuilder.True<GenericControl>();
			if (!string.IsNullOrEmpty(sortBuider.Keywords))
			{
				expression = expression.And(x => x.Name.ToLower().Contains(sortBuider.Keywords.ToLower()) || x.Description.ToLower().Contains(sortBuider.Keywords.ToLower()));
			}
			return FindAndSort(expression, sortBuider.Sorts, page);
		}
	}
}