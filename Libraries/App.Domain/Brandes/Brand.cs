using App.Core.Common;
using App.Domain.Repairs;
using System.Collections.Generic;

namespace App.Domain.Brandes
{
    public class Brand : AuditableEntity<int>
	{
		public string Description
		{
			get;
			set;
		}

		public string Name
		{
			get;
			set;
		}

		public int OrderDisplay
		{
			get;
			set;
		}

		public int Status
		{
			get;
			set;
		}

        public virtual ICollection<Repair> Orders
        {
            get;
            set;
        }

        public Brand()
		{
		}
	}
}