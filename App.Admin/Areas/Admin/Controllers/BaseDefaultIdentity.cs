using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using App.Aplication;
using App.Domain.Entities.Identity;
using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;

namespace App.Admin.Controllers
{
	public abstract class BaseDefaultIdentity : BaseAdminController
	{
		protected readonly UserManager<IdentityUser, Guid> UserManager;

		protected string XsrfKey = AccountUtils.XsrfKey;

		protected IAuthenticationManager AuthenticationManager
		{
			get
			{
				return HttpContext.GetOwinContext().Authentication;
			}
		}

		protected BaseDefaultIdentity()
		{
		}

		protected BaseDefaultIdentity(UserManager<IdentityUser, Guid> userManager)
		{
			UserManager = userManager;
		}

		protected void AddErrors(IdentityResult result)
		{
			foreach (var error in result.Errors)
			{
				ModelState.AddModelError("", error);
			}
		}

		protected override void Dispose(bool disposing)
		{
			if (disposing && UserManager != null)
			{
				UserManager.Dispose();
			}
			base.Dispose(disposing);
		}

		protected Guid GetGuid(string value)
		{
			var guid = new Guid();
			Guid.TryParse(value, out guid);
			return guid;
		}

		protected IList<AuthenticationDescription> GetUnassignedExternalLogins(IList<UserLoginInfo> userLogins)
		{
			return (
				from auth in AuthenticationManager.GetAuthenticationTypes()
				where userLogins.All(ul => auth.AuthenticationType != ul.LoginProvider)
				select auth).ToList();
		}

		protected bool HasPassword()
		{
			var identityUser = UserManager.FindById(GetGuid(User.Identity.GetUserId()));
			if (identityUser == null)
			{
				return false;
			}
			return identityUser.PasswordHash != null;
		}

		public enum ManageMessageId
		{
			ChangePasswordSuccess,
			SetPasswordSuccess,
			RemoveLoginSuccess,
			Error
		}
	}
}