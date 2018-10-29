using App.Domain.Interfaces.Services;
using App.Domain.Menus;

namespace App.Service.Menus
{
    public interface IPositionMenuLinkService : IBaseService<PositionMenuLink>
    {
        PositionMenuLink GetById(int id, bool isCache = true);
    }
}