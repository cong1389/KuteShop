using App.Core.Common;
using App.Domain.Entities.Menu;
using System.Collections.Generic;

namespace App.Domain.Menu
{
    public class PositionMenuLink : AuditableEntity<int>
    {
        public string Name
        {
            get;
            set;
        }

        public int Status
        {
            get;
            set;
        }
        public virtual ICollection<MenuLink> MenuLinks
        {
            get;
            set;
        }

        public PositionMenuLink()
        {
            MenuLinks = new List<MenuLink>();
        }
    }
}
