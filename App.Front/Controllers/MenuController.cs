using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using App.Aplication;
using App.Aplication.Extensions;
using App.Aplication.MVCHelper;
using App.Domain.Entities.Data;
using App.Domain.Entities.Menu;
using App.Front.Models;
using App.Service.Common;
using App.Service.Language;
using App.Service.Locations;
using App.Service.Menu;
using App.Service.Static;
using Newtonsoft.Json;

namespace App.Front.Controllers
{
    public class MenuController : FrontBaseController
    {
        private readonly IMenuLinkService _menuLinkService;

        private readonly IProvinceService _provinceService;

        private readonly IDistrictService _isDistrictService;

        private IStaticContentService _staticContentService;

        private readonly IWorkContext _workContext;

        public MenuController(
            IMenuLinkService menuLinkService
            , IProvinceService provinceService
            , IDistrictService isDistrictService
            , IStaticContentService staticContentService
            , IWorkContext workContext)
        {
            _menuLinkService = menuLinkService;
            _provinceService = provinceService;
            _isDistrictService = isDistrictService;
            _staticContentService = staticContentService;
            _workContext = workContext;
        }

        [ChildActionOnly]
        [PartialCache("Short")]
        public ActionResult GetAccesssories()
        {
            IEnumerable<MenuLink> menuLinks = _menuLinkService.GetByOption(position: new List<int> { 8 }, isDisplayHomePage: true);
            //IEnumerable<MenuLink> menuLinks = this._menuLinkService.FindBy((MenuLink x) => x.TemplateType == 8 && x.DisplayOnHomePage && x.Status == 1, true);

            return PartialView(menuLinks);
        }

        [PartialCache("Short")]
        public ActionResult GetContent(string menu, int page)
        {
            dynamic viewBag = ViewBag;

            MenuLink menuLink = _menuLinkService.GetBySeoUrl(seoUrl: menu, @readonly: false);

            if (menuLink != null)
            {
                var menuLinkLocalized = menuLink.ToModel();

                ViewBag.Title = menuLinkLocalized.MetaTitle ?? menuLinkLocalized.MenuName;
                ViewBag.MetaKeyWords = menuLinkLocalized.MetaKeywords;
                ViewBag.SiteUrl = Url.Action("GetContent", "Menu", new {menu, page, area = "" });
                ViewBag.Description = menuLinkLocalized.MetaDescription;
                ViewBag.Image = Url.Content(string.Concat("~/", menuLinkLocalized.ImageUrl));

                //((dynamic)base.ViewBag).Title = menuLinkLocalized.MetaTitle;
                //((dynamic)base.ViewBag).KeyWords = menuLinkLocalized.MetaKeywords;D:\Project\MVC\AoThun\AoThun_ANT\App.Front\App.Front\Views\Post\GetProductTimeLine.cshtml
                //((dynamic)base.ViewBag).SiteUrl = base.Url.Action("GetContent", "Menu", new { menu = menu, page = page, area = "" });
                //((dynamic)base.ViewBag).Description = menuLinkLocalized.MetaDescription;
                //((dynamic)base.ViewBag).Image = base.Url.Content(string.Concat("~/", menuLinkLocalized.ImageUrl));

                if (menuLinkLocalized.TemplateType == 1)
                {
                    viewBag.MenuList = _menuLinkService.GetByOption(template: new List<int> { 1 });
                    //IMenuLinkService menuLinkService = this._menuLinkService;
                    //viewBag.MenuList = _menuLinkService.FindBy((MenuLink x) => x.TemplateType == 1, false);
                }


            ViewBag.ParentId = menuLink.ParentId;
            ViewBag.Attrs = Request["attribute"];
            ViewBag.Prices = Request["price"];
            ViewBag.KeyWords = Request["keywords"];
            ViewBag.ProAttrs = Request["proattribute"];

            ViewBag.ProductHot = Request["producthot"];
            ViewBag.ProductOld = Request["productold"];
            ViewBag.ProductNew = Request["productnew"];

                ViewBag.TemplateType = menuLink.TemplateType;
                ViewBag.MenuId = menuLink.Id;
                ViewBag.ImgePath = menuLink.ImageUrl;
                ViewBag.PageNumber = page;
                ViewBag.VirtualId = menuLink.VirtualId;
            }

            return View();
        }

        [PartialCache("Short")]
        public ActionResult GetFixItemContent(int id)
        {
            MenuLink menuLink = _menuLinkService.GetById(id);
            //MenuLink menuLink = this._menuLinkService.Get((MenuLink x) => x.Id == Id, false);
            ViewBag.ImgUrl = menuLink.ImageUrl;
            ViewBag.TitleFix = menuLink.MenuName;

            IEnumerable<MenuLink> menuLinks = _menuLinkService.GetByOption(parentId: new List<int> { id }, isDisplayHomePage: true);
            //IEnumerable<MenuLink> menuLinks = this._menuLinkService.FindBy((MenuLink x) => x.ParentId == (int?)id && x.Status == 1 && x.DisplayOnHomePage, false);

            if (!menuLinks.IsAny())
            {
                return Json(new { success = true, data = "" }, JsonRequestBehavior.AllowGet);
            }
            return Json(new { data = this.RenderRazorViewToString("_PartialFixItemContent", menuLinks), success = true }, JsonRequestBehavior.AllowGet);
        }

        [PartialCache("Short")]
        public ActionResult GetLeftFixItem(int id)
        {
            IEnumerable<MenuLink> menuLinks = _menuLinkService.GetByOption(parentId: new List<int> { id }, isDisplayHomePage: true);
            //IEnumerable<MenuLink> menuLinks = _menuLinkService.FindBy((MenuLink x) => x.ParentId == (int?)Id && x.Status == 1 && x.DisplayOnHomePage, false);

            if (!menuLinks.IsAny())
            {
                return Json(new { success = false }, JsonRequestBehavior.AllowGet);
            }
            return Json(new { data = this.RenderRazorViewToString("_PartialLeftFixItemHome", menuLinks), success = true }, JsonRequestBehavior.AllowGet);
        }

        [ChildActionOnly]
        [PartialCache("Short")]
        public ActionResult GetProductTab()
        {
            IEnumerable<MenuLink> menuLinks = _menuLinkService.GetByOption(template: new List<int> { 2 }, isDisplayHomePage: true);
            //IEnumerable<MenuLink> menuLinks = this._menuLinkService.FindBy((MenuLink x) => x.TemplateType == 2 && x.DisplayOnHomePage && x.Status == 1, true);

            return PartialView(menuLinks);
        }

        [ChildActionOnly]
        public ActionResult GetStaticContent(int MenuId, string virtualId, string title)
        {
            List<BreadCrumb> breadCrumbs = new List<BreadCrumb>();
            string[] strArrays = virtualId.Split('/');

            for (int i = 0; i < strArrays.Length; i++)
            {
                string str = strArrays[i];
                MenuLink menuLink = _menuLinkService.GetByParentId(parentId: MenuId, currentVirtualId: str);
                //MenuLink menuLink = this._menuLinkService.Get((MenuLink x) => x.CurrentVirtualId.Equals(str) && x.ParentId != MenuId, false);

                if (menuLink != null)
                {
                    breadCrumbs.Add(new BreadCrumb
                    {
                        Title = menuLink.GetLocalized(x => x.MenuName, menuLink.Id),
                        Current = false,
                        Url = Url.Action("GetContent", "Menu", new { area = "", menu = menuLink.SeoUrl })
                    });
                }
            }

            breadCrumbs.Add(new BreadCrumb
            {
                Current = true,
                Title = title
            });
            ViewBag.BreadCrumb = breadCrumbs;
            StaticContent staticContent = _staticContentService.Get(x => x.MenuId == MenuId, true);
            if (staticContent != null)
            {
                staticContent = staticContent.ToModel();

                StaticContent viewCount = staticContent;
                viewCount.ViewCount = viewCount.ViewCount + 1;
                _staticContentService.Update(staticContent);

                //Lấy bannerId từ post để hiển thị banner trên post
                ViewBag.BannerId = staticContent.MenuId;

                ViewBag.Title = staticContent.Title;
            }

            ViewBag.MenuId = MenuId;

            return PartialView(staticContent);
        }

        public ActionResult GetStaticContentParent(int menuId, string title, string virtualId)
        {
            List<BreadCrumb> breadCrumbs = new List<BreadCrumb>();
            string[] strArrays = virtualId.Split('/');

            StaticContent staticContent = _staticContentService.Get(x => x.MenuId == menuId && x.Status == 1, false);

            //Convert to localized
            var staticContentLocalized = staticContent.ToModel();

            dynamic viewBag = ViewBag;

            IEnumerable<MenuLink> menuLinks = _menuLinkService.FindBy(x => x.Id == menuId && x.Status == 1, false);

            //Convert to localized
            menuLinks = menuLinks.Select(x => x.ToModel());

            if (menuLinks.IsAny())
            {
                viewBag.ListItems = menuLinks;
            }

            string[] strArrays1 = strArrays;
            for (int i = 0; i < strArrays1.Length; i++)
            {
                string str = strArrays1[i];
                MenuLink menuLink = _menuLinkService.Get(x => x.CurrentVirtualId.Equals(str) && !x.MenuName.Equals(title), false);
                if (menuLink != null)
                {
                    breadCrumbs.Add(new BreadCrumb
                    {
                        Title = menuLink.GetLocalized(x => x.MenuName, menuLink.Id),
                        Current = false,
                        Url = Url.Action("GetContent", "Menu", new { area = "", menu = menuLink.SeoUrl })
                    });
                }
            }

            breadCrumbs.Add(new BreadCrumb
            {
                Current = true,
                Title = staticContentLocalized.Title
            });

            ViewBag.TitleNews = staticContentLocalized.Title;
            ViewBag.BreadCrumb = breadCrumbs;
            ViewBag.Title = staticContentLocalized.Title;

            return PartialView(staticContentLocalized);
        }

        [ChildActionOnly]
        public ActionResult GetStaticHot(string virtualId)
        {
            string str = virtualId;
            string[] strArrays = str.Split('/');

            if (strArrays.Length >= 3)
            {
                str = string.Format("{0}/{1}", strArrays[0], strArrays[1]);
            }

            IEnumerable<MenuLink> menuLinks = _menuLinkService.FindBy(x => x.VirtualId.Contains(str) && x.TemplateType == 6, false);
            return PartialView(menuLinks);
        }

        public ActionResult Search(SeachConditions conditions)
        {
            string str = JsonConvert.SerializeObject(conditions);
            HttpCookie cookie = new HttpCookie("system_search", str);
            cookie.Expires = DateTime.Now.AddDays(1.0);
            Response.Cookies.Add(cookie);

            MenuLink byId = new MenuLink();
            IEnumerable<MenuLink> menuLinks = _menuLinkService.GetByOption(isDisplayHomePage: true, template: new List<int> { 2 });

            if (menuLinks.IsAny())
            {
                byId = menuLinks.FirstOrDefault();
            }

            return RedirectToAction("SearchResult", "Post", new { catUrl = byId.SeoUrl, parameters = conditions.Keywords.NonAccent(), area = "" });
        }
    }
}