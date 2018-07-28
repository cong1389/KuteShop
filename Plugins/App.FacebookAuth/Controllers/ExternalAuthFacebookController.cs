using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using App.Core.Configuration;
using App.Core.Extensions;
using App.Service.Authentication.External;
using App.Service.Common;

namespace App.FacebookAuth.Controllers
{
    public class ExternalAuthFacebookController : Controller
    {
        private readonly IOpenAuthenticationService _openAuthenticationService;
        private readonly ExternalAuthenticationSettings _externalAuthenticationSettings;
        private readonly ICommonServices _services;

        public ExternalAuthFacebookController(IOpenAuthenticationService openAuthenticationService, ExternalAuthenticationSettings externalAuthenticationSettings, ICommonServices services)
        {
            _openAuthenticationService = openAuthenticationService;
            _externalAuthenticationSettings = externalAuthenticationSettings;
            _services = services;
        }

        public ActionResult Login(string returnUrl)
        {
            return View();
        }

        public ActionResult Configure(FacebookExternalAuthSettings settings)
        {
            return View(settings);
        }

        [ChildActionOnly]
        public ActionResult PublicInfo()
        {
            var settings = _services.Settings.LoadSetting<FacebookExternalAuthSettings>();

            if (settings.ClientKeyIdentifier.HasValue() && settings.ClientSecret.HasValue())
                return View();
            else
                return new EmptyResult();
        }
    }
}