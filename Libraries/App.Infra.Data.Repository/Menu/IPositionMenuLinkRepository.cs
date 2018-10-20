using System.Collections.Generic;
using App.Core.Utilities;
using App.Domain.Interfaces.Repository;

namespace App.Infra.Data.Repository.PositionMenuLink
{
    public interface IPositionMenuLinkRepository : IRepositoryBase<Domain.Menu.PositionMenuLink>
	{
		Domain.Menu.PositionMenuLink GetById(int id);

		IEnumerable<Domain.Menu.PositionMenuLink> PagedList(Paging page);

		IEnumerable<Domain.Menu.PositionMenuLink> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);
	}
}