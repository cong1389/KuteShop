using App.Core.Common;
using App.Domain.ContactInfors;
using System.Collections.Generic;

namespace App.Domain.Locations
{
    public class Province : AuditableEntity<int>
	{
		public virtual ICollection<ContactInformation> ContactInformations
		{
			get;
			set;
		}

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

		public Province()
		{
		}
	}
}