using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using App.Aplication;
using App.Core.Caching;
using App.Core.Utils;
using App.Domain.Entities.Language;
using App.FakeEntity.Language;
using App.Framework.Ultis;
using App.Service.Language;
using AutoMapper;
using Resources;

namespace App.Admin.Controllers
{
    public class LanguageController : BaseAdminController
    {
        #region Language
        private const string CacheLanguageKey = "db.Language";
        private readonly ICacheManager _cacheManager;

        private readonly ILanguageService _langService;
        
        public LanguageController(ILanguageService langService
            , ICacheManager cacheManager)
        {
            _langService = langService;
            _cacheManager = cacheManager;

            //Clear cache
            _cacheManager.RemoveByPattern(CacheLanguageKey);

        }

        [HttpGet]
        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(LanguageFormViewModel model, string returnUrl)
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

                if (model.File != null && model.File.ContentLength > 0)
                {
                    string fileName = Path.GetFileName(model.File.FileName);
                    string extension = Path.GetExtension(model.File.FileName);
                    //image = string.Concat(image.NonAccent(), extension);
                    string str = Path.Combine(Server.MapPath(string.Concat("~/", Contains.FolderLanguage)), fileName);
                    model.File.SaveAs(str);
                    model.Flag = string.Concat(Contains.FolderLanguage, fileName);
                }

                Language modelMap = Mapper.Map<LanguageFormViewModel, Language>(model);
                _langService.CreateLanguage(modelMap);

                if (_langService.SaveLanguage() > 0)
                {
                    Response.Cookies.Add(new HttpCookie("system_message", MessageUI.SuccessLanguage));
                    if (!Url.IsLocalUrl(returnUrl) || returnUrl.Length <= 1 || !returnUrl.StartsWith("/") || returnUrl.StartsWith("//") || returnUrl.StartsWith("/\\"))
                    {
                        action = RedirectToAction("Index");
                        return action;
                    }

                    action = Redirect(returnUrl);
                    return action;
                }
                ModelState.AddModelError("", MessageUI.ErrorMessage);
                return View(model);
            }
            catch (Exception ex)
            {
                ExtentionUtils.Log(string.Concat("Language.Create: ", ex.Message));
                return View(model);
            }
        }

        public ActionResult Edit(int id)
        {
            LanguageFormViewModel languageViewModel = Mapper.Map<Language, LanguageFormViewModel>(_langService.GetById(id));
            return View(languageViewModel);
        }

        [HttpPost]
        public ActionResult Edit(LanguageFormViewModel model, string returnUrl)
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

                if (model.File != null && model.File.ContentLength > 0)
                {
                    string fileName = Path.GetFileName(model.File.FileName);
                    string extension = Path.GetExtension(model.File.FileName);
                    //fileName = string.Concat(empty.NonAccent(), extension);
                    string str = Path.Combine(Server.MapPath(string.Concat("~/", Contains.FolderLanguage)), fileName);
                    model.File.SaveAs(str);
                    model.Flag = string.Concat(Contains.FolderLanguage, fileName);
                }

                Language modelMap = Mapper.Map<LanguageFormViewModel, Language>(model);
                _langService.Update(modelMap);

                Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.UpdateSuccess, FormUI.Language)));
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
                ExtentionUtils.Log(string.Concat("Language.Edit: ", exception.Message));
                return View(model);
            }
            return action;
        }

        public ActionResult Delete(string[] ids)
        {
            try
            {
                if (ids.Length != 0)
                {
                    IEnumerable<Language> language =
                        from id in ids
                        select _langService.GetById(int.Parse(id));
                    _langService.BatchDelete(language);
                }
            }
            catch (Exception exception1)
            {
                Exception exception = exception1;
                ExtentionUtils.Log(string.Concat("Banner.Delete: ", exception.Message));
            }
            return RedirectToAction("Index");
        }

        public ActionResult Index(int page = 1, string keywords = "")
        {
            ViewBag.Keywords = keywords;
            SortingPagingBuilder sortingPagingBuilder = new SortingPagingBuilder
            {
                Keywords = keywords,
                Sorts = new SortBuilder
                {
                    ColumnName = "LanguageCode",
                    ColumnOrder = SortBuilder.SortOrder.Descending
                }
            };
            Paging paging = new Paging
            {
                PageNumber = page,
                PageSize = PageSize,
                TotalRecord = 0
            };
            IEnumerable<Language> languages = _langService.PagedList(sortingPagingBuilder, paging);
            if (languages != null && languages.Any())
            {
                Helper.PageInfo pageInfo = new Helper.PageInfo(ExtentionUtils.PageSize, page, paging.TotalRecord, i => Url.Action("Index", new { page = i, keywords }));
                ViewBag.PageInfo = pageInfo;
            }
            return View(languages);
        }

        #endregion

    }
}