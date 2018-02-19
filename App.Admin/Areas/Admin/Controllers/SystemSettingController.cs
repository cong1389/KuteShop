using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using App.Admin.Helpers;
using App.Aplication;
using App.Core.Caching;
using App.Core.Utils;
using App.Domain.Entities.GlobalSetting;
using App.FakeEntity.System;
using App.Framework.Ultis;
using App.Service.Language;
using App.Service.LocalizedProperty;
using App.Service.SystemApp;
using AutoMapper;
using Resources;

namespace App.Admin.Controllers
{
    public class SystemSettingController : BaseAdminController
    {
        private const string CacheSystemsettingKey = "db.SystemSetting";
        private readonly ICacheManager _cacheManager;

        private readonly ISystemSettingService _systemSettingService;

        private readonly ILanguageService _languageService;

        private readonly ILocalizedPropertyService _localizedPropertyService;

        public SystemSettingController(
            ISystemSettingService systemSettingService
            , ILanguageService languageService
            , ILocalizedPropertyService localizedPropertyService
             , ICacheManager cacheManager
            )
        {
            _systemSettingService = systemSettingService;
            _languageService = languageService;
            _localizedPropertyService = localizedPropertyService;
            _cacheManager = cacheManager;

            //Clear cache
            _cacheManager.RemoveByPattern(CacheSystemsettingKey);

        }

        [RequiredPermisson(Roles = "CreateEditSystemSetting")]
        public ActionResult Create()
        {
            var model = new SystemSettingViewModel();

            //Add locales to model
            AddLocales(_languageService, model.Locales);

            return View(model);
        }

        [HttpPost]
        [RequiredPermisson(Roles = "CreateEditSystemSetting")]
        public ActionResult Create(SystemSettingViewModel model, string returnUrl)
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

                if (model.Status == 1)
                {
                    IEnumerable<SystemSetting> systemSettings = _systemSettingService.FindBy(x => x.Status == 1);
                    if (systemSettings.IsAny())
                    {
                        foreach (SystemSetting systemSetting1 in systemSettings)
                        {
                            systemSetting1.Status = 0;
                            _systemSettingService.Update(systemSetting1);
                        }
                    }
                }

                if (model.Favicon != null && model.Favicon.ContentLength > 0)
                {
                    string fileName = Path.GetFileName(model.Favicon.FileName);
                    string extension = Path.GetExtension(model.Favicon.FileName);
                    fileName = string.Concat("favicon", extension);
                    string str = Path.Combine(Server.MapPath(string.Concat("~/", Contains.ImageFolder)), fileName);

                    //Check and delete logo exists
                    if (System.IO.File.Exists(str))
                        System.IO.File.Delete(str);

                    model.Favicon.SaveAs(str);
                    model.FaviconImage = string.Concat(Contains.ImageFolder, fileName);
                }

                if (model.Logo != null && model.Logo.ContentLength > 0)
                {
                    string fileName = Path.GetFileName(model.Logo.FileName);
                    string extension = Path.GetExtension(model.Logo.FileName);
                    fileName = string.Concat("logo", extension);
                    string str = Path.Combine(Server.MapPath(string.Concat("~/", Contains.ImageFolder)), fileName);

                    //Check and delete logo exists
                    if (System.IO.File.Exists(str))
                        System.IO.File.Delete(str);

                    model.Logo.SaveAs(str);
                    model.LogoImage = string.Concat(Contains.ImageFolder, fileName);
                }

                SystemSetting modelMap = Mapper.Map<SystemSettingViewModel, SystemSetting>(model);
                _systemSettingService.Create(modelMap);

                //Update Localized   
                foreach (var localized in model.Locales)
                {
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.Title, localized.Title, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.FooterContent, localized.FooterContent, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.Description, localized.Description, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MetaTitle, localized.MetaTitle, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MetaKeywords, localized.MetaKeywords, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MetaDescription, localized.MetaDescription, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.TimeWork, localized.TimeWork, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.Slogan, localized.Slogan, localized.LanguageId);
                }

                Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.CreateSuccess, FormUI.SystemSetting)));
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
                Exception exception = exception1;
                ExtentionUtils.Log(string.Concat("SystemSetting.Create: ", exception.Message));
                ModelState.AddModelError("", exception.Message);
                return View(model);
            }
            return action;
        }

        [RequiredPermisson(Roles = "DeleteSystemSetting")]
        public ActionResult Delete(string[] ids)
        {
            try
            {
                if (ids.Length != 0)
                {
                    IEnumerable<SystemSetting> systemSettings =
                        from id in ids
                        select _systemSettingService.GetById(int.Parse(id));
                    _systemSettingService.BatchDelete(systemSettings);
                }
            }
            catch (Exception exception1)
            {
                Exception exception = exception1;
                ExtentionUtils.Log(string.Concat("SystemSetting.Delete: ", exception.Message));
            }
            return RedirectToAction("Index");
        }

        [RequiredPermisson(Roles = "CreateEditSystemSetting")]
        public ActionResult Edit(int id)
        {
            SystemSettingViewModel modelMap = Mapper.Map<SystemSetting, SystemSettingViewModel>(_systemSettingService.GetById(id));

            //Add Locales to model
            AddLocales(_languageService, modelMap.Locales, (locale, languageId) =>
            {
                locale.Id = modelMap.Id;
                locale.LocalesId = modelMap.Id;
                locale.Language = modelMap.Language;
                locale.Status = modelMap.Status;
                locale.Favicon = modelMap.Favicon;
                locale.LogoImage = modelMap.LogoImage;
                locale.MaintanceSite = modelMap.MaintanceSite;
                locale.Hotline = modelMap.Hotline;
                locale.Email = modelMap.Email;
                locale.TimeWork = modelMap.TimeWork;

                locale.Title = modelMap.GetLocalized(x => x.Title, id, languageId, false, false);
                locale.FooterContent = modelMap.GetLocalized(x => x.FooterContent, id, languageId, false, false);
                locale.Description = modelMap.GetLocalized(x => x.Description, id, languageId, false, false);
                locale.MetaTitle = modelMap.GetLocalized(x => x.MetaTitle, id, languageId, false, false);
                locale.MetaKeywords = modelMap.GetLocalized(x => x.MetaKeywords, id, languageId, false, false);
                locale.MetaDescription = modelMap.GetLocalized(x => x.MetaDescription, id, languageId, false, false);
                locale.Slogan = modelMap.GetLocalized(x => x.Slogan, id, languageId, false, false);
            });

            return View(modelMap);
        }

        [HttpPost]
        [RequiredPermisson(Roles = "CreateEditSystemSetting")]
        public ActionResult Edit(SystemSettingViewModel model, string returnUrl)
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

                SystemSetting byId = _systemSettingService.GetById(model.Id, isCache: false);
                if (model.Status == 1 && model.Status != byId.Status)
                {
                    IEnumerable<SystemSetting> systemSettings = _systemSettingService.FindBy(x => x.Status == 1);
                    if (systemSettings.IsAny())
                    {
                        foreach (SystemSetting systemSetting1 in systemSettings)
                        {
                            systemSetting1.Status = 0;
                            _systemSettingService.Update(systemSetting1);
                        }
                    }
                }

                if (model.Favicon != null && model.Favicon.ContentLength > 0)
                {
                    string fileName = Path.GetFileName(model.Favicon.FileName);
                    string extension = Path.GetExtension(model.Favicon.FileName);
                    fileName = string.Concat("favicon", extension);
                    string str = Path.Combine(Server.MapPath(string.Concat("~/", Contains.ImageFolder)), fileName);

                    //Check and delete logo exists
                    if (System.IO.File.Exists(str))
                        System.IO.File.Delete(str);

                    model.Favicon.SaveAs(str);
                    model.FaviconImage = string.Concat(Contains.ImageFolder, fileName);
                }

                if (model.Logo != null && model.Logo.ContentLength > 0)
                {
                    string fileName = Path.GetFileName(model.Logo.FileName);
                    string extension = Path.GetExtension(model.Logo.FileName);
                    fileName = string.Concat("logo", extension);
                    string str = Path.Combine(Server.MapPath(string.Concat("~/", Contains.ImageFolder)), fileName);

                    //Check and delete logo exists
                    if (System.IO.File.Exists(str))
                        System.IO.File.Delete(str);

                    model.Logo.SaveAs(str);
                    model.LogoImage = string.Concat(Contains.ImageFolder, fileName);
                }

                if (model.LogoFooter != null && model.LogoFooter.ContentLength > 0)
                {
                    string fileName = Path.GetFileName(model.LogoFooter.FileName);
                    string extension = Path.GetExtension(model.LogoFooter.FileName);
                    fileName = string.Concat("logoFooter", extension);
                    string str = Path.Combine(Server.MapPath(string.Concat("~/", Contains.ImageFolder)), fileName);

                    //Check and delete logo exists
                    if (System.IO.File.Exists(str))
                        System.IO.File.Delete(str);

                    model.LogoFooter.SaveAs(str);
                    model.LogoFooterImage = string.Concat(Contains.ImageFolder, fileName);
                }

                SystemSetting modelMap = Mapper.Map(model, byId);
                _systemSettingService.Update(modelMap);

                //Update Localized   
                foreach (var localized in model.Locales)
                {
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.Title, localized.Title, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.FooterContent, localized.FooterContent, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.Description, localized.Description, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MetaTitle, localized.MetaTitle, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MetaKeywords, localized.MetaKeywords, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.MetaDescription, localized.MetaDescription, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.TimeWork, localized.TimeWork, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.Slogan, localized.Slogan, localized.LanguageId);
                }

                Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.UpdateSuccess, FormUI.SystemSetting)));
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
                Exception exception = exception1;
                ModelState.AddModelError("", exception.Message);
                ExtentionUtils.Log(string.Concat("SystemSetting.Edit: ", exception.Message));
                return View(model);
            }
            return action;
        }

        [RequiredPermisson(Roles = "ViewSystemSetting")]
        public ActionResult Index(int page = 1, string keywords = "")
        {
            ViewBag.Keywords = keywords;
            SortingPagingBuilder sortingPagingBuilder = new SortingPagingBuilder
            {
                Keywords = keywords,
                Sorts = new SortBuilder
                {
                    ColumnName = "Title",
                    ColumnOrder = SortBuilder.SortOrder.Descending
                }
            };
            Paging paging = new Paging
            {
                PageNumber = page,
                PageSize = PageSize,
                TotalRecord = 0
            };
            IEnumerable<SystemSetting> systemSettings = _systemSettingService.PagedList(sortingPagingBuilder, paging);
            if (systemSettings != null && systemSettings.Any())
            {
                Helper.PageInfo pageInfo = new Helper.PageInfo(ExtentionUtils.PageSize, page, paging.TotalRecord, i => Url.Action("Index", new { page = i, keywords }));
                ViewBag.PageInfo = pageInfo;
            }
            return View(systemSettings);
        }
    }
}