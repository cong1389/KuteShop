using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using App.Aplication.Extensions;
using App.Domain.Entities.GlobalSetting;
using App.Front.Models;
using App.Service.ContactInformation;
using App.Service.Language;
using App.Service.MailSetting;
using App.Service.Menu;
using App.Service.SystemApp;

namespace App.Front.Controllers
{
    public class ContactController : FrontBaseController
    {
        private readonly IContactInfoService _contactInfoService;
        private readonly IMenuLinkService _menuLinkService;
        private readonly IMailSettingService _mailSettingService;
        private readonly ISystemSettingService _systemSettingService;

        public ContactController(IContactInfoService contactInfoService, IMenuLinkService menuLinkService
            , IMailSettingService mailSettingService
            , ISystemSettingService systemSettingService)
        {
            _contactInfoService = contactInfoService;
            _menuLinkService = menuLinkService;
            _mailSettingService = mailSettingService;
            _systemSettingService = systemSettingService;
        }

        [ChildActionOnly]
        public ActionResult ContactUs(int id, string title)
        {
            var menuLink = _menuLinkService.GetById(id);

            var contactInformation = _contactInfoService.FindBy(x => x.Status == 1, true);

            if (contactInformation == null)
            {
                return HttpNotFound();
            }

            var contactInformationLocalize = contactInformation.Select(x => x.ToModel());

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
            //ViewBag.Contact = contactInformationLocalize;

            return PartialView(contactInformationLocalize);
        }

        [HttpPost]
        public ActionResult SendContact(string name, string email, string content)
        {
            ActionResult actionResult;
            try
            {
                if (!Request.IsAjaxRequest())
                {
                    return Json(new { succes = false, message = "Liên hệ chưa gửi được, vui lòng thử lại." });
                }

                ServerMailSetting serverMailSetting = _mailSettingService.Get(x => x.Status == 1, false);
                string str = _systemSettingService.Get(x => x.Status == 1, false).Email;
                string str1 = "Thông tin liên hệ";
                string str2 = string.Concat("", "Người gửi: ", name, "<br>");
                str2 = string.Concat(str2, string.Concat("E-mail: ", email), "<br>");
                str2 = string.Concat(str2, content, "<br>");
                SendMail sendMail = new SendMail();
                sendMail.InitMail(serverMailSetting.FromAddress, serverMailSetting.SmtpClient, serverMailSetting.UserID, serverMailSetting.Password, serverMailSetting.SMTPPort, serverMailSetting.EnableSSL);
                sendMail.SendToMail("Email", str, new[] { str1, str2 });
                actionResult = Json(new { success = true, message = "Gửi liên hệ thành công, chúng tôi sẽ liên lạc với bạn ngay khi có thể." });
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return actionResult;
        }
    }
}