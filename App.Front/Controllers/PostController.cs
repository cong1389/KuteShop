using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using App.Aplication;
using App.Aplication.Extensions;
using App.Core.Caching;
using App.Core.Utils;
using App.Domain.Entities.Data;
using App.Domain.Entities.GenericControl;
using App.Domain.Entities.Menu;
using App.FakeEntity.GenericControl;
using App.Framework.Ultis;
using App.Front.Models;
using App.Front.Models.Posts;
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
        private readonly IPostService _postService;

        private readonly IMenuLinkService _menuLinkService;

        private readonly IGalleryService _galleryService;

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
        }

        //[PartialCache("Short")]
        public ActionResult PostCategories(string virtualCategoryId, int page, string title, string attrs,
            string prices, string proattrs, string keywords
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
                PageSize = PageSize,
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
                expression = expression.And(x => x.Price >= item && x.Price <= num);
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
            IEnumerable<Post> postLocalized = null;

            if (posts.IsAny())
            {
                postLocalized = posts.Select(x => x.ToModel());

                Helper.PageInfo pageInfo = new Helper.PageInfo(ExtentionUtils.PageSize, page, paging.TotalRecord,
                    i => Url.Action("GetContent", "Menu", new { page = i }));

                ViewBag.PageInfo = pageInfo;
                ViewBag.CountItem = pageInfo.TotalItems;
                ViewBag.MenuId = postLocalized.ElementAt(0).MenuId;
            }

            //Get menu category filter
            IEnumerable<MenuLink> menuCategoryFilter = _menuLinkService.GetByOption(virtualId: virtualCategoryId);
                
            if (menuCategoryFilter.IsAny())
            {
                List<BreadCrumb> lstBreadCrumb = new List<BreadCrumb>();
                ViewBag.MenuCategoryFilter = menuCategoryFilter;

                //Lấy bannerId từ post để hiển thị banner trên post
                ViewBag.BannerId = menuCategoryFilter.FirstOrDefault(x => x.VirtualId == virtualCategoryId).Id;

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

            ViewBag.Title = title;
            ViewBag.VirtualId = virtualCategoryId;

            return PartialView(postLocalized);
        }
        
        [PartialCache("Medium")]
        public ActionResult PostDetail(string seoUrl)
        {
            Post post = _postService.GetBySeoUrl(seoUrl);

            if (post == null)
            {
                return HttpNotFound();
            }

            Post postLocalized = post.ToModel();

            Post viewCount = post;
            viewCount.ViewCount = viewCount.ViewCount + 1;
            _postService.Update(post);

            var strArrays = post.VirtualCategoryId.Split('/');
            List<BreadCrumb> breadCrumbs = new List<BreadCrumb>();
            breadCrumbs.AddRange(strArrays.Select(str => _menuLinkService.GetByCurrentVirtualId(str))
                .Select(menuLink => new BreadCrumb
                {
                    Title = menuLink.GetLocalized(x => x.MenuName, menuLink.Id),
                    Current = false,
                    Url = Url.Action("GetContent", "Menu", new { area = "", menu = menuLink.SeoUrl })
                }));
            breadCrumbs.Add(new BreadCrumb
            {
                Current = true,
                Title = postLocalized.Title
            });

            ViewBag.BreadCrumb = breadCrumbs;
            ViewBag.Title = postLocalized.Title;
            ViewBag.KeyWords = postLocalized.MetaKeywords;
            ViewBag.SiteUrl = Url.Action("PostDetail", "Post", new { seoUrl, area = "" });
            ViewBag.Description = postLocalized.MetaTitle;
            ViewBag.Image = Url.Content(string.Concat("~/", postLocalized.ImageMediumSize));
            ViewBag.MenuId = postLocalized.MenuId;

            return View(postLocalized);
        }

        [PartialCache("Medium")]
        public ActionResult PostForYou()
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
        public ActionResult PostLatest()
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
        public ActionResult PostSameMenu(int menuId, int postId)
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
        public ActionResult PostPrice(int productId, int attributeId)
        {
            var galleryImage = _galleryService.Get(x => x.PostId == productId && x.AttributeValueId == attributeId);

            return galleryImage?.Price == null ? Json("Liên hệ") : Json(galleryImage.Price);
        }

        [ChildActionOnly]
        [PartialCache("Long")]
        public ActionResult PostHot()
        {
            IEnumerable<Post> top = _postService.GetTop(5, x => x.Status == 1 && (x.ProductHot || x.ProductNew));

            return PartialView(top);
        }

        [PartialCache("Medium")]
        public ActionResult PostTimeLine()
        {
            IEnumerable<Post> top = _postService.GetTop(9999, x => x.Status == 1 && x.OldOrNew);
            return PartialView(top);
        }

        [PartialCache("Medium")]
        public ActionResult PostHomeNew(int page, string id)
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

        [PartialCache("Long")]
        public ActionResult PostHome()
        {
            var menuLinks = _menuLinkService.GetByOption(new List<int> { 5 }, isDisplayHomePage: true);

            if (!menuLinks.IsAny())
            {
                return HttpNotFound();
            }

            //Convert to localized
            menuLinks = menuLinks.Select(x => x.ToModel());

            var menuParent = menuLinks.Where(x => x.ParentId == null).OrderByDescending(x => x.OrderDisplay);

            List<Post> lstPost = new List<Post>();
            foreach (var item in menuParent)
            {
                var iePost = _postService.GetByOption(item.CurrentVirtualId, true);

                if (iePost.IsAny())
                {
                    iePost = iePost.Select(x => x.ToModel());

                    lstPost.AddRange(iePost);
                }
            }

            CategoryPostModel categoryPost = new CategoryPostModel
            {
                NumberMenu = menuParent.Count(),
                MenuLinks = menuParent,
                Posts = from x in lstPost orderby x.OrderDisplay descending select x
            };

            return PartialView(categoryPost);
        }

        //Get product SearchHome
        [PartialCache("Medium")]
        public ActionResult PostHomeSearch(bool productHot, bool productNew, bool productOld)
        {
            IEnumerable<Post> iePost = _postService.GetTop(9999, x => x.Status == 1 && x.ProductHot);

            return PartialView(iePost);

        }

        [ChildActionOnly]
        public ActionResult PostHomeNewTab(string virtualId)
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
        
        [ChildActionOnly]
        [PartialCache("Short")]
        public ActionResult PostHomeCareer(string virtualId)
        {
            List<Post> posts = new List<Post>();
            IEnumerable<Post> top = _postService.GetTop(4, x => x.Status == 1 && x.VirtualCategoryId.Contains(virtualId), x => x.ViewCount);
            if (top.IsAny())
            {
                posts.AddRange(top);
            }
            return PartialView(posts);
        }

        public ActionResult GetGallery(int postId, int typeId)
        {
            IEnumerable<GalleryImage> galleryImages = _galleryService.GetByOption(typeId, postId: postId);

            if (!galleryImages.IsAny())
            {
                return Json(new { success = false }, JsonRequestBehavior.AllowGet);
            }
            return Json(new { data = this.RenderRazorViewToString("_PartialGallery", galleryImages), success = true }, JsonRequestBehavior.AllowGet);
        }

        [ChildActionOnly]
        [PartialCache("Short")]
        public ActionResult PostRelativePrice(double? price, int productId)
        {
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
                nullable1 = null;
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
                nullable2 = null;
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
        public ActionResult PostRelative(string virtualId, int productId)
        {
            var iePost = _postService.GetTop(10,
                x => x.Status == 1 && x.VirtualCategoryId.Contains(virtualId) && x.Id != productId, x => x.UpdatedDate);

            if (iePost == null)
            {
                return HttpNotFound();
            }

            var postLocalized = iePost.Select(x => x.ToModel());

            return PartialView(postLocalized);
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
                PageSize = PageSize,
                TotalRecord = 0
            };

            var seachCondition = JsonConvert.DeserializeObject<SeachConditions>(Server.UrlDecode(httpCookie.Value));

            if (!string.IsNullOrEmpty(seachCondition.Keywords))
            {
                expression = expression.And(x =>
                    x.SeoUrl.Contains(seachCondition.Keywords) || x.Title.Contains(seachCondition.Keywords) ||
                    x.Description.Contains(seachCondition.Keywords));
            }

            var posts = _postService.FindAndSort(expression, sortBuilder, paging);
            if (posts.IsAny())
            {
                Helper.PageInfo pageInfo = new Helper.PageInfo(ExtentionUtils.PageSize, page, paging.TotalRecord,
                    i => Url.Action("GetContent", "Menu", new { page = i }));
                ViewBag.PageInfo = pageInfo;
                ViewBag.CountItem = pageInfo.TotalItems;
            }

            ViewBag.PageNumber = page;
            ViewBag.Title = "Tìm kiếm";

            return View(posts);
        }

        //Hien thi san pham footer
        [PartialCache("Medium")]
        public JsonResult PostOutOfStock()
        {
            IEnumerable<Post> post = _postService.GetTop(6, x => x.Status == 1 && x.OutOfStock);

            JsonResult jsonResult = Json(new { success = true, list = this.RenderRazorViewToString("_Footer.Product", post) }, JsonRequestBehavior.AllowGet);

            return jsonResult;
        }

        #region Post discount

        [ChildActionOnly]
        [PartialCache("Short")]
        public ActionResult PostDiscountSlide()
        {
            return PartialView(PreparePostDiscount());
        }

        [ChildActionOnly]
        [PartialCache("Short")]
        public ActionResult PostDiscountBlock()
        {
            return PartialView("_PostDetail.Discount", PreparePostDiscount().Take(5));
        }

        private IEnumerable<Post> PreparePostDiscount()
        {
            return _postService.GetByOption(isDiscount: true);
        }

        #endregion

        #region Attribute

        [HttpPost]
        public async Task<JsonResult> GetByMenuId(int menuId, int entityId)
        {
            var lstValueResponse = new List<ControlValueItemResponse>();

            MenuLink menuLink = _menuLinkService.GetById(menuId);
            if (menuLink != null)
            {
                IEnumerable<GenericControl> ieGc = menuLink.GenericControls;
                if (ieGc.IsAny())
                {
                    foreach (GenericControl item in ieGc)
                    {
                        IEnumerable<GenericControlValue> gCvDefault = item.GenericControlValues.Where(m => m.Status == 1);

                        foreach (var gcValue in gCvDefault)
                        {
                            var objValueResponse =
                                new ControlValueItemResponse
                                {
                                    GenericControlValueId = gcValue.Id,
                                    Name = gcValue.ValueName,
                                    ValueName = gcValue.GetValueItem(entityId)
                                };


                            lstValueResponse.Add(objValueResponse);
                        }
                    }
                }
            }

            JsonResult jsonResult = Json(
                new
                {
                    success = lstValueResponse.Any(),
                    list = this.RenderRazorViewToString("_PostDetail.Attribute", lstValueResponse)
                },
                JsonRequestBehavior.AllowGet);

            return jsonResult;
        }

        #endregion
    }
}