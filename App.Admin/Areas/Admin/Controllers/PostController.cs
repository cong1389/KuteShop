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
using App.Domain.Common;
using App.Domain.Entities.Attribute;
using App.Domain.Entities.Data;
using App.FakeEntity.Gallery;
using App.FakeEntity.Post;
using App.Framework.Ultis;
using App.Service.Attribute;
using App.Service.Gallery;
using App.Service.GenericControl;
using App.Service.Language;
using App.Service.LocalizedProperty;
using App.Service.Manufacturers;
using App.Service.Menu;
using App.Service.Post;
using AutoMapper;
using Resources;

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

        private readonly IManufacturerService _manufacturerService;

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
            , ICacheManager cacheManager
            , IManufacturerService manufacturerService)
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
            _manufacturerService = manufacturerService;

            //Clear cache
            _cacheManager.RemoveByPattern(CachePostKey);
        }

        [RequiredPermisson(Roles = "CreatePost")]
        public ActionResult Create()
        {
            var model = new PostViewModel
            {
                OrderDisplay = 1,
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
                    var messages = String.Join(Environment.NewLine, ModelState.Values.SelectMany(v => v.Errors)
                                                          .Select(v => v.ErrorMessage + " " + v.Exception));
                    ModelState.AddModelError("", messages);
                    return View(model);
                }

                var titleNonAccent = model.Title.NonAccent();
                var bySeoUrl = _postService.GetListSeoUrl(titleNonAccent);

                model.SeoUrl = model.Title.NonAccent();
                if (bySeoUrl.Any(x => x.Id != model.Id))
                {
                    var postViewModel = model;
                    postViewModel.SeoUrl = string.Concat(postViewModel.SeoUrl, "-", bySeoUrl.Count());
                }

                var folderName = Utils.FolderName(model.Title);
                if (model.Image != null && model.Image.ContentLength > 0)
                {
                    var fileNameOriginal = Path.GetFileNameWithoutExtension(model.Image.FileName);
                    var fileExtension = Path.GetExtension(model.Image.FileName);

                    var fileName1 = fileNameOriginal.FileNameFormat(fileExtension);
                    var fileName2 = fileNameOriginal.FileNameFormat(fileExtension);
                    var fileName3 = fileNameOriginal.FileNameFormat(fileExtension);

                    _imagePlugin.CropAndResizeImage(model.Image, $"{Contains.PostFolder}{folderName}/", fileName1, ImageSize.WithBigSize, ImageSize.HeightBigSize, true);
                    _imagePlugin.CropAndResizeImage(model.Image, $"{Contains.PostFolder}{folderName}/", fileName2, ImageSize.WithMediumSize, ImageSize.HeightMediumSize, true);
                    _imagePlugin.CropAndResizeImage(model.Image, $"{Contains.PostFolder}{folderName}/", fileName3, ImageSize.WithSmallSize, ImageSize.HeightSmallSize, true);

                    model.ImageBigSize = $"{Contains.PostFolder}{folderName}/{fileName1}";
                    model.ImageMediumSize = $"{Contains.PostFolder}{folderName}/{fileName2}";
                    model.ImageSmallSize = $"{Contains.PostFolder}{folderName}/{fileName3}";
                }

                var menuId = model.MenuId;
                var i = 0;
                if (menuId.GetValueOrDefault() > i && menuId.HasValue)
                {
                    var menuLinkService = _menuLinkService;
                    menuId = model.MenuId;
                    var byId = menuLinkService.GetById(menuId.Value);
                    model.VirtualCatUrl = byId.VirtualSeoUrl;
                    model.VirtualCategoryId = byId.VirtualId;
                }

                //Gallery image
                var files = Request.Files;
                var galleryImages = new List<GalleryImage>();
                if (files.Count > 0)
                {
                    var count = files.Count - 1;
                    var num = 0;
                    var allKeys = files.AllKeys;
                    for (i = 0; i < allKeys.Length; i++)
                    {
                        var str7 = allKeys[i];
                        if (num <= count)
                        {
                            if (!str7.Equals("Image"))
                            {
                                var str8 = str7.Replace("[]", "");
                                var item = files[num];
                                if (item.ContentLength > 0)
                                {
                                    var item1 = Request[str8];
                                    var galleryImageViewModel = new GalleryImageViewModel
                                    {
                                        PostId = model.Id,
                                        AttributeValueId = int.Parse(str8)
                                    };

                                    var fileNameOriginal = Path.GetFileNameWithoutExtension(item.FileName);
                                    var fileExtension = Path.GetExtension(item.FileName);

                                    var fileName1 = $"attr.{ fileNameOriginal}".FileNameFormat(fileExtension);
                                    var fileName2 = $"attr.{ fileNameOriginal}".FileNameFormat(fileExtension);

                                    _imagePlugin.CropAndResizeImage(item, $"{Contains.PostFolder}{folderName}/", fileName1, ImageSize.WithBigSize, ImageSize.HeightBigSize, true);
                                    _imagePlugin.CropAndResizeImage(item, $"{Contains.PostFolder}{folderName}/", fileName2, ImageSize.WithThumbnailSize, ImageSize.HeightThumbnailSize, true);

                                    galleryImageViewModel.ImageBig = $"{Contains.PostFolder}{folderName}/{fileName1}";
                                    galleryImageViewModel.ImageThumbnail = $"{Contains.PostFolder}{folderName}/{fileName2}";

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
                var attributeValues = new List<AttributeValue>();
                var item2 = Request["Values"];
                if (!string.IsNullOrEmpty(item2))
                {
                    foreach (var list in item2.Split(',').ToList())
                    {
                        var num1 = int.Parse(list);
                        attributeValues.Add(_attributeValueService.GetById(num1));
                    }
                }

                var modelMap = Mapper.Map<PostViewModel, Post>(model);
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
                    var posts = new List<Post>();
                    var galleryImages = new List<GalleryImage>();
                    var strArrays = ids;
                    for (var i = 0; i < strArrays.Length; i++)
                    {
                        var num = int.Parse(strArrays[i]);
                        var post = _postService.Get(x => x.Id == num);
                        galleryImages.AddRange(post.GalleryImages.ToList());
                        post.AttributeValues.ToList().ForEach(att => post.AttributeValues.Remove(att));
                        posts.Add(post);
                    }

                    _galleryService.BatchDelete(galleryImages);
                    _postService.BatchDelete(posts);

                    //Delete localize
                    for (var i = 0; i < ids.Length; i++)
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
                var galleryImage = _galleryService.Get(x => x.PostId == postId && x.Id == galleryId);
                _galleryService.Delete(galleryImage);

                var path1 = Server.MapPath(string.Concat("~/", galleryImage.ImageBig));
                var path2 = Server.MapPath(string.Concat("~/", galleryImage.ImageThumbnail));

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

        [RequiredPermisson(Roles = "EditPost")]
        public ActionResult Edit(int id)
        {
            var byId = _postService.GetById(id);

            var modelMap = Mapper.Map<Post, PostViewModel>(byId);

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
        [RequiredPermisson(Roles = "EditPost")]
        [ValidateInput(false)]
        public ActionResult Edit(PostViewModel model, string returnUrl)
        {
            ActionResult action;
            try
            {
                if (!ModelState.IsValid)
                {
                    var messages = String.Join(Environment.NewLine, ModelState.Values.SelectMany(v => v.Errors)
                                                          .Select(v => v.ErrorMessage + " " + v.Exception));
                    ModelState.AddModelError("", messages);
                    return View(model);
                }

                if (!_postService.FindBy(x => x.ProductCode.Equals(model.ProductCode) && x.Id != model.Id, true).IsAny())
                {
                    var byId = _postService.GetById(model.Id, false);

                    var titleNonAccent = model.Title.NonAccent();
                    var bySeoUrl = _menuLinkService.GetListSeoUrl(titleNonAccent, false);

                    model.SeoUrl = model.Title.NonAccent();
                    if (bySeoUrl.Any(x => x.Id != model.Id))
                    {
                        var postViewModel = model;
                        postViewModel.SeoUrl = string.Concat(postViewModel.SeoUrl, "-", bySeoUrl.Count());
                    }

                    var folderName = Utils.FolderName(model.Title);
                    if (model.Image != null && model.Image.ContentLength > 0)
                    {
                        var fileNameOriginal = Path.GetFileNameWithoutExtension(model.Image.FileName);
                        var fileExtension = Path.GetExtension(model.Image.FileName);

                        var fileName1 = fileNameOriginal.FileNameFormat(fileExtension);
                        var fileName2 = fileNameOriginal.FileNameFormat(fileExtension);
                        var fileName3 = fileNameOriginal.FileNameFormat(fileExtension);

                        _imagePlugin.CropAndResizeImage(model.Image, $"{Contains.PostFolder}{folderName}/", fileName1, ImageSize.WithBigSize, ImageSize.HeightBigSize, true);
                        _imagePlugin.CropAndResizeImage(model.Image, $"{Contains.PostFolder}{folderName}/", fileName2, ImageSize.WithMediumSize, ImageSize.HeightMediumSize, true);
                        _imagePlugin.CropAndResizeImage(model.Image, $"{Contains.PostFolder}{folderName}/", fileName3, ImageSize.WithSmallSize, ImageSize.HeightSmallSize, true);

                        model.ImageBigSize = $"{Contains.PostFolder}{folderName}/{fileName1}";
                        model.ImageMediumSize = $"{Contains.PostFolder}{folderName}/{fileName2}";
                        model.ImageSmallSize = $"{Contains.PostFolder}{folderName}/{fileName3}";
                    }
                    var menuId = model.MenuId;
                    var i = 0;
                    if (menuId.GetValueOrDefault() > i && menuId.HasValue)
                    {
                        var menuLinkService = _menuLinkService;
                        menuId = model.MenuId;
                        var menuLink = menuLinkService.GetById(menuId.Value, false);
                        model.VirtualCatUrl = menuLink.VirtualSeoUrl;
                        model.VirtualCategoryId = menuLink.VirtualId;
                    }

                    //GalleryImage
                    var files = Request.Files;
                    var lstGalleryImages = new List<GalleryImage>();
                    if (files.Count > 0)
                    {
                        var count = files.Count - 1;
                        var num = 0;

                        var allKeys = files.AllKeys;
                        for (i = 0; i < allKeys.Length; i++)
                        {
                            var str7 = allKeys[i];
                            if (num <= count)
                            {
                                if (!str7.Equals("Image"))
                                {
                                    var str8 = str7.Replace("[]", "");
                                    var item = files[num];
                                    if (item.ContentLength > 0)
                                    {
                                        var item1 = Request[str8];
                                        var galleryImageViewModel = new GalleryImageViewModel
                                        {
                                            PostId = model.Id,
                                            AttributeValueId = int.Parse(str8)
                                        };

                                        var fileNameOrginal = Path.GetFileNameWithoutExtension(item.FileName);
                                        var fileExtension = Path.GetExtension(item.FileName);

                                        var fileName1 = $"attr.{ fileNameOrginal}".FileNameFormat(fileExtension);
                                        var fileName2 = $"attr.{ fileNameOrginal}".FileNameFormat(fileExtension);

                                        _imagePlugin.CropAndResizeImage(item, $"{Contains.PostFolder}{folderName}/", fileName1, ImageSize.WithBigSize, ImageSize.WithBigSize, true);
                                        _imagePlugin.CropAndResizeImage(item, $"{Contains.PostFolder}{folderName}/", fileName2, ImageSize.WithThumbnailSize, ImageSize.HeightThumbnailSize, true);

                                        galleryImageViewModel.ImageBig = $"{Contains.PostFolder}{folderName}/{fileName1}";
                                        galleryImageViewModel.ImageThumbnail = $"{Contains.PostFolder}{folderName}/{fileName2}";


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
                    var lstAttributeValues = new List<AttributeValue>();
                    var nums = new List<int>();
                    var item2 = Request["Values"];
                    if (!string.IsNullOrEmpty(item2))
                    {
                        foreach (var list in item2.Split(',').ToList())
                        {
                            var num1 = int.Parse(list);
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

                    var modelMap = Mapper.Map(model, byId);
                    _postService.Update(byId);

                    //Update GalleryImage
                    if (lstAttributeValues.IsAny())
                    {
                        foreach (var attributeValue in lstAttributeValues)
                        {
                            var nullable = _galleryService.Get(x => x.AttributeValueId == attributeValue.Id && x.PostId == model.Id);
                            if (nullable == null)
                            {
                                continue;
                            }
                            var request = Request;
                            i = attributeValue.Id;
                            var num2 = decimal.Parse(request[i.ToString()]);
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
            var posts = _postService.PagedList(sortingPagingBuilder, paging);
            if (posts != null && posts.IsAny())
            {
                var pageInfo = new Helper.PageInfo(ExtentionUtils.PageSize, page, paging.TotalRecord,
                    i => Url.Action("Index", new { page = i, keywords }));

                ViewBag.PageInfo = pageInfo;
            }

            return View(posts);
        }

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.RouteData.Values["action"].Equals("edit") || filterContext.RouteData.Values["action"].Equals("create"))
            {
                var manufacturers = _manufacturerService.FindBy(x => x.Status == 1);
                if (manufacturers.IsAny())
                {
                    ViewBag.Manufacturers = manufacturers;
                }

                var attributes = _attributeService.FindBy(x => x.Status == 1);
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
            var byId = _postService.GetById(postId, false);
            var titleOriginal = byId.Title;

            var files = Request.Files;
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
                                var postGallery = new PostGallery
                                {
                                    PostId = postId,
                                    Status = (int)Status.Enable
                                };

                                var folderName = Utils.FolderName(titleOriginal);
                                var fileExtension = Path.GetExtension(item.FileName);

                                var fileName1 = $"slide.{ titleOriginal}".FileNameFormat(fileExtension);
                                var fileName2 = $"slide.{ titleOriginal}".FileNameFormat(fileExtension);
                                var fileName3 = $"slide.{ titleOriginal}".FileNameFormat(fileExtension);

                                _imagePlugin.CropAndResizeImage(item, $"{Contains.PostFolder}{folderName}/", fileName1, ImageSize.WithBigSize, ImageSize.HeightBigSize, true);
                                _imagePlugin.CropAndResizeImage(item, $"{Contains.PostFolder}{folderName}/", fileName2, ImageSize.WithMediumSize, ImageSize.HeightMediumSize, true);
                                _imagePlugin.CropAndResizeImage(item, $"{Contains.PostFolder}{folderName}/", fileName3, ImageSize.WithSmallSize, ImageSize.HeightSmallSize, true);

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

            return Json(new { success = true }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult PostGalleryEdit(PostGalleryViewModel model)
        {
            var postGallery = _postGalleryService.GetById(model.Id);

            if (postGallery != null)
            {
                model.ImageSmallSize = postGallery.ImageSmallSize;
                model.ImageBigSize = postGallery.ImageBigSize;
                model.ImageMediumSize = postGallery.ImageMediumSize;

                var postGalleryMap = Mapper.Map(model, postGallery);
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
            var postGalleryList = _postGalleryService.GetByPostId(postId);

            var posts = await Task.FromResult(
                from x in postGalleryList
                orderby x.Id descending
                select x);

            var jsonResult = Json(new { data = posts }, JsonRequestBehavior.AllowGet);



            return jsonResult;
        }

        public ActionResult DeletePostGallery(int postId, int id)
        {
            if (!Request.IsAjaxRequest())
            {
                return Json(new { success = false });
            }

            ActionResult actionResult;
            try
            {
                var postGallery = _postGalleryService.Get(x => x.PostId == postId && x.Id == id);
                _postGalleryService.Delete(postGallery);

                var path1 = Server.MapPath(string.Concat("~/", postGallery.ImageBigSize));
                var path2 = Server.MapPath(string.Concat("~/", postGallery.ImageMediumSize));
                var path3 = Server.MapPath(string.Concat("~/", postGallery.ImageSmallSize));

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

        public ActionResult PostGalleryChangeStatus(int postId, int id)
        {
            if (!Request.IsAjaxRequest())
            {
                return Json(new { success = false });
            }

            ActionResult actionResult;
            try
            {
                var postGallery = _postGalleryService.Get(x => x.PostId == postId && x.Id == id);
                var oldStatus = postGallery.Status;
                postGallery.Status = oldStatus == (int)Status.Enable ? (int)Status.Disable : (int)Status.Enable;

                _postGalleryService.Update(postGallery);
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