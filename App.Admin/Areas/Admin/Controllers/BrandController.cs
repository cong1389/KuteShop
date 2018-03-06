using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using App.Admin.Helpers;
using App.Core.Utils;
using App.Domain.Entities.Brandes;
using App.FakeEntity.Brandes;
using App.Framework.Ultis;
using App.Service.Brandes;
using AutoMapper;
using Resources;

namespace App.Admin.Controllers
{
	public class BrandController : BaseAdminController
	{
		private readonly IBrandService _brandService;

		public BrandController(IBrandService brandService)
		{
			_brandService = brandService;
		}

		[RequiredPermisson(Roles="ViewBrand")]
		public ActionResult Create()
		{
			return View();
		}

		[HttpPost]
		[RequiredPermisson(Roles="ViewBrand")]
		public ActionResult Create(BrandViewModel brand, string returnUrl)
		{
			ActionResult action;
			try
			{
				if (!ModelState.IsValid)
				{
					ModelState.AddModelError("", MessageUI.ErrorMessage);
					return View(brand);
				}

			    var brand1 = Mapper.Map<BrandViewModel, Brand>(brand);
			    _brandService.Create(brand1);
			    Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.CreateSuccess, FormUI.Brand)));
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
				var exception = exception1;
				ExtentionUtils.Log(string.Concat("Brand.Create: ", exception.Message));
				return View(brand);
			}
			return action;
		}

		[RequiredPermisson(Roles="DeleteBrand")]
		public ActionResult Delete(string[] ids)
		{
			try
			{
				if (ids.Length != 0)
				{
					var brands = 
						from id in ids
						select _brandService.GetById(int.Parse(id));
					_brandService.BatchDelete(brands);
				}
			}
			catch (Exception exception1)
			{
				var exception = exception1;
				ExtentionUtils.Log(string.Concat("Brand.Delete: ", exception.Message));
			}
			return RedirectToAction("Index");
		}
        		
		public ActionResult Edit(int id)
		{
			var brandViewModel = Mapper.Map<Brand, BrandViewModel>(_brandService.GetById(id));
			return View(brandViewModel);
		}

		[HttpPost]
		[RequiredPermisson(Roles="ViewBrand")]
		public ActionResult Edit(BrandViewModel brandView, string returnUrl)
		{
			ActionResult action;
			try
			{
				if (!ModelState.IsValid)
				{
					ModelState.AddModelError("", MessageUI.ErrorMessage);
					return View(brandView);
				}

			    var brand = Mapper.Map<BrandViewModel, Brand>(brandView);
			    _brandService.Update(brand);
			    Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.UpdateSuccess, FormUI.Brand)));
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
				var exception = exception1;
				ExtentionUtils.Log(string.Concat("MailSetting.Create: ", exception.Message));
				return View(brandView);
			}
			return action;
		}

		[RequiredPermisson(Roles="ViewBrand")]
		public ActionResult Index(int page = 1, string keywords = "")
		{
			ViewBag.Keywords = keywords;
			var sortingPagingBuilder = new SortingPagingBuilder
			{
				Keywords = keywords,
				Sorts = new SortBuilder
				{
					ColumnName = "Name",
					ColumnOrder = SortBuilder.SortOrder.Descending
				}
			};
			var paging = new Paging
			{
				PageNumber = page,
				PageSize = PageSize,
				TotalRecord = 0
			};
			var brands = _brandService.PagedList(sortingPagingBuilder, paging);
			if (brands != null && brands.Any())
			{
				var pageInfo = new Helper.PageInfo(ExtentionUtils.PageSize, page, paging.TotalRecord, i => Url.Action("Index", new { page = i, keywords }));
				ViewBag.PageInfo = pageInfo;
			}
			return View(brands);
		}
	}
}