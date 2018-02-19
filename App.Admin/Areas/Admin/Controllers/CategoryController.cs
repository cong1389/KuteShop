using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using App.Admin.Helpers;
using App.Core.Caching;
using App.Domain.Entities.Menu;
using App.Service.Menu;

namespace App.Admin.Controllers
{
	public class CategoryController : BaseAdminController
	{
        private const string CacheCategoryKey = "db.Category";
        private readonly ICacheManager _cacheManager;

        private readonly IMenuLinkService _menuLinkService;

		public CategoryController(IMenuLinkService menuLinkService
             , ICacheManager cacheManager)
		{
			_menuLinkService = menuLinkService;
            _cacheManager = cacheManager;

            //Clear cache
            _cacheManager.RemoveByPattern(CacheCategoryKey);
        }

        private List<MenuNav> CreateMenuNav(int? parentId, IEnumerable<MenuNav> source)
		{
			return source.Where(x => {
				int? nullable1 = x.ParentId;
				int? nullable = parentId;
				if (nullable1.GetValueOrDefault() != nullable.GetValueOrDefault())
				{
					return false;
				}
				return nullable1.HasValue == nullable.HasValue;
			}).Select(x => new MenuNav
			{
				MenuId = x.MenuId,
				ParentId = x.ParentId,
				MenuName = x.MenuName,
				ChildNavMenu = CreateMenuNav(x.MenuId, source)
			}).ToList();
		}

		public ActionResult GetMenu(int? selected)
		{
			List<MenuNav> menuNavs = new List<MenuNav>();
			IEnumerable<MenuLink> all = _menuLinkService.GetAll();
			if (all.Any())
			{
				IEnumerable<MenuNav> orderDisplay = 
					from x in all
					orderby x.OrderDisplay descending
					select new MenuNav
					{
						MenuId = x.Id,
						ParentId = x.ParentId,
						MenuName = x.MenuName
					};
				menuNavs = CreateMenuNav(null, orderDisplay);
			}
			ViewBag.Selected = selected;
			return PartialView(menuNavs.ToList());
		}

		public ActionResult GetMenuProduct(int? selected)
		{
			List<MenuNav> menuNavs = new List<MenuNav>();
			IEnumerable<MenuLink> menuLinks = _menuLinkService.FindBy(x => x.TemplateType == 2 || x.TemplateType == 8, true);
			if (menuLinks.Any())
			{
				IEnumerable<MenuNav> orderDisplay = 
					from x in menuLinks
					orderby x.OrderDisplay descending
					select new MenuNav
					{
						MenuId = x.Id,
						ParentId = x.ParentId,
						MenuName = x.MenuName
					};
				menuNavs = CreateMenuNav(null, orderDisplay);
			}
			ViewBag.Selected = selected;
			return PartialView(menuNavs.ToList());
		}
	}
}