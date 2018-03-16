using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using App.Aplication;
using App.Aplication.Extensions;
using App.Core.Utils;
using App.Domain.Entities.Data;
using App.FakeEntity.Repairs;
using App.Front.Models;
using App.Service.Brandes;
using App.Service.Locations;
using App.Service.MailSetting;
using App.Service.Repairs;
using App.Service.SystemApp;
using AutoMapper;

namespace App.Front.Controllers
{
    public class HomeController : FrontBaseController
    {
        private readonly ISystemSettingService _systemSettingService;

        private readonly IBrandService _brandService;

        private readonly IRepairService _orderService;

        private readonly IImagePlugin _imagePlugin;

        public HomeController(ISystemSettingService systemSettingService, IProvinceService province,
            IMailSettingService mailSettingService, IBrandService brandService, IImagePlugin imagePlugin,
            IRepairService orderService)
        {
            _systemSettingService = systemSettingService;
            _brandService = brandService;
            _imagePlugin = imagePlugin;
            _orderService = orderService;
        }

        public ActionResult BuyProduct(RepairViewModel repair)
        {
            var id = 1;
            var order1 = _orderService.GetTop(1, x => x.Id > 0, x => x.Id).FirstOrDefault();
            if (order1 != null)
            {
                id = order1.Id;
            }
            repair.RepairCode = string.Concat("DH", id.ToString());
            repair.CustomerCode = string.Concat("KH", id.ToString());
            repair.Category = "Định giá và thu mua sản phẩm";
            if (!Request.IsAjaxRequest())
            {
                return Json(new
                {
                    success = false,
                    errors = string.Join(", ", ModelState.Values.SelectMany(v =>
from x in v.Errors
select x.ErrorMessage).ToArray())
                });
            }
            var files = Request.Files;
            var orderGalleries = new List<RepairGallery>();
            if (files.Count > 0)
            {
                var count = files.Count - 1;
                var num = 0;
                var allKeys = files.AllKeys;
                for (var i = 0; i < allKeys.Length; i++)
                {
                    var str = allKeys[i];
                    if (num <= count)
                    {
                        if (!str.Equals("Image"))
                        {
                            var item = files[num];
                            if (item.ContentLength > 0)
                            {
                                var orderGalleryViewModel = new RepairGalleryViewModel
                                {
                                    RepairId = repair.Id
                                };
                                var str1 = $"{repair.RepairCode}-{Guid.NewGuid()}.jpg";
                                _imagePlugin.CropAndResizeImage(item, $"{Contains.RepairFolder}{repair.RepairCode}/", str1, ImageSize.WithBigSize, ImageSize.WithBigSize);
                                orderGalleryViewModel.ImagePath = $"{Contains.RepairFolder}{repair.RepairCode}/{str1}";
                                orderGalleries.Add(Mapper.Map<RepairGallery>(orderGalleryViewModel));
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
            var order2 = Mapper.Map<RepairViewModel, Repair>(repair);
            if (orderGalleries.IsAny())
            {
                order2.RepairGalleries = orderGalleries;
            }
            _orderService.Create(order2);
            return Json(new { success = true });
        }

        public ActionResult CheckRepair(string phone, string ordercode)
        {
            if (!Request.IsAjaxRequest())
            {
                return Json(new { data = this.RenderRazorViewToString("_RepairResult", null), success = true }, JsonRequestBehavior.AllowGet);
            }
            var expression = PredicateBuilder.True<Repair>();
            if (!string.IsNullOrEmpty(phone))
            {
                expression = expression.And(x => x.PhoneNumber == phone).Or(x => x.CustomerName.ToLower().Equals(phone));
            }
            if (!string.IsNullOrEmpty(ordercode))
            {
                expression = expression.And(x => x.RepairCode.ToLower() == ordercode);
            }
            var repair = _orderService.Get(expression, true);
            return Json(new { data = this.RenderRazorViewToString("_RepairResult", repair), success = true }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult CheckProduct(RepairViewModel repair)
        {
            var id = 1;
            var order1 = _orderService.GetTop(1, x => x.Id > 0, x => x.Id).FirstOrDefault();
            if (order1 != null)
            {
                id = order1.Id;
            }
            repair.RepairCode = string.Concat("DH", id.ToString());
            repair.CustomerCode = string.Concat("KH", id.ToString());
            repair.Category = "kiểm tra tình trạng máy";
            if (!Request.IsAjaxRequest())
            {
                return Json(new
                {
                    success = false,
                    errors = string.Join(", ", ModelState.Values.SelectMany(v =>
from x in v.Errors
select x.ErrorMessage).ToArray())
                });
            }
            var files = Request.Files;
            var orderGalleries = new List<RepairGallery>();
            if (files.Count > 0)
            {
                var count = files.Count - 1;
                var num = 0;
                var allKeys = files.AllKeys;
                for (var i = 0; i < allKeys.Length; i++)
                {
                    var str = allKeys[i];
                    if (num <= count)
                    {
                        if (!str.Equals("Image"))
                        {
                            var item = files[num];
                            if (item.ContentLength > 0)
                            {
                                var orderGalleryViewModel = new RepairGalleryViewModel
                                {
                                    RepairId = repair.Id
                                };
                                var str1 = $"{repair.RepairCode}-{Guid.NewGuid()}.jpg";
                                _imagePlugin.CropAndResizeImage(item, $"{Contains.RepairFolder}{repair.RepairCode}/", str1, ImageSize.WithBigSize, ImageSize.WithBigSize);
                                orderGalleryViewModel.ImagePath = $"{Contains.RepairFolder}{repair.RepairCode}/{str1}";
                                orderGalleries.Add(Mapper.Map<RepairGallery>(orderGalleryViewModel));
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
            var order2 = Mapper.Map<RepairViewModel, Repair>(repair);
            if (orderGalleries.IsAny())
            {
                order2.RepairGalleries = orderGalleries;
            }
            _orderService.Create(order2);
            return Json(new { success = true });
        }

        public ActionResult Error()
        {
            return View();
        }

        public ActionResult FlowForm()
        {
            var viewBag = ViewBag;
            var brandService = _brandService;
            viewBag.Brands = brandService.FindBy(x => x.Status == 1);
            return PartialView();
        }
        
        [OutputCache(CacheProfile = "Medium")]
        public ActionResult Index()
        {
            var systemSetting = _systemSettingService.Get(x => x.Status == 1, true);
            if (systemSetting != null)
            {
                ViewBag.Title = systemSetting.MetaTitle ?? systemSetting.Title;
                ViewBag.KeyWords = systemSetting.MetaKeywords;
                ViewBag.SiteUrl = Url.Action("Index", "Home", new { area = "" });
                ViewBag.Description = systemSetting.Description;
                ViewBag.Image = Url.Content(string.Concat("~/", systemSetting.LogoImage));
                ViewBag.Favicon = Url.Content(string.Concat("~/", systemSetting.FaviconImage));
            }

            //IProvinceService provinceService = this._province;
            //viewBag.Provinces = provinceService.FindBy((Province x) => x.Status == 1, false);
            return View();
        }
        
    }
}