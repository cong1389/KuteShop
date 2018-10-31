using System.Collections.Generic;
using System.Linq;
using App.Core.Utilities;
using App.Domain.Languages;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;

namespace App.Infra.Data.Repository.Languages
{
    public class LanguageRepository : RepositoryBase<Language>, ILanguageRepository
	{
        public LanguageRepository(IDbFactory dbFactory) : base(dbFactory)
        {
        }

		protected override IOrderedQueryable<Language> GetDefaultOrder(IQueryable<Language> query)
		{
			var languages = 
				from p in query
				orderby p.Id
				select p;
			return languages;
		}

		public Language GetById(int id)
		{
            var language = FindBy(x => x.Id == id).FirstOrDefault();

            return language;
		}

		public IEnumerable<Language> PagedList(Paging page)
		{
			return GetAllPagedList(page).ToList();
		}

		public IEnumerable<Language> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
		{
			var expression = PredicateBuilder.True<Language>();
			if (!string.IsNullOrEmpty(sortBuider.Keywords))
			{
				expression = expression.And(x => x.LanguageCode.ToLower().Contains(sortBuider.Keywords.ToLower()) || x.LanguageName.ToLower().Contains(sortBuider.Keywords.ToLower()));
			}
			return FindAndSort(expression, sortBuider.Sorts, page);
		}
	}
}