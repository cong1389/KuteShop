using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using App.Admin.Helpers;
using App.Aplication;
using App.Core.Caching;
using App.Domain.Entities.Menu;
using App.FakeEntity.Menu;
using App.Framework.Ultis;
using App.Service.Language;
using App.Service.LocalizedProperty;
using App.Service.Menu;
using AutoMapper;
using Resources;

namespace App.Admin.Controllers
{
    public class MenuController : BaseAdminController
    {
        private const string CacheMenuKey = "db.MenuLink";
        private readonly ICacheManager _cacheManager;

        private readonly IMenuLinkService _menuLinkService;

        private readonly ILocalizedPropertyService _localizedPropertyService;

        private readonly ILanguageService _languageService;      

        public MenuController(IMenuLinkService menuLinkService, ILocalizedPropertyService localizedPropertyService
            , ILanguageService languageService
           , ICacheManager cacheManager)
        {
            _menuLinkService = menuLinkService;
            _localizedPropertyService = localizedPropertyService;
            _languageService = languageService;
            _cacheManager = cacheManager;

            //Clear cache
            _cacheManager.RemoveByPattern(CacheMenuKey);
        }

        [RequiredPermisson(Roles = "CreateEditMenu")]
        public ActionResult Create()
        {
            var model = new MenuLinkViewModel();

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
                    var messages = String.Join(Environment.NewLine, ModelState.Values.SelectMany(v => v.Errors)
                                                            .Select(v => v.ErrorMessage + " " + v.Exception));
                    ModelState.AddModelError("", messages);
                    return View(model);
                }

                var str = model.MenuName.NonAccent();
                var bySeoUrl = _menuLinkService.GetListSeoUrl(str);
                model.SeoUrl = model.MenuName.NonAccent();
                if (bySeoUrl.Any(x => x.Id != model.Id))
                {
                    var menuLinkViewModel = model;
                    var seoUrl = menuLinkViewModel.SeoUrl;
                    var num = bySeoUrl.Count();
                    menuLinkViewModel.SeoUrl = string.Concat(seoUrl, "-", num.ToString());
                }
                if (model.Image != null && model.Image.ContentLength > 0)
                {
                    var fileName = Path.GetFileName(model.Image.FileName);
                    var extension = Path.GetExtension(model.Image.FileName);
                    fileName = string.Concat(model.MenuName.NonAccent(), extension);
                    var str1 = Path.Combine(Server.MapPath(string.Concat("~/", Contains.MenuFolder)), fileName);
                    model.Image.SaveAs(str1);
                    model.ImageUrl = string.Concat(Contains.MenuFolder, fileName);
                }
                if (model.ImageIcon1 != null && model.ImageIcon1.ContentLength > 0)
                {
                    var fileName1 = Path.GetFileName(model.ImageIcon1.FileName);
                    var extension1 = Path.GetExtension(model.ImageIcon1.FileName);
                    fileName1 = string.Concat(string.Concat(model.MenuName, "-icon").NonAccent(), extension1);
                    var str2 = Path.Combine(Server.MapPath(string.Concat("~/", Contains.MenuFolder)), fileName1);
                    model.ImageIcon1.SaveAs(str2);
                    model.Icon1 = string.Concat(Contains.MenuFolder, fileName1);
                }
                if (model.ImageIcon2 != null && model.ImageIcon2.ContentLength > 0)
                {
                    var fileName2 = Path.GetFileName(model.ImageIcon2.FileName);
                    var extension2 = Path.GetExtension(model.ImageIcon2.FileName);
                    fileName2 = string.Concat(string.Concat(model.MenuName, "-iconbar").NonAccent(), extension2);
                    var str3 = Path.Combine(Server.MapPath(string.Concat("~/", Contains.MenuFolder)), fileName2);
                    model.ImageIcon2.SaveAs(str3);
                    model.Icon2 = string.Concat(Contains.MenuFolder, fileName2);
                }
                if (model.ParentId.HasValue)
                {
                    var str4 = Guid.NewGuid().ToString();
                    model.CurrentVirtualId = str4;
                    var byId = _menuLinkService.GetById(model.ParentId.Value);
                    model.VirtualId = $"{byId.VirtualId}/{str4}";
                    model.VirtualSeoUrl = $"{byId.SeoUrl}/{model.SeoUrl}";
                }
                else
                {
                    var str5 = Guid.NewGuid().ToString();
                    model.VirtualId = str5;
                    model.CurrentVirtualId = str5;
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
            catch (Exception exception1)
            {
                var exception = exception1;
                ExtentionUtils.Log(string.Concat("MailSetting.Create: ", exception.Message));
                return View(model);
            }
            return action;
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
                        select _menuLinkService.GetById(int.Parse(id));
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
                ExtentionUtils.Log(string.Concat("MenuLink.Delete: ", ex.Message));
                ModelState.AddModelError("", ex.Message);
               
            }
            return RedirectToAction("Index");
        }


        [RequiredPermisson(Roles = "DeleteMenu")]
        public ActionResult DeleteOne(int id)
        {
            try
            {
                var menuLink = _menuLinkService.GetById(id);

                _menuLinkService.Delete(menuLink);
            }
            catch (Exception ex)
            {
                ExtentionUtils.Log(string.Concat("MenuLink.DeleteById: ", ex.Message));
              
                Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.ErrorMessageWithFormat, ex.Message)));

            }
            return RedirectToAction("Index");
        }

        [RequiredPermisson(Roles = "CreateEditMenu")]
        public ActionResult Edit(int id)
        {
            var modelMap = Mapper.Map<MenuLink, MenuLinkViewModel>(_menuLinkService.GetById(id));

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

                var byId = _menuLinkService.GetById(model.Id);
                var str = model.MenuName.NonAccent();
                var bySeoUrl = _menuLinkService.GetListSeoUrl(str);
                model.SeoUrl = model.MenuName.NonAccent();
                if (bySeoUrl.Any(x => x.Id != model.Id))
                {
                    var menuLinkViewModel = model;
                    var seoUrl = menuLinkViewModel.SeoUrl;
                    var num = bySeoUrl.Count();
                    menuLinkViewModel.SeoUrl = string.Concat(seoUrl, "-", num.ToString());
                }
                if (model.Image != null && model.Image.ContentLength > 0)
                {
                    var fileName = Path.GetFileName(model.Image.FileName);
                    var extension = Path.GetExtension(model.Image.FileName);
                    fileName = string.Concat(model.MenuName.NonAccent(), extension);
                    var str1 = Path.Combine(Server.MapPath(string.Concat("~/", Contains.MenuFolder)), fileName);
                    model.Image.SaveAs(str1);
                    model.ImageUrl = string.Concat(Contains.MenuFolder, fileName);
                }
                if (model.ImageIcon1 != null && model.ImageIcon1.ContentLength > 0)
                {
                    var fileName1 = Path.GetFileName(model.ImageIcon1.FileName);
                    var extension1 = Path.GetExtension(model.ImageIcon1.FileName);
                    fileName1 = string.Concat(string.Concat(model.MenuName, "-icon").NonAccent(), extension1);
                    var str2 = Path.Combine(Server.MapPath(string.Concat("~/", Contains.MenuFolder)), fileName1);
                    model.ImageIcon1.SaveAs(str2);
                    model.Icon1 = string.Concat(Contains.MenuFolder, fileName1);
                }
                if (model.ImageIcon2 != null && model.ImageIcon2.ContentLength > 0)
                {
                    var fileName2 = Path.GetFileName(model.ImageIcon2.FileName);
                    var extension2 = Path.GetExtension(model.ImageIcon2.FileName);
                    fileName2 = string.Concat(string.Concat(model.MenuName, "-iconbar").NonAccent(), extension2);
                    var str3 = Path.Combine(Server.MapPath(string.Concat("~/", Contains.MenuFolder)), fileName2);
                    model.ImageIcon2.SaveAs(str3);
                    model.Icon2 = string.Concat(Contains.MenuFolder, fileName2);
                }
                var parentId = model.ParentId;
                if (!parentId.HasValue)
                {
                    parentId = null;
                    model.ParentId = parentId;
                    model.VirtualId = byId.CurrentVirtualId;
                    model.VirtualSeoUrl = null;
                }
                else
                {
                    var menuLinkService = _menuLinkService;
                    parentId = model.ParentId;
                    var byId1 = menuLinkService.GetById(parentId.Value);
                    model.VirtualId = $"{byId1.VirtualId}/{byId.CurrentVirtualId}";
                    model.VirtualSeoUrl = $"{byId1.SeoUrl}/{model.SeoUrl}";
                }

                var modelMap = Mapper.Map(model, byId);
                _menuLinkService.Update(byId);

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
                ExtentionUtils.Log(string.Concat("MailSetting.Create: ", ex.Message));

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
                        ImageUrl = x.ImageUrl,
                        CurrentVirtualId = x.CurrentVirtualId,
                        VirtualId = x.VirtualId,
                        TemplateType = x.TemplateType,
                        IconNav = x.Icon1,
                        IconBar = x.Icon2                        
                    };
                lstMenuNav = CreateMenuNav(null, menuNav);
            }
            return View(lstMenuNav);
        }

        private List<MenuNavViewModel> CreateMenuNav(int? parentId, IEnumerable<MenuNavViewModel> source)
        {
            var ieMenuNavViewModel = (from x in source
                                                         orderby x.OrderDisplay descending
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
                                                             ImageUrl = x.ImageUrl,
                                                             CurrentVirtualId = x.CurrentVirtualId,
                                                             VirtualId = x.VirtualId,
                                                             TemplateType = x.TemplateType,
                                                             OtherLink = x.OtherLink,
                                                             IconNav = x.IconNav,
                                                             IconBar = x.IconBar,
                                                             ChildNavMenu = CreateMenuNav(x.MenuId, source)
                                                         }).ToList();

            return ieMenuNavViewModel;
        }

        protected override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            if (filterContext.RouteData.Values["action"].Equals("create") || filterContext.RouteData.Values["action"].Equals("edit"))
            {
                ViewBag.MenuList = _menuLinkService.GetAll();
            }
        }
    }
}