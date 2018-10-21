using App.Domain.Interfaces.Services;

namespace App.Service.Menu
{
    public interface IPositionMenuLinkService : IBaseService<App.Domain.Menu.PositionMenuLink>
    {
        App.Domain.Menu.PositionMenuLink GetById(int id, bool isCache = true);
    }
}