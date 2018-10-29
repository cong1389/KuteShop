using System.Collections.Generic;
using App.Core.Utilities;
using App.Domain.GenericControls;
using App.Domain.Interfaces.Services;

namespace App.Service.GenericControls
{
    public interface IGenericControlService : IBaseService<GenericControl>
    {
        GenericControl GetById(int id, bool isCache = true);

        IEnumerable<GenericControl> GetByMenuId(int menuId, bool isCache = true);

        IEnumerable<GenericControl> PagedList(SortingPagingBuilder sortBuider, Paging page);
    }
}