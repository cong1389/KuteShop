using System.Collections.Generic;
using App.Core.Utilities;
using App.Domain.Menus;
using App.Domain.Interfaces.Repository;

namespace App.Infra.Data.Repository.Menus
{
    public interface IMenuLinkRepository : IRepositoryBase<MenuLink>
	{
        MenuLink GetById(int id);

        IEnumerable<MenuLink> PagedList(Paging page);

		IEnumerable<MenuLink> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);
	}
}