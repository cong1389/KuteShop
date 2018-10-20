using System.Collections.Generic;
using App.Core.Utilities;
using App.Domain.Interfaces.Services;

namespace App.Service.PositionMenuLink
{
    public interface IPositionMenuLinkService : IBaseService<App.Domain.Menu.PositionMenuLink>
    {
        App.Domain.Menu.PositionMenuLink GetById(int id, bool isCache = true);
    }
}