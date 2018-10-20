using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using App.Aplication;
using App.Domain.Entities.Menu;
using App.Service.GenericControl;
using App.Service.PositionMenuLink;

namespace App.Service.Menu
{
    public static class PositionMenuLinkExtensions
    {
        public static bool SelectedPosition(this Domain.Entities.Menu.PositionMenuLink position, IEnumerable<MenuLink> menuCurrent)
        {
            var menusExsist = menuCurrent.Where(x => x.PositionMenuLinks.Count() > 0);

            if (!menusExsist.IsAny())
            {
                return false;
            }

            var positionsExsist = menusExsist.FirstOrDefault().PositionMenuLinks;

            return positionsExsist.FirstOrDefault(p => p.Id == position.Id) != null;
        }
    }
}
