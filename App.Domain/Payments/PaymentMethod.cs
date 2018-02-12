using App.Core.Common;

namespace App.Domain.Entities.Payments
{
	public class PaymentMethod : AuditableEntity<int>
	{
		public string PaymentMethodSystemName
        {
			get;
			set;
		}

		public string FullDescription
        {
			get;
			set;
		}

        public PaymentMethod()
		{
		}
	}
}