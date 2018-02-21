using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
using App.Aplication.Extensions;
using App.Core.Caching;
using App.Domain.Entities.GlobalSetting;
using App.Domain.Entities.Location;
using App.Domain.Entities.Menu;
using App.FakeEntity.Menu;
using App.Front.Models;
using App.Service.Common;
using App.Service.ContactInformation;
using App.Service.Locations;
using App.Service.Menu;
using App.Service.SeoSetting;
using App.Service.SystemApp;

namespace App.Front.Controllers
{
    public class SummaryController : FrontBaseController
    {
        private const string CacheSettingsystemKey = "db.SettingSystem.{0}";
        private const string CacheSettingseoglobalKey = "db.SettingSeoGlobal.{0}";
        private readonly ICacheManager _cacheManager;
        private readonly IMenuLinkService _menuLinkService;

        private readonly IProvinceService _provinceService;

        private readonly IDistrictService _districtService;

        private readonly ISystemSettingService _systemSettingService;

        private readonly IContactInfoService _contactInfoService;

        private readonly ISettingSeoGlobalService _settingSeoGlobal;

        private readonly IWorkContext _workContext;

        public SummaryController(IMenuLinkService menuLinkService
            , IProvinceService provinceService, IDistrictService districtService, ISystemSettingService systemSettingService
            , IContactInfoService contactInfoService
            , ISettingSeoGlobalService settingSeoGlobal
            , IWorkContext workContext
            , ICacheManager cacheManager)
        {
            _menuLinkService = menuLinkService;
            _provinceService = provinceService;
            _districtService = districtService;
            _systemSettingService = systemSettingService;
            _contactInfoService = contactInfoService;
            _settingSeoGlobal = settingSeoGlobal;
            _workContext = workContext;
            _cacheManager = cacheManager;
        }

        [PartialCache("Long")]
        private List<MenuNavViewModel> CreateMenuNav(int? parentId, IEnumerable<MenuNavViewModel> source)
        {
            return (
                from x in source
                orderby x.OrderDisplay descending
                select x).Where(x =>
                {
                    int? nullable1 = x.ParentId;
                    int? nullable = parentId;
                    if (nullable1.GetValueOrDefault() != nullable.GetValueOrDefault())
                    {
                        return false;
                    }
                    return nullable1.HasValue == nullable.HasValue;
                }).Select(x => new MenuNavViewModel
            {
                    MenuId = x.MenuId,
                    ParentId = x.ParentId,
                    MenuName = x.MenuName,
                    SeoUrl = x.SeoUrl,
                    OrderDisplay = x.OrderDisplay,
                    ImageUrl = x.ImageUrl,
                    CurrentVirtualId = x.CurrentVirtualId,
                    VirtualId = x.VirtualId,
                    ChildNavMenu = CreateMenuNav(x.MenuId, source)
                }).ToList();
        }

        [PartialCache("Long")]
        public ActionResult GetAddressInfo()
        {
            ContactInformation contactInformation = _contactInfoService.Get(x => x.Status == 1 && x.Type == 1, true);

            var contactInformationLocalize = contactInformation.ToModel();

            return PartialView(contactInformationLocalize);
        }

        [ChildActionOnly]
        [PartialCache("Short")]
        public ActionResult GetCategorySearchBox()
        {
            List<MenuNavViewModel> menuNavs = new List<MenuNavViewModel>();
            IEnumerable<MenuLink> menuLinks = _menuLinkService.FindBy(x => x.Status == 1 && x.TemplateType == 2, true);
            if (menuLinks.Any())
            {
                IEnumerable<MenuNavViewModel> menuNav =
                    from x in menuLinks
                    select new MenuNavViewModel
                    {
                        MenuId = x.Id,
                        ParentId = x.ParentId,
                        MenuName = x.MenuName,
                        SeoUrl = x.SeoUrl,
                        OrderDisplay = x.OrderDisplay,
                        ImageUrl = x.ImageUrl,
                        CurrentVirtualId = x.CurrentVirtualId,
                        VirtualId = x.VirtualId
                    };
                menuNavs = CreateMenuNav(null, menuNav);
            }
            return PartialView(menuNavs);
        }

        [ChildActionOnly]
        [PartialCache("Short")]
        public ActionResult GetContactHeader()
        {
            SystemSetting systemSetting = _systemSettingService.Get(x => x.Status == 1, false);

            var systemSettingLocalized = systemSetting.ToModel();

            return PartialView(systemSettingLocalized);
        }

        [ChildActionOnly]
        [PartialCache("Short")]
        public ActionResult GetContactOrder()
        {
            ContactInformation contactInformation = _contactInfoService.Get(x => x.Status == 1 && x.Type == 1, true);

            var contactInformationLocalized = contactInformation.ToModel();

            return PartialView(contactInformationLocalized);
        }

        [ChildActionOnly]
        [PartialCache("Short")]
        public ContentResult GetContentFooter()
        {
            SystemSetting systemSetting = _systemSettingService.Get(x => x.Status == 1, true);

            var systemSettingLocalized = systemSetting.ToModel();

            if (systemSetting == null)
            {
                return Content(string.Empty);
            }

            return Content(systemSetting.FooterContent);
        }

        [HttpPost]
        public JsonResult GetDistrictByProvinceId(int provinceId)
        {
            if (!Request.IsAjaxRequest())
            {
                return null;
            }

            var byProvinceId =
                from x in _districtService.GetByProvinceId(provinceId)
                select new {x.Id, x.Name };

            return Json(byProvinceId);
        }

        [ChildActionOnly]
        [PartialCache("Short")]
        public ActionResult Footer()
        {
            ContactInformation contactInformation = _contactInfoService.Get(x => x.Status == 1 && x.Type == 1, true);

            var contactInformationLocalize = contactInformation.ToModel();

            return PartialView(contactInformationLocalize);
        }

        public ActionResult GetLogo()
        {
            SystemSetting systemSetting = GetSystemSettingData();

            var systemSettingLocalized = systemSetting.ToModel();

            return PartialView(systemSettingLocalized);
        }

        [ChildActionOnly]
        [PartialCache("Short")]
        public ActionResult GetMetaTagsSeo()
        {
            SettingSeoGlobal settingSeoGlobal = GetSettingSeoData();

            return PartialView(settingSeoGlobal);
        }

        public ActionResult GetMeta()
        {
            SystemSetting systemSetting = _systemSettingService.Get(x => x.Status == 1, true);

            if (systemSetting == null)
                return HttpNotFound();

            var systemSettingLocalized = systemSetting.ToModel();

            string controller = Request.RequestContext.RouteData.Values["Controller"].ToString();
            string action = Request.RequestContext.RouteData.Values["Action"].ToString();

            if (controller.Equals("Home") && action.Equals("Index"))
            {
                ViewBag.Title = systemSettingLocalized.Title;
                ViewBag.KeyWords = systemSettingLocalized.MetaKeywords;
                ViewBag.SiteUrl = Url.Action("Index", "Home", new { area = "" });
                ViewBag.Description = systemSettingLocalized.Description;
                ViewBag.Image = Url.Content(string.Concat("~/", systemSettingLocalized.LogoImage));
            }

            ViewBag.Favicon = Url.Content(string.Concat("~/", systemSettingLocalized.FaviconImage));

            return PartialView(systemSettingLocalized);
        }

        [ChildActionOnly]
        [PartialCache("Short")]
        public ActionResult GetProvinceSearchBox()
        {
            IEnumerable<Province> provinces = _provinceService.FindBy(x => x.Status == 1, false);
            return PartialView(provinces);
        }

        [ChildActionOnly]
        [PartialCache("Short")]
        public ActionResult ScriptSippet()
        {
            SettingSeoGlobal settingSeoGlobal = GetSettingSeoData();
            return PartialView(settingSeoGlobal);
        }

        [PartialCache("Long")]
        public JsonResult GetPostAddress()
        {
            ContactInformation contactInformation = _contactInfoService.Get(x => x.Status == 1 && x.Type == 1, true);

            var contactInformationLocalize = contactInformation.ToModel();

            JsonResult jsonResult = Json(new { success = true, list = this.RenderRazorViewToString("_Post.Address", contactInformationLocalize) }, JsonRequestBehavior.AllowGet);

            return jsonResult;

        }

        [PartialCache("Long")]
        public JsonResult GetFooterAddress()
        {
            IEnumerable<ContactInformation> contactInformation = _contactInfoService.FindBy(x => x.Status == 1, true);

            var contactInformationLocalize = contactInformation.Select(x => x.ToModel());

            JsonResult jsonResult =
                Json(
                    new
                    {
                        success = true,
                        list = this.RenderRazorViewToString("_Footer.Address", contactInformationLocalize)
                    }, JsonRequestBehavior.AllowGet);

            return jsonResult;

        }

        [PartialCache("Long")]
        public JsonResult GetFooterLogo()
        {
            SystemSetting systemSetting = _systemSettingService.Get(x => x.Status == 1, false);

            var systemSettingLocalize = systemSetting.ToModel();

            JsonResult jsonResult = Json(new { success = true, list = this.RenderRazorViewToString("_Footer.Logo", systemSettingLocalize) }, JsonRequestBehavior.AllowGet);

            return jsonResult;

        }

        [PartialCache("Long")]
        public JsonResult GetSystemSetting()
        {
            SystemSetting systemSetting = _systemSettingService.Get(x => x.Status == 1, false);

            var systemSettingLocalize = systemSetting.ToModel();

            JsonResult jsonResult = Json(new { success = true, list = systemSettingLocalize }, JsonRequestBehavior.AllowGet);

            return jsonResult;

        }

        #region Social

        public async Task<JsonResult> GetSettingSeo()
        {
            SettingSeoGlobal settingSeoGlobal = await Task.FromResult(GetSettingSeoData());

            JsonResult jsonResult = Json(new { success = true, response = settingSeoGlobal }, JsonRequestBehavior.AllowGet);

            return jsonResult;
        }

        #endregion

        #region System Setting

        [PartialCache("Long")]
        public JsonResult GetLogoMobile()
        {
            SystemSetting systemSetting = GetSystemSettingData();

            var systemSettingLocalize = systemSetting.ToModel();

            JsonResult jsonResult = Json(new { success = true, list = systemSettingLocalize }, JsonRequestBehavior.AllowGet);

            return jsonResult;
        }

        private SystemSetting GetSystemSettingData()
        {
            StringBuilder sbKey = new StringBuilder();
            sbKey.AppendFormat(CacheSettingsystemKey, "GetSystemSettingData");

            string key = sbKey.ToString();
            SystemSetting systemSetting = _cacheManager.Get<SystemSetting>(key);
            if (systemSetting == null)
            {
                systemSetting = _systemSettingService.Get(x => x.Status == 1, false);
                _cacheManager.Put(key, systemSetting);
            }

            return systemSetting;
        }

        #endregion

        #region Setting Seo

        private SettingSeoGlobal GetSettingSeoData()
        {
            StringBuilder sbKey = new StringBuilder();
            sbKey.AppendFormat(CacheSettingseoglobalKey, "GetSettingSeoGlobal");

            string key = sbKey.ToString();
            SettingSeoGlobal settingSeoGlobal = _cacheManager.Get<SettingSeoGlobal>(key);
            if (settingSeoGlobal == null)
            {
                settingSeoGlobal = _settingSeoGlobal.Get(x => x.Status == 1, false);
                _cacheManager.Put(key, settingSeoGlobal);
            }

            return settingSeoGlobal;
        }

        #endregion
    }
}