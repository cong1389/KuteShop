using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using App.Aplication;
using App.Aplication.Extensions;
using App.Core.Utils;
using App.Domain.Entities.Data;
using App.Domain.Entities.GlobalSetting;
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
            int id = 1;
            Repair order1 = _orderService.GetTop(1, x => x.Id > 0, x => x.Id).FirstOrDefault();
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
            HttpFileCollectionBase files = Request.Files;
            List<RepairGallery> orderGalleries = new List<RepairGallery>();
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
                                RepairGalleryViewModel orderGalleryViewModel = new RepairGalleryViewModel
                                {
                                    RepairId = repair.Id
                                };
                                string str1 = string.Format("{0}-{1}.jpg", repair.RepairCode, Guid.NewGuid());
                                _imagePlugin.CropAndResizeImage(item, string.Format("{0}{1}/", Contains.ImageFolder, repair.RepairCode), str1, ImageSize.WithBigSize, ImageSize.WithBigSize, false);
                                orderGalleryViewModel.ImagePath = string.Format("{0}{1}/{2}", Contains.ImageFolder, repair.RepairCode, str1);
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
            Repair order2 = Mapper.Map<RepairViewModel, Repair>(repair);
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
            Expression<Func<Repair, bool>> expression = PredicateBuilder.True<Repair>();
            if (!string.IsNullOrEmpty(phone))
            {
                expression = expression.And(x => x.PhoneNumber == phone).Or(x => x.CustomerName.ToLower().Equals(phone));
            }
            if (!string.IsNullOrEmpty(ordercode))
            {
                expression = expression.And(x => x.RepairCode.ToLower() == ordercode);
            }
            Repair repair = _orderService.Get(expression, true);
            return Json(new { data = this.RenderRazorViewToString("_RepairResult", repair), success = true }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult CheckProduct(RepairViewModel repair)
        {
            int id = 1;
            Repair order1 = _orderService.GetTop(1, x => x.Id > 0, x => x.Id).FirstOrDefault();
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
            HttpFileCollectionBase files = Request.Files;
            List<RepairGallery> orderGalleries = new List<RepairGallery>();
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
                                RepairGalleryViewModel orderGalleryViewModel = new RepairGalleryViewModel
                                {
                                    RepairId = repair.Id
                                };
                                string str1 = string.Format("{0}-{1}.jpg", repair.RepairCode, Guid.NewGuid());
                                _imagePlugin.CropAndResizeImage(item, string.Format("{0}{1}/", Contains.ImageFolder, repair.RepairCode), str1, ImageSize.WithBigSize, ImageSize.WithBigSize, false);
                                orderGalleryViewModel.ImagePath = string.Format("{0}{1}/{2}", Contains.ImageFolder, repair.RepairCode, str1);
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
            Repair order2 = Mapper.Map<RepairViewModel, Repair>(repair);
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
            dynamic viewBag = ViewBag;
            IBrandService brandService = _brandService;
            viewBag.Brands = brandService.FindBy(x => x.Status == 1, false);
            return PartialView();
        }

        [OutputCache(CacheProfile = "Medium")]
        public ActionResult Index()
        {
            SystemSetting systemSetting = _systemSettingService.Get(x => x.Status == 1, true);
            if (systemSetting != null)
            {
                ViewBag.Title = systemSetting.MetaTitle ?? systemSetting.Title;
                ViewBag.KeyWords = systemSetting.MetaKeywords;
                ViewBag.SiteUrl = Url.Action("Index", "Home", new { area = "" });
                ViewBag.Description = systemSetting.Description;
                ViewBag.Image = Url.Content(string.Concat("~/", systemSetting.LogoImage));
                ViewBag.Favicon = Url.Content(string.Concat("~/", systemSetting.FaviconImage));
            }
            dynamic viewBag = ViewBag;

            //IProvinceService provinceService = this._province;
            //viewBag.Provinces = provinceService.FindBy((Province x) => x.Status == 1, false);
            return View();
        }

       
    }
}