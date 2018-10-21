using App.Core.Utilities;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;
using System.Collections.Generic;
using System.Linq;

namespace App.Infra.Data.Repository.Menu
{
    public class PositionMenuLinkRepository : RepositoryBase<Domain.Menu.PositionMenuLink>, IPositionMenuLinkRepository
    {
        public PositionMenuLinkRepository(IDbFactory dbFactory) : base(dbFactory)
        {
        }

        public Domain.Menu.PositionMenuLink GetById(int id)
        {
            var positionMenuLink = FindBy(x => x.Id == id).FirstOrDefault();
            return positionMenuLink;
        }

        protected override IOrderedQueryable<Domain.Menu.PositionMenuLink> GetDefaultOrder(IQueryable<Domain.Menu.PositionMenuLink> query)
        {
            var PositionMenuLinks =
                from p in query
                orderby p.Id
                select p;
            return PositionMenuLinks;
        }

        public IEnumerable<Domain.Menu.PositionMenuLink> PagedList(Paging page)
        {
            return GetAllPagedList(page).ToList();
        }

        public IEnumerable<Domain.Menu.PositionMenuLink> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
        {
            var expression = PredicateBuilder.True<Domain.Menu.PositionMenuLink>();
            if (!string.IsNullOrEmpty(sortBuider.Keywords))
            {
                expression = expression.And(x => x.Name.ToLower().Contains(sortBuider.Keywords.ToLower()));
            }
            return FindAndSort(expression, sortBuider.Sorts, page);
        }
    }
}