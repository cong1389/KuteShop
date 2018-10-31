using System.Collections.Generic;
using System.Linq;
using App.Core.Utilities;
using App.Domain.Languages;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;

namespace App.Infra.Data.Repository.LocaleStringResources
{
    public class LocaleStringResourceRepository : RepositoryBase<LocaleStringResource>, ILocaleStringResourceRepository
	{

        public LocaleStringResourceRepository(IDbFactory dbFactory) : base(dbFactory)
		{
        }

        public LocaleStringResource GetLocaleStringResourceById(int id)
        {
            var localeString = FindBy(x => x.Id == id).FirstOrDefault();
            
            return localeString;
        }

        protected override IOrderedQueryable<LocaleStringResource> GetDefaultOrder(IQueryable<LocaleStringResource> query)
        {
            var attributes =
                from p in query
                orderby p.Id
                select p;
            return attributes;
        }

        public IEnumerable<LocaleStringResource> PagedList(Paging page)
        {
            return GetAllPagedList(page).ToList();
        }

        public IEnumerable<LocaleStringResource> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
        {
            var expression = PredicateBuilder.True<LocaleStringResource>();
            if (!string.IsNullOrEmpty(sortBuider.Keywords))
            {
                expression = expression.And(x => x.ResourceName.ToLower().Contains(sortBuider.Keywords.ToLower()) || x.ResourceName.ToLower().Contains(sortBuider.Keywords.ToLower()));
            }
            return FindAndSort(expression, sortBuider.Sorts, page);
        }
    }
}