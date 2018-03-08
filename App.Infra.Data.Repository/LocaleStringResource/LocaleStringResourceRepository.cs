using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using App.Core.Utils;
using App.Domain.Interfaces.Repository;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;

namespace App.Infra.Data.Repository.LocaleStringResource
{
    public class LocaleStringResourceRepository : RepositoryBase<Domain.Entities.Language.LocaleStringResource>, ILocaleStringResourceRepository, IRepositoryBase<Domain.Entities.Language.LocaleStringResource>
	{

        public LocaleStringResourceRepository(IDbFactory dbFactory) : base(dbFactory)
		{
        }

        public Domain.Entities.Language.LocaleStringResource GetLocaleStringResourceById(int id)
        {
            Domain.Entities.Language.LocaleStringResource localeString = FindBy(x => x.Id == id).FirstOrDefault();
            
            return localeString;
        }

        protected override IOrderedQueryable<Domain.Entities.Language.LocaleStringResource> GetDefaultOrder(IQueryable<Domain.Entities.Language.LocaleStringResource> query)
        {
            IOrderedQueryable<Domain.Entities.Language.LocaleStringResource> attributes =
                from p in query
                orderby p.Id
                select p;
            return attributes;
        }

        public IEnumerable<Domain.Entities.Language.LocaleStringResource> PagedList(Paging page)
        {
            return GetAllPagedList(page).ToList();
        }

        public IEnumerable<Domain.Entities.Language.LocaleStringResource> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
        {
            Expression<Func<Domain.Entities.Language.LocaleStringResource, bool>> expression = PredicateBuilder.True<Domain.Entities.Language.LocaleStringResource>();
            if (!string.IsNullOrEmpty(sortBuider.Keywords))
            {
                expression = expression.And(x => x.ResourceName.ToLower().Contains(sortBuider.Keywords.ToLower()) || x.ResourceName.ToLower().Contains(sortBuider.Keywords.ToLower()));
            }
            return FindAndSort(expression, sortBuider.Sorts, page);
        }
    }
}