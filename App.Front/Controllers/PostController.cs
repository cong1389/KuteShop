using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using App.Aplication;
using App.Aplication.Extensions;
using App.Aplication.MVCHelper;
using App.Core.Caching;
using App.Core.Utils;
using App.Domain.Entities.Data;
using App.Domain.Entities.GenericControl;
using App.Domain.Entities.Menu;
using App.FakeEntity.GenericControl;
using App.Framework.Ultis;
using App.Front.Models;
using App.Service.Common;
using App.Service.Gallery;
using App.Service.GenericControl;
using App.Service.Language;
using App.Service.Menu;
using App.Service.Post;
using Newtonsoft.Json;

namespace App.Front.Controllers
{
    public class PostController : FrontBaseController
    {
        private readonly ICacheManager _cacheManager;

        private readonly IPostService _postService;

        private readonly IMenuLinkService _menuLinkService;

        private readonly IGalleryService _galleryService;

        private readonly IWorkContext _workContext;

        private readonly IGenericControlService _genericControlService;
        public PostController(
            IPostService postService
            , IMenuLinkService menuLinkService
            , IGalleryService galleryService
             , IWorkContext workContext
            , IGenericControlService genericControlService
            , ICacheManager cacheManager)
        {
            _postService = postService;
            _menuLinkService = menuLinkService;
            _galleryService = galleryService;
            _workContext = workContext;
            _genericControlService = genericControlService;
            _cacheManager = cacheManager;
        }

        [PartialCache("Medium")]
        public ActionResult FillterProduct(string attribute = null)
        {
            return PartialView();
        }

        [PartialCache("Medium")]
        public ActionResult GetAccesssoriesHome(int page, string id)
        {
            Expression<Func<Post, bool>> expression = PredicateBuilder.True<Post>();
            expression = expression.And(x => x.Status == 1);
            expression = expression.And(x => x.VirtualCategoryId.Contains(id));
            expression = expression.And(x => x.ProductHot);
            SortBuilder sortBuilder = new SortBuilder
            {
                ColumnName = "UpdatedDate",
                ColumnOrder = SortBuilder.SortOrder.Descending
            };
            Paging paging = new Paging
            {
                PageNumber = page,
                PageSize = 4,
                TotalRecord = 0
            };
            IEnumerable<Post> posts = _postService.FindAndSort(expression, sortBuilder, paging);
            if (!posts.IsAny())
            {
                return Json(new { success = true, data = "" }, JsonRequestBehavior.AllowGet);
            }
            return Json(new { data = this.RenderRazorViewToString("_SlideProductHome", posts), success = true }, JsonRequestBehavior.AllowGet);
        }

        [ChildActionOnly]
        [PartialCache("Short")]
        public ActionResult GetCareerHomePage(string virtualId)
        {
            List<Post> posts = new List<Post>();
            IEnumerable<Post> top = _postService.GetTop(4, x => x.Status == 1 && x.VirtualCategoryId.Contains(virtualId), x => x.ViewCount);
            if (top.IsAny())
            {
                posts.AddRange(top);
            }
            return PartialView("GetPostRelative", posts);
        }

        public ActionResult GetGallery(int postId, int typeId)
        {
            IEnumerable<GalleryImage> galleryImages = _galleryService.GetByOption(attributeValueId: typeId, postId: postId);

            //IEnumerable<GalleryImage> galleryImages = _galleryService.FindBy((GalleryImage x) => x.AttributeValueId == typeId && x.PostId == postId, false);
            if (!galleryImages.IsAny())
            {
                return Json(new { success = false }, JsonRequestBehavior.AllowGet);
            }
            return Json(new { data = this.RenderRazorViewToString("_PartialGallery", galleryImages), success = true }, JsonRequestBehavior.AllowGet);
        }

        [ChildActionOnly]
        [PartialCache("Short")]
        public ActionResult GetNewProductRelative(double? price, int productId)
        {
            double? nullable;
            double? nullable1;
            double? nullable2;
            double? nullable3 = price;
            double num = 2000000;
            if (nullable3.HasValue)
            {
                nullable1 = nullable3.GetValueOrDefault() - num;
            }
            else
            {
                nullable = null;
                nullable1 = nullable;
            }
            double? nullable4 = nullable1;
            nullable3 = price;
            num = 2000000;
            if (nullable3.HasValue)
            {
                nullable2 = nullable3.GetValueOrDefault() + num;
            }
            else
            {
                nullable = null;
                nullable2 = nullable;
            }
            double? nullable5 = nullable2;
            List<Post> posts = new List<Post>();
            IEnumerable<Post> top = _postService.GetTop(4, x => x.Status == 1 && x.Price >= nullable4 && x.Price <= nullable5 && x.Id != productId, x => x.UpdatedDate);

            if (top == null)
                return HttpNotFound();

            if (top.IsAny())
            {
                posts.AddRange(top);
            }
            return PartialView(posts);
        }

        [ChildActionOnly]
        [PartialCache("Short")]
        public ActionResult GetNewProductRelative2(string virtualId, int productId)
        {
            int languageId = _workContext.WorkingLanguage.Id;

            List<Post> lstPost = new List<Post>();
            IEnumerable<Post> iePost = _postService.GetTop(4, x => x.Status == 1 && x.VirtualCategoryId.Contains(virtualId) && x.Id != productId, x => x.UpdatedDate);

            if (iePost == null)
                return HttpNotFound();

            IEnumerable<Post> postLocalized = null;
            if (iePost.IsAny())
            {
                postLocalized = iePost.Select(x =>
                {
                    return x.ToModel();
                });               

                lstPost.AddRange(postLocalized);
            }
            return PartialView(lstPost);
        }

        [ChildActionOnly]
        public ActionResult GetPostAccessory(string virtualId)
        {
            List<Post> posts = new List<Post>();
            IEnumerable<Post> top = _postService.GetTop(4, x => x.Status == 1 && x.VirtualCategoryId.Contains(virtualId)
            , x => x.UpdatedDate);

            if (top.IsAny())
            {
                posts.AddRange(top);
            }
            return PartialView("_SlideProductHome", posts);
        }

        [PartialCache("Short")]
        public ActionResult GetPostByCategory(string virtualCategoryId, int page, string title, string attrs, string prices, string proattrs, string keywords
            , int? productOld, int? productNew)
        {
            Expression<Func<Post, bool>> expression = PredicateBuilder.True<Post>();
            expression = expression.And(x => x.Status == 1);
            SortBuilder sortBuilder = new SortBuilder
            {
                ColumnName = "CreatedDate",
                ColumnOrder = SortBuilder.SortOrder.Descending
            };
            Paging paging = new Paging
            {
                PageNumber = page,
                PageSize = _pageSize,
                TotalRecord = 0
            };
            if (page == 1)
            {
                dynamic viewBag = ViewBag;
                IPostService postService = _postService;
                Expression<Func<Post, bool>> productNews = x => x.ProductNew && x.Status == 1;
                viewBag.HotCard = postService.GetTop(3, productNews, x => x.CreatedDate).ToList();
            }
            if (!string.IsNullOrEmpty(attrs))
            {
                string[] strArrays = attrs.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                List<int> list = (
                    from s in strArrays
                    select int.Parse(s)).ToList();
                expression = expression.And(x => x.AttributeValues.Count(a => list.Contains(a.Id)) > 0);
                ViewBag.Attributes = list;
            }
            if (!string.IsNullOrEmpty(prices))
            {
                List<double> nums = (
                    from s in prices.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries)
                    select double.Parse(s)).ToList();
                double item = nums[0];
                double num = nums[1];
                expression = expression.And(x => x.Price >= (double?)item && x.Price <= (double?)num);
                ViewBag.Prices = nums;
            }
            if (!string.IsNullOrEmpty(proattrs))
            {
                string[] strArrays1 = proattrs.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                List<int> list1 = (
                    from s in strArrays1
                    select int.Parse(s)).ToList();
                expression = expression.And(x => list1.Contains(x.Id));
                ViewBag.ProAttributes = list1;
            }
            if (!string.IsNullOrEmpty(keywords))
            {
                expression = expression.And(x => x.Title.Contains(keywords));
            }
            expression = expression.And(x => x.VirtualCategoryId.Contains(virtualCategoryId));
            if (productNew.HasValue)
            {
                expression = expression.And(x => !x.OldOrNew);
                ViewBag.ProductNew = productNew;
            }
            if (productOld.HasValue & productNew.HasValue)
            {
                expression = expression.Or(x => x.OldOrNew);
                ViewBag.ProductOld = productOld;
            }
            if (productOld.HasValue & !productNew.HasValue)
            {
                expression = expression.And(x => x.OldOrNew);
                ViewBag.ProductOld = productOld;
            }

            IEnumerable<Post> posts = _postService.GetBySort(expression, sortBuilder, paging);

            if (posts == null)
                return HttpNotFound();

            //Get menu category filter
            IEnumerable<MenuLink> menuCategoryFilter = _menuLinkService.GetByOption(virtualId: virtualCategoryId);

            if (menuCategoryFilter.IsAny())
            {
                List<BreadCrumb> lstBreadCrumb = new List<BreadCrumb>();
                ViewBag.MenuCategoryFilter = menuCategoryFilter;

                //Lấy bannerId từ post để hiển thị banner trên post
                ViewBag.BannerId = menuCategoryFilter.Where(x => x.VirtualId == virtualCategoryId).FirstOrDefault().Id;

                string[] strArrays2 = virtualCategoryId.Split('/');
                for (int i1 = 0; i1 < strArrays2.Length; i1++)
                {
                    string str = strArrays2[i1];
                    MenuLink menuLink = _menuLinkService.GetByMenuName(str, title);
                    
                    if (menuLink != null)
                    {
                        //Lấy bannerId từ post để hiển thị banner trên post
                        if (i1 == 0)
                            ViewBag.BannerId = menuLink.Id;

                        lstBreadCrumb.Add(new BreadCrumb
                        {
                            Title = menuLink.GetLocalized(m => m.MenuName, menuLink.Id),
                            Current = false,
                            Url = Url.Action("GetContent", "Menu", new { area = "", menu = menuLink.SeoUrl })
                        });
                    }
                }
                lstBreadCrumb.Add(new BreadCrumb
                {
                    Current = true,
                    Title = title
                });
                ViewBag.BreadCrumb = lstBreadCrumb;
            }

            IEnumerable<Post> postLocalized = null;

            if (posts.IsAny())
            {
                postLocalized = posts.Select(x =>
                {
                    return x.ToModel();
                });

                Helper.PageInfo pageInfo = new Helper.PageInfo(ExtentionUtils.PageSize, page, paging.TotalRecord, i => Url.Action("GetContent", "Menu", new { page = i }));
                ViewBag.PageInfo = pageInfo;
                ViewBag.CountItem = pageInfo.TotalItems;
                ViewBag.MenuId = postLocalized.ElementAt(0).MenuId;

            }

            ViewBag.Title = title;
            ViewBag.VirtualId = virtualCategoryId;

            return PartialView(postLocalized);
        }

        [PartialCache("Medium")]
        public ActionResult GetPostForYou()
        {
            List<Post> posts = new List<Post>();
            IEnumerable<Post> top = _postService.GetTop(20, x => x.Status == 1 && x.PostType == 1, x => x.CreatedDate);
            if (top.IsAny())
            {
                posts.AddRange(top);
            }
            return Json(new { data = this.RenderRazorViewToString("_PartialPostItems", posts), success = true }, JsonRequestBehavior.AllowGet);
        }

        [PartialCache("Medium")]
        public ActionResult GetPostLatest()
        {
            List<Post> posts = new List<Post>();
            IEnumerable<Post> top = _postService.GetTop(20, x => x.Status == 1, x => x.CreatedDate);
            if (top.IsAny())
            {
                posts.AddRange(top);
            }
            return Json(new { data = this.RenderRazorViewToString("_PartialPostItems", posts), success = true }, JsonRequestBehavior.AllowGet);
        }

        [ChildActionOnly]
        [PartialCache("Short")]
        public ActionResult GetPostRelative(string virtualId)
        {
            List<Post> posts = new List<Post>();
            IEnumerable<Post> top = _postService.GetTop(4, x => x.Status == 1 && x.VirtualCategoryId.Contains(virtualId), x => x.UpdatedDate);
            if (top.IsAny())
            {
                posts.AddRange(top);
            }
            return PartialView(posts);
        }

        [ChildActionOnly]
        [PartialCache("Short")]
        public ActionResult GetPostSameMenu(int menuId, int postId)
        {
            List<Post> posts = new List<Post>();
            IEnumerable<Post> top = _postService.GetTop(6, x => x.Status == 1 && x.MenuId == menuId && x.Id != postId, x => x.CreatedDate);
            if (top.IsAny())
            {
                posts.AddRange(top);
            }
            return PartialView(posts);
        }

        [PartialCache("Medium")]
        public ActionResult GetPriceProduct(int productId, int attributeId)
        {
            GalleryImage galleryImage = _galleryService.Get(x => x.PostId == productId && x.AttributeValueId == attributeId, false);
            if (galleryImage == null || !galleryImage.Price.HasValue)
            {
                return Json("Liên hệ");
            }

            return Json(galleryImage.Price);
            //return base.Json(string.Format("{0:##,###0 VND}", galleryImage.Price));
        }

        [PartialCache("Medium")]
        public ActionResult GetProductHot()
        {
            IEnumerable<Post> top = _postService.GetTop(9999, x => x.Status == 1 && (x.ProductHot || x.ProductNew));
            return PartialView(top);
        }

        [PartialCache("Medium")]
        public ActionResult GetProductTimeLine()
        {
            IEnumerable<Post> top = _postService.GetTop(9999, x => x.Status == 1 && x.OldOrNew);
            return PartialView(top);
        }

        [PartialCache("Medium")]
        public ActionResult GetProductNewHome(int page, string id)
        {
            Expression<Func<Post, bool>> expression = PredicateBuilder.True<Post>();
            expression = expression.And(x => x.Status == 1);
            expression = expression.And(x => x.VirtualCategoryId.Contains(id));
            expression = expression.And(x => x.ProductHot);
            SortBuilder sortBuilder = new SortBuilder
            {
                ColumnName = "UpdatedDate",
                ColumnOrder = SortBuilder.SortOrder.Descending
            };
            Paging paging = new Paging
            {
                PageNumber = page,
                PageSize = 4,
                TotalRecord = 0
            };
            IEnumerable<Post> posts = _postService.FindAndSort(expression, sortBuilder, paging);
            if (!posts.IsAny())
            {
                return Json(new { success = true, data = string.Empty }, JsonRequestBehavior.AllowGet);
            }
            return Json(new
            {
                data = this.RenderRazorViewToString("_SlideProductHome",
                from x in posts
                orderby x.OrderDisplay descending
                select x),
                success = true
            }, JsonRequestBehavior.AllowGet);
        }

        //Get product trang chủ
        [PartialCache("Medium")]
        public ActionResult GetProductHome()
        {
            IEnumerable<Post> iePost = null;

            //Get danh sách menu có DisplayOnHomePage ==true
            IEnumerable<MenuLink> menuLinks = _menuLinkService.GetByOption(isDisplayHomePage: true, template: new List<int> { 2 });

            //Convert to localized
            menuLinks = menuLinks.Select(x =>
            {
                return x.ToModel();
            });

            if (menuLinks.IsAny())
            {
                ViewBag.MenuLinkHome = menuLinks;


                List<Post> lstPost = new List<Post>();

                foreach (var item in menuLinks)
                {
                    iePost = _postService.GetByOption(virtualCategoryId: item.CurrentVirtualId, isDisplayHomePage: true);

                    if (iePost.IsAny())
                    {
                        iePost = iePost.Select(x =>
                        {
                            return x.ToModel();
                        });

                        lstPost.AddRange(iePost);
                    }
                }

                iePost = from x in lstPost orderby x.OrderDisplay descending select x;
            }

            return PartialView(iePost);

        }

        //Get product SearchHome
        [PartialCache("Medium")]
        public ActionResult GetProductSearchHome(bool productHot, bool productNew, bool productOld)
        {
            IEnumerable<Post> iePost = _postService.GetTop(9999, x => x.Status == 1 && x.ProductHot);

            return PartialView(iePost);

        }

        [ChildActionOnly]
        public ActionResult GetProductNewTabHome(string virtualId)
        {
            List<Post> posts = new List<Post>();
            IEnumerable<Post> top = _postService.GetTop(4, x => x.Status == 1 && x.VirtualCategoryId.Contains(virtualId) && x.ProductHot, x => x.UpdatedDate);
            if (top.IsAny())
            {
                posts.AddRange(top);
            }
            return PartialView("_SlideProductHome",
                from x in posts
                orderby x.OrderDisplay descending
                select x);
        }

        [PartialCache("Medium")]
        public ActionResult PostDetail(string seoUrl)
        {
            List<BreadCrumb> breadCrumbs = new List<BreadCrumb>();
            Post post = _postService.GetBySeoUrl(seoUrl);

            if (post == null)
                return HttpNotFound();

            Post postLocalized = null;

            if (post != null)
            {
                postLocalized = post.ToModel();

                Post viewCount = post;
                viewCount.ViewCount = viewCount.ViewCount + 1;
                _postService.Update(post);

                string[] strArrays = post.VirtualCategoryId.Split('/');
                for (int i = 0; i < strArrays.Length; i++)
                {
                    string str = strArrays[i];
                    MenuLink menuLink = _menuLinkService.GetByCurrentVirtualId(str);
                    //MenuLink menuLink = this._menuLinkService.Get((MenuLink x) => x.CurrentVirtualId.Equals(str), false);
                    breadCrumbs.Add(new BreadCrumb
                    {
                        Title = menuLink.GetLocalized(x => x.MenuName, menuLink.Id), //menuLink.GetLocalizedByLocaleKey(menuLink.MenuName, menuLink.Id, languageId, "MenuLink", "MenuName"),
                        Current = false,
                        Url = Url.Action("GetContent", "Menu", new { area = "", menu = menuLink.SeoUrl })
                    });
                }
                breadCrumbs.Add(new BreadCrumb
                {
                    Current = true,
                    Title = postLocalized.Title
                });
                ViewBag.BreadCrumb = breadCrumbs;
                ViewBag.Title = postLocalized.Title;
                ViewBag.KeyWords = postLocalized.MetaKeywords;
                ViewBag.SiteUrl = Url.Action("PostDetail", "Post", new {seoUrl, area = "" });
                ViewBag.Description = postLocalized.MetaTitle;
                ViewBag.Image = Url.Content(string.Concat("~/", postLocalized.ImageMediumSize));
                ViewBag.MenuId = postLocalized.MenuId;
            }
            return View(postLocalized);
        }

        [PartialCache("Medium")]
        public ActionResult SearchResult(string catUrl, string parameters, int page)
        {
            HttpCookie httpCookie = HttpContext.Request.Cookies.Get("system_search");
            if (!Request.Cookies.ExistsCokiee("system_search"))
            {
                return View();
            }
            Expression<Func<Post, bool>> expression = PredicateBuilder.True<Post>();
            SortBuilder sortBuilder = new SortBuilder
            {
                ColumnName = "CreatedDate",
                ColumnOrder = SortBuilder.SortOrder.Descending
            };
            Paging paging = new Paging
            {
                PageNumber = page,
                PageSize = _pageSize,
                TotalRecord = 0
            };

            SeachConditions seachCondition = JsonConvert.DeserializeObject<SeachConditions>(Server.UrlDecode(httpCookie.Value));

            //expression = expression.And<Post>((Post x) => (int?)x.MenuId == seachCondition.CategoryId);
            //MenuLink byId = this._menuLinkService.GetById(seachCondition.CategoryId.Value);
            //((dynamic)base.ViewBag).KeyWords = byId.MetaKeywords;
            //((dynamic)base.ViewBag).SiteUrl = base.Url.Action("GetContent", "Menu", new { catUrl = catUrl, parameters = parameters, page = page, area = "" });
            //((dynamic)base.ViewBag).Description = byId.MetaDescription;
            //((dynamic)base.ViewBag).Image = base.Url.Content(string.Concat("~/", byId.ImageUrl));
            //((dynamic)base.ViewBag).VirtualId = byId.CurrentVirtualId;
            //string menuName = byId.MenuName;

            if (!string.IsNullOrEmpty(seachCondition.Keywords))
            {
                expression = expression.And(x => x.SeoUrl.Contains(seachCondition.Keywords) || x.Title.Contains(seachCondition.Keywords) || x.Description.Contains(seachCondition.Keywords));
            }

            IEnumerable<Post> posts = _postService.FindAndSort(expression, sortBuilder, paging);
            ViewBag.PageNumber = page;
            //((dynamic)base.ViewBag).Title = menuName;
            if (posts.IsAny())
            {
                Helper.PageInfo pageInfo = new Helper.PageInfo(ExtentionUtils.PageSize, page, paging.TotalRecord, i => Url.Action("GetContent", "Menu", new { page = i }));
                ViewBag.PageInfo = pageInfo;
                ViewBag.CountItem = pageInfo.TotalItems;
            }
            return View("GetPostByCategory", posts);
        }

        [PartialCache("Medium")]
        public async Task<JsonResult> GetGenericControlByEntityId()
        {
            IEnumerable<GenericControl> genericControls = _genericControlService.GetByMenuId(3);

            IOrderedEnumerable<GenericControl> genericControls1 = await Task.FromResult(
                from x in genericControls
                orderby x.OrderDisplay descending
                select x);

            JsonResult jsonResult = Json(new { success = true, list = this.RenderRazorViewToString("_PostDetail.Attribute", genericControls1) }, JsonRequestBehavior.AllowGet);
            return jsonResult;
        }

        //Hien thi san pham footer
        [PartialCache("Medium")]
        public JsonResult GetProductOutOfStock()
        {
            IEnumerable<Post> post = _postService.GetTop(6, x => x.Status == 1 && x.OutOfStock);

            JsonResult jsonResult = Json(new { success = true, list = this.RenderRazorViewToString("_Footer.Product", post) }, JsonRequestBehavior.AllowGet);

            return jsonResult;
        }

        #region Attribute

        [HttpPost]
        public JsonResult GetByMenuId(int menuId, int entityId)
        {
            List<ControlValueItemResponse> lstValueResponse = new List<ControlValueItemResponse>();

            MenuLink menuLink = _menuLinkService.GetById(menuId);
            if (menuLink != null)
            {
                IEnumerable<GenericControl> ieGC = menuLink.GenericControls;
                if (ieGC.IsAny())
                {
                    foreach (GenericControl item in ieGC)
                    {
                        IEnumerable<GenericControlValue> gCVDefault = item.GenericControlValues.Where(m => m.Status == 1);

                        foreach (var gcValue in gCVDefault)
                        {
                            ControlValueItemResponse objValueResponse = new ControlValueItemResponse();

                            objValueResponse.GenericControlValueId = gcValue.Id;
                            objValueResponse.Name = gcValue.ValueName;
                            objValueResponse.ValueName = gcValue.GetValueItem(entityId);

                            lstValueResponse.Add(objValueResponse);
                        }
                    }
                }
            }

            JsonResult jsonResult = Json(
                 new
                 {
                     success = lstValueResponse.Count() > 0,
                     list = this.RenderRazorViewToString("_PostDetail.Attribute", lstValueResponse)
                 },
                 JsonRequestBehavior.AllowGet);

            return jsonResult;
        }

        #endregion
    }
}