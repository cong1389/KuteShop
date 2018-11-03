using App.Core.Extensions;
using App.Domain.Customers;
using App.Domain.Entities.Identity;
using App.FakeEntity.Orders;
using App.FakeEntity.User;
using App.Framework.Utilities;
using App.Front.Extensions;
using App.Front.Models;
using App.Service.Common;
using App.Service.Orders;
using AutoMapper;
using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using ChangePasswordViewModel = App.FakeEntity.User.ChangePasswordViewModel;
using LoginViewModel = App.FakeEntity.User.LoginViewModel;

namespace App.Front.Controllers
{
    [Authorize]
    public class UserController : BaseAccessUserController
    {
        //private readonly ISendMailService _emailService;
        //private readonly DpapiDataProtectionProvider _provider = new DpapiDataProtectionProvider();

        private readonly IOrderService _orderService;
        private readonly IWorkContext _workContext;

        public UserController(UserManager<IdentityUser, Guid> userManager
            , IIdentityMessageService emailService, IOrderService orderService, IWorkContext workContext) : base(userManager, emailService)
        {
            _orderService = orderService;
            _workContext = workContext;
            //_emailService = emailService;

            //if (_provider != null)
            //{
            //    var dataProtector = _provider.Create("ResetPassword");

            //    UserManager.UserTokenProvider = new DataProtectorTokenProvider<IdentityUser, Guid>(dataProtector);
            //}
        }

        #region Change password


        [AllowAnonymous]
        public ActionResult ChangePassword()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> ChangePassword(ChangePasswordViewModel model)
        {
            var hasPassword = HasPassword();
            ViewBag.HasLocalPassword = hasPassword;
            ViewBag.ReturnUrl = Url.Action("Index", "Home");

            if (!hasPassword)
            {
                var item = ModelState["OldPassword"];
                item?.Errors.Clear();

                if (ModelState.IsValid)
                {
                    var addPw = await UserManager.AddPasswordAsync(GetGuid(User.Identity.GetUserId()), model.NewPassword);

                    if (!addPw.Succeeded)
                    {
                        AddErrors(addPw);
                    }
                    else
                    {
                        return RedirectToAction("Orders", "User", new { area = "" });
                    }
                }
            }
            else if (ModelState.IsValid)
            {
                var changePw = await UserManager.ChangePasswordAsync(GetGuid(User.Identity.GetUserId()), model.OldPassword, model.NewPassword);
                if (!changePw.Succeeded)
                {
                    ViewBag.Error = "Mật khẩu cũ không chính xác.";
                }
                else
                {
                    return RedirectToAction("Orders", "User", new { area = "" });
                }
            }

            return View();
        }


        #endregion

        #region Login and external login

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

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult ExternalLogin(string provider, string returnUrl)
        {
            // Request a redirect to the external login provider
            return new ChallengeResult(provider, Url.Action("ExternalLoginCallback", "User", new { ReturnUrl = returnUrl }));
        }

        [AllowAnonymous]
        public async Task<ActionResult> ExternalLoginCallback(string returnUrl)
        {
            var loginInfo = await AuthenticationManager.GetExternalLoginInfoAsync();
            if (loginInfo == null)
            {
                return RedirectToAction("Login");
            }

            // Sign in the user with this external login provider if the user already has a login
            var user = await UserManager.FindAsync(loginInfo.Login);
            if (user != null)
            {
                await SignInAsync(user, false);
                return RedirectToLocal(returnUrl);
            }

            // If the user does not have an account, then prompt the user to create an account
            ViewBag.ReturnUrl = returnUrl;
            ViewBag.LoginProvider = loginInfo.Login.LoginProvider;
            return View("ExternalLoginConfirmation", new ExternalLoginConfirmationViewModel
            {
                UserName = loginInfo.DefaultUserName,
                Email = loginInfo.Email
            });
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> ExternalLoginConfirmation(ExternalLoginConfirmationViewModel model, string returnUrl)
        {
            if (User.Identity.IsAuthenticated)
            {
                //return RedirectToAction("Manage");
            }

            if (ModelState.IsValid)
            {
                // Get the information about the user from the external login provider
                var info = await AuthenticationManager.GetExternalLoginInfoAsync();
                if (info == null)
                {
                    //return View("ExternalLoginFailure");
                }
                var user = new IdentityUser
                {
                    UserName = model.UserName,
                    Email = model.Email,
                    IsLockedOut = false,
                    IsSuperAdmin = false,
                    Created = DateTime.UtcNow
                };
                var result = await UserManager.CreateAsync(user);
                if (result.Succeeded)
                {
                    result = await UserManager.AddLoginAsync(user.Id, info.Login);
                    if (result.Succeeded)
                    {
                        await SignInAsync(user, false);
                        return RedirectToLocal(returnUrl);
                    }
                }
                AddErrors(result);
            }

            ViewBag.ReturnUrl = returnUrl;

            return View(model);
        }

        #endregion

        #region Registration

        [AllowAnonymous]
        public ActionResult Registration()
        {
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
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

        #endregion

        #region Forget password

        [AllowAnonymous]
        public ActionResult ForgotPassword()
        {
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> ForgotPassword(ForgotPasswordViewModel model)
        {
            if (ModelState.IsValid)
            {
                var user = await UserManager.FindByNameAsync(model.Email);
                if (user == null || !await UserManager.IsEmailConfirmedAsync(user.Id))
                {
                    // Don't reveal that the user does not exist or is not confirmed
                    return View("ForgotPasswordConfirmation");
                }

                string code = await UserManager.GeneratePasswordResetTokenAsync(user.Id);
                var callbackUrl = Url.Action("ResetPassword", "User", new { userId = user.Id, code }, Request.Url.Scheme);

                var message = new IdentityMessage()
                {
                    Subject = "Reset Password",
                    Body = "Please reset your password by clicking <a href=\"" + callbackUrl + "\">here</a>",
                    Destination = "ddemo9698@gmail.com"
                };
                //await _emailService.SendAsync(message);

                //TODO: Implementation UserManager
                await UserManager.SendEmailAsync(user.Id, "Reset Password",
                    "Please reset your password by clicking <a href=\"" + callbackUrl + "\">here</a>");

                return RedirectToAction("ForgotPasswordConfirmation", "User");
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        [AllowAnonymous]
        public ActionResult ForgotPasswordConfirmation()
        {
            return View();
        }

        #endregion

        #region Reset password

        [AllowAnonymous]
        public ActionResult ResetPassword(string code)
        {
            return code == null ? View("Error") : View();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> ResetPassword(ResetPasswordViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            var user = await UserManager.FindByNameAsync(model.Email);
            if (user == null)
            {
                // Don't reveal that the user does not exist
                return RedirectToAction("ResetPasswordConfirmation", "User");
            }

            var result = await UserManager.ResetPasswordAsync(user.Id, model.Code, model.Password);
            if (result.Succeeded)
            {
                return RedirectToAction("ResetPasswordConfirmation", "User");
            }
            AddErrors(result);
            return View();
        }

        //
        // GET: /Account/ResetPasswordConfirmation
        [AllowAnonymous]
        public ActionResult ResetPasswordConfirmation()
        {
            return View();
        }


        #endregion

        public ActionResult Manage(ManageMessageId? message)
        {
            ViewBag.StatusMessage =
                message == ManageMessageId.ChangePasswordSuccess ? "Your password has been changed."
                : message == ManageMessageId.SetPasswordSuccess ? "Your password has been set."
                : message == ManageMessageId.RemoveLoginSuccess ? "The external login was removed."
                : message == ManageMessageId.Error ? "An error has occurred."
                : "";

            ViewBag.HasLocalPassword = HasPassword();
            ViewBag.ReturnUrl = Url.Action("Manage");

            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Manage(ChangePasswordViewModel model)
        {
            var hasPassword = HasPassword();
            ViewBag.HasLocalPassword = hasPassword;
            ViewBag.ReturnUrl = Url.Action("Manage");

            if (hasPassword)
            {
                if (!ModelState.IsValid)
                {
                    return View(model);
                }

                var result = await UserManager.ChangePasswordAsync(GetGuid(User.Identity.GetUserId()), model.OldPassword, model.NewPassword);
                if (result.Succeeded)
                {
                    return RedirectToAction("Manage", new { Message = ManageMessageId.ChangePasswordSuccess });
                }

                AddErrors(result);
            }
            else
            {
                var state = ModelState["OldPassword"];
                state?.Errors.Clear();

                if (!ModelState.IsValid)
                {
                    return View(model);
                }

                var result = await UserManager.AddPasswordAsync(GetGuid(User.Identity.GetUserId()), model.NewPassword);
                if (result.Succeeded)
                {
                    return RedirectToAction("Manage", new { Message = ManageMessageId.SetPasswordSuccess });
                }

                AddErrors(result);
            }

            return View(model);
        }

        #region Helpers

        public enum ManageMessageId
        {
            ChangePasswordSuccess,
            SetPasswordSuccess,
            RemoveLoginSuccess,
            Error
        }

        private ActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }

            return RedirectToAction("Index", "Home");
        }

        private class ChallengeResult : HttpUnauthorizedResult
        {
            private readonly string _xsrfKey = Contains.XsrfKey;

            public ChallengeResult(string provider, string redirectUri) : this(provider, redirectUri, null)
            {
            }

            private ChallengeResult(string provider, string redirectUri, string userId)
            {
                LoginProvider = provider;
                RedirectUri = redirectUri;
                UserId = userId;
            }

            private string LoginProvider { get; }
            private string RedirectUri { get; }
            private string UserId { get; }

            public override void ExecuteResult(ControllerContext context)
            {
                var properties = new AuthenticationProperties { RedirectUri = RedirectUri };
                if (UserId != null)
                {
                    properties.Dictionary[_xsrfKey] = UserId;
                }
                context.HttpContext.GetOwinContext().Authentication.Challenge(properties, LoginProvider);
            }
        }
        #endregion

        #region Information account of customer

        public ActionResult ChangeInfoUser()
        {
            var user = UserManager.FindByName(HttpContext.User.Identity.Name);

            var registerFormViewModel = Mapper.Map<RegisterFormViewModel>(user);
            registerFormViewModel.Password = user.PasswordHash;
            registerFormViewModel.ConfirmPassword = user.PasswordHash;

            return View(registerFormViewModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> ChangeInfoUser(RegisterFormViewModel model)
        {
            if (!ModelState.IsValid)
            {
                string msg = string.Join(Environment.NewLine
                    , ModelState.Values.SelectMany(v => v.Errors).Select(v => v.ErrorMessage + " " + v.Exception));

                ModelState.AddModelError("", msg);

                return View(model);
            }

            var identityUser = UserManager.FindById(model.Id);

            identityUser = Mapper.Map(model, identityUser);
            identityUser.Created = DateTime.UtcNow;

            var result = await UserManager.UpdateAsync(identityUser);
            if (result.Succeeded)
            {
                return RedirectToAction("ChangeInfoUser", "User");
            }

            return View();
        }

        public ActionResult Orders()
        {
            var model = PrepareCustomerOrderListModel(_workContext.CurrentCustomer);

            return View(model);
        }

        [NonAction]
        protected IEnumerable<OrderViewModel> PrepareCustomerOrderListModel(Customer customer)
        {
            if (customer == null)
            {
                throw new ArgumentNullException("customer");
            }

            var ieOrder = _orderService.GetByCustomerId(customer.Id, false);

            if (!ieOrder.IsAny())
            {
                return null;
            }

            ieOrder = ieOrder.OrderByDescending(m => m.Id);

            var orderViewModel = new OrderViewModel();

            var model = ieOrder.Select(x => x.ToModel(orderViewModel));

            return model;

        }

        #endregion
    }
}