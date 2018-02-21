using System.Collections.Generic;
using System.Web.Mvc;
using App.Aplication;
using App.Core.Utils;
using App.Domain.Entities.Data;
using App.Framework.Ultis;
using App.Front.Models;
using App.Service.Menu;
using App.Service.News;

namespace App.Front.Controllers
{
	public class CustomerCareController : FrontBaseController
	{
		private readonly INewsService _newsService;

		private readonly IMenuLinkService _menuLinkService;

		public CustomerCareController(INewsService newsService, IMenuLinkService menuLinkService)
		{
			_newsService = newsService;
			_menuLinkService = menuLinkService;
		}

		[ChildActionOnly]
		[PartialCache("Short")]
		public ActionResult GetCustomerCareCategory(string virtualCategoryId, int page, string title)
		{
			SortBuilder sortBuilder = new SortBuilder
			{
				ColumnName = "CreatedDate",
				ColumnOrder = SortBuilder.SortOrder.Descending
			};
			Paging paging = new Paging
			{
				PageNumber = page,
				PageSize = PageSize,
				TotalRecord = 0
			};
			IEnumerable<News> news = _newsService.FindAndSort(x => !x.Video && x.Status == 1 && x.VirtualCategoryId.Contains(virtualCategoryId), sortBuilder, paging);
			if (news.IsAny())
			{
				Helper.PageInfo pageInfo = new Helper.PageInfo(ExtentionUtils.PageSize, page, paging.TotalRecord, i => Url.Action("GetContent", "Menu", new { page = i }));
				ViewBag.PageInfo = pageInfo;
				ViewBag.CountItem = pageInfo.TotalItems;
			}
			ViewBag.Title = title;
			ViewBag.virtualCategoryId = virtualCategoryId;
			return PartialView(news);
		}
	}
}