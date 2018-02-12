using System.Collections.Generic;
using System.Web.Mvc;
using App.Aplication.Extensions;
using App.Domain.Entities.GlobalSetting;
using App.Domain.Entities.Menu;
using App.Front.Models;
using App.Service.ContactInformation;
using App.Service.Language;
using App.Service.Menu;

namespace App.Front.Controllers
{
    public class ContactController : FrontBaseController
    {
        private readonly IContactInfoService _contactInfoService;
        private readonly IMenuLinkService _menuLinkService;

        public ContactController(IContactInfoService contactInfoService, IMenuLinkService menuLinkService)
        {
            _contactInfoService = contactInfoService;
            _menuLinkService = menuLinkService;
        }

        [ChildActionOnly]
        public ActionResult ContactUs(int id, string title)
        {
            MenuLink menuLink = _menuLinkService.GetById(id: id);

            ContactInformation contactInformation = _contactInfoService.Get(x => x.Type == 1 && x.Status == 1, true);

            if (contactInformation == null)
                return HttpNotFound();

            ContactInformation contactInformationLocalize = contactInformation.ToModel();

            List<BreadCrumb> breadCrumbs = new List<BreadCrumb>();
            if (menuLink != null)
            {

                breadCrumbs.Add(new BreadCrumb
                {
                    Title = menuLink.GetLocalized(m => m.MenuName, menuLink.Id),
                    Current = false,
                    Url = Url.Action("GetContent", "Menu", new { area = "", menu = menuLink.SeoUrl })
                });               
                ViewBag.MenuId = menuLink.Id;
            }
            ViewBag.BreadCrumb = breadCrumbs;

            ViewBag.Title = title;
            ViewBag.Contact = contactInformationLocalize;          

            return PartialView(menuLink);
        }
    }
}