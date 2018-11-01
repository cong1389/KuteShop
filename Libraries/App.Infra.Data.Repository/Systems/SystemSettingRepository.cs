using App.Core.Utilities;
using App.Domain.Systems;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;
using System.Collections.Generic;
using System.Linq;

namespace App.Infra.Data.Repository.Systems
{
    public class SystemSettingRepository : RepositoryBase<SystemSetting>, ISystemSettingRepository
	{

        public SystemSettingRepository(IDbFactory dbFactory) : base(dbFactory)
		{
        }

		public SystemSetting GetById(int id)
        {
            var systemSetting = FindBy(x => x.Id == id).FirstOrDefault();
            
            return systemSetting;
		}

		protected override IOrderedQueryable<SystemSetting> GetDefaultOrder(IQueryable<SystemSetting> query)
		{
			var systemSettings = 
				from p in query
				orderby p.Id
				select p;
			return systemSettings;
		}

		public IEnumerable<SystemSetting> PagedList(Paging page)
		{
			return GetAllPagedList(page).ToList();
		}

		public IEnumerable<SystemSetting> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
		{
			var expression = PredicateBuilder.True<SystemSetting>();
			return FindAndSort(expression, sortBuider.Sorts, page);
		}
	}
}