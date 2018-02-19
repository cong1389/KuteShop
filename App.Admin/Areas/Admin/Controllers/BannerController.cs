using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using App.Aplication;
using App.Core.Caching;
using App.Core.Utils;
using App.Domain.Entities.Ads;
using App.Domain.Entities.Menu;
using App.FakeEntity.Ads;
using App.Framework.Ultis;
using App.Service.Ads;
using App.Service.Menu;
using AutoMapper;
using Resources;

namespace App.Admin.Controllers
{
	public class BannerController : BaseAdminController
    {
        private const string CacheBannerKey = "db.Banner";
        private readonly ICacheManager _cacheManager;

        private readonly IMenuLinkService _menuLinkService;

		private readonly IBannerService _bannerService;

		private readonly IPageBannerService _pageBannerService;

		public BannerController(IBannerService bannerService
            , IMenuLinkService menuLinkService
            , IPageBannerService pageBannerService
            , ICacheManager cacheManager)
		{
            _bannerService = bannerService;
            _menuLinkService = menuLinkService;
            _pageBannerService = pageBannerService;
            _cacheManager = cacheManager;

            //Clear cache
            _cacheManager.RemoveByPattern(CacheBannerKey);
        }

		public ActionResult Create()
		{
			return View();
		}

		[HttpPost]
		public ActionResult Create(BannerViewModel bannerView, string returnUrl)
		{
			ActionResult action;
			try
			{
				if (!ModelState.IsValid)
				{
					ModelState.AddModelError("", MessageUI.ErrorMessage);
					return View(bannerView);
				}

			    if (bannerView.Image != null && bannerView.Image.ContentLength > 0)
			    {
			        //string fileName = "Test";
			        //string extension = "Test";
			        string fileName = Path.GetFileName(bannerView.Image.FileName);
			        string extension = Path.GetExtension(bannerView.Image.FileName);
			        //fileName = string.Concat(bannerView.FullName.NonAccent(), extension);
			        string str = Path.Combine(Server.MapPath(string.Concat("~/", Contains.AdsFolder)), fileName);
			        bannerView.Image.SaveAs(str);
			        bannerView.ImgPath = string.Concat(Contains.AdsFolder, fileName);
			    }

			    Banner banner = Mapper.Map<BannerViewModel, Banner>(bannerView);
			    _bannerService.Create(banner);

			    Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.CreateSuccess, FormUI.Banner)));
			    if (!Url.IsLocalUrl(returnUrl) || returnUrl.Length <= 1 || !returnUrl.StartsWith("/") || returnUrl.StartsWith("//") || returnUrl.StartsWith("/\\"))
			    {
			        action = RedirectToAction("Index");
			    }
			    else
			    {
			        action = Redirect(returnUrl);
			    }
			}
			catch (Exception exception1)
			{
				Exception exception = exception1;
				ExtentionUtils.Log(string.Concat("Banner.Create: ", exception.Message));
				ModelState.AddModelError("", exception.Message);
				return View(bannerView);
			}
			return action;
		}

		public ActionResult Delete(string[] ids)
		{
			try
			{
				if (ids.Length != 0)
				{
					IEnumerable<Banner> banners = 
						from id in ids
						select _bannerService.GetById(int.Parse(id));
					_bannerService.BatchDelete(banners);
				}
			}
			catch (Exception exception1)
			{
				Exception exception = exception1;
				ExtentionUtils.Log(string.Concat("Banner.Delete: ", exception.Message));
			}
			return RedirectToAction("Index");
		}

		public ActionResult Edit(int id)
		{
			BannerViewModel bannerViewModel = Mapper.Map<Banner, BannerViewModel>(_bannerService.GetById(id));
			return View(bannerViewModel);
		}

		[HttpPost]
		public ActionResult Edit(BannerViewModel model, string returnUrl)
		{
			ActionResult action;
			try
			{
				if (!ModelState.IsValid)
				{
					ModelState.AddModelError("", MessageUI.ErrorMessage);
					return View(model);
				}

			    Banner byId = _bannerService.GetById(model.Id);
			    if (model.Image != null && model.Image.ContentLength > 0)
			    {
			        string fileName = Path.GetFileName(model.Image.FileName);
			        string extension = Path.GetExtension(model.Image.FileName);
			        //fileName = string.Concat(bannerView.FullName.NonAccent(""), extension);
			        string str = Path.Combine(Server.MapPath(string.Concat("~/", Contains.AdsFolder)), fileName);
			        model.Image.SaveAs(str);
			        model.ImgPath = string.Concat(Contains.AdsFolder, fileName);
			    }

			    Banner banner = Mapper.Map(model, byId);
			    _bannerService.Update(banner);
			    Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.UpdateSuccess, FormUI.Banner)));
			    if (!Url.IsLocalUrl(returnUrl) || returnUrl.Length <= 1 || !returnUrl.StartsWith("/") || returnUrl.StartsWith("//") || returnUrl.StartsWith("/\\"))
			    {
			        action = RedirectToAction("Index");
			    }
			    else
			    {
			        action = Redirect(returnUrl);
			    }
			}
			catch (Exception exception1)
			{
				Exception exception = exception1;
				ModelState.AddModelError("", exception.Message);
				ExtentionUtils.Log(string.Concat("Banner.Edit: ", exception.Message));
				return View(model);
			}
			return action;
		}

		public ActionResult Index(int page = 1, string keywords = "")
		{
			ViewBag.Keywords = keywords;
			SortingPagingBuilder sortingPagingBuilder = new SortingPagingBuilder
			{
				Keywords = keywords,
				Sorts = new SortBuilder
				{
					ColumnName = "Title",
					ColumnOrder = SortBuilder.SortOrder.Descending
				}
			};
			Paging paging = new Paging
			{
				PageNumber = page,
				PageSize = PageSize,
				TotalRecord = 0
			};
			IEnumerable<Banner> banners = _bannerService.PagedList(sortingPagingBuilder, paging);
			if (banners != null && banners.Any())
			{
				Helper.PageInfo pageInfo = new Helper.PageInfo(ExtentionUtils.PageSize, page, paging.TotalRecord, i => Url.Action("Index", new { page = i, keywords }));
				ViewBag.PageInfo = pageInfo;
			}
			return View(banners);
		}

		protected override void OnActionExecuted(ActionExecutedContext filterContext)
		{
			if (filterContext.RouteData.Values["action"].Equals("create") || filterContext.RouteData.Values["action"].Equals("edit"))
			{
				IEnumerable<MenuLink> menuLinks = _menuLinkService.FindBy(x => x.Status == 1 && x.TemplateType != 5, true);
				ViewBag.MenuList = menuLinks;

				IEnumerable<PageBanner> pageBanners = _pageBannerService.FindBy(x => x.Status == 1);
				ViewBag.PageBanners = pageBanners;
			}
		}
	}
}