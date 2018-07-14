using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using App.Core.Configuration;
using App.Service.Authentication.External;

namespace App.FacebookAuth.Controllers
{
    public class ExternalAuthFacebookController : Controller
    {
        private readonly IOpenAuthenticationService _openAuthenticationService;
        private readonly ExternalAuthenticationSettings _externalAuthenticationSettings;

        public ExternalAuthFacebookController(IOpenAuthenticationService openAuthenticationService, ExternalAuthenticationSettings externalAuthenticationSettings)
        {
            _openAuthenticationService = openAuthenticationService;
            _externalAuthenticationSettings = externalAuthenticationSettings;
        }

        // GET: ExternalAuthFacebook
        public ActionResult Index()
        {
            return View();
        }
    }
}