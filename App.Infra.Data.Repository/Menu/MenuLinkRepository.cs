using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using App.Core.Utils;
using App.Domain.Entities.Menu;
using App.Domain.Interfaces.Repository;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;

namespace App.Infra.Data.Repository.Menu
{
    public class MenuLinkRepository : RepositoryBase<MenuLink>, IMenuLinkRepository, IRepositoryBase<MenuLink>
    {
        public MenuLinkRepository(IDbFactory dbFactory) : base(dbFactory)
        {
        }

        public MenuLink GetById(int Id)
        {
            MenuLink menuLink = FindBy(x => x.Id == Id, false).FirstOrDefault();         

            return menuLink;
        }

        protected override IOrderedQueryable<MenuLink> GetDefaultOrder(IQueryable<MenuLink> query)
        {
            IOrderedQueryable<MenuLink> menuLinks =
                from p in query
                orderby p.Id
                select p;
            return menuLinks;
        }

        public IEnumerable<MenuLink> PagedList(Paging page)
        {
            return GetAllPagedList(page).ToList();
        }

        public IEnumerable<MenuLink> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
        {
            Expression<Func<MenuLink, bool>> expression = PredicateBuilder.True<MenuLink>();
            if (!string.IsNullOrEmpty(sortBuider.Keywords))
            {
                expression = expression.And(x => x.MenuName.ToLower().Contains(sortBuider.Keywords.ToLower()));
            }
            return FindAndSort(expression, sortBuider.Sorts, page);
        }
    }
}