using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using App.Core.Caching;
using App.Domain.Entities.Language;
using App.FakeEntity.Language;
using App.Service.Common;
using App.Service.Language;
using App.Service.LocaleStringResource;
using AutoMapper;

namespace App.Admin.Controllers
{
    public class LocaleResourceController : BaseAdminController
    {
        private const string CacheLanguageKey = "db.Language";
        private const string CacheLocalstringresourceKey = "db.LocaleStringResource";
        private readonly ICacheManager _cacheManager;

        private readonly ILanguageService _langService;

        private readonly ILocaleStringResourceService _localeStringResourceService;

        private readonly ICommonServices _services;

        public LocaleResourceController(ICommonServices services
            , ILocaleStringResourceService localeStringResourceService
            , ILanguageService langService
             , ICacheManager cacheManager)
        {
            _langService = langService;
            _services = services;
            _localeStringResourceService = localeStringResourceService;
            _cacheManager = cacheManager;

            //Clear cache
            _cacheManager.RemoveByPattern(CacheLanguageKey);
            _cacheManager.RemoveByPattern(CacheLocalstringresourceKey);
        }

        public ActionResult Index(int languageId, int page = 1, string keywords = "")
        {
            var resources = _services.Localization.GetByLanguageId(languageId);
            resources = resources.Where(m => m.ResourceName.Contains(keywords) || m.ResourceValue.Contains(keywords));
            ViewBag.Localization = resources.OrderByDescending(m => m.CreatedDate);

            //Lưu lại languageId, keywork để k bị mất value text ở view
            ViewBag.LanguageSelected = languageId;
            ViewBag.keywords = keywords;

            IEnumerable<Language> all = _langService.GetAll();
            ViewBag.AllLanguage = all;

            return View(resources);
        }

        //public ActionResult Resource(int languageId)
        //{
        //    return View();
        //}

        //public ActionResult Create(LocaleStringResourceViewModel model)
        //{
        //    var res = _services.Localization.GetByName(model.LanguageId, model.ResourceName);
        //    return View();
        //}

        public ActionResult Edit(LocaleStringResourceViewModel model)
        {
            LocaleStringResource locale = _services.Localization.GetById(model.Id);

            if (locale != null)
            {
                model.LanguageId = locale.LanguageId;
                model.IsFromPlugin = locale.IsFromPlugin;
                model.IsTouched = true;

                LocaleStringResource localeByMap = Mapper.Map(model, locale);
                _localeStringResourceService.Update(localeByMap);
            }
            else
            {
                LocaleStringResource localeByMap = Mapper.Map<LocaleStringResourceViewModel, LocaleStringResource>(model);
                _localeStringResourceService.Create(localeByMap);
            }

            //var resources = _services.Localization.GetByLanguageId(1);
            //ViewBag.Localization = resources;

            return Json(
                new
                {
                    succes = true
                }
                , JsonRequestBehavior.AllowGet);
        }

        public ActionResult Delete(string id)
        {
            LocaleStringResource locale = _services.Localization.GetById(int.Parse(id));
            _services.Localization.Delete(locale);

            return Json(
                new { success = true }
                , JsonRequestBehavior.AllowGet);
        }

        public ActionResult NewRow(string languageId)
        {
            LocaleStringResource model = new LocaleStringResource();
            model.LanguageId = int.Parse(languageId);

            string newRow = RenderRazorViewToString("_NewRow", model);

            return Json(new { data = newRow, success = true }, JsonRequestBehavior.AllowGet);
        }

    }
}