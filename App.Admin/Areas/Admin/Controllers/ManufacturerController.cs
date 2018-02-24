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
using App.FakeEntity.Manufacturers;
using App.Framework.Ultis;
using App.Service.Manufacturers;
using AutoMapper;
using Resources;

namespace App.Admin.Controllers
{
    public class ManufacturerController : BaseAdminController
    {
        private const string CacheFlowstepKey = "db.Manufacturer";
        private readonly ICacheManager _cacheManager;

        private readonly IManufacturerService _manufacturerService;

        private readonly IImagePlugin _imagePlugin;

        public ManufacturerController(IManufacturerService manufacturerService, IImagePlugin imagePlugin
            , ICacheManager cacheManager)
        {
            _manufacturerService = manufacturerService;
            _imagePlugin = imagePlugin;
            _cacheManager = cacheManager;

            //Clear cache
            _cacheManager.RemoveByPattern(CacheFlowstepKey);

        }

        [RequiredPermisson(Roles = "CreateEditFlowStep")]
        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        [RequiredPermisson(Roles = "CreateEditFlowStep")]
        public ActionResult Create(ManufacturerViewModel model, string returnUrl)
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

                    _imagePlugin.CropAndResizeImage(model.Image, $"{Contains.FlowStepFolder}", fileName1, ImageSize.FlowStep_WithMediumSize, ImageSize.FlowStep_HeightMediumSize);

                    model.ImageUrl = string.Concat(Contains.FlowStepFolder, fileName1);
                }

                Manufacturer manufacturer = Mapper.Map<ManufacturerViewModel, Manufacturer>(model);

                _manufacturerService.Create(manufacturer);

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
            catch (Exception ex)
            {
                ExtentionUtils.Log(string.Concat("Manufacturer.Create: ", ex.Message));
                ModelState.AddModelError("", ex.Message);
                return View(model);
            }

            return action;
        }

        [RequiredPermisson(Roles = "CreateEditFlowStep")]
        public ActionResult Delete(int[] ids)
        {
            try
            {
                if (ids.Length != 0)
                {
                    IEnumerable<Manufacturer> flowSteps =
                        from id in ids
                        select _manufacturerService.Get(x => x.Id == id);
                    _manufacturerService.BatchDelete(flowSteps);
                }
            }
            catch (Exception ex)
            {
                ExtentionUtils.Log(string.Concat("Manufacturer.Delete: ", ex.Message));
            }

            return RedirectToAction("Index");
        }

        [RequiredPermisson(Roles = "CreateEditFlowStep")]
        public ActionResult Edit(int id)
        {
            ManufacturerViewModel manufacturerViewModel = Mapper.Map<Manufacturer, ManufacturerViewModel>(_manufacturerService.Get(x => x.Id == id));

            return View(manufacturerViewModel);
        }

        [HttpPost]
        [RequiredPermisson(Roles = "CreateEditFlowStep")]
        public ActionResult Edit(ManufacturerViewModel model, string returnUrl)
        {
            ActionResult action;
            try
            {
                if (!ModelState.IsValid)
                {
                    ModelState.AddModelError("", MessageUI.ErrorMessage);
                    return View(model);
                }

                Manufacturer byId = _manufacturerService.Get(x => x.Id == model.Id);

                string titleNonAccent = model.Title.NonAccent();
                if (model.Image != null && model.Image.ContentLength > 0)
                {
                    string fileExtension = Path.GetExtension(model.Image.FileName);

                    string fileName1 = titleNonAccent.FileNameFormat(fileExtension);

                    _imagePlugin.CropAndResizeImage(model.Image, $"{Contains.FlowStepFolder}", fileName1, ImageSize.FlowStep_WithMediumSize, ImageSize.FlowStep_HeightMediumSize);

                    model.ImageUrl = string.Concat(Contains.FlowStepFolder, fileName1);
                }

                Manufacturer manufacturer = Mapper.Map(model, byId);

                _manufacturerService.Update(manufacturer);

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
            catch (Exception ex)
            {
                ExtentionUtils.Log(string.Concat("Manufacturer.Edit: ", ex.Message));
                return View(model);
            }

            return action;
        }

        [RequiredPermisson(Roles = "ViewManufacturer")]
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

            IEnumerable<Manufacturer> manufacturers = _manufacturerService.PagedList(sortingPagingBuilder, paging);
            if (manufacturers != null && manufacturers.Any())
            {
                Helper.PageInfo pageInfo = new Helper.PageInfo(ExtentionUtils.PageSize, page, paging.TotalRecord, i => Url.Action("Index", new { page = i, keywords }));
                ViewBag.PageInfo = pageInfo;
            }

            return View(manufacturers);
        }
    }
}