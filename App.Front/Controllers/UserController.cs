using System;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
using App.Domain.Entities.Identity;
using App.FakeEntity.User;
using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;

namespace App.Front.Controllers
{
	public class UserController : BaseAccessUserController
	{
		public UserController(UserManager<IdentityUser, Guid> userManager) : base(userManager)
		{
		}

		public ActionResult ChangePassword()
		{
			return View();
		}

		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<ActionResult> ChangePassword(ChangePasswordViewModel model)
		{
			ActionResult action;
			bool flag = HasPassword();
			ViewBag.HasLocalPassword = flag;
			ViewBag.ReturnUrl = Url.Action("Index", "Home");

			if (!flag)
			{
				ModelState item = ModelState["OldPassword"];
			    item?.Errors.Clear();

			    if (ModelState.IsValid)
				{
					IdentityResult identityResult = await _userManager.AddPasswordAsync(GetGuid(User.Identity.GetUserId()), model.NewPassword);
					IdentityResult identityResult1 = identityResult;
					if (!identityResult1.Succeeded)
					{
						AddErrors(identityResult1);
					}
					else
					{
						action = RedirectToAction("PostManagement", "Account", new { area = "" });
						return action;
					}
				}
			}
			else if (ModelState.IsValid)
			{
				IdentityResult identityResult2 = await _userManager.ChangePasswordAsync(GetGuid(User.Identity.GetUserId()), model.OldPassword, model.NewPassword);
				if (!identityResult2.Succeeded)
				{
					ViewBag.Error = "Mật khẩu cũ không chính xác.";
				}
				else
				{
					action = RedirectToAction("PostManagement", "Account", new { area = "" });
					return action;
				}
			}

			action = View();

			return action;
		}

		protected bool HasPassword()
		{
			IdentityUser identityUser = _userManager.FindById(GetGuid(User.Identity.GetUserId()));
			if (identityUser == null)
			{
				return false;
			}
			return identityUser.PasswordHash != null;
		}

		public ActionResult Login()
		{
			return View();
		}

		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<ActionResult> Login(LoginViewModel login, string ReturnUrl)
		{
			ActionResult action;
			if (ModelState.IsValid)
			{
				IdentityUser identityUser = await _userManager.FindAsync(login.UserName, login.Password);
				IdentityUser identityUser1 = identityUser;
				if (identityUser1 == null)
				{
					ModelState.AddModelError("", "Tên đăng nhập hoặc mật khẩu không chính xác.");
				}
				else
				{
					await SignInAsync(identityUser1, login.Remember);
					if (!Url.IsLocalUrl(ReturnUrl) || ReturnUrl.Length <= 1 || !ReturnUrl.StartsWith("/") || ReturnUrl.StartsWith("//") || ReturnUrl.StartsWith("/\\"))
					{
						action = RedirectToAction("Index", "Home");
						return action;
					}

				    action = Redirect(ReturnUrl);
				    return action;
				}
			}
			action = View();
			return action;
		}

		public ActionResult Registration()
		{
			return View();
		}

		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<ActionResult> Registration(RegisterFormViewModel model)
		{
            try
            {
                if (ModelState.IsValid)
                {
                    IdentityUser identityUser = new IdentityUser
                    {
                        UserName = model.UserName,
                        Address = model.Address,
                        FirstName = model.FirstName,
                        LastName = model.LastName,
                        MiddleName = model.MiddleName,
                        Phone = model.Phone,
                        Email = model.Email,
                        City = model.City,
                        State = model.State,
                        IsLockedOut = false,
                        IsSuperAdmin = false,
                        Created = DateTime.UtcNow
                    };

                    IdentityResult identityResult = await _userManager.CreateAsync(identityUser, model.Password);

                    if (identityResult.Succeeded)
                    {
                        ModelState.AddModelError("", "Đăng ký tài khoản thành công.");
                    }
                    else
                    {
                        StringBuilder sb = new StringBuilder();
                        foreach (string item in identityResult.Errors)
                        {
                            sb.Append(item);
                        }
                        ModelState.AddModelError("", sb.ToString());
                        //ModelState.AddModelError("", "Đăng ký tài khoản không thành công, Vui lòng thử lại."); 
                    }
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("Error", ex.Message);
            }

            return View(model);
        }

		private async Task SignInAsync(IdentityUser user, bool isPersistent)
		{
			AuthenticationManager.SignOut("ExternalCookie");
			ClaimsIdentity claimsIdentity = await _userManager.CreateIdentityAsync(user, "ApplicationCookie");
			IAuthenticationManager authenticationManager = AuthenticationManager;
			AuthenticationProperties authenticationProperty = new AuthenticationProperties
			{
				IsPersistent = isPersistent
			};
			authenticationManager.SignIn(authenticationProperty, claimsIdentity);
		}
	}
}