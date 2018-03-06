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

        [RequiredPermisson(Roles = "CreateEditManufacture")]
        public ActionResult Create()
        {
            var model = new ManufacturerViewModel();

            return View(model);
        }

        [HttpPost]
        [RequiredPermisson(Roles = "CreateEditManufacture")]
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

                var titleNonAccent = model.Title.NonAccent();
                if (model.Image != null && model.Image.ContentLength > 0)
                {
                    var fileExtension = Path.GetExtension(model.Image.FileName);
                    var fileName = titleNonAccent.FileNameFormat(fileExtension);

                    _imagePlugin.CropAndResizeImage(model.Image, $"{Contains.ManufactureFolder}", fileName, ImageSize.Manufacture_WithMediumSize, ImageSize.Manufacture_HeightMediumSize);

                    model.ImageUrl = string.Concat(Contains.ManufactureFolder, fileName);
                }

                var manufacturer = Mapper.Map<ManufacturerViewModel, Manufacturer>(model);

                _manufacturerService.Create(manufacturer);

                Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.CreateSuccess, FormUI.Manufacture)));
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

        [RequiredPermisson(Roles = "CreateEditManufacture")]
        public ActionResult Delete(int[] ids)
        {
            try
            {
                if (ids.Length != 0)
                {
                    var flowSteps =
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

        [RequiredPermisson(Roles = "CreateEditManufacture")]
        public ActionResult Edit(int id)
        {
            var manufacturerViewModel = Mapper.Map<Manufacturer, ManufacturerViewModel>(_manufacturerService.Get(x => x.Id == id));

            return View(manufacturerViewModel);
        }

        [HttpPost]
        [RequiredPermisson(Roles = "CreateEditManufacture")]
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

                var byId = _manufacturerService.Get(x => x.Id == model.Id);

                var titleNonAccent = model.Title.NonAccent();
                if (model.Image != null && model.Image.ContentLength > 0)
                {
                    var fileExtension = Path.GetExtension(model.Image.FileName);

                    var fileName1 = titleNonAccent.FileNameFormat(fileExtension);

                    _imagePlugin.CropAndResizeImage(model.Image, $"{Contains.ManufactureFolder}", fileName1, ImageSize.Manufacture_WithMediumSize, ImageSize.Manufacture_HeightMediumSize);

                    model.ImageUrl = string.Concat(Contains.ManufactureFolder, fileName1);
                }

                var manufacturer = Mapper.Map(model, byId);

                _manufacturerService.Update(manufacturer);

                Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.UpdateSuccess, FormUI.Manufacture)));
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
            var sortingPagingBuilder = new SortingPagingBuilder
            {
                Keywords = keywords,
                Sorts = new SortBuilder
                {
                    ColumnName = "CreatedDate",
                    ColumnOrder = SortBuilder.SortOrder.Descending
                }
            };
            var paging = new Paging
            {
                PageNumber = page,
                PageSize = PageSize,
                TotalRecord = 0
            };

            var manufacturers = _manufacturerService.PagedList(sortingPagingBuilder, paging);
            if (manufacturers != null && manufacturers.Any())
            {
                var pageInfo = new Helper.PageInfo(ExtentionUtils.PageSize, page, paging.TotalRecord, i => Url.Action("Index", new { page = i, keywords }));
                ViewBag.PageInfo = pageInfo;
            }

            return View(manufacturers);
        }
    }
}