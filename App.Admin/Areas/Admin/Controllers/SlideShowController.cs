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
using App.Domain.Entities.Slide;
using App.FakeEntity.Slide;
using App.Framework.Ultis;
using App.Service.Language;
using App.Service.LocalizedProperty;
using App.Service.Slide;
using AutoMapper;
using Resources;

namespace App.Admin.Controllers
{
    public class SlideShowController : BaseAdminController
    {
        private const string CacheSlideshowKey = "db.SlideShow";
        private readonly ICacheManager _cacheManager;

        private readonly ISlideShowService _slideShowService;

        private readonly ILanguageService _languageService;

        private readonly ILocalizedPropertyService _localizedPropertyService;

        public SlideShowController(
            ISlideShowService slideShowService
            , ILanguageService languageService
            , ILocalizedPropertyService localizedPropertyService
            , ICacheManager cacheManager
            )
        {
            _slideShowService = slideShowService;
            _languageService = languageService;
            _localizedPropertyService = localizedPropertyService;
            _cacheManager = cacheManager;

            //Clear cache
            _cacheManager.RemoveByPattern(CacheSlideshowKey);

        }

        public ActionResult Create()
        {
            var model = new SlideShowViewModel();

            //Add locales to model
            AddLocales(_languageService, model.Locales);

            return View(model);
        }

        [HttpPost]
        public ActionResult Create(SlideShowViewModel model, string returnUrl)
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

                if (model.Image != null && model.Image.ContentLength > 0)
                {
                    string fileExtension = Path.GetExtension(model.Image.FileName);

                    string fileName = model.Title.NonAccent().FileNameFormat(fileExtension);

                    string imageServerPath = Path.Combine(Server.MapPath(string.Concat("~/", Contains.AdsFolder)), fileName);

                    model.ImgPath = $"{Contains.AdsFolder}/{fileName}";
                    model.Image.SaveAs(imageServerPath);
                }

                SlideShow modelMap = Mapper.Map<SlideShowViewModel, SlideShow>(model);
                _slideShowService.Create(modelMap);

                //Update Localized   
                foreach (var localized in model.Locales)
                {
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.Title, localized.Title, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.Description, localized.Description, localized.LanguageId);
                }

                Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.CreateSuccess, FormUI.SlideShow)));
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
                ExtentionUtils.Log(string.Concat("SlideShow.Edit: ", ex.Message));

                return View(model);
            }

            return action;
        }

        public ActionResult Delete(int[] ids)
        {
            try
            {
                if (ids.Length != 0)
                {
                    int[] numArray = ids;
                    for (int i = 0; i < numArray.Length; i++)
                    {
                        int num = numArray[i];
                        SlideShow slideShow = _slideShowService.Get(x => x.Id == num);

                        _slideShowService.Delete(slideShow);

                        //Delete localize
                        var ieLocalizedProperty = _localizedPropertyService.GetByEntityId(num);

                        _localizedPropertyService.BatchDelete(ieLocalizedProperty);
                    }
                }
            }
            catch (Exception ex)
            {
                ExtentionUtils.Log(string.Concat("SlideShow.Delete: ", ex.Message));
            }

            return RedirectToAction("Index");
        }

        public ActionResult Edit(int id)
        {
            SlideShowViewModel modelMap = Mapper.Map<SlideShow, SlideShowViewModel>(_slideShowService.Get(x => x.Id == id));

            //Add Locales to model
            AddLocales(_languageService, modelMap.Locales, (locale, languageId) =>
            {
                locale.Id = modelMap.Id;
                locale.LocalesId = modelMap.Id;
                locale.Title = modelMap.GetLocalized(x => x.Title, modelMap.Id);
                locale.Description = modelMap.GetLocalized(x => x.Description, id);
            });

            return View(modelMap);
        }

        [HttpPost]
        public ActionResult Edit(SlideShowViewModel model, string returnUrl)
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

                SlideShow slideShow = _slideShowService.Get(x => x.Id == model.Id);

                if (model.Image != null && model.Image.ContentLength > 0)
                {
                    string fileExtension = Path.GetExtension(model.Image.FileName);

                    string fileName = model.Title.NonAccent().FileNameFormat(fileExtension);

                    string imageServerPath = Path.Combine(Server.MapPath(string.Concat("~/", Contains.AdsFolder)), fileName);

                    model.ImgPath = $"{Contains.AdsFolder}/{fileName}";
                    model.Image.SaveAs(imageServerPath);
                }

                SlideShow modelMap = Mapper.Map(model, slideShow);
                _slideShowService.Update(modelMap);

                //Update Localized   
                foreach (var localized in model.Locales)
                {
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.Title, localized.Title, localized.LanguageId);
                    _localizedPropertyService.SaveLocalizedValue(modelMap, x => x.Description, localized.Description, localized.LanguageId);
                }

                Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.UpdateSuccess, FormUI.SlideShow)));
                if (!Url.IsLocalUrl(returnUrl) || returnUrl.Length <= 1 || !returnUrl.StartsWith("/") ||
                    returnUrl.StartsWith("//") || returnUrl.StartsWith("/\\"))
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
                ExtentionUtils.Log(string.Concat("SlideShow.Edit: ", ex.Message));

                return View(model);
            }

            return action;
        }

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

            IEnumerable<SlideShow> slideShows = _slideShowService.PagedList(sortingPagingBuilder, paging);
            if (slideShows != null && slideShows.Any())
            {
                Helper.PageInfo pageInfo = new Helper.PageInfo(ExtentionUtils.PageSize, page, paging.TotalRecord,
                    i => Url.Action("Index", new {page = i, keywords}));

                ViewBag.PageInfo = pageInfo;
            }

            return View(slideShows);
        }
    }
}