using System.Collections.Generic;
using System.Linq;
using App.Core.Utilities;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;

namespace App.Infra.Data.Repository.PositionMenuLink
{
    public class PositionMenuLinkRepository : RepositoryBase<Domain.Entities.Menu.PositionMenuLink>, IPositionMenuLinkRepository
    {
        public PositionMenuLinkRepository(IDbFactory dbFactory) : base(dbFactory)
        {
        }

        public Domain.Entities.Menu.PositionMenuLink GetById(int id)
        {
            var positionMenuLink = FindBy(x => x.Id == id).FirstOrDefault();
            return positionMenuLink;
        }

        protected override IOrderedQueryable<Domain.Entities.Menu.PositionMenuLink> GetDefaultOrder(IQueryable<Domain.Entities.Menu.PositionMenuLink> query)
        {
            var PositionMenuLinks =
                from p in query
                orderby p.Id
                select p;
            return PositionMenuLinks;
        }

        public IEnumerable<Domain.Entities.Menu.PositionMenuLink> PagedList(Paging page)
        {
            return GetAllPagedList(page).ToList();
        }

        public IEnumerable<Domain.Entities.Menu.PositionMenuLink> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
        {
            var expression = PredicateBuilder.True<Domain.Entities.Menu.PositionMenuLink>();
            if (!string.IsNullOrEmpty(sortBuider.Keywords))
            {
                expression = expression.And(x => x.Name.ToLower().Contains(sortBuider.Keywords.ToLower()));
            }
            return FindAndSort(expression, sortBuider.Sorts, page);
        }
    }
}