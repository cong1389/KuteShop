using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using App.Core.Utils;
using App.Domain.Entities.Language;
using App.Domain.Interfaces.Repository;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;

namespace App.Infra.Data.Repository.Language
{
    public class LocalizedPropertyRepository : RepositoryBase<LocalizedProperty>, ILocalizedPropertyRepository, IRepositoryBase<LocalizedProperty>
	{
        public LocalizedPropertyRepository(IDbFactory dbFactory) : base(dbFactory)
		{
        }

		protected override IOrderedQueryable<LocalizedProperty> GetDefaultOrder(IQueryable<LocalizedProperty> query)
		{
			IOrderedQueryable<LocalizedProperty> languages = 
				from p in query
				orderby p.Id
				select p;
			return languages;
		}

		public LocalizedProperty GetId(int id)
		{
            LocalizedProperty language = FindBy(x => x.Id == id).FirstOrDefault();

            return language;
		}

		public IEnumerable<LocalizedProperty> PagedList(Paging page)
		{
			return GetAllPagedList(page).ToList();
		}

		public IEnumerable<LocalizedProperty> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
		{
			Expression<Func<LocalizedProperty, bool>> expression = PredicateBuilder.True<LocalizedProperty>();
			if (!string.IsNullOrEmpty(sortBuider.Keywords))
			{
				expression = expression.And(x => x.LocaleKey.ToLower().Contains(sortBuider.Keywords.ToLower()) || x.LocaleKey.ToLower().Contains(sortBuider.Keywords.ToLower()));
			}
			return FindAndSort(expression, sortBuider.Sorts, page);
		}
	}
}