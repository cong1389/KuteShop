using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using App.Aplication;
using App.Core.Utils;
using App.Domain.Entities.Data;
using App.Framework.Ultis;
using App.Service.News;

namespace App.Front.Controllers
{
	public class ProfileController : FrontBaseController
	{
		private readonly INewsService _newsService;

		public ProfileController(INewsService newsService)
		{
			_newsService = newsService;
		}

		public ActionResult GetProfileCategory(string virtualCategoryId, int page, string title)
		{
			SortingPagingBuilder sortingPagingBuilder = new SortingPagingBuilder
			{
				Keywords = virtualCategoryId,
				Sorts = new SortBuilder
				{
					ColumnName = "OrderDisplay",
					ColumnOrder = SortBuilder.SortOrder.Descending
				}
			};
			Paging paging = new Paging
			{
				PageNumber = page,
				PageSize = PageSize,
				TotalRecord = 0
			};
			IEnumerable<News> news = _newsService.PagedListByMenu(sortingPagingBuilder, paging);
			if (news.IsAny())
			{
				Helper.PageInfo pageInfo = new Helper.PageInfo(ExtentionUtils.PageSize, page, paging.TotalRecord, i => Url.Action("GetContent", "Menu", new { page = i }));
				ViewBag.PageInfo = pageInfo;
				ViewBag.CountItem = pageInfo.TotalItems;
			}
			ViewBag.Title = title;
			return PartialView(news.ToList());
		}
	}
}