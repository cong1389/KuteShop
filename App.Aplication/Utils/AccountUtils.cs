using System.Configuration;

namespace App.Aplication
{
	public static class AccountUtils
	{
		public static string XsrfKey => ConfigurationManager.AppSettings["XsrfKey"] ?? "XsrfKey";

	    public enum ManageMessageId
		{
			ChangePasswordSuccess,
			SetPasswordSuccess,
			RemoveLoginSuccess,
			Error
		}
	}
}