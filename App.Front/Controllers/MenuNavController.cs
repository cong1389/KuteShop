using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using App.Aplication;
using App.Domain.Common;
using App.FakeEntity.Menu;
using App.Front.Extensions;
using App.Front.Models;
using App.Service.Menu;

namespace App.Front.Controllers
{
    public class MenuNavController : FrontBaseController
    {
        private readonly IMenuLinkService _menuLinkService;

        public MenuNavController(IMenuLinkService menuLinkService)
        {
            _menuLinkService = menuLinkService;
        }

        [ChildActionOnly]
        public ActionResult GetFooterLink()
        {
            var menuNavs = new List<MenuNavViewModel>();

            var menuLinks = _menuLinkService.GetByOption(new List<int> { (int)Position.Footer });

            if (!menuLinks.IsAny())
            {
                return PartialView(menuNavs);
            }

            var navViewModels = menuLinks.Select(x => new MenuNavViewModel
            {
                MenuId = x.Id,
                ParentId = x.ParentId,
                MenuName = x.MenuName,
                SeoUrl = x.SeoUrl,
                OrderDisplay = x.OrderDisplay,
                ImageBigSize = x.ImageBigSize,
                CurrentVirtualId = x.CurrentVirtualId,
                VirtualId = x.VirtualId,
                TemplateType = x.TemplateType,
                ImageMediumSize = x.ImageMediumSize,
                ImageSmallSize = x.ImageSmallSize
            });
            menuNavs = MenuNavExtensions.MenuNavsViewModels(null, navViewModels);
            //menuNavs = CreateMenuNav(null, navViewModels);

            return PartialView(menuNavs);
        }
        
        public List<MenuNavViewModel> TopMenuNavs()
        {
            var menuLinks = _menuLinkService.GetByOption(new List<int> { (int)Position.Top });

            //Convert to localized
            menuLinks = menuLinks.Select(x => x.ToModel());

            var menuNav = menuLinks.Select(x => new MenuNavViewModel
            {
                MenuId = x.Id,
                ParentId = x.ParentId,
                MenuName = x.MenuName,
                SeoUrl = x.SeoUrl,
                OtherLink = x.SourceLink,
                OrderDisplay = x.OrderDisplay,
                ImageBigSize = x.ImageBigSize,
                CurrentVirtualId = x.CurrentVirtualId,
                VirtualId = x.VirtualId,
                TemplateType = x.TemplateType,
                ImageMediumSize = x.ImageMediumSize,
                ImageSmallSize = x.ImageSmallSize
            });

            return MenuNavExtensions.MenuNavsViewModels(null, menuNav);
        }
        
        [PartialCache("Long")]
        [ChildActionOnly]
        public ActionResult GetTopMenu()
        {
            var menuNavs = TopMenuNavs();

            return PartialView(menuNavs);
        }

        [ChildActionOnly]
        public ActionResult GetTopMenuMobile()
        {
            var menuNavs = TopMenuNavs();

            return PartialView(menuNavs);
        }

        [ChildActionOnly]
        //[PartialCache("Long")]
        public ActionResult GetTopHead()
        {
            var menuNavs = new List<MenuNavViewModel>();
            var menuLinks = _menuLinkService.GetByOption(new List<int> { (int)Position.TopHead });

            //Convert to localized
            menuLinks = menuLinks.Select(x => x.ToModel());

            if (!menuLinks.Any())
            {
                return PartialView(menuNavs);
            }

            var menuNav = menuLinks.Select(x => new MenuNavViewModel
            {
                MenuId = x.Id,
                ParentId = x.ParentId,
                MenuName = x.MenuName,
                SeoUrl = x.SeoUrl,
                OrderDisplay = x.OrderDisplay,
                ImageBigSize = x.ImageBigSize,
                CurrentVirtualId = x.CurrentVirtualId,
                VirtualId = x.VirtualId,
                TemplateType = x.TemplateType,
                ImageMediumSize = x.ImageMediumSize,
                ImageSmallSize = x.ImageSmallSize
            });

            return PartialView(menuNav);
        }
        
        [ChildActionOnly]
        public PartialViewResult MenuNavLeft(string virtualId)
        {
            var ieMenuNav = PrepareMenuNavBase(virtualId);

            return PartialView(ieMenuNav);
        }

        [ChildActionOnly]
        public PartialViewResult MenuNavNews(string virtualId)
        {
            var navViewModels = PrepareMenuNavBase(virtualId);

            return PartialView(navViewModels);
        }

        [ChildActionOnly]
        public PartialViewResult MenuHomeSlide(string virtualId)
        {
            var ieMenuNav = PrepareMenuNavBase(virtualId);

            return PartialView(ieMenuNav);
        }

        [NonAction]
        private IEnumerable<MenuNavViewModel> PrepareMenuNavBase(string virtualId)
        {
            virtualId = virtualId != null && virtualId.Count(i => i.Equals('/')) > 0
                ? virtualId.Split('/')[0]
                : virtualId;

            var menuLinks = _menuLinkService.GetByOption(virtualId: virtualId);

            if (!menuLinks.IsAny())
            {
                return null;
            }

            //Convert to localized
            menuLinks = menuLinks.Where(x => x.ParentId != null).Select(x => x.ToModel());

            var navViewModels = menuLinks.Select(x => new MenuNavViewModel
            {
                MenuId = x.Id,
                ParentId = x.ParentId,
                MenuName = x.MenuName,
                SeoUrl = x.SeoUrl,
                OrderDisplay = x.OrderDisplay,
                ImageBigSize = x.ImageBigSize,
                CurrentVirtualId = x.CurrentVirtualId,
                VirtualId = x.VirtualId,
                TemplateType = x.TemplateType,
                ImageMediumSize = x.ImageMediumSize,
                ImageSmallSize = x.ImageSmallSize
            });
            return navViewModels;

        }

        [ChildActionOnly]
        [PartialCache("Long")]
        public ActionResult GetMenuCategory()
        {
            var menuLinks = _menuLinkService.GetByOption(new List<int> { (int)Position.Top, (int)Position.SiderBar });

            var menuNavs = new List<MenuNavViewModel>();
            if (menuLinks.IsAny())
            {
                var navViewModels =
                    from x in menuLinks
                    select new MenuNavViewModel
                    {
                        MenuId = x.Id,
                        ParentId = x.ParentId,
                        MenuName = x.MenuName,
                        SeoUrl = x.SeoUrl,
                        OrderDisplay = x.OrderDisplay,
                        ImageBigSize = x.ImageBigSize,
                        CurrentVirtualId = x.CurrentVirtualId,
                        VirtualId = x.VirtualId,
                        TemplateType = x.TemplateType,
                        ImageMediumSize = x.ImageMediumSize,
                        ImageSmallSize = x.ImageSmallSize
                    };
                menuNavs = MenuNavExtensions.MenuNavsViewModels(null, navViewModels);
                //menuNavs = CreateMenuNav(null, menuNav);
            }

            return PartialView(menuNavs);
        }

        [ChildActionOnly]
        public ActionResult GetMenuVerticalMega()
        {
            var menuLinks = _menuLinkService.GetByOption(new List<int> { (int)Position.SiderBar });

            if (!menuLinks.IsAny())
            {
                return HttpNotFound();
            }

            var navViewModels =
                from x in menuLinks
                select new MenuNavViewModel
                {
                    MenuId = x.Id,
                    ParentId = x.ParentId,
                    MenuName = x.MenuName,
                    SeoUrl = x.SeoUrl,
                    OrderDisplay = x.OrderDisplay,
                    ImageBigSize = x.ImageBigSize,
                    CurrentVirtualId = x.CurrentVirtualId,
                    VirtualId = x.VirtualId,
                    TemplateType = x.TemplateType,
                    ImageMediumSize = x.ImageMediumSize,
                    ImageSmallSize = x.ImageSmallSize
                };

            var menuNavs = MenuNavExtensions.MenuNavsViewModels(null, navViewModels);
            //var menuNavs = CreateMenuNav(null, menuNav);

            return PartialView(menuNavs);
        }

        [ChildActionOnly]
        public ActionResult GetMenuLinkSideBar(string virtualId, List<int> proAttrs = null)
        {
            virtualId = virtualId != null && virtualId.Count(i => i.Equals('/')) > 0
                ? virtualId.Split('/')[0]
                : virtualId;

            var menuLinks = _menuLinkService.GetByOption(virtualId: virtualId);

            if (!menuLinks.IsAny())
            {
                return HttpNotFound();
            }

            //Convert to localized
            menuLinks = menuLinks.Select(x => x.ToModel());

            var navViewModels =
                from x in menuLinks
                select new MenuNavViewModel
                {
                    MenuId = x.Id,
                    ParentId = x.ParentId,
                    MenuName = x.MenuName,
                    SeoUrl = x.SeoUrl,
                    OrderDisplay = x.OrderDisplay,
                    ImageBigSize = x.ImageBigSize,
                    CurrentVirtualId = x.CurrentVirtualId,
                    VirtualId = x.VirtualId,
                    TemplateType = x.TemplateType,
                    ImageMediumSize = x.ImageMediumSize,
                    ImageSmallSize = x.ImageSmallSize
                };


            var menuNavs = MenuNavExtensions.MenuNavsViewModels(null, navViewModels);
            //var menuNavs = CreateMenuNav(null, menuNav);

            ViewBag.ProIds = proAttrs;

            return PartialView(menuNavs);
        }
        
        [ChildActionOnly]
        public ActionResult Header()
        {
            return PartialView();
        }

        [PartialCache("Long")]
        public ActionResult StickyBar()
        {
            var menuNavs = new List<MenuNavViewModel>();
            var menuLinks = _menuLinkService.GetByOption(new List<int> { (int)Position.Middle }, isDisplaySearch: true);

            if (menuLinks.IsAny())
            {
                var navViewModels =
                    from x in menuLinks
                    select new MenuNavViewModel
                    {
                        MenuId = x.Id,
                        ParentId = x.ParentId,
                        MenuName = x.MenuName,
                        SeoUrl = x.SeoUrl,
                        OrderDisplay = x.OrderDisplay,
                        ImageBigSize = x.ImageBigSize,
                        CurrentVirtualId = x.CurrentVirtualId,
                        VirtualId = x.VirtualId,
                        TemplateType = x.TemplateType,
                        ImageMediumSize = x.ImageMediumSize,
                        ImageSmallSize = x.ImageSmallSize
                    };

                 menuNavs = MenuNavExtensions.MenuNavsViewModels(null, navViewModels);
                //menuNavs = CreateMenuNav(null, menuNav);
            }

            return PartialView(menuNavs);
        }
    }


}