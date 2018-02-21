using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using App.Aplication;
using App.Aplication.Extensions;
using App.Domain.Entities.Data;
using App.Domain.Entities.Menu;
using App.Front.Models;
using App.Service.Language;
using App.Service.Menu;
using App.Service.Static;
using Newtonsoft.Json;

namespace App.Front.Controllers
{
    public class MenuController : FrontBaseController
    {
        private readonly IMenuLinkService _menuLinkService;

        private readonly IStaticContentService _staticContentService;

        public MenuController(
            IMenuLinkService menuLinkService
            , IStaticContentService staticContentService
            )
        {
            _menuLinkService = menuLinkService;
            _staticContentService = staticContentService;
        }

        [PartialCache("Short")]
        public ActionResult GetContent(string menu, int page)
        {
            dynamic viewBag = ViewBag;

            MenuLink menuLink = _menuLinkService.GetBySeoUrl(menu);

            if (menuLink == null) return View();

            var menuLinkLocalized = menuLink.ToModel();

            ViewBag.Title = menuLinkLocalized.MetaTitle ?? menuLinkLocalized.MenuName;
            ViewBag.MetaKeyWords = menuLinkLocalized.MetaKeywords;
            ViewBag.SiteUrl = Url.Action("GetContent", "Menu", new { menu, page, area = "" });
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

            return View();
        }

        [PartialCache("Short")]
        public ActionResult GetFixItemContent(int id)
        {
            MenuLink menuLink = _menuLinkService.GetById(id);

            ViewBag.ImgUrl = menuLink.ImageUrl;
            ViewBag.TitleFix = menuLink.MenuName;

            var menuLinks = _menuLinkService.GetByOption(parentId: new List<int> { id }, isDisplayHomePage: true);

            if (!menuLinks.IsAny())
            {
                return Json(new { success = true, data = "" }, JsonRequestBehavior.AllowGet);
            }
            return Json(new { data = this.RenderRazorViewToString("_PartialFixItemContent", menuLinks), success = true }, JsonRequestBehavior.AllowGet);
        }

        [PartialCache("Short")]
        public ActionResult GetLeftFixItem(int id)
        {
            var menuLinks = _menuLinkService.GetByOption(parentId: new List<int> { id }, isDisplayHomePage: true);

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
            var menuLinks = _menuLinkService.GetByOption(template: new List<int> { 2 }, isDisplayHomePage: true);

            return PartialView(menuLinks);
        }

        [ChildActionOnly]
        public ActionResult GetStaticContent(int menuId, string virtualId, string title)
        {
            List<BreadCrumb> breadCrumbs = new List<BreadCrumb>();
            string[] strArrays = virtualId.Split('/');

            for (int i = 0; i < strArrays.Length; i++)
            {
                string str = strArrays[i];
                MenuLink menuLink = _menuLinkService.GetByParentId(menuId, str);

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

            StaticContent staticContent = _staticContentService.Get(x => x.MenuId == menuId, true);
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

            ViewBag.MenuId = menuId;

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
                str = $"{strArrays[0]}/{strArrays[1]}";
            }

            var menuLinks = _menuLinkService.FindBy(x => x.VirtualId.Contains(str) && x.TemplateType == 6);

            return PartialView(menuLinks);
        }

        public ActionResult Search(SeachConditions conditions)
        {
            string str = JsonConvert.SerializeObject(conditions);
            HttpCookie cookie = new HttpCookie("system_search", str) { Expires = DateTime.Now.AddDays(1.0) };
            Response.Cookies.Add(cookie);

            MenuLink byId = new MenuLink();
            IEnumerable<MenuLink> menuLinks = _menuLinkService.GetByOption(isDisplayHomePage: true, template: new List<int> { 2 });

            if (menuLinks.IsAny())
            {
                byId = menuLinks.FirstOrDefault();
            }

            return RedirectToAction("SearchResult", "Post", new { catUrl = byId?.SeoUrl, parameters = conditions.Keywords.NonAccent(), area = "" });
        }
    }
}