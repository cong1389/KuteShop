using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Mvc;
using App.Admin.Helpers;
using App.Core.Utils;
using App.Domain.Entities.Account;
using App.Framework.Ultis;
using App.Service.Account;

namespace App.Admin.Controllers
{
	public class RoleController : BaseAdminController
	{
		private readonly IRoleService _roleService;

		public RoleController(IRoleService roleService)
		{
			_roleService = roleService;
		}

		[RequiredPermisson(Roles="ViewRole")]
		public async Task<ActionResult> Index(int page = 1, string keywords = "")
		{
			ViewBag.Keywords = keywords;
			SortingPagingBuilder sortingPagingBuilder = new SortingPagingBuilder
			{
				Keywords = keywords
			};
			SortBuilder sortBuilder = new SortBuilder
			{
				ColumnName = "Name",
				ColumnOrder = SortBuilder.SortOrder.Descending
			};
			sortingPagingBuilder.Sorts = sortBuilder;
			SortingPagingBuilder sortingPagingBuilder1 = sortingPagingBuilder;
			Paging paging = new Paging
			{
				PageNumber = page,
				PageSize = PageSize,
				TotalRecord = 0
			};
			Paging paging1 = paging;
			IEnumerable<Role> roles = await _roleService.PagedList(sortingPagingBuilder1, paging1);
			if (roles != null && roles.Any())
			{
				Helper.PageInfo pageInfo = new Helper.PageInfo(ExtentionUtils.PageSize, page, paging1.TotalRecord, i => Url.Action("Index", new { page = i, keywords }));
				ViewBag.PageInfo = pageInfo;
			}
			return View(roles);
		}
	}
}