using System.Collections.Generic;
using App.Core.Utilities;
using App.Domain.Interfaces.Repository;
using App.Domain.Menus;

namespace App.Infra.Data.Repository.Menus
{
    public interface IPositionMenuLinkRepository : IRepositoryBase<PositionMenuLink>
    {
        PositionMenuLink GetById(int id);
        IEnumerable<PositionMenuLink> PagedList(Paging page);
        IEnumerable<PositionMenuLink> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);
    }
}