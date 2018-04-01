using System.Web.Mvc;
using App.Service.SystemApp;

namespace App.Front.Controllers
{
    public class HomeController : FrontBaseController
    {
        private readonly ISystemSettingService _systemSettingService;

        public HomeController(ISystemSettingService systemSettingService)
        {
            _systemSettingService = systemSettingService;
        }

        public ActionResult Error()
        {
            return View();
        }
        
        [OutputCache(CacheProfile = "Medium")]
        public ActionResult Index()
        {
            var systemSetting = _systemSettingService.Get(x => x.Status == 1, true);
            if (systemSetting != null)
            {
                ViewBag.Title = systemSetting.MetaTitle ?? systemSetting.Title;
                ViewBag.KeyWords = systemSetting.MetaKeywords;
                ViewBag.SiteUrl = Url.Action("Index", "Home", new { area = "" });
                ViewBag.Description = systemSetting.Description;
                ViewBag.Image = Url.Content(string.Concat("~/", systemSetting.LogoImage));
                ViewBag.Favicon = Url.Content(string.Concat("~/", systemSetting.FaviconImage));
            }
            
            return View();
        }
        
    }
}