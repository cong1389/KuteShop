using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using App.Admin.Helpers;
using App.Core.Caching;
using App.Core.Utils;
using App.FakeEntity.Attribute;
using App.Framework.Ultis;
using App.Service.Attribute;
using AutoMapper;
using Resources;
using Attribute = App.Domain.Entities.Attribute.Attribute;

namespace App.Admin.Controllers
{
	public class AttributeController : BaseAdminController
    {
        private const string CacheAttributeKey = "db.Attribute";
        private readonly ICacheManager _cacheManager;

        private readonly IAttributeService _attributeService;

		public AttributeController(IAttributeService attributeService
             , ICacheManager cacheManager)
		{
            _attributeService = attributeService;
            _cacheManager = cacheManager;

            //Clear cache
            _cacheManager.RemoveByPattern(CacheAttributeKey);
        }

		[RequiredPermisson(Roles="CreateEditAttribute")]
		public ActionResult Create()
		{
			return View();
		}

		[HttpPost]
		[RequiredPermisson(Roles="CreateEditAttribute")]
		public ActionResult Create(AttributeViewModel attributeView, string returnUrl)
		{
			ActionResult action;
			try
			{
				if (!ModelState.IsValid)
				{
					ModelState.AddModelError("", MessageUI.ErrorMessage);
					return View(attributeView);
				}

			    Attribute attribute = Mapper.Map<AttributeViewModel, Attribute>(attributeView);
			    _attributeService.Create(attribute);
			    Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.CreateSuccess, FormUI.Attribute)));
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
				ExtentionUtils.Log(string.Concat("Attribute.Create: ", exception.Message));
				return View(attributeView);
			}
			return action;
		}

		[RequiredPermisson(Roles="DeleteAttribute")]
		public ActionResult Delete(string[] ids)
		{
			try
			{
				if (ids.Length != 0)
				{
					IEnumerable<Attribute> attributes = 
						from id in ids
						select _attributeService.GetById(int.Parse(id));
					_attributeService.BatchDelete(attributes);
				}
			}
			catch (Exception exception1)
			{
				Exception exception = exception1;
				ExtentionUtils.Log(string.Concat("ServerAttribute.Delete: ", exception.Message));
			}
			return RedirectToAction("Index");
		}

		[RequiredPermisson(Roles="CreateEditAttribute")]
		public ActionResult Edit(int id)
		{
			AttributeViewModel attributeViewModel = Mapper.Map<Attribute, AttributeViewModel>(_attributeService.GetById(id));
			return View(attributeViewModel);
		}

		[HttpPost]
		[RequiredPermisson(Roles="CreateEditAttribute")]
		public ActionResult Edit(AttributeViewModel attributeView, string returnUrl)
		{
			ActionResult action;
			try
			{
				if (!ModelState.IsValid)
				{
					ModelState.AddModelError("", MessageUI.ErrorMessage);
					return View(attributeView);
				}

			    Attribute attribute = Mapper.Map<AttributeViewModel, Attribute>(attributeView);
			    _attributeService.Update(attribute);
			    Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.UpdateSuccess, FormUI.Attribute)));
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
				ExtentionUtils.Log(string.Concat("Attribute.Create: ", exception.Message));
				return View(attributeView);
			}
			return action;
		}

		[RequiredPermisson(Roles="ViewAttribute")]
		public ActionResult Index(int page = 1, string keywords = "")
		{
			ViewBag.Keywords = keywords;
			SortingPagingBuilder sortingPagingBuilder = new SortingPagingBuilder
			{
				Keywords = keywords,
				Sorts = new SortBuilder
				{
					ColumnName = "CreatedDate",
					ColumnOrder = SortBuilder.SortOrder.Descending
				}
			};
			Paging paging = new Paging
			{
				PageNumber = page,
				PageSize = PageSize,
				TotalRecord = 0
			};
			IEnumerable<Attribute> attributes = _attributeService.PagedList(sortingPagingBuilder, paging);
			if (attributes != null && attributes.Any())
			{
				Helper.PageInfo pageInfo = new Helper.PageInfo(ExtentionUtils.PageSize, page, paging.TotalRecord, i => Url.Action("Index", new { page = i, keywords }));
				ViewBag.PageInfo = pageInfo;
			}
			return View(attributes);
		}
	}
}