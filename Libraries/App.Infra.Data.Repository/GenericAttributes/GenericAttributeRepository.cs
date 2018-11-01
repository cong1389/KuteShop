using App.Core.Utilities;
using App.Domain.GenericAttributes;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;
using System.Collections.Generic;
using System.Linq;

namespace App.Infra.Data.Repository.GenericAttributes
{
    public class GenericAttributeRepository : RepositoryBase<GenericAttribute>, IGenericAttributeRepository
	{
		public GenericAttributeRepository(IDbFactory dbFactory) : base(dbFactory)
		{
		}

        public GenericAttribute GetAttributeById(int id)
        {
            var attribute = FindBy(x => x.Id == id).FirstOrDefault();
            return attribute;
        }

        protected override IOrderedQueryable<GenericAttribute> GetDefaultOrder(IQueryable<GenericAttribute> query)
        {
            var attributes =
                from p in query
                orderby p.Id
                select p;
            return attributes;
        }

        public IEnumerable<GenericAttribute> PagedList(Paging page)
        {
            return GetAllPagedList(page).ToList();
        }

        public IEnumerable<GenericAttribute> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
        {
            var expression = PredicateBuilder.True<GenericAttribute>();
            if (!string.IsNullOrEmpty(sortBuider.Keywords))
            {
                expression = expression.And(x => x.Key.ToLower().Contains(sortBuider.Keywords.ToLower()) || x.Value.ToLower().Contains(sortBuider.Keywords.ToLower()));
            }
            return FindAndSort(expression, sortBuider.Sorts, page);
        }
    }
}