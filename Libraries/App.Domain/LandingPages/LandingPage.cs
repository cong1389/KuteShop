using App.Core.Common;
using App.Domain.ContactInfors;
using System.ComponentModel.DataAnnotations.Schema;

namespace App.Domain.LandingPages
{
    public class LandingPage : AuditableEntity<int>
	{
		[ForeignKey("ShopId")]
		public virtual ContactInformation ContactInformation
		{
			get;
			set;
		}

		public string DateOfBith
		{
			get;
			set;
		}

		public string Email
		{
			get;
			set;
		}

		public string FullName
		{
			get;
			set;
		}

		public string PhoneNumber
		{
			get;
			set;
		}

		public int ShopId
		{
			get;
			set;
		}

		public int Status
		{
			get;
			set;
		}

		public LandingPage()
		{
		}
	}
}