using App.Admin.Helpers;
using App.Core.Caching;
using App.Core.Extensions;
using App.Core.Infrastructure;
using App.Domain.Menus;
using App.FakeEntity.Menus;
using App.Framework.Utilities;
using App.Service.Languages;
using App.Service.Media;
using App.Service.Menus;
using App.Service.Settings;
using AutoMapper;
using Resources;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using App.Core.Logging;
using App.Core.Utilities;

namespace App.Admin.Controllers
{
    public class MenuController : BaseAdminController
    {
        private const string CacheMenuKey = "db.MenuLink";

        private readonly IMenuLinkService _menuLinkService;

        private readonly ILocalizedPropertyService _localizedPropertyService;

        private readonly ILanguageService _languageService;
        private readonly IImageService _imageService;
        private readonly ISettingService _settingService;

        private readonly IPositionMenuLinkService _positionMenuLink;

        public MenuController(IMenuLinkService menuLinkService, ILocalizedPropertyService localizedPropertyService
            , ILanguageService languageService
           , ICacheManager cacheManager
            , IImageService imageService, ISettingService settingService
            , IPositionMenuLinkService positionMenuLink)
        {
            _menuLinkService = menuLinkService;
            _localizedPropertyService = localizedPropertyService;
            _languageService = languageService;
            _imageService = imageService;
            _settingService = settingService;
            _positionMenuLink = positionMenuLink;

            //Clear cache
            cacheManager.RemoveByPattern(CacheMenuKey);
        }

        [RequiredPermisson(Roles = "CreateEditMenu")]
        public ActionResult Create()
        {
            var model = new MenuLinkViewModel
            {
                OrderDisplay = 1,
                Status = 1
            };

            //Add locales to model
            AddLocales(_languageService, model.Locales);

            return View(model);
        }

        [HttpPost]
        [RequiredPermisson(Roles = "CreateEditMenu")]
        public ActionResult Create(MenuLinkViewModel model, string returnUrl)
        {
            ActionResult action;
            try
            {
                if (!ModelState.IsValid)
                {
                    var messages = string.Join(Environment.NewLine, ModelState.Values.SelectMany(v => v.Errors)
                                                            .Select(v => v.ErrorMessage + " " + v.Exception));
                    ModelState.AddModelError("", messages);
                    return View(model);
                }

                var menuName = model.MenuName.NonAccent();
                var menuExsist = _menuLinkService.GetListSeoUrl(menuName);
                model.SeoUrl = model.MenuName.NonAccent();

                if (menuExsist.Any(x => x.Id != model.Id))
                {
                    var menuLinkViewModel = model;
                    var seoUrl = menuLinkViewModel.SeoUrl;
                    var num = menuExsist.Count();
                    menuLinkViewModel.SeoUrl = string.Concat(seoUrl, "-", num.ToString());
                }

                ImageHandler(model);

                var guid = Guid.NewGuid().ToString();
                if (model.ParentId.HasValue)
                {
                    model.CurrentVirtualId = guid;
                    var byId = _menuLinkService.GetMenu(model.ParentId.Value);
                    model.VirtualId = $"{byId.VirtualId}/{guid}";
                    model.VirtualSeoUrl = $"{byId.SeoUrl}/{model.SeoUrl}";
                }
                else
                {
                    model.VirtualId = guid;
                    model.CurrentVirtualId = guid;
                }

                var modelMap = Mapper.Map<MenuLinkViewModel, MenuLink>(model);
                _menuLinkService.Create(modelMap);

                //Update Localized   
                foreach (var localized in model.Locales)
                {
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MenuName, localized.MenuName, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.SeoUrl, localized.MenuName.NonAccent(), localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MetaTitle, localized.MetaTitle, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MetaKeywords, localized.MetaKeywords, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MetaDescription, localized.MetaDescription, localized.LanguageId);
                }

                Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.CreateSuccess, FormUI.MenuLink)));
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
                LogText.Log(string.Concat("MenuLink.Create: ", ex.Message));

                return View(model);
            }
            return action;
        }

        private void ImageHandler(MenuLinkViewModel model)
        {
            var isPng = _settingService.GetSetting("Menu.pngFormat", 0);
            var folderName = CommonHelper.FolderName(model.MenuName);
            if (model.ImageBigSizeFile != null && model.ImageBigSizeFile.ContentLength > 0)
            {
                var fileName = Path.GetFileNameWithoutExtension(model.ImageBigSizeFile.FileName);
                var fileExtension = Path.GetExtension(model.ImageBigSizeFile.FileName);
                var fileNameFormat = fileName.FileNameFormat(fileExtension);

                var sizeWidthBg = _settingService.GetSetting("Menu.WidthBigSize", ImageSize.WidthDefaultSize);
                var sizeHeighthBg = _settingService.GetSetting("Menu.HeightBigSize", ImageSize.HeightDefaultSize);


                _imageService.CropAndResizeImage(model.ImageBigSizeFile, $"{Constant.MenuFolder}{folderName}/", fileNameFormat,
                    sizeWidthBg, sizeHeighthBg, isPng != 0);
                model.ImageBigSize = $"{Constant.MenuFolder}{folderName}/{fileNameFormat}";
            }

            if (model.ImageMediumSizeFile != null && model.ImageMediumSizeFile.ContentLength > 0)
            {
                var fileName = Path.GetFileNameWithoutExtension(model.ImageMediumSizeFile.FileName);
                var fileExtension = Path.GetExtension(model.ImageMediumSizeFile.FileName);
                var fileNameFormat = fileName.FileNameFormat(fileExtension);

                var sizeWidthMd = _settingService.GetSetting("Menu.WidthMediumSize", ImageSize.WidthDefaultSize);
                var sizeHeighthMd = _settingService.GetSetting("Menu.HeightMediumSize", ImageSize.HeightDefaultSize);

                _imageService.CropAndResizeImage(model.ImageMediumSizeFile, $"{Constant.MenuFolder}{folderName}/", fileNameFormat, sizeWidthMd, sizeHeighthMd, isPng != 0);
                model.ImageMediumSize = $"{Constant.MenuFolder}{folderName}/{fileNameFormat}";
            }

            if (model.ImageSmallSizeFile != null && model.ImageSmallSizeFile.ContentLength > 0)
            {
                var fileName = Path.GetFileNameWithoutExtension(model.ImageSmallSizeFile.FileName);
                var fileExtension = Path.GetExtension(model.ImageSmallSizeFile.FileName);
                var fileNameFormat = fileName.FileNameFormat(fileExtension);

                var sizeWidthSm = _settingService.GetSetting("Menu.WidthSmallSize", ImageSize.WidthDefaultSize);
                var sizeHeighthSm = _settingService.GetSetting("Menu.HeightSmallSize", ImageSize.HeightDefaultSize);

                _imageService.CropAndResizeImage(model.ImageSmallSizeFile, $"{Constant.MenuFolder}{folderName}/", fileNameFormat,
                    sizeWidthSm, sizeHeighthSm, isPng != 0);
                model.ImageSmallSize = $"{Constant.MenuFolder}{folderName}/{fileNameFormat}";
            }
        }

        [RequiredPermisson(Roles = "DeleteMenu")]
        public ActionResult Delete(string[] ids)
        {
            try
            {
                if (ids.Length != 0)
                {
                    var menuLinks =
                        from id in ids
                        select _menuLinkService.GetMenu(int.Parse(id));

                    _menuLinkService.BatchDelete(menuLinks);

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
                LogText.Log(string.Concat("MenuLink.Delete: ", ex.Message));
                ModelState.AddModelError("", ex.Message);

            }
            return RedirectToAction("Index");
        }


        [RequiredPermisson(Roles = "DeleteMenu")]
        public ActionResult DeleteOne(int id)
        {
            try
            {
                var menuLink = _menuLinkService.GetMenu(id);

                _menuLinkService.Delete(menuLink);
            }
            catch (Exception ex)
            {
                LogText.Log(string.Concat("MenuLink.DeleteById: ", ex.Message));

                Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.ErrorMessageWithFormat, ex.Message)));

            }
            return RedirectToAction("Index");
        }

        [RequiredPermisson(Roles = "CreateEditMenu")]
        public ActionResult Edit(int id)
        {
            var modelMap = Mapper.Map<MenuLink, MenuLinkViewModel>(_menuLinkService.GetMenu(id));

            //Add Locales to model
            AddLocales(_languageService, modelMap.Locales, (locale, languageId) =>
            {
                locale.Id = modelMap.Id;
                locale.LocalesId = modelMap.Id;
                locale.MenuName = modelMap.GetLocalized(x => x.MenuName, id, languageId, false, false);
                locale.MetaTitle = modelMap.GetLocalized(x => x.MetaTitle, id, languageId, false, false);
                locale.MetaKeywords = modelMap.GetLocalized(x => x.MetaKeywords, id, languageId, false, false);
                locale.MetaDescription = modelMap.GetLocalized(x => x.MetaDescription, id, languageId, false, false);
                locale.SeoUrl = modelMap.GetLocalized(x => x.SeoUrl, id, languageId, false, false);
            });

            return View(modelMap);
        }

        [HttpPost]
        [RequiredPermisson(Roles = "CreateEditMenu")]
        public ActionResult Edit(MenuLinkViewModel model, string returnUrl)
        {
            ActionResult action;
            try
            {
                if (!ModelState.IsValid)
                {
                    var messages = string.Join(Environment.NewLine, ModelState.Values.SelectMany(v => v.Errors)
                                                             .Select(v => v.ErrorMessage + " " + v.Exception));
                    ModelState.AddModelError("", messages);

                    return View(model);
                }

                var menuExsist = _menuLinkService.GetMenu(model.Id);
                var menuName = model.MenuName.NonAccent();

                var bySeoUrl = _menuLinkService.GetListSeoUrl(menuName);
                model.SeoUrl = model.MenuName.NonAccent();
                if (bySeoUrl.Any(x => x.Id != model.Id))
                {
                    var menuLinkViewModel = model;
                    var seoUrl = menuLinkViewModel.SeoUrl;
                    var num = bySeoUrl.Count();
                    menuLinkViewModel.SeoUrl = string.Concat(seoUrl, "-", num.ToString());
                }

                ImageHandler(model);

                var parentId = model.ParentId;
                if (!parentId.HasValue)
                {
                    model.ParentId = null;
                    model.VirtualId = menuExsist.CurrentVirtualId;
                    model.VirtualSeoUrl = null;
                }
                else
                {
                    var byId1 = _menuLinkService.GetMenu(parentId.Value);
                    model.VirtualId = $"{byId1.VirtualId}/{menuExsist.CurrentVirtualId}";
                    model.VirtualSeoUrl = $"{byId1.SeoUrl}/{model.SeoUrl}";
                }

                //Get PositionMenuLink selected
                var positionMenuLinks = new List<Domain.Menus.PositionMenuLink>();
                var positionIds = new List<int>();

                var position = Request["Position"];
                if (!string.IsNullOrEmpty(position))
                {
                    foreach (var item in position.Split(',').ToList())
                    {
                        var positionId = int.Parse(item);
                        positionIds.Add(positionId);

                        positionMenuLinks.Add(_positionMenuLink.GetById(positionId, false));
                    }

                    if (positionIds.IsAny())
                    {
                        (from x in menuExsist.PositionMenuLinks
                         where !positionIds.Contains(x.Id)
                         select x).ToList()
                            .ForEach(m =>
                                menuExsist.PositionMenuLinks.Remove(m)
                            );
                    }
                }

                menuExsist.PositionMenuLinks = positionMenuLinks;

                var modelMap = Mapper.Map(model, menuExsist);
                _menuLinkService.Update(menuExsist);

                //Update Localized   
                foreach (var localized in model.Locales)
                {
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MenuName, localized.MenuName, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.SeoUrl, localized.MenuName.NonAccent(), localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MetaTitle, localized.MetaTitle, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MetaKeywords, localized.MetaKeywords, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MetaDescription, localized.MetaDescription, localized.LanguageId);
                }

                Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.UpdateSuccess, FormUI.MenuLink)));
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
                LogText.Log(string.Concat("MenuLink.Create: ", ex.Message));

                return View(model);
            }

            return action;
        }

        [RequiredPermisson(Roles = "ViewMenu")]
        public ActionResult Index(int page = 1, string keywords = "")
        {
            var lstMenuNav = new List<MenuNavViewModel>();

            var menuLinks = _menuLinkService.GetAll();
            if (menuLinks.Any())
            {
                var menuNav =
                    from x in menuLinks
                    select new MenuNavViewModel
                    {
                        MenuId = x.Id,
                        ParentId = x.ParentId,
                        MenuName = x.MenuName,
                        SeoUrl = x.SeoUrl,
                        OrderDisplay = x.OrderDisplay,
                        ImageBigSize = x.ImageBigSize,
                        CurrentVirtualId = x.CurrentVirtualId,
                        VirtualId = x.VirtualId,
                        TemplateType = x.TemplateType,
                        ImageMediumSize = x.ImageMediumSize,
                        ImageSmallSize = x.ImageSmallSize
                    };
                lstMenuNav = CreateMenuNav(null, menuNav);
            }

            return View(lstMenuNav);
        }

        private List<MenuNavViewModel> CreateMenuNav(int? parentId, IEnumerable<MenuNavViewModel> source)
        {
            var ieMenuNavViewModel = (from x in source
                                      orderby x.OrderDisplay
                                      select x).Where(x =>
                                      {
                                          var nullable1 = x.ParentId;
                                          var nullable = parentId;
                                          if (nullable1.GetValueOrDefault() != nullable.GetValueOrDefault())
                                          {
                                              return false;
                                          }
                                          return nullable1.HasValue == nullable.HasValue;
                                      }).Select(x => new MenuNavViewModel
                                      {
                                          MenuId = x.MenuId,
                                          ParentId = x.ParentId,
                                          MenuName = x.MenuName,
                                          SeoUrl = x.SeoUrl,
                                          OrderDisplay = x.OrderDisplay,
                                          ImageBigSize = x.ImageBigSize,
                                          CurrentVirtualId = x.CurrentVirtualId,
                                          VirtualId = x.VirtualId,
                                          TemplateType = x.TemplateType,
                                          OtherLink = x.OtherLink,
                                          ImageMediumSize = x.ImageMediumSize,
                                          ImageSmallSize = x.ImageSmallSize,
                                          ChildNavMenu = CreateMenuNav(x.MenuId, source)
                                      }).ToList();

            return ieMenuNavViewModel;
        }

        protected override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            if (filterContext.RouteData.Values["action"].Equals("create"))
            {
                ViewBag.MenuList = _menuLinkService.GetAll();

                var positionMenuLinks = _positionMenuLink.GetAll();

                ViewBag.PositionMenu = from x in positionMenuLinks
                                       select new PositionMenuLinkViewModel
                                       {
                                           Id = x.Id,
                                           Name = x.Name
                                       };
            }

            if (filterContext.RouteData.Values["action"].Equals("edit"))
            {
                var menuLinks = _menuLinkService.GetAll();
                ViewBag.MenuList = menuLinks;

                var id = int.Parse(filterContext.RouteData.Values["id"].ToString());

                var positionMenuLinks = _positionMenuLink.GetAll();

                ViewBag.PositionMenu = from x in positionMenuLinks
                                       select new PositionMenuLinkViewModel
                                       {
                                           Id = x.Id,
                                           Status = x.Status,
                                           Name = x.Name,
                                           Selected = x.SelectedPosition(menuLinks.Where(m => m.Id == id))
                                       };
            }
        }

        [HttpPost]
        public ActionResult ChangeOrder(int id, int newPosition, int newParentId)
        {
            if (!Request.IsAjaxRequest())
            {
                return Json(new { success = false });
            }

            ActionResult actionResult;
            try
            {
                var menuLink = _menuLinkService.GetMenu(id);
                menuLink.OrderDisplay = newPosition;

                var newParentIdNullable = newParentId == 0 ? (int?)null : newParentId;
                menuLink.ParentId = menuLink.ParentId == newParentIdNullable ? menuLink.ParentId : newParentIdNullable;

                _menuLinkService.Update(menuLink);

                actionResult = Json(new { success = true });
            }
            catch (Exception ex)
            {
                actionResult = Json(new { success = false, messages = ex.Message });
            }

            return actionResult;
        }

        [HttpPost]
        public ActionResult DeleteAsContext(int id)
        {
            if (!Request.IsAjaxRequest())
            {
                return Json(new { success = false });
            }

            ActionResult actionResult;
            try
            {
                var menuLink = _menuLinkService.GetMenu(id);

                _menuLinkService.Delete(menuLink);

                actionResult = Json(new { success = true });
            }
            catch (Exception ex)
            {
                actionResult = Json(new { success = false, messages = ex.Message });
            }

            return actionResult;
        }
    }
}