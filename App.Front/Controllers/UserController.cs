using System;
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
            var flag = HasPassword();
            ViewBag.HasLocalPassword = flag;
            ViewBag.ReturnUrl = Url.Action("Index", "Home");

            if (!flag)
            {
                var item = ModelState["OldPassword"];
                item?.Errors.Clear();

                if (ModelState.IsValid)
                {
                    var identityResult = await UserManager.AddPasswordAsync(GetGuid(User.Identity.GetUserId()), model.NewPassword);
                    var identityResult1 = identityResult;
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
                var identityResult2 = await UserManager.ChangePasswordAsync(GetGuid(User.Identity.GetUserId()), model.OldPassword, model.NewPassword);
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
            var identityUser = UserManager.FindById(GetGuid(User.Identity.GetUserId()));

            return identityUser?.PasswordHash != null;
        }

        [AllowAnonymous]
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Login(LoginViewModel model, string returnUrl)
        {
            if (!ModelState.IsValid)
            {
                return View();
            }

            var user = await UserManager.FindAsync(model.UserName, model.Password);

            if (user == null)
            {
                ModelState.AddModelError("", "Tên đăng nhập hoặc mật khẩu không chính xác.");
                return View();
            }

            await SignInAsync(user, model.Remember);

            if (!Url.IsLocalUrl(returnUrl) || returnUrl.Length <= 1 || !returnUrl.StartsWith("/") || returnUrl.StartsWith("//") || returnUrl.StartsWith("/\\"))
            {
                return RedirectToAction("Index", "Home");
            }

            return Redirect(returnUrl);
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
                    var identityUser = new IdentityUser
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

                    var identityResult = await UserManager.CreateAsync(identityUser, model.Password);

                    if (identityResult.Succeeded)
                    {
                        ModelState.AddModelError("", "Đăng ký tài khoản thành công.");
                    }
                    else
                    {
                        var sb = new StringBuilder();
                        foreach (var item in identityResult.Errors)
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
            AuthenticationManager.SignOut(DefaultAuthenticationTypes.ExternalCookie);
            var identity = await UserManager.CreateIdentityAsync(user, DefaultAuthenticationTypes.ApplicationCookie);
            AuthenticationManager.SignIn(new AuthenticationProperties() { IsPersistent = isPersistent }, identity);

            //AuthenticationManager.SignOut("ExternalCookie");
            //var claimsIdentity = await UserManager.CreateIdentityAsync(user, "ApplicationCookie");
            //var authenticationManager = AuthenticationManager;
            //var authenticationProperty = new AuthenticationProperties
            //{
            //    IsPersistent = isPersistent
            //};
            //authenticationManager.SignIn(authenticationProperty, claimsIdentity);
        }
    }
}