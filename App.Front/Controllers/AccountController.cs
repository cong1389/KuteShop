using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using App.Aplication;
using App.Aplication.Extensions;
using App.Aplication.MVCHelper;
using App.Core.Utils;
using App.Domain.Entities.Data;
using App.Domain.Entities.Identity;
using App.Domain.Entities.Menu;
using App.FakeEntity.Gallery;
using App.FakeEntity.Orders;
using App.FakeEntity.Post;
using App.FakeEntity.User;
using App.Framework.Ultis;
using App.Front.Models;
using App.Service.Common;
using App.Service.Gallery;
using App.Service.Locations;
using App.Service.Menu;
using App.Service.Orders;
using App.Service.Post;
using AutoMapper;
using Domain.Entities.Customers;
using Microsoft.AspNet.Identity;
using Resources;

namespace App.Front.Controllers
{
    [FrontAuthorize]
    public class AccountController : BaseAccessUserController
    {
        private readonly IPostService _postService;

        private readonly IDistrictService _districtService;

        private readonly IMenuLinkService _menuLinkService;

        private readonly IProvinceService _provinceService;

        private readonly IGalleryService _galleryService;

        private readonly IImagePlugin _imagePlugin;

        private readonly IOrderService _orderService;
        private readonly IWorkContext _workContext;

        public AccountController(UserManager<IdentityUser, Guid> userManager
            , IPostService postService, IGalleryService galleryService, IProvinceService provinceService, IMenuLinkService menuLinkService
            , IDistrictService districtService, IImagePlugin imagePlugin
            , IOrderService orderService
            , IWorkContext workContext) : base(userManager)
        {
            _postService = postService;
            _galleryService = galleryService;
            _provinceService = provinceService;
            _menuLinkService = menuLinkService;
            _districtService = districtService;
            _imagePlugin = imagePlugin;
            _orderService = orderService;
            _workContext = workContext;
        }

        [HttpGet]
        public ActionResult ChangeInfo()
        {
            RegisterFormViewModel registerFormViewModel = Mapper.Map<RegisterFormViewModel>(_userManager.FindByName(HttpContext.User.Identity.Name));
            return View(registerFormViewModel);
        }

        [HttpPost]
        public ActionResult ChangeInfo(RegisterFormViewModel model)
        {
            return View(model);
        }

        [HttpGet]
        public ActionResult CreatePost()
        {
            _userManager.FindByName(HttpContext.User.Identity.Name);
            return View(new PostViewModel());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(true)]
        public ActionResult CreatePost(PostViewModel post)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    ModelState.AddModelError("", MessageUI.ErrorMessage);
                }
                else
                {
                    string str = post.Title.NonAccent();
                    IEnumerable<Post> bySeoUrl = _postService.GetListSeoUrl(str);
                    post.SeoUrl = post.Title.NonAccent();
                    if (bySeoUrl.Any(x => x.Id != post.Id))
                    {
                        PostViewModel postViewModel = post;
                        postViewModel.SeoUrl = string.Concat(postViewModel.SeoUrl, "-", bySeoUrl.Count());
                    }
                    if (post.Image != null && post.Image.ContentLength > 0)
                    {
                        string str1 = string.Format("{0}-{1}", str, Utils.GetTime());
                        string str2 = string.Format("{0}-{1}", str, Utils.GetTime());
                        string str3 = string.Format("{0}-{1}", str, Utils.GetTime());
                        _imagePlugin.CropAndResizeImage(post.Image, string.Format("{0}/{1}/", Contains.PostFolder, str), str1, ImageSize.WithBigSize, ImageSize.HeightBigSize, false);
                        _imagePlugin.CropAndResizeImage(post.Image, string.Format("{0}/{1}/", Contains.PostFolder, str), str2, ImageSize.WithMediumSize, ImageSize.HeightMediumSize, false);
                        _imagePlugin.CropAndResizeImage(post.Image, string.Format("{0}/{1}/", Contains.PostFolder, str), str3, ImageSize.WithSmallSize, ImageSize.HeightSmallSize, false);
                        post.ImageBigSize = string.Format("{0}/{1}/{2}", Contains.PostFolder, str, str1);
                        post.ImageMediumSize = string.Format("{0}/{1}/{2}", Contains.PostFolder, str, str2);
                        post.ImageSmallSize = string.Format("{0}/{1}/{2}", Contains.PostFolder, str, str3);
                    }
                    int? menuId = post.MenuId;
                    int i = 0;
                    if ((menuId.GetValueOrDefault() > i ? menuId.HasValue : false))
                    {
                        IMenuLinkService menuLinkService = _menuLinkService;
                        menuId = post.MenuId;
                        MenuLink byId = menuLinkService.GetById(menuId.Value);
                        post.VirtualCatUrl = byId.VirtualSeoUrl;
                        post.VirtualCategoryId = byId.VirtualId;
                    }
                    HttpFileCollectionBase files = Request.Files;
                    List<GalleryImage> galleryImages = null;
                    if (files.Count > 0)
                    {
                        galleryImages = new List<GalleryImage>();
                        int count = files.Count - 1;
                        int num = 0;
                        string[] allKeys = files.AllKeys;
                        for (i = 0; i < allKeys.Length; i++)
                        {
                            string str4 = allKeys[i];
                            if (num <= count)
                            {
                                if (!str4.Equals("Image"))
                                {
                                    HttpPostedFileBase item = files[num];
                                    if (item.ContentLength > 0)
                                    {
                                        GalleryImageViewModel galleryImageViewModel = new GalleryImageViewModel
                                        {
                                            PostId = post.Id
                                        };
                                        string str5 = string.Format("{0}-{1}", str, Utils.GetTime());
                                        string str6 = string.Format("{0}-{1}", str, Utils.GetTime());
                                        _imagePlugin.CropAndResizeImage(item, string.Format("{0}/{1}/", Contains.PostFolder, str), str5, ImageSize.WithOrignalSize, ImageSize.HeighthOrignalSize, false);
                                        _imagePlugin.CropAndResizeImage(item, string.Format("{0}/{1}/", Contains.PostFolder, str), str6, ImageSize.WithThumbnailSize, ImageSize.HeightThumbnailSize, false);
                                        galleryImageViewModel.ImageThumbnail = string.Format("{0}/{1}/{2}", Contains.PostFolder, str, str6);
                                        galleryImageViewModel.ImagePath = string.Format("{0}/{1}/{2}", Contains.PostFolder, str, str5);
                                        galleryImageViewModel.OrderDisplay = num;
                                        galleryImageViewModel.Status = 1;
                                        galleryImageViewModel.Title = post.Title;
                                        galleryImages.Add(Mapper.Map<GalleryImage>(galleryImageViewModel));
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
                    Post post1 = Mapper.Map<PostViewModel, Post>(post);
                    post1.GalleryImages = galleryImages;
                    _postService.Create(post1);
                    return RedirectToAction("PostManagement");
                }
            }
            catch (Exception exception1)
            {
                Exception exception = exception1;
                ExtentionUtils.Log(string.Concat("Post.Create: ", exception.Message));
                ModelState.AddModelError("", exception.Message);
            }
            return View(post);
        }

        public ActionResult DeleteGallery(int postId, int galleryId)
        {
            ActionResult actionResult;
            if (Request.IsAjaxRequest())
            {
                try
                {
                    if (_postService.Get(x => x.Id == postId && x.CreatedBy.Equals(HttpContext.User.Identity.Name), false) == null)
                    {
                        return Json(new { success = false });
                    }

                    GalleryImage galleryImage = _galleryService.Get(x => x.PostId == postId && x.Id == galleryId, false);
                    _galleryService.Delete(galleryImage);
                    string str = Server.MapPath(string.Concat("~/", galleryImage.ImagePath));
                    string str1 = Server.MapPath(string.Concat("~/", galleryImage.ImageThumbnail));
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
            return Json(new { success = false });
        }

        [HttpGet]
        public ActionResult EditPost(int Id)
        {
            PostViewModel postViewModel = Mapper.Map<Post, PostViewModel>(_postService.Get(x => x.Id == Id && x.CreatedBy.Equals(HttpContext.User.Identity.Name), false));
            return View(postViewModel);
        }

        public ActionResult EditPost(PostViewModel postView)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    ModelState.AddModelError("", MessageUI.ErrorMessage);
                }
                else
                {
                    Post byId = _postService.GetById(postView.Id);
                    string str = postView.Title.NonAccent();
                    IEnumerable<MenuLink> bySeoUrl = _menuLinkService.GetListSeoUrl(str);
                    postView.SeoUrl = postView.Title.NonAccent();
                    if (bySeoUrl.Any(x => x.Id != postView.Id))
                    {
                        PostViewModel postViewModel = postView;
                        postViewModel.SeoUrl = string.Concat(postViewModel.SeoUrl, "-", bySeoUrl.Count());
                    }
                    HttpFileCollectionBase files = Request.Files;
                    if (postView.Image != null && postView.Image.ContentLength > 0)
                    {
                        string str1 = string.Format("{0}-{1}", str, Utils.GetTime());
                        string str2 = string.Format("{0}-{1}", str, Utils.GetTime());
                        string str3 = string.Format("{0}-{1}", str, Utils.GetTime());
                        _imagePlugin.CropAndResizeImage(postView.Image, string.Format("{0}/{1}/", Contains.PostFolder, str), str1, ImageSize.WithBigSize, ImageSize.HeightBigSize, false);
                        _imagePlugin.CropAndResizeImage(postView.Image, string.Format("{0}/{1}/", Contains.PostFolder, str), str2, ImageSize.WithMediumSize, ImageSize.HeightMediumSize, false);
                        _imagePlugin.CropAndResizeImage(postView.Image, string.Format("{0}/{1}/", Contains.PostFolder, str), str3, ImageSize.WithSmallSize, ImageSize.HeightSmallSize, false);
                        postView.ImageBigSize = string.Format("{0}/{1}/{2}", Contains.PostFolder, str, str1);
                        postView.ImageMediumSize = string.Format("{0}/{1}/{2}", Contains.PostFolder, str, str2);
                        postView.ImageSmallSize = string.Format("{0}/{1}/{2}", Contains.PostFolder, str, str3);
                    }
                    int? menuId = postView.MenuId;
                    int i = 0;
                    if ((menuId.GetValueOrDefault() > i ? menuId.HasValue : false))
                    {
                        IMenuLinkService menuLinkService = _menuLinkService;
                        menuId = postView.MenuId;
                        MenuLink menuLink = menuLinkService.GetById(menuId.Value);
                        postView.VirtualCatUrl = menuLink.VirtualSeoUrl;
                        postView.VirtualCategoryId = menuLink.VirtualId;
                    }
                    List<GalleryImage> galleryImages = new List<GalleryImage>();
                    if (files.Count > 0)
                    {
                        int count = files.Count - 1;
                        int num = 0;
                        string[] allKeys = files.AllKeys;
                        for (i = 0; i < allKeys.Length; i++)
                        {
                            string str4 = allKeys[i];
                            if (num <= count)
                            {
                                if (!str4.Equals("Image"))
                                {
                                    HttpPostedFileBase item = files[num];
                                    if (item.ContentLength > 0)
                                    {
                                        GalleryImageViewModel galleryImageViewModel = new GalleryImageViewModel
                                        {
                                            PostId = postView.Id
                                        };
                                        string str5 = string.Format("{0}-{1}", str, Utils.GetTime());
                                        string str6 = string.Format("{0}-{1}", str, Utils.GetTime());
                                        _imagePlugin.CropAndResizeImage(item, string.Format("{0}/{1}/", Contains.PostFolder, str), str5, ImageSize.WithOrignalSize, ImageSize.HeighthOrignalSize, false);
                                        _imagePlugin.CropAndResizeImage(item, string.Format("{0}/{1}/", Contains.PostFolder, str), str6, ImageSize.WithThumbnailSize, ImageSize.HeightThumbnailSize, false);
                                        galleryImageViewModel.ImageThumbnail = string.Format("{0}/{1}/{2}", Contains.PostFolder, str, str6);
                                        galleryImageViewModel.ImagePath = string.Format("{0}/{1}/{2}", Contains.PostFolder, str, str5);
                                        galleryImageViewModel.OrderDisplay = num;
                                        galleryImageViewModel.Status = 1;
                                        galleryImageViewModel.Title = postView.Title;
                                        galleryImages.Add(Mapper.Map<GalleryImage>(galleryImageViewModel));
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
                    if (galleryImages.IsAny())
                    {
                        byId.GalleryImages = galleryImages;
                    }
                    byId = Mapper.Map(postView, byId);
                    _postService.Update(byId);
                    ViewBag.Message = "Cập nhật tin rao thành công";
                    return View(postView);
                }
            }
            catch (Exception exception1)
            {
                Exception exception = exception1;
                ModelState.AddModelError("", exception.Message);
                ExtentionUtils.Log(string.Concat("Post.Edit: ", exception.Message));
            }
            ViewBag.Message = "Cập nhật tin rao KHÔNG thành công";
            return View(postView);
        }

        public JsonResult GetDistrictByProvinceId(int provinceId)
        {
            var byProvinceId =
                from x in _districtService.GetByProvinceId(provinceId)
                select new {x.Id, x.Name };
            return Json(byProvinceId);
        }

        [AllowAnonymous]
        public ActionResult LogOff()
        {
            AuthenticationManager.SignOut();
            return RedirectToAction("Index", "Home");
        }

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.RouteData.Values["action"].Equals("CreatePost"))
            {
                IEnumerable<MenuLink> menuLinks = _menuLinkService.FindBy(x => x.Status == 1 && x.TemplateType != 5 && x.TemplateType != 1, true);
                ViewBag.MenuList = menuLinks;
            }
            if (filterContext.RouteData.Values["action"].Equals("EditPost"))
            {
                IEnumerable<MenuLink> menuLinks1 = _menuLinkService.FindBy(x => x.Status == 1 && x.TemplateType != 5 && x.TemplateType != 1, true);
                ViewBag.MenuList = menuLinks1;
            }
        }

        [HttpGet]
        public ActionResult PostManagement(int page = 1)
        {
            SortBuilder sortBuilder = new SortBuilder
            {
                ColumnName = "CreatedDate",
                ColumnOrder = SortBuilder.SortOrder.Descending
            };
            Paging paging = new Paging
            {
                PageNumber = page,
                PageSize = 10,
                TotalRecord = 0
            };
            Expression<Func<Post, bool>> expression = PredicateBuilder.True<Post>();
            expression = expression.And(x => x.CreatedBy.Equals(HttpContext.User.Identity.Name));
            IEnumerable<Post> posts = _postService.FindAndSort(expression, sortBuilder, paging);
            if (posts.IsAny())
            {
                Helper.PageInfo pageInfo = new Helper.PageInfo(ExtentionUtils.PageSize, page, paging.TotalRecord, i => Url.Action("PostManagement", "Account", new { page = i }));
                ViewBag.PageInfo = pageInfo;
                ViewBag.CountItem = pageInfo.TotalItems;
            }
            return View(posts);
        }

        [HttpPost]
        public ActionResult SearchPost(string keywords, int? status = null, DateTime? from = null, DateTime? to = null)
        {
            ViewBag.Keywords = keywords;
            SortBuilder sortBuilder = new SortBuilder
            {
                ColumnName = "CreatedDate",
                ColumnOrder = SortBuilder.SortOrder.Descending
            };
            Paging paging = new Paging
            {
                PageNumber = 1,
                PageSize = 10,
                TotalRecord = 0
            };
            Expression<Func<Post, bool>> expression = PredicateBuilder.True<Post>();
            expression = expression.And(x => x.CreatedBy.Equals(HttpContext.User.Identity.Name));
            if (status.HasValue)
            {
                expression = expression.And(x => (int?)x.Status == status);
            }
            if (from.HasValue)
            {
                expression = expression.And(x => x.StartDate >= from);
            }
            if (to.HasValue)
            {
                expression = expression.And(x => x.EndDate <= to);
            }
            if (!string.IsNullOrEmpty(keywords))
            {
                expression = expression.And(x => x.Title.Contains(keywords));
            }
            IEnumerable<Post> posts = _postService.FindAndSort(expression, sortBuilder, paging);
            if (posts.IsAny())
            {
                Helper.PageInfo pageInfo = new Helper.PageInfo(ExtentionUtils.PageSize, 1, paging.TotalRecord, i => Url.Action("PostManagement", "Account", new { page = i }));
                ViewBag.PageInfo = pageInfo;
                ViewBag.CountItem = pageInfo.TotalItems;
            }
            return View("PostManagement", posts);
        }

        #region Information account of customer

        public JsonResult AccountOrder()
        {
            IEnumerable<OrderViewModel> model = PrepareCustomerOrderListModel(_workContext.CurrentCustomer);

            JsonResult jsonResult = Json(
                new
                {
                    success = true,
                    list = this.RenderRazorViewToString("_Account.Order", model)
                }, JsonRequestBehavior.AllowGet);

            return jsonResult;
        }

        [NonAction]
        protected IEnumerable<OrderViewModel> PrepareCustomerOrderListModel(Customer customer)
        {
            if (customer == null)
                throw new ArgumentNullException("customer");

            var ieOrder = _orderService.GetByCustomerId(customer.Id, false);

            if (!ieOrder.IsAny())
            {
                return null;
            }

            ieOrder = ieOrder.OrderByDescending(m => m.Id);

            OrderViewModel orderViewModel = new OrderViewModel();

            IEnumerable<OrderViewModel> model = ieOrder.Select(x => x.ToModel(orderViewModel));

            //OrderViewModel orderViewModel = new OrderViewModel();
            //IEnumerable<OrderViewModel> model = ieOrder
            //    .Select(m =>
            //    {
            //        foreach (var orderItem in m.OrderItems)
            //        {
            //            var orderItemModel = new OrderViewModel.OrderItemModel
            //            {
            //                Id = orderItem.Id,
            //                PostId = orderItem.PostId,
            //                PostName = orderItem.Post.Title,
            //                Quantity = orderItem.Quantity,
            //                UnitPriceInclTax = orderItem.UnitPriceInclTax,
            //                SubTotalInclTax = orderItem.PriceInclTax
            //            };

            //            orderViewModel.Items.Add(orderItemModel);
            //        }

            //        return m.ToModel(orderViewModel);
            //    });

            return model;

        }

        #endregion
    }
}