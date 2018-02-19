﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using App.Admin.Helpers;
using App.Aplication;
using App.Core.Caching;
using App.Core.Utils;
using App.Domain.Entities.Data;
using App.FakeEntity.Repairs;
using App.Framework.Ultis;
using App.Service.Attribute;
using App.Service.Brandes;
using App.Service.Menu;
using App.Service.Repair;
using App.Service.Repairs;
using AutoMapper;
using Resources;

namespace App.Admin.Controllers
{
    public class RepairController : BaseAdminUploadController
    {
        private readonly IBrandService _brandService;

        private readonly IRepairGalleryService _galleryService;

        private readonly IImagePlugin _imagePlugin;

        private readonly IMenuLinkService _menuLinkService;

        private readonly IRepairService _repairService;

        private readonly IRepairItemService _repairItemService;


        public RepairController(IRepairService repairService, IMenuLinkService menuLinkService, IAttributeValueService attributeValueService, IRepairGalleryService galleryService
            , IImagePlugin imagePlugin, IBrandService brandService, IRepairItemService repairItemService
            , ICacheManager cacheManager)
            : base(cacheManager)
        {
            _repairService = repairService;
            _menuLinkService = menuLinkService;
            _galleryService = galleryService;
            _imagePlugin = imagePlugin;
            _brandService = brandService;
            _repairItemService = repairItemService;
        }

        [RequiredPermisson(Roles = "CreateEditRepair")]
        public ActionResult Create()
        {
            int id = 1;
            Repair repair = _repairService.GetTop(1, x => x.RepairCode != null, x => x.Id).FirstOrDefault();
            if (repair != null)
            {
                id = repair.Id;
            }
            return View(new RepairViewModel
            {
                RepairCode = string.Concat("DH", id.ToString()),
                CustomerCode = string.Concat("KH", id.ToString())
            });
        }

        [HttpPost]
        [RequiredPermisson(Roles = "CreateEditRepair")]
        [ValidateInput(false)]
        public ActionResult Create([Bind] RepairViewModel repair, string returnUrl)
        {
            ActionResult action;
            try
            {
                if (!ModelState.IsValid)
                {
                    ModelState.AddModelError("", MessageUI.ErrorMessage);
                    return View(repair);
                }

                HttpFileCollectionBase files = Request.Files;
                List<RepairGallery> repairGalleries = new List<RepairGallery>();
                if (files.Count > 0)
                {
                    int count = files.Count - 1;
                    int num = 0;
                    string[] allKeys = files.AllKeys;
                    for (int i = 0; i < allKeys.Length; i++)
                    {
                        string str = allKeys[i];
                        if (num <= count)
                        {
                            if (!str.Equals("Image"))
                            {
                                HttpPostedFileBase httpPostedFileBase = files[num];
                                if (httpPostedFileBase.ContentLength > 0)
                                {
                                    RepairGalleryViewModel repairGalleryViewModel = new RepairGalleryViewModel
                                    {
                                        RepairId = repair.Id
                                    };
                                    string str1 = $"{repair.RepairCode}-{Guid.NewGuid()}.jpg";
                                    _imagePlugin.CropAndResizeImage(httpPostedFileBase,
                                        $"{Contains.ImageFolder}{repair.RepairCode}/", str1, ImageSize.WithBigSize, ImageSize.WithBigSize);
                                    repairGalleryViewModel.ImagePath =
                                        $"{Contains.ImageFolder}{repair.RepairCode}/{str1}";
                                    repairGalleries.Add(Mapper.Map<RepairGallery>(repairGalleryViewModel));
                                }
                                num++;
                            }
                            else
                            {
                                num++;
                            }
                        }
                    }
                }
                Repair repair1 = Mapper.Map<RepairViewModel, Repair>(repair);
                if (repairGalleries.IsAny())
                {
                    repair1.RepairGalleries = repairGalleries;
                }
                List<RepairItem> repairItems = new List<RepairItem>();
                if (repair.RepairItems.IsAny())
                {
                    repairItems.AddRange(
                        from item in repair.RepairItems
                        select Mapper.Map<RepairItem>(item));
                }
                if (repairItems.IsAny())
                {
                    repair1.RepairItems = repairItems;
                }
                _repairService.Create(repair1);
                Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.CreateSuccess, FormUI.Repair)));
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
                ExtentionUtils.Log(string.Concat("Repair.Create: ", exception.Message));
                ModelState.AddModelError("", exception.Message);
                return View(repair);
            }
            return action;
        }

        [RequiredPermisson(Roles = "DeleteRepair")]
        public ActionResult Delete(string[] ids)
        {
            try
            {
                if (ids.Length != 0)
                {
                    List<Repair> repairs = new List<Repair>();
                    List<RepairGallery> repairGalleries = new List<RepairGallery>();
                    string[] strArrays = ids;
                    for (int i = 0; i < strArrays.Length; i++)
                    {
                        int num = int.Parse(strArrays[i]);
                        Repair repair = _repairService.Get(x => x.Id == num);
                        repairGalleries.AddRange(repair.RepairGalleries.ToList());
                        repairs.Add(repair);
                    }
                    _galleryService.BatchDelete(repairGalleries);
                    _repairService.BatchDelete(repairs);
                }
            }
            catch (Exception exception1)
            {
                Exception exception = exception1;
                ExtentionUtils.Log(string.Concat("Repair.Delete: ", exception.Message));
            }
            return RedirectToAction("Index");
        }

        [RequiredPermisson(Roles = "CreateEditRepair")]
        public ActionResult DeleteGallery(int repairId, int galleryId)
        {
            ActionResult actionResult;
            if (!Request.IsAjaxRequest())
            {
                return Json(new { success = false });
            }
            try
            {
                RepairGallery repairGallery = _galleryService.Get(x => x.RepairId == repairId && x.Id == galleryId);
                _galleryService.Delete(repairGallery);
                string str = Server.MapPath(string.Concat("~/", repairGallery.ImagePath));
                string str1 = Server.MapPath(string.Concat("~/", repairGallery.ImagePath));
                System.IO.File.Delete(str);
                System.IO.File.Delete(str1);
                actionResult = Json(new { success = true });
            }
            catch (Exception exception1)
            {
                Exception exception = exception1;
                actionResult = Json(new { success = false, messages = exception.Message });
            }
            return actionResult;
        }

        [RequiredPermisson(Roles = "CreateEditRepair")]
        public ActionResult Edit(int id)
        {
            RepairViewModel repairViewModel = Mapper.Map<Repair, RepairViewModel>(_repairService.Get(x => x.Id == id));
            return View(repairViewModel);
        }

        [HttpPost]
        [RequiredPermisson(Roles = "CreateEditRepair")]
        [ValidateInput(false)]
        public ActionResult Edit([Bind] RepairViewModel repairView, string returnUrl)
        {
            ActionResult action;
            try
            {
                if (!ModelState.IsValid)
                {
                    ModelState.AddModelError("", MessageUI.ErrorMessage);
                    return View(repairView);
                }

                Repair repair = _repairService.Get(x => x.Id == repairView.Id);
                HttpFileCollectionBase files = Request.Files;
                List<RepairGallery> lstRepairGalleries = new List<RepairGallery>();
                if (files.Count > 0)
                {
                    int count = files.Count - 1;
                    int num = 0;
                    string[] allKeys = files.AllKeys;
                    for (int i = 0; i < allKeys.Length; i++)
                    {
                        string str = allKeys[i];
                        if (num <= count)
                        {
                            if (!str.Equals("Image"))
                            {
                                HttpPostedFileBase item = files[num];
                                if (item.ContentLength > 0)
                                {
                                    RepairGalleryViewModel repairGalleryViewModel = new RepairGalleryViewModel
                                    {
                                        RepairId = repairView.Id
                                    };
                                    string str1 = $"{repairView.RepairCode}-{Guid.NewGuid()}.jpg";
                                    _imagePlugin.CropAndResizeImage(item,
                                        $"{Contains.ImageFolder}{repairView.RepairCode}/", str1, ImageSize.WithBigSize, ImageSize.WithBigSize);
                                    repairGalleryViewModel.ImagePath =
                                        $"{Contains.ImageFolder}{repairView.RepairCode}/{str1}";
                                    lstRepairGalleries.Add(Mapper.Map<RepairGallery>(repairGalleryViewModel));
                                }
                                num++;
                            }
                            else
                            {
                                num++;
                            }
                        }
                    }
                }
                if (lstRepairGalleries.IsAny())
                {
                    repair.RepairGalleries = lstRepairGalleries;
                }
                List<RepairItem> repairItems = new List<RepairItem>();
                if (repairView.RepairItems.IsAny())
                {
                    foreach (RepairItemViewModel repairItem in repairView.RepairItems)
                    {
                        RepairItemViewModel repairItemViewModel = new RepairItemViewModel();
                        if (repairItem.Id > 0)
                        {
                            repairItemViewModel.Id = repairItem.Id;
                        }
                        repairItemViewModel.RepairId = repairView.Id;
                        repairItemViewModel.FixedFee = repairItem.FixedFee;
                        repairItemViewModel.Category = repairItem.Category;
                        repairItemViewModel.WarrantyFrom = repairItem.WarrantyFrom;
                        repairItemViewModel.WarrantyTo = repairItem.WarrantyTo;
                        repairItems.Add(Mapper.Map<RepairItem>(repairItemViewModel));
                    }
                }
                if (repairItems.IsAny())
                {
                    repair.RepairItems = repairItems;
                }
                IEnumerable<RepairItem> repairItems1 = _repairItemService.FindBy(x => x.RepairId == repairView.Id);
                _repairItemService.BatchDelete(repairItems1);
                repair = Mapper.Map(repairView, repair);
                _repairService.Update(repair);
                Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.UpdateSuccess, FormUI.Repair)));
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
                ExtentionUtils.Log(string.Concat("Repair.Edit: ", exception.Message));
                return View(repairView);
            }
            return action;
        }

        [RequiredPermisson(Roles = "ViewRepair")]
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
            IEnumerable<Repair> repairs = _repairService.PagedList(sortingPagingBuilder, paging);
            if (repairs != null && repairs.Any())
            {
                Helper.PageInfo pageInfo = new Helper.PageInfo(ExtentionUtils.PageSize, page, paging.TotalRecord, i => Url.Action("Index", new { page = i, keywords }));
                ViewBag.PageInfo = pageInfo;
            }
            return View(repairs);
        }

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.RouteData.Values["action"].Equals("edit") || filterContext.RouteData.Values["action"].Equals("create"))
            {
                dynamic viewBag = ViewBag;
                IBrandService brandService = _brandService;
                viewBag.Brands = brandService.FindBy(x => x.Status == 1);
            }
        }

        public ActionResult WarrantyForm()
        {
            RepairViewModel repairViewModel = new RepairViewModel();
            repairViewModel.RepairItems.Add(new RepairItemViewModel());
            return View(repairViewModel);
        }
    }
}