using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using App.Aplication;
using App.Domain.Entities.Identity;
using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;

namespace App.Front.Controllers
{
	public class BaseAccessUserController : Controller
	{
		protected readonly UserManager<IdentityUser, Guid> _userManager;

		protected string XsrfKey = AccountUtils.XsrfKey;

		protected IAuthenticationManager AuthenticationManager
		{
			get
			{
				return HttpContext.GetOwinContext().Authentication;
			}
		}

		protected BaseAccessUserController()
		{
		}

		protected BaseAccessUserController(UserManager<IdentityUser, Guid> userManager)
		{
            _userManager = userManager;
		}

		protected void AddErrors(IdentityResult result)
		{
			foreach (string error in result.Errors)
			{
                ModelState.AddModelError("", error);
			}
		}

		protected override void Dispose(bool disposing)
		{
			if (disposing && _userManager != null)
			{
				_userManager.Dispose();
			}
			base.Dispose(disposing);
		}

		protected Guid GetGuid(string value)
		{
			Guid guid = new Guid();
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
	}
}