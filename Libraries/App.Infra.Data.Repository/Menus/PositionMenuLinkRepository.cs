using App.Core.Utilities;
using App.Domain.Menus;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;
using System.Collections.Generic;
using System.Linq;

namespace App.Infra.Data.Repository.Menus
{
    public class PositionMenuLinkRepository : RepositoryBase<PositionMenuLink>, IPositionMenuLinkRepository
    {
        public PositionMenuLinkRepository(IDbFactory dbFactory) : base(dbFactory)
        {
        }

        public PositionMenuLink GetById(int id)
        {
            var positionMenuLink = FindBy(x => x.Id == id).FirstOrDefault();

            return positionMenuLink;
        }

        protected override IOrderedQueryable<PositionMenuLink> GetDefaultOrder(IQueryable<PositionMenuLink> query)
        {
            var positionMenuLinks =
                from p in query
                orderby p.Id
                select p;

            return positionMenuLinks;
        }

        public IEnumerable<PositionMenuLink> PagedList(Paging page)
        {
            return GetAllPagedList(page).ToList();
        }

        public IEnumerable<PositionMenuLink> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
        {
            var expression = PredicateBuilder.True<PositionMenuLink>();
            if (!string.IsNullOrEmpty(sortBuider.Keywords))
            {
                expression = expression.And(x => x.Name.ToLower().Contains(sortBuider.Keywords.ToLower()));
            }

            return FindAndSort(expression, sortBuider.Sorts, page);
        }
    }
}
