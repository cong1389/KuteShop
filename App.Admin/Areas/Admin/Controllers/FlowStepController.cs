using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using App.Admin.Helpers;
using App.Aplication;
using App.Core.Caching;
using App.Core.Utils;
using App.Domain.Entities.Data;
using App.FakeEntity.Step;
using App.Framework.Ultis;
using App.Service.Step;
using AutoMapper;
using Resources;

namespace App.Admin.Controllers
{
    public class FlowStepController : BaseAdminController
    {
        private const string CacheFlowstepKey = "db.FlowStep";
        private readonly ICacheManager _cacheManager;

        private readonly IFlowStepService _flowStepService;

		private IImagePlugin _imagePlugin;

		public FlowStepController(IFlowStepService flowStepService, IImagePlugin imagePlugin
            , ICacheManager cacheManager)
		{
			_flowStepService = flowStepService;
			_imagePlugin = imagePlugin;
            _cacheManager = cacheManager;

            //Clear cache
            _cacheManager.RemoveByPattern(CacheFlowstepKey);

        }

        [RequiredPermisson(Roles="CreateEditFlowStep")]
		public ActionResult Create()
		{
			return View();
		}

		[HttpPost]
		[RequiredPermisson(Roles="CreateEditFlowStep")]
		public ActionResult Create(FlowStepViewModel model, string returnUrl)
		{
			ActionResult action;
			try
			{
				if (!ModelState.IsValid)
				{
					ModelState.AddModelError("", MessageUI.ErrorMessage);
					return View(model);
				}

			    string titleNonAccent = model.Title.NonAccent();
			    if (model.Image != null && model.Image.ContentLength > 0)
			    {
			        string fileExtension = Path.GetExtension(model.Image.FileName);
			        string fileName1 = titleNonAccent.FileNameFormat(fileExtension);
			        //                  int? nullable = null;
			        //int? nullable1 = nullable;
			        //nullable = null;

			        _imagePlugin.CropAndResizeImage(model.Image, $"{Contains.FlowStepFolder}", fileName1, ImageSize.FlowStep_WithMediumSize, ImageSize.FlowStep_HeightMediumSize);

			        model.ImageUrl = string.Concat(Contains.FlowStepFolder, fileName1);
			    }

			    FlowStep flowStep = Mapper.Map<FlowStepViewModel, FlowStep>(model);

			    _flowStepService.Create(flowStep);

			    Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.CreateSuccess, FormUI.FlowStep)));
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
				ExtentionUtils.Log(string.Concat("Post.Create: ", exception.Message));
				ModelState.AddModelError("", exception.Message);
				return View(model);
			}
			return action;
		}

		[RequiredPermisson(Roles="CreateEditFlowStep")]
		public ActionResult Delete(int[] ids)
		{
			try
			{
				if (ids.Length != 0)
				{
					IEnumerable<FlowStep> flowSteps = 
						from id in ids
						select _flowStepService.Get(x => x.Id == id);
					_flowStepService.BatchDelete(flowSteps);
				}
			}
			catch (Exception exception1)
			{
				Exception exception = exception1;
				ExtentionUtils.Log(string.Concat("Post.Delete: ", exception.Message));
			}
			return RedirectToAction("Index");
		}

		[RequiredPermisson(Roles="CreateEditFlowStep")]
		public ActionResult Edit(int id)
		{
			FlowStepViewModel flowStepViewModel = Mapper.Map<FlowStep, FlowStepViewModel>(_flowStepService.Get(x => x.Id == id));
			return View(flowStepViewModel);
		}

		[HttpPost]
		[RequiredPermisson(Roles="CreateEditFlowStep")]
		public ActionResult Edit(FlowStepViewModel model, string returnUrl)
		{
			ActionResult action;
			try
			{
				if (!ModelState.IsValid)
				{
					ModelState.AddModelError("", MessageUI.ErrorMessage);
					return View(model);
				}

			    FlowStep byId = _flowStepService.Get(x => x.Id == model.Id);

			    string titleNonAccent = model.Title.NonAccent();
			    if (model.Image != null && model.Image.ContentLength > 0)
			    {
			        string fileExtension = Path.GetExtension(model.Image.FileName);
                        
			        string fileName1 = titleNonAccent.FileNameFormat(fileExtension);
			        //                  int? nullable = null;
			        //int? nullable1 = nullable;
			        //nullable = null;

			        _imagePlugin.CropAndResizeImage(model.Image, $"{Contains.FlowStepFolder}", fileName1, ImageSize.FlowStep_WithMediumSize, ImageSize.FlowStep_HeightMediumSize);

			        model.ImageUrl = string.Concat(Contains.FlowStepFolder, fileName1);
			    }

			    FlowStep flowStep1 = Mapper.Map(model, byId);

			    _flowStepService.Update(flowStep1);

			    Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.UpdateSuccess, FormUI.FlowStep)));
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
				ExtentionUtils.Log(string.Concat("Post.Edit: ", exception.Message));
				return View(model);
			}
			return action;
		}

		[RequiredPermisson(Roles="ViewFlowStep")]
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
			IEnumerable<FlowStep> flowSteps = _flowStepService.PagedList(sortingPagingBuilder, paging);
			if (flowSteps != null && flowSteps.Any())
			{
				Helper.PageInfo pageInfo = new Helper.PageInfo(ExtentionUtils.PageSize, page, paging.TotalRecord, i => Url.Action("Index", new { page = i, keywords }));
				ViewBag.PageInfo = pageInfo;
			}
			return View(flowSteps);
		}
	}
}