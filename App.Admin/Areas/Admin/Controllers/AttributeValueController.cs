using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using App.Admin.Helpers;
using App.Core.Utils;
using App.Domain.Entities.Attribute;
using App.FakeEntity.Attribute;
using App.Framework.Ultis;
using App.Service.Attribute;
using AutoMapper;
using Resources;
using Attribute = App.Domain.Entities.Attribute.Attribute;

namespace App.Admin.Controllers
{
	public class AttributeValueController : BaseAdminController
	{
		private readonly IAttributeValueService _attributeValueService;

		private readonly IAttributeService _attributeService;

		public AttributeValueController(IAttributeValueService attributeValueService, IAttributeService attributeService)
		{
			_attributeValueService = attributeValueService;
			_attributeService = attributeService;
		}

		[RequiredPermisson(Roles="CreateEditDistrict")]
		public ActionResult Create()
		{
			return View();
		}

		[HttpPost]
		[RequiredPermisson(Roles="CreateEditDistrict")]
		public ActionResult Create(AttributeValueViewModel attributeValue, string returnUrl)
		{
			ActionResult action;
			try
			{
				if (!ModelState.IsValid)
				{
					ModelState.AddModelError("", MessageUI.ErrorMessage);
					return View(attributeValue);
				}

			    AttributeValue attributeValue1 = Mapper.Map<AttributeValueViewModel, AttributeValue>(attributeValue);
			    _attributeValueService.Create(attributeValue1);
			    Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.CreateSuccess, FormUI.AttributeValue)));
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
				ExtentionUtils.Log(string.Concat("District.Create: ", exception.Message));
				return View(attributeValue);
			}
			return action;
		}

		[RequiredPermisson(Roles="DeleteDistrict")]
		public ActionResult Delete(string[] ids)
		{
			try
			{
				if (ids.Length != 0)
				{
					IEnumerable<AttributeValue> attributeValues = 
						from id in ids
						select _attributeValueService.GetById(int.Parse(id));
					_attributeValueService.BatchDelete(attributeValues);
				}
			}
			catch (Exception exception1)
			{
				Exception exception = exception1;
				ExtentionUtils.Log(string.Concat("District.Delete: ", exception.Message));
			}
			return RedirectToAction("Index");
		}

		[RequiredPermisson(Roles="CreateEditDistrict")]
		public ActionResult Edit(int id)
		{
			AttributeValueViewModel attributeValueViewModel = Mapper.Map<AttributeValue, AttributeValueViewModel>(_attributeValueService.GetById(id));
			return View(attributeValueViewModel);
		}

		[HttpPost]
		[RequiredPermisson(Roles="CreateEditDistrict")]
		public ActionResult Edit(AttributeValueViewModel attributeValue, string returnUrl)
		{
			ActionResult action;
			try
			{
				if (!ModelState.IsValid)
				{
					ModelState.AddModelError("", MessageUI.ErrorMessage);
					return View(attributeValue);
				}

			    AttributeValue attributeValue1 = Mapper.Map<AttributeValueViewModel, AttributeValue>(attributeValue);
			    _attributeValueService.Update(attributeValue1);
			    Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.UpdateSuccess, FormUI.AttributeValue)));
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
				ExtentionUtils.Log(string.Concat("District.Edit: ", exception.Message));
				return View(attributeValue);
			}
			return action;
		}

		[RequiredPermisson(Roles="ViewDistrict")]
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
			List<AttributeValue> list = _attributeValueService.PagedList(sortingPagingBuilder, paging).ToList();
			list.ForEach(item => item.Attribute = _attributeService.GetById(item.AttributeId));
			if (list != null && list.Any())
			{
				Helper.PageInfo pageInfo = new Helper.PageInfo(ExtentionUtils.PageSize, page, paging.TotalRecord, i => Url.Action("Index", new { page = i, keywords }));
				ViewBag.PageInfo = pageInfo;
			}
			return View(list);
		}

		protected override void OnActionExecuted(ActionExecutedContext filterContext)
		{
			if (filterContext.RouteData.Values["action"].Equals("create") || filterContext.RouteData.Values["action"].Equals("edit"))
			{
				IEnumerable<Attribute> all = _attributeService.GetAll();
				ViewBag.Attributes = all;
			}
		}
	}
}