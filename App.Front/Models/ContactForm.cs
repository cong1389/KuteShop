using System.ComponentModel;

namespace App.Front.Models
{
	public class ContactForm
	{
	    [DisplayName("Nội dung liên hệ")]
        public string Content
		{
			get;
			set;
		}

		public string Email
		{
			get;
			set;
		}

        [DisplayName("Tên của bạn")]
		public string FullName
		{
			get;
			set;
		}
	}
}