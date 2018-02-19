using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using App.Admin.Helpers;
using App.Core.Caching;
using App.Core.Utils;
using App.Domain.Entities.GlobalSetting;
using App.FakeEntity.ServerMail;
using App.Framework.Ultis;
using App.Service.MailSetting;
using AutoMapper;
using Resources;

namespace App.Admin.Controllers
{
	public class MailSettingController : BaseAdminController
    {
        private const string CacheMailsettingKey = "db.MailSetting";
        private readonly ICacheManager _cacheManager;

        private readonly IMailSettingService _mailSettingService;

		public MailSettingController(IMailSettingService mailSettingService
            , ICacheManager cacheManager)
		{
			_mailSettingService = mailSettingService;
            _cacheManager = cacheManager;

            //Clear cache
            _cacheManager.RemoveByPattern(CacheMailsettingKey);

        }

        [RequiredPermisson(Roles="CreateEditMailSetting")]
		public ActionResult Create()
		{
			return View();
		}

		[HttpPost]
		[RequiredPermisson(Roles="CreateEditMailSetting")]
		public ActionResult Create(ServerMailSettingViewModel serverMail, string returnUrl)
		{
			ActionResult action;
			try
			{
				if (!ModelState.IsValid)
				{
					ModelState.AddModelError("", MessageUI.ErrorMessage);
					return View(serverMail);
				}

			    ServerMailSetting serverMailSetting = Mapper.Map<ServerMailSettingViewModel, ServerMailSetting>(serverMail);
			    _mailSettingService.Create(serverMailSetting);
			    Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.CreateSuccess, FormUI.ServerMailSetting)));
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
				ExtentionUtils.Log(string.Concat("MailSetting.Create: ", exception.Message));
				return View(serverMail);
			}
			return action;
		}

		[RequiredPermisson(Roles="DeleteMailSetting")]
		public ActionResult Delete(string[] ids)
		{
			try
			{
				if (ids.Length != 0)
				{
					IEnumerable<ServerMailSetting> serverMailSettings = 
						from id in ids
						select _mailSettingService.GetById(int.Parse(id));
					_mailSettingService.BatchDelete(serverMailSettings);
				}
			}
			catch (Exception exception1)
			{
				Exception exception = exception1;
				ExtentionUtils.Log(string.Concat("ServerMailSetting.Delete: ", exception.Message));
			}
			return RedirectToAction("Index");
		}

		[RequiredPermisson(Roles="CreateEditMailSetting")]
		public ActionResult Edit(int id)
		{
			ServerMailSettingViewModel serverMailSettingViewModel = Mapper.Map<ServerMailSetting, ServerMailSettingViewModel>(_mailSettingService.GetById(id));
			return View(serverMailSettingViewModel);
		}

		[HttpPost]
		[RequiredPermisson(Roles="CreateEditMailSetting")]
		public ActionResult Edit(ServerMailSettingViewModel serverMail, string returnUrl)
		{
			ActionResult action;
			try
			{
				if (!ModelState.IsValid)
				{
					ModelState.AddModelError("", MessageUI.ErrorMessage);
					return View(serverMail);
				}

			    ServerMailSetting serverMailSetting = Mapper.Map<ServerMailSettingViewModel, ServerMailSetting>(serverMail);
			    _mailSettingService.Update(serverMailSetting);
			    Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.UpdateSuccess, FormUI.ServerMailSetting)));
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
				ExtentionUtils.Log(string.Concat("MailSetting.Create: ", exception.Message));
				return View(serverMail);
			}
			return action;
		}

		[RequiredPermisson(Roles="ViewMailSetting")]
		public ActionResult Index(int page = 1, string keywords = "")
		{
			ViewBag.Keywords = keywords;
			SortingPagingBuilder sortingPagingBuilder = new SortingPagingBuilder
			{
				Keywords = keywords,
				Sorts = new SortBuilder
				{
					ColumnName = "FromAddress",
					ColumnOrder = SortBuilder.SortOrder.Descending
				}
			};
			Paging paging = new Paging
			{
				PageNumber = page,
				PageSize = PageSize,
				TotalRecord = 0
			};
			IEnumerable<ServerMailSetting> serverMailSettings = _mailSettingService.PagedList(sortingPagingBuilder, paging);
			if (serverMailSettings != null && serverMailSettings.Any())
			{
				Helper.PageInfo pageInfo = new Helper.PageInfo(ExtentionUtils.PageSize, page, paging.TotalRecord, i => Url.Action("Index", new { page = i, keywords }));
				ViewBag.PageInfo = pageInfo;
			}
			return View(serverMailSettings);
		}
	}
}