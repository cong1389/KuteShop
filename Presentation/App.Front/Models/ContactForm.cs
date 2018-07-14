using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

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
        [Required(ErrorMessage = "Vui lòng nhập tên.")]
        public string FullName
		{
			get;
			set;
		}

	    public bool SuccessfullySent { get; set; }
	    public string Result { get; set; }
    }
}