using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using App.Core.Utils;
using App.Domain.Entities.GlobalSetting;
using App.Domain.Interfaces.Repository;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;

namespace App.Infra.Data.Repository.System
{
	public class SystemSettingRepository : RepositoryBase<SystemSetting>, ISystemSettingRepository, IRepositoryBase<SystemSetting>
	{

        public SystemSettingRepository(IDbFactory dbFactory) : base(dbFactory)
		{
        }

		public SystemSetting GetById(int id)
        {
            SystemSetting systemSetting = FindBy(x => x.Id == id, false).FirstOrDefault();
            
            return systemSetting;
		}

		protected override IOrderedQueryable<SystemSetting> GetDefaultOrder(IQueryable<SystemSetting> query)
		{
			IOrderedQueryable<SystemSetting> systemSettings = 
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
			Expression<Func<SystemSetting, bool>> expression = PredicateBuilder.True<SystemSetting>();
			return FindAndSort(expression, sortBuider.Sorts, page);
		}
	}
}