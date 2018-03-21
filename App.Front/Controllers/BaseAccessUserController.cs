using System;
using System.Web;
using System.Web.Mvc;
using App.Aplication;
using App.Domain.Entities.Identity;
using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;

namespace App.Front.Controllers
{
    public class BaseAccessUserController :Controller
    {
		protected readonly UserManager<IdentityUser, Guid> UserManager;
	    //private readonly IEmailService _emailService;


		protected IAuthenticationManager AuthenticationManager => HttpContext.GetOwinContext().Authentication;

	    protected BaseAccessUserController()
		{
		}

		protected BaseAccessUserController(UserManager<IdentityUser, Guid> userManager, IIdentityMessageService emailService)
		{
            UserManager = userManager;

		    UserManager.EmailService = emailService;
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
			if (disposing)
			{
				UserManager?.Dispose();
			}
			base.Dispose(disposing);
		}

		protected Guid GetGuid(string value)
		{
		    Guid.TryParse(value, out var guid);

			return guid;
		}
	}
}