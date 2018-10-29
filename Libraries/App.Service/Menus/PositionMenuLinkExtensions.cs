using App.Aplication;
using App.Domain.Menus;
using System.Collections.Generic;
using System.Linq;

namespace App.Service.Menus
{
    public static class PositionMenuLinkExtensions
    {
        public static bool SelectedPosition(this PositionMenuLink position, IEnumerable<MenuLink> menuCurrent)
        {
            var menusExsist = menuCurrent.Where(x => x.PositionMenuLinks.Count > 0);

            if (!menusExsist.IsAny())
            {
                return false;
            }

            var positionsExsist = menusExsist.FirstOrDefault().PositionMenuLinks;

            return positionsExsist.FirstOrDefault(p => p.Id == position.Id) != null;
        }
    }
}
