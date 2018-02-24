using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using App.Core.Utils;
using App.Domain.Interfaces.Repository;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;

namespace App.Infra.Data.Repository.Language
{
	public class LanguageRepository : RepositoryBase<Domain.Entities.Language.Language>, ILanguageRepository, IRepositoryBase<Domain.Entities.Language.Language>
	{
        public LanguageRepository(IDbFactory dbFactory) : base(dbFactory)
        {
        }

		protected override IOrderedQueryable<Domain.Entities.Language.Language> GetDefaultOrder(IQueryable<Domain.Entities.Language.Language> query)
		{
			IOrderedQueryable<Domain.Entities.Language.Language> languages = 
				from p in query
				orderby p.Id
				select p;
			return languages;
		}

		public Domain.Entities.Language.Language GetById(int id)
		{
            Domain.Entities.Language.Language language = FindBy(x => x.Id == id, false).FirstOrDefault();

            return language;
		}

		public IEnumerable<Domain.Entities.Language.Language> PagedList(Paging page)
		{
			return GetAllPagedList(page).ToList();
		}

		public IEnumerable<Domain.Entities.Language.Language> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
		{
			Expression<Func<Domain.Entities.Language.Language, bool>> expression = PredicateBuilder.True<Domain.Entities.Language.Language>();
			if (!string.IsNullOrEmpty(sortBuider.Keywords))
			{
				expression = expression.And(x => x.LanguageCode.ToLower().Contains(sortBuider.Keywords.ToLower()) || x.LanguageName.ToLower().Contains(sortBuider.Keywords.ToLower()));
			}
			return FindAndSort(expression, sortBuider.Sorts, page);
		}
	}
}