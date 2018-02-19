using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using App.Admin.Helpers;
using App.Aplication;
using App.Core.Caching;
using App.Core.Utils;
using App.Domain.Entities.Attribute;
using App.Domain.Entities.Data;
using App.Domain.Entities.Menu;
using App.FakeEntity.Gallery;
using App.FakeEntity.Post;
using App.Framework.Ultis;
using App.Service.Attribute;
using App.Service.Gallery;
using App.Service.GenericControl;
using App.Service.Language;
using App.Service.LocalizedProperty;
using App.Service.Menu;
using App.Service.Post;
using AutoMapper;
using Resources;
using Attribute = App.Domain.Entities.Attribute.Attribute;

namespace App.Admin.Controllers
{
    public class PostController : BaseAdminUploadController
    {
        private const string CachePostKey = "db.Post";
        private readonly ICacheManager _cacheManager;

        private readonly IAttributeValueService _attributeValueService;

        private readonly IMenuLinkService _menuLinkService;

        private readonly IPostService _postService;

        private readonly IAttributeService _attributeService;

        private readonly IGalleryService _galleryService;

        private readonly IImagePlugin _imagePlugin;

        private readonly ILanguageService _languageService;

        private readonly ILocalizedPropertyService _localizedPropertyService;

        private readonly IPostGalleryService _postGalleryService;

        public PostController(
            IPostService postService
            , IMenuLinkService menuLinkService
            , IAttributeValueService attributeValueService
            , IGalleryService galleryService
            , IImagePlugin imagePlugin
            , IAttributeService attributeService
            , ILanguageService languageService
            , ILocalizedPropertyService localizedPropertyService
            , IPostGalleryService postGalleryService
            , IGenericControlService genericControlService
            , ICacheManager cacheManager)
            : base(cacheManager)
        {
            _postService = postService;
            _menuLinkService = menuLinkService;
            _attributeValueService = attributeValueService;
            _galleryService = galleryService;
            _imagePlugin = imagePlugin;
            _attributeService = attributeService;
            _languageService = languageService;
            _localizedPropertyService = localizedPropertyService;
            _postGalleryService = postGalleryService;
            _cacheManager = cacheManager;

            //Clear cache
            _cacheManager.RemoveByPattern(CachePostKey);
        }

        [RequiredPermisson(Roles = "CreatePost")]
        public ActionResult Create()
        {
            var model = new PostViewModel
            {
                OrderDisplay = 0,
                Status = 1
            };

            //Add locales to model
            AddLocales(_languageService, model.Locales);

            return View(model);
        }

        [HttpPost]
        [RequiredPermisson(Roles = "CreatePost")]
        [ValidateInput(false)]
        public ActionResult Create(PostViewModel model, string returnUrl)
        {
            ActionResult action;
            try
            {
                if (!ModelState.IsValid)
                {
                    String messages = String.Join(Environment.NewLine, ModelState.Values.SelectMany(v => v.Errors)
                                                          .Select(v => v.ErrorMessage + " " + v.Exception));
                    ModelState.AddModelError("", messages);
                    return View(model);
                }

                string titleNonAccent = model.Title.NonAccent();
                IEnumerable<Post> bySeoUrl = _postService.GetListSeoUrl(titleNonAccent);

                model.SeoUrl = model.Title.NonAccent();
                if (bySeoUrl.Any(x => x.Id != model.Id))
                {
                    PostViewModel postViewModel = model;
                    postViewModel.SeoUrl = string.Concat(postViewModel.SeoUrl, "-", bySeoUrl.Count());
                }

                string folderName = $"{DateTime.UtcNow:ddMMyyyy}";
                if (model.Image != null && model.Image.ContentLength > 0)
                {
                    string fileExtension = Path.GetExtension(model.Image.FileName);

                    string fileName1 = titleNonAccent.FileNameFormat(fileExtension);
                    string fileName2 = titleNonAccent.FileNameFormat(fileExtension);
                    string fileName3 = titleNonAccent.FileNameFormat(fileExtension);

                    _imagePlugin.CropAndResizeImage(model.Image, $"{Contains.PostFolder}{folderName}/", fileName1, ImageSize.WithBigSize, ImageSize.HeightBigSize);
                    _imagePlugin.CropAndResizeImage(model.Image, $"{Contains.PostFolder}{folderName}/", fileName2, ImageSize.WithMediumSize, ImageSize.HeightMediumSize);
                    _imagePlugin.CropAndResizeImage(model.Image, $"{Contains.PostFolder}{folderName}/", fileName3, ImageSize.WithSmallSize, ImageSize.HeightSmallSize);

                    model.ImageBigSize = $"{Contains.PostFolder}{folderName}/{fileName1}";
                    model.ImageMediumSize = $"{Contains.PostFolder}{folderName}/{fileName2}";
                    model.ImageSmallSize = $"{Contains.PostFolder}{folderName}/{fileName3}";
                }

                int? menuId = model.MenuId;
                int i = 0;
                if (menuId.GetValueOrDefault() > i ? menuId.HasValue : false)
                {
                    IMenuLinkService menuLinkService = _menuLinkService;
                    menuId = model.MenuId;
                    MenuLink byId = menuLinkService.GetById(menuId.Value);
                    model.VirtualCatUrl = byId.VirtualSeoUrl;
                    model.VirtualCategoryId = byId.VirtualId;
                }

                //Gallery image
                HttpFileCollectionBase files = Request.Files;
                List<GalleryImage> galleryImages = new List<GalleryImage>();
                if (files.Count > 0)
                {
                    int count = files.Count - 1;
                    int num = 0;
                    string str6 = titleNonAccent;
                    string[] allKeys = files.AllKeys;
                    for (i = 0; i < allKeys.Length; i++)
                    {
                        string str7 = allKeys[i];
                        if (num <= count)
                        {
                            if (!str7.Equals("Image"))
                            {
                                string str8 = str7.Replace("[]", "");
                                HttpPostedFileBase item = files[num];
                                if (item.ContentLength > 0)
                                {
                                    string item1 = Request[str8];
                                    GalleryImageViewModel galleryImageViewModel = new GalleryImageViewModel
                                    {
                                        PostId = model.Id,
                                        AttributeValueId = int.Parse(str8)
                                    };

                                    string fileExtension = Path.GetExtension(model.Image.FileName);
                                    string fileName1 = titleNonAccent.FileNameFormat(fileExtension);
                                    string fileName2 = titleNonAccent.FileNameFormat(fileExtension);

                                    _imagePlugin.CropAndResizeImage(item, $"{Contains.PostFolder}{folderName}/", fileName1, ImageSize.WithBigSize, ImageSize.HeightBigSize);
                                    _imagePlugin.CropAndResizeImage(item, $"{Contains.PostFolder}{folderName}/", fileName2, ImageSize.WithThumbnailSize, ImageSize.HeightThumbnailSize);

                                    galleryImageViewModel.ImageThumbnail =$"{Contains.PostFolder}{folderName}/{fileName2}";
                                    galleryImageViewModel.ImagePath = $"{Contains.PostFolder}{folderName}/{fileName1}";

                                    galleryImageViewModel.OrderDisplay = num;
                                    galleryImageViewModel.Status = 1;
                                    galleryImageViewModel.Title = model.Title;
                                    galleryImageViewModel.Price = double.Parse(item1);

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

                //Attribute
                List<AttributeValue> attributeValues = new List<AttributeValue>();
                string item2 = Request["Values"];
                if (!string.IsNullOrEmpty(item2))
                {
                    foreach (string list in item2.Split(',').ToList())
                    {
                        int num1 = int.Parse(list);
                        attributeValues.Add(_attributeValueService.GetById(num1));
                    }
                }

                Post modelMap = Mapper.Map<PostViewModel, Post>(model);
                if (galleryImages.IsAny())
                {
                    modelMap.GalleryImages = galleryImages;
                }
                if (attributeValues.IsAny())
                {
                    modelMap.AttributeValues = attributeValues;
                }

                _postService.Create(modelMap);

                //Update Localized   
                foreach (var localized in model.Locales)
                {
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.Title, localized.Title, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.ProductCode, localized.ProductCode, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.ShortDesc, localized.ShortDesc, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.Description, localized.Description, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.TechInfo, localized.TechInfo, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.SeoUrl, localized.SeoUrl, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MetaTitle, localized.MetaTitle, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MetaKeywords, localized.MetaKeywords, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MetaDescription, localized.MetaDescription, localized.LanguageId);
                }

                Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.CreateSuccess, FormUI.Post)));
                if (!Url.IsLocalUrl(returnUrl) || returnUrl.Length <= 1 || !returnUrl.StartsWith("/") || returnUrl.StartsWith("//") || returnUrl.StartsWith("/\\"))
                {
                    action = RedirectToAction("Index");
                }
                else
                {
                    action = Redirect(returnUrl);
                }
                //else
                //{
                //	base.ModelState.AddModelError("", "Mã sản phẩm đã tồn tại.");
                //	action = base.View(model);
                //}
            }
            catch (Exception ex)
            {
                ExtentionUtils.Log(string.Concat("Post.Create: ", ex.Message));
                ModelState.AddModelError("", ex.Message);

                return View(model);
            }
            return action;
        }

        [RequiredPermisson(Roles = "DeletePost")]
        public ActionResult Delete(string[] ids)
        {
            try
            {
                if (ids.Length != 0)
                {
                    List<Post> posts = new List<Post>();
                    List<GalleryImage> galleryImages = new List<GalleryImage>();
                    string[] strArrays = ids;
                    for (int i = 0; i < strArrays.Length; i++)
                    {
                        int num = int.Parse(strArrays[i]);
                        Post post = _postService.Get(x => x.Id == num);
                        galleryImages.AddRange(post.GalleryImages.ToList());
                        post.AttributeValues.ToList().ForEach(att => post.AttributeValues.Remove(att));
                        posts.Add(post);
                    }

                    _galleryService.BatchDelete(galleryImages);
                    _postService.BatchDelete(posts);

                    //Delete localize
                    for (int i = 0; i < ids.Length; i++)
                    {
                        var ieLocalizedProperty = _localizedPropertyService.GetByEntityId(int.Parse(ids[i]));

                        _localizedPropertyService.BatchDelete(ieLocalizedProperty);
                    }
                }
            }
            catch (Exception ex)
            {
                ExtentionUtils.Log(string.Concat("Post.Delete: ", ex.Message));
            }

            return RedirectToAction("Index");
        }

        [RequiredPermisson(Roles = "CreatePost")]
        public ActionResult DeleteGallery(int postId, int galleryId)
        {
            ActionResult actionResult;
            if (!Request.IsAjaxRequest())
            {
                return Json(new { success = false });
            }
            try
            {
                GalleryImage galleryImage = _galleryService.Get(x => x.PostId == postId && x.Id == galleryId);
                _galleryService.Delete(galleryImage);

                string path1 = Server.MapPath(string.Concat("~/", galleryImage.ImagePath));
                string path2 = Server.MapPath(string.Concat("~/", galleryImage.ImageThumbnail));

                System.IO.File.Delete(path1);
                System.IO.File.Delete(path2);

                actionResult = Json(new { success = true });
            }
            catch (Exception ex)
            {
                actionResult = Json(new { success = false, messages = ex.Message });
            }
            return actionResult;
        }

        [RequiredPermisson(Roles = "CreatePost")]
        public ActionResult Edit(int id)
        {
            Post byId = _postService.GetById(id);

            PostViewModel modelMap = Mapper.Map<Post, PostViewModel>(byId);

            ViewBag.Galleries = byId.GalleryImages;

            //Add Locales to model
            AddLocales(_languageService, modelMap.Locales, (locale, languageId) =>
            {
                locale.Id = modelMap.Id;
                locale.LocalesId = modelMap.Id;
                locale.Title = modelMap.GetLocalized(x => x.Title, id, languageId, false, false);
                locale.ProductCode = modelMap.GetLocalized(x => x.ProductCode, id, languageId, false, false);
                locale.ShortDesc = modelMap.GetLocalized(x => x.ShortDesc, id, languageId, false, false);
                locale.Description = modelMap.GetLocalized(x => x.Description, id, languageId, false, false);
                locale.TechInfo = modelMap.GetLocalized(x => x.TechInfo, id, languageId, false, false);
                locale.MetaTitle = modelMap.GetLocalized(x => x.MetaTitle, id, languageId, false, false);
                locale.MetaKeywords = modelMap.GetLocalized(x => x.MetaKeywords, id, languageId, false, false);
                locale.MetaDescription = modelMap.GetLocalized(x => x.MetaDescription, id, languageId, false, false);
                locale.SeoUrl = modelMap.GetLocalized(x => x.SeoUrl, id, languageId, false, false);
            });

            return View(modelMap);
        }

        [HttpPost]
        [RequiredPermisson(Roles = "CreatePost")]
        [ValidateInput(false)]
        public ActionResult Edit(PostViewModel model, string returnUrl)
        {
            ActionResult action;
            try
            {
                if (!ModelState.IsValid)
                {
                    String messages = String.Join(Environment.NewLine, ModelState.Values.SelectMany(v => v.Errors)
                                                          .Select(v => v.ErrorMessage + " " + v.Exception));
                    ModelState.AddModelError("", messages);
                    return View(model);
                }

                if (!_postService.FindBy(x => x.ProductCode.Equals(model.ProductCode) && x.Id != model.Id, true).IsAny())
                {
                    Post byId = _postService.GetById(model.Id, false);

                    string titleNonAccent = model.Title.NonAccent();
                    IEnumerable<MenuLink> bySeoUrl = _menuLinkService.GetListSeoUrl(titleNonAccent, false);

                    model.SeoUrl = model.Title.NonAccent();
                    if (bySeoUrl.Any(x => x.Id != model.Id))
                    {
                        PostViewModel postViewModel = model;
                        postViewModel.SeoUrl = string.Concat(postViewModel.SeoUrl, "-", bySeoUrl.Count());
                    }

                    string folderName = $"{DateTime.UtcNow:ddMMyyyy}";
                    if (model.Image != null && model.Image.ContentLength > 0)
                    {
                        string fileExtension = Path.GetExtension(model.Image.FileName);

                        string fileName1 = titleNonAccent.FileNameFormat(fileExtension);
                        string fileName2 = titleNonAccent.FileNameFormat(fileExtension);
                        string fileName3 = titleNonAccent.FileNameFormat(fileExtension);

                        _imagePlugin.CropAndResizeImage(model.Image, $"{Contains.PostFolder}{folderName}/", fileName1, ImageSize.WithBigSize, ImageSize.HeightBigSize);
                        _imagePlugin.CropAndResizeImage(model.Image, $"{Contains.PostFolder}{folderName}/", fileName2, ImageSize.WithMediumSize, ImageSize.HeightMediumSize);
                        _imagePlugin.CropAndResizeImage(model.Image, $"{Contains.PostFolder}{folderName}/", fileName3, ImageSize.WithSmallSize, ImageSize.HeightSmallSize);

                        model.ImageBigSize = $"{Contains.PostFolder}{folderName}/{fileName1}";
                        model.ImageMediumSize = $"{Contains.PostFolder}{folderName}/{fileName2}";
                        model.ImageSmallSize = $"{Contains.PostFolder}{folderName}/{fileName3}";
                    }
                    int? menuId = model.MenuId;
                    int i = 0;
                    if (menuId.GetValueOrDefault() > i ? menuId.HasValue : false)
                    {
                        IMenuLinkService menuLinkService = _menuLinkService;
                        menuId = model.MenuId;
                        MenuLink menuLink = menuLinkService.GetById(menuId.Value, false);
                        model.VirtualCatUrl = menuLink.VirtualSeoUrl;
                        model.VirtualCategoryId = menuLink.VirtualId;
                    }

                    //GalleryImage
                    HttpFileCollectionBase files = Request.Files;
                    List<GalleryImage> lstGalleryImages = new List<GalleryImage>();
                    if (files.Count > 0)
                    {
                        int count = files.Count - 1;
                        int num = 0;

                        string[] allKeys = files.AllKeys;
                        for (i = 0; i < allKeys.Length; i++)
                        {
                            string str7 = allKeys[i];
                            if (num <= count)
                            {
                                if (!str7.Equals("Image"))
                                {
                                    string str8 = str7.Replace("[]", "");
                                    HttpPostedFileBase item = files[num];
                                    if (item.ContentLength > 0)
                                    {
                                        string item1 = Request[str8];
                                        GalleryImageViewModel galleryImageViewModel = new GalleryImageViewModel
                                        {
                                            PostId = model.Id,
                                            AttributeValueId = int.Parse(str8)
                                        };
                                        string fileName1 = $"{titleNonAccent}-{Guid.NewGuid()}.jpg";
                                        string fileName2 = $"{titleNonAccent}-{Guid.NewGuid()}.jpg";

                                        _imagePlugin.CropAndResizeImage(item, $"{Contains.PostFolder}{folderName}/", fileName1, ImageSize.WithBigSize, ImageSize.WithBigSize);
                                        _imagePlugin.CropAndResizeImage(item, $"{Contains.PostFolder}{folderName}/", fileName2, ImageSize.WithThumbnailSize, ImageSize.HeightThumbnailSize);

                                        galleryImageViewModel.ImageThumbnail =
                                            $"{Contains.PostFolder}{folderName}/{fileName2}";
                                        galleryImageViewModel.ImagePath =
                                            $"{Contains.PostFolder}{folderName}/{fileName1}";

                                        galleryImageViewModel.OrderDisplay = num;
                                        galleryImageViewModel.Status = 1;
                                        galleryImageViewModel.Title = model.Title;
                                        galleryImageViewModel.Price = double.Parse(item1);

                                        lstGalleryImages.Add(Mapper.Map<GalleryImage>(galleryImageViewModel));
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
                    if (lstGalleryImages.IsAny())
                    {
                        byId.GalleryImages = lstGalleryImages;
                    }

                    //AttributeValue
                    List<AttributeValue> lstAttributeValues = new List<AttributeValue>();
                    List<int> nums = new List<int>();
                    string item2 = Request["Values"];
                    if (!string.IsNullOrEmpty(item2))
                    {
                        foreach (string list in item2.Split(',').ToList())
                        {
                            int num1 = int.Parse(list);
                            nums.Add(num1);
                            lstAttributeValues.Add(_attributeValueService.GetById(num1, false));
                        }

                        if (nums.IsAny())
                        {
                            (
                                from x in byId.AttributeValues
                                where !nums.Contains(x.Id)
                                select x).ToList().ForEach(att => byId.AttributeValues.Remove(att));
                        }
                    }

                    byId.AttributeValues = lstAttributeValues;

                    Post modelMap = Mapper.Map(model, byId);
                    _postService.Update(byId);

                    //Update GalleryImage
                    if (lstAttributeValues.IsAny())
                    {
                        foreach (AttributeValue attributeValue in lstAttributeValues)
                        {
                            GalleryImage nullable = _galleryService.Get(x => x.AttributeValueId == attributeValue.Id && x.PostId == model.Id);
                            if (nullable == null)
                            {
                                continue;
                            }
                            HttpRequestBase request = Request;
                            i = attributeValue.Id;
                            double num2 = double.Parse(request[i.ToString()]);
                            nullable.Price = num2;
                            _galleryService.Update(nullable);
                        }
                    }

                    //Update Localized
                    foreach (var localized in model.Locales)
                    {
                        _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.Title, localized.Title, localized.LanguageId);
                        _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.ProductCode, localized.ProductCode, localized.LanguageId);
                        _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.ShortDesc, localized.ShortDesc, localized.LanguageId);
                        _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.Description, localized.Description, localized.LanguageId);
                        _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.TechInfo, localized.TechInfo, localized.LanguageId);
                        _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.SeoUrl, localized.SeoUrl, localized.LanguageId);
                        _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MetaTitle, localized.MetaTitle, localized.LanguageId);
                        _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MetaKeywords, localized.MetaKeywords, localized.LanguageId);
                        _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MetaDescription, localized.MetaDescription, localized.LanguageId);
                    }

                    Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.UpdateSuccess, FormUI.Post)));
                    if (!Url.IsLocalUrl(returnUrl) || returnUrl.Length <= 1 || !returnUrl.StartsWith("/") || returnUrl.StartsWith("//") || returnUrl.StartsWith("/\\"))
                    {
                        action = RedirectToAction("Index");
                    }
                    else
                    {
                        action = Redirect(returnUrl);
                    }
                }
                else
                {
                    ModelState.AddModelError("", "Mã sản phẩm đã tồn tại.");
                    action = View(model);
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", ex.Message);
                ExtentionUtils.Log(string.Concat("Post.Edit: ", ex.Message));

                return View(model);
            }

            return action;
        }

        [RequiredPermisson(Roles = "ViewPost")]
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
            IEnumerable<Post> posts = _postService.PagedList(sortingPagingBuilder, paging);
            if (posts != null && posts.Any())
            {
                Helper.PageInfo pageInfo = new Helper.PageInfo(ExtentionUtils.PageSize, page, paging.TotalRecord,
                    i => Url.Action("Index", new {page = i, keywords}));

                ViewBag.PageInfo = pageInfo;
            }

            return View(posts);
        }

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.RouteData.Values["action"].Equals("edit") || filterContext.RouteData.Values["action"].Equals("create"))
            {
                IEnumerable<Attribute> attributes = _attributeService.FindBy(x => x.Status == 1);
                if (attributes.IsAny())
                {
                    ViewBag.Attributes = attributes;
                }
            }
        }

        #region Post image gallery

        [HttpPost]
        public ActionResult PostGalleryAdd(int postId)
        {
            HttpFileCollectionBase files = Request.Files;
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
                                PostGallery postGallery = new PostGallery
                                {
                                    PostId = postId
                                };

                                string fileNameNonAccent = $"{item.FileName.NonAccent()}";
                                string folderName = $"{DateTime.UtcNow:ddMMyyyy}";

                                string fileExtension = Path.GetExtension(item.FileName);

                                string fileName1 = fileNameNonAccent.FileNameFormat(fileExtension);
                                string fileName2 = fileNameNonAccent.FileNameFormat(fileExtension);
                                string fileName3 = fileNameNonAccent.FileNameFormat(fileExtension);

                                _imagePlugin.CropAndResizeImage(item, $"{Contains.PostFolder}{folderName}/", fileName1, ImageSize.WithBigSize, ImageSize.HeightBigSize);
                                _imagePlugin.CropAndResizeImage(item, $"{Contains.PostFolder}{folderName}/", fileName2, ImageSize.WithMediumSize, ImageSize.HeightMediumSize);
                                _imagePlugin.CropAndResizeImage(item, $"{Contains.PostFolder}{folderName}/", fileName3, ImageSize.WithSmallSize, ImageSize.HeightSmallSize);

                                postGallery.ImageBigSize = $"{Contains.PostFolder}{folderName}/{fileName1}";
                                postGallery.ImageMediumSize = $"{Contains.PostFolder}{folderName}/{fileName2}";
                                postGallery.ImageSmallSize = $"{Contains.PostFolder}{folderName}/{fileName3}";

                                _postGalleryService.Create(postGallery);
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

            return Json(new { Result = true }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult PostGalleryEdit(PostGalleryViewModel model)
        {
            PostGallery postGallery = _postGalleryService.GetById(model.Id);

            if (postGallery != null)
            {
                model.ImageSmallSize = postGallery.ImageSmallSize;
                model.ImageBigSize = postGallery.ImageBigSize;
                model.ImageMediumSize = postGallery.ImageMediumSize;

                PostGallery postGalleryMap = Mapper.Map(model, postGallery);
                _postGalleryService.Update(postGalleryMap);
            }

            return Json(
                new
                {
                    succes = true
                }
                , JsonRequestBehavior.AllowGet);
        }

        public async Task<JsonResult> PostGalleryList(int postId)
        {
            IEnumerable<PostGallery> postGalleryList = _postGalleryService.GetByPostId(postId);

            IOrderedEnumerable<PostGallery> posts = await Task.FromResult(
                from x in postGalleryList
                orderby x.Id descending
                select x);

            JsonResult jsonResult = Json(new { data = posts }, JsonRequestBehavior.AllowGet);



            return jsonResult;
        }

        public ActionResult DeletePostGallery(int postId, int id)
        {
            ActionResult actionResult;

            if (!Request.IsAjaxRequest())
            {
                return Json(new { success = false });
            }
            try
            {
                PostGallery galleryImage = _postGalleryService.Get(x => x.PostId == postId && x.Id == id);

                _postGalleryService.Delete(galleryImage);

                string path1 = Server.MapPath(string.Concat("~/", galleryImage.ImageBigSize));
                string path2 = Server.MapPath(string.Concat("~/", galleryImage.ImageMediumSize));
                string path3 = Server.MapPath(string.Concat("~/", galleryImage.ImageSmallSize));

                System.IO.File.Delete(path1);
                System.IO.File.Delete(path2);
                System.IO.File.Delete(path3);

                actionResult = Json(new { success = true });
            }
            catch (Exception ex)
            {
                actionResult = Json(new { success = false, messages = ex.Message });
            }
            return actionResult;
        }

        #endregion
    }
}