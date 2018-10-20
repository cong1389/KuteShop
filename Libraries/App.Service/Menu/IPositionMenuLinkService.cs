using System.Collections.Generic;
using App.Core.Utilities;
using App.Domain.Interfaces.Services;

namespace App.Service.PositionMenuLink
{
    public interface IPositionMenuLinkService : IBaseService<Domain.Entities.Menu.PositionMenuLink>
    {
        Domain.Entities.Menu.PositionMenuLink GetById(int id, bool isCache = true);
    }
}