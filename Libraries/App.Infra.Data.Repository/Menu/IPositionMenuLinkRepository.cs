using System.Collections.Generic;
using App.Core.Utilities;
using App.Domain.Interfaces.Repository;

namespace App.Infra.Data.Repository.PositionMenuLink
{
    public interface IPositionMenuLinkRepository : IRepositoryBase<Domain.Entities.Menu.PositionMenuLink>
	{
		Domain.Entities.Menu.PositionMenuLink GetById(int id);

		IEnumerable<Domain.Entities.Menu.PositionMenuLink> PagedList(Paging page);

		IEnumerable<Domain.Entities.Menu.PositionMenuLink> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);
	}
}