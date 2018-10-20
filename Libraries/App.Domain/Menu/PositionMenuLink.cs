using App.Core.Common;
using System.Collections.Generic;

namespace App.Domain.Entities.Menu
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
		    
        }
	}
}