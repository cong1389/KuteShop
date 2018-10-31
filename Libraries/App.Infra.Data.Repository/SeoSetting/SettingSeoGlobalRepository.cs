using App.Core.Utilities;
using App.Domain.SettingSeoes;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;
using System.Collections.Generic;
using System.Linq;

namespace App.Infra.Data.Repository.SeoSetting
{
    public class SettingSeoGlobalRepository : RepositoryBase<SettingSeoGlobal>, ISettingSeoGlobalRepository
	{
		public SettingSeoGlobalRepository(IDbFactory dbFactory) : base(dbFactory)
		{
		}

		public SettingSeoGlobal GetById(int id)
		{
			var settingSeoGlobal = FindBy(x => x.Id == id).FirstOrDefault();
			return settingSeoGlobal;
		}

		protected override IOrderedQueryable<SettingSeoGlobal> GetDefaultOrder(IQueryable<SettingSeoGlobal> query)
		{
			var settingSeoGlobals = 
				from p in query
				orderby p.Id
				select p;
			return settingSeoGlobals;
		}

		public IEnumerable<SettingSeoGlobal> PagedList(Paging page)
		{
			return GetAllPagedList(page).ToList();
		}

		public IEnumerable<SettingSeoGlobal> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
		{
			var expression = PredicateBuilder.True<SettingSeoGlobal>();
			return FindAndSort(expression, sortBuider.Sorts, page);
		}
	}
}