using System;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using App.Admin.Helpers;
using App.Aplication;
using App.Core.Caching;
using App.Core.Utils;
using App.Domain.Entities.Data;
using App.Domain.Entities.Menu;
using App.FakeEntity.Menu;
using App.FakeEntity.Static;
using App.Framework.Ultis;
using App.Service.Language;
using App.Service.LocalizedProperty;
using App.Service.Menu;
using App.Service.Static;
using AutoMapper;
using Resources;
using static System.String;

namespace App.Admin.Controllers
{
    public class StaticContentController : BaseAdminController
    {
        private const string CacheStaticcontentKey = "db.StaticContent";
        private readonly ICacheManager _cacheManager;

        private readonly IMenuLinkService _menuLinkService;

        private readonly IStaticContentService _staticContentService;

        private readonly ILanguageService _languageService;

        private readonly ILocalizedPropertyService _localizedPropertyService;
        private readonly IImagePlugin _imagePlugin;

        public StaticContentController(
            IStaticContentService staticContentService
            , IMenuLinkService menuLinkService
            , ILanguageService languageService
            , ILocalizedPropertyService localizedPropertyService
            , ICacheManager cacheManager, IImagePlugin imagePlugin)
        {
            _staticContentService = staticContentService;
            _menuLinkService = menuLinkService;
            _languageService = languageService;
            _localizedPropertyService = localizedPropertyService;
            _cacheManager = cacheManager;
            _imagePlugin = imagePlugin;

            //Clear cache
            _cacheManager.RemoveByPattern(CacheStaticcontentKey);
        }

        [RequiredPermisson(Roles = "CreateEditStaticContent")]
        public ActionResult Create()
        {
            var model = new StaticContentViewModel
            {
                Status = 1
            };

            //Add locales to model
            AddLocales(_languageService, model.Locales);

            return View(model);
        }

        [HttpPost]
        [RequiredPermisson(Roles = "CreateEditStaticContent")]
        public ActionResult Create(StaticContentViewModel model, string returnUrl)
        {
            ActionResult action;
            try
            {
                if (!ModelState.IsValid)
                {
                    var messages = Join(Environment.NewLine, ModelState.Values.SelectMany(v => v.Errors)
                                                           .Select(v => v.ErrorMessage + " " + v.Exception));
                    ModelState.AddModelError("", messages);
                    return View(model);
                }

                var titleNonAccent = model.Title.NonAccent();
                var bySeoUrl = _staticContentService.GetBySeoUrl(titleNonAccent, false);
                model.SeoUrl = model.Title.NonAccent();

                if (bySeoUrl.Any(x => x.Id != model.Id))
                {
                    var staticContentViewModel = model;
                    staticContentViewModel.SeoUrl = Concat(staticContentViewModel.SeoUrl, "-", bySeoUrl.Count());
                }

                if (model.Image != null && model.Image.ContentLength > 0)
                {
                    var folderName = Utils.FolderName(model.Title);
                    var fileExtension = Path.GetExtension(model.Image.FileName);
                    var fileNameOriginal = Path.GetFileNameWithoutExtension(model.Image.FileName);

                    var fileName = fileNameOriginal.FileNameFormat(fileExtension);

                    _imagePlugin.CropAndResizeImage(model.Image, $"{Contains.StaticContentFolder}{folderName}/", fileName, ImageSize.StaticContentWithBigSize, ImageSize.StaticContentHeightBigSize, true);

                    model.ImagePath = $"{Contains.StaticContentFolder}{folderName}/{fileName}";

                    //var fileName = Path.GetFileName(model.Image.FileName);
                    //var extension = Path.GetExtension(model.Image.FileName);
                    //fileName = fileName.FileNameFormat(extension);

                    //var str = Path.Combine(Server.MapPath(Concat("~/", Contains.StaticContentFolder)), fileName);

                    //model.Image.SaveAs(str);
                    //model.ImagePath = Concat(Contains.StaticContentFolder, fileName);
                }

                if (model.MenuId > 0)
                {
                    var menuLink = _menuLinkService.GetById(model.MenuId, false);
                    model.MenuLink = Mapper.Map<MenuLink, MenuLinkViewModel>(menuLink);
                    model.VirtualCategoryId = menuLink.VirtualId;
                }

                var modelMap = Mapper.Map<StaticContentViewModel, StaticContent>(model);
                _staticContentService.Create(modelMap);

                //Update Localized   
                foreach (var localized in model.Locales)
                {
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.Title, localized.Title, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.ShortDesc, localized.ShortDesc, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.Description, localized.Description, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.SeoUrl, localized.Title.NonAccent(), localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MetaTitle, localized.MetaTitle, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MetaKeywords, localized.MetaKeywords, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MetaDescription, localized.MetaDescription, localized.LanguageId);
                }

                Response.Cookies.Add(new HttpCookie("system_message", Format(MessageUI.CreateSuccess, FormUI.StaticContent)));
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
                ExtentionUtils.Log(Concat("StaticContent.Create: ", ex.Message));
                ModelState.AddModelError("", ex.Message);

                return View(model);
            }
            return action;
        }

        [RequiredPermisson(Roles = "DeleteStaticContent")]
        public ActionResult Delete(string[] ids)
        {
            try
            {
                if (ids.Length != 0)
                {
                    var staticContents =
                        from id in ids
                        select _staticContentService.GetById(int.Parse(id));
                    _staticContentService.BatchDelete(staticContents);

                    ////Check and delete logo exists
                    //string str1 = string.Format("{0}", item.FileName.NonAccent());
                    //if (System.IO.File.Exists(str))
                    //    System.IO.File.Delete(str);

                    //Delete localize
                    for (var i = 0; i < ids.Length; i++)
                    {
                        var ieLocalizedProperty
                           = _localizedPropertyService.GetByEntityId(int.Parse(ids[i]));
                        _localizedPropertyService.BatchDelete(ieLocalizedProperty);
                    }
                }
            }
            catch (Exception ex)
            {
                ExtentionUtils.Log(Concat("StaticContent.Delete: ", ex.Message));
            }

            return RedirectToAction("Index");
        }

        [RequiredPermisson(Roles = "CreateEditStaticContent")]
        public ActionResult Edit(int id)
        {
            var modelMap = Mapper.Map<StaticContent, StaticContentViewModel>(_staticContentService.GetById(id));

            //Add Locales to model
            AddLocales(_languageService, modelMap.Locales, (locale, languageId) =>
            {
                locale.Id = modelMap.Id;
                locale.LocalesId = modelMap.Id;
                locale.Title = modelMap.GetLocalized(x => x.Title, id, languageId, false, false);
                locale.ShortDesc = modelMap.GetLocalized(x => x.ShortDesc, id, languageId, false, false);
                locale.Description = modelMap.GetLocalized(x => x.Description, id, languageId, false, false);
                locale.MetaTitle = modelMap.GetLocalized(x => x.MetaTitle, id, languageId, false, false);
                locale.MetaKeywords = modelMap.GetLocalized(x => x.MetaKeywords, id, languageId, false, false);
                locale.MetaDescription = modelMap.GetLocalized(x => x.MetaDescription, id, languageId, false, false);
                locale.SeoUrl = modelMap.GetLocalized(x => x.SeoUrl, id, languageId, false, false);
            });

            return View(modelMap);
        }

        [HttpPost]
        [RequiredPermisson(Roles = "CreateEditStaticContent")]
        public ActionResult Edit(StaticContentViewModel model, string returnUrl)
        {
            ActionResult action;
            try
            {
                if (!ModelState.IsValid)
                {
                    ModelState.AddModelError("", MessageUI.ErrorMessage);
                    return View(model);
                }

                var byId = _staticContentService.GetById(model.Id, false);

                var titleNonAccent = model.Title.NonAccent();
                var bySeoUrl = _menuLinkService.GetListSeoUrl(titleNonAccent, false);
                model.SeoUrl = titleNonAccent;

                if (bySeoUrl.Any(x => x.Id != model.Id))
                {
                    var staticContentViewModel = model;
                    staticContentViewModel.SeoUrl = Concat(staticContentViewModel.SeoUrl, "-", bySeoUrl.Count());
                }
                if (model.Image != null && model.Image.ContentLength > 0)
                {
                    var folderName = Utils.FolderName(model.Title);
                    var fileExtension = Path.GetExtension(model.Image.FileName);
                    var fileNameOriginal = Path.GetFileNameWithoutExtension(model.Image.FileName);

                    var fileName = fileNameOriginal.FileNameFormat(fileExtension);

                    _imagePlugin.CropAndResizeImage(model.Image, $"{Contains.StaticContentFolder}{folderName}/", fileName, ImageSize.StaticContentWithBigSize, ImageSize.StaticContentHeightBigSize, true);

                    model.ImagePath = $"{Contains.StaticContentFolder}{folderName}/{fileName}";

                    //var extension = Path.GetExtension(model.Image.FileName);
                    //var fileName = titleNonAccent.FileNameFormat(extension);

                    //model.Image.SaveAs(Path.Combine(Server.MapPath(Concat("~/", Contains.StaticContentFolder)), fileName));
                    //model.ImagePath = Concat(Contains.StaticContentFolder, fileName);
                }

                if (model.MenuId > 0)
                {
                    var menuLink = _menuLinkService.GetById(model.MenuId, false);
                    model.MenuLink = Mapper.Map<MenuLink, MenuLinkViewModel>(menuLink);
                    model.VirtualCategoryId = menuLink.VirtualId;
                }

                var modelMap = Mapper.Map(model, byId);
                _staticContentService.Update(modelMap);

                //Update Localized   
                foreach (var localized in model.Locales)
                {
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.Title, localized.Title, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.ShortDesc, localized.ShortDesc, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.Description, localized.Description, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.SeoUrl, localized.Title.NonAccent(), localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MetaTitle, localized.MetaTitle, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MetaKeywords, localized.MetaKeywords, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MetaDescription, localized.MetaDescription, localized.LanguageId);
                }

                Response.Cookies.Add(new HttpCookie("system_message", Format(MessageUI.UpdateSuccess, FormUI.StaticContent)));
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
                ModelState.AddModelError("", ex.Message);
                ExtentionUtils.Log(Concat("StaticContent.Edit: ", ex.Message));

                return View(model);
            }

            return action;
        }

        [RequiredPermisson(Roles = "ViewStaticContent")]
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
            var staticContents = _staticContentService.PagedList(sortingPagingBuilder, paging);
            if (staticContents.IsAny())
            {
                var pageInfo = new Helper.PageInfo(ExtentionUtils.PageSize, page, paging.TotalRecord, i => Url.Action("Index", new { page = i, keywords }));
                ViewBag.PageInfo = pageInfo;
            }
            return View(staticContents);
        }

        protected override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            if (filterContext.RouteData.Values["action"].Equals("create") || filterContext.RouteData.Values["action"].Equals("edit"))
            {
                var menuLinks = _menuLinkService.FindBy(x => x.Status == 1 && x.TemplateType == 5 || x.TemplateType == 6);
                ViewBag.MenuList = menuLinks;
            }
        }
    }
}