using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Mvc;
using App.Front.Extensions;
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
        private readonly ISystemSettingService _systemSettingService;
        private readonly ISendMailService _sendMailService;

        public ContactController(IContactInfoService contactInfoService, IMenuLinkService menuLinkService
            , IMailSettingService mailSettingService
            , ISystemSettingService systemSettingService
            , ISendMailService sendMailService)
        {
            _contactInfoService = contactInfoService;
            _menuLinkService = menuLinkService;
            _systemSettingService = systemSettingService;
            _sendMailService = sendMailService;
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

            var breadCrumbs = new List<BreadCrumb>();
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

            return PartialView();
        }

        [HttpPost]
        public async Task<ActionResult> SendContact(ContactForm model)
        {
            ActionResult actionResult;
            try
            {
                //var toEmail = _systemSettingService.Get(x => x.Status == 1).Email;
                //const string title = "Thông tin liên hệ";
                //var body = string.Concat("", "Người gửi: ", model.FullName, "<br>");
                //body = string.Concat(body, string.Concat("E-mail: ", model.Email), "<br>");
                //body = string.Concat(body, model.Content, "<br>");

                //XmlDocument xmlDocument = new XmlDocument();
                //string serverPathEmail = string.Concat(Server.MapPath("\\"), "Mailformat.xml");
                //if (System.IO.File.Exists(serverPathEmail))
                //{
                //    xmlDocument.Load(serverPathEmail);
                //    XmlNode xmlNodes = xmlDocument.SelectSingleNode(string.Concat("MailFormats/MailFormat[@Id='", messageId, "']"));
                //    var subject = xmlNodes.SelectSingleNode("Subject").InnerText;
                //    var body = xmlNodes.SelectSingleNode("Body").InnerText;

                //    int i;
                //    for (i = 0; i <= param.Length - 1; i++)
                //    {
                //        body = body.Replace(string.Concat(i.ToString(), "?"), param[i]);
                //        subject = subject.Replace(string.Concat(i.ToString(), "?"), param[i]);
                //    }
                //}

                //var sendMail = new SendMail
                //{
                //    MessageId = "Email",
                //    ToEmail = toEmail,
                //    Subject = title,
                //    Body = body
                //};

                //var toEmail = _systemSettingService.Get(x => x.Status == 1).Email;
                //const string title = "Thông tin liên hệ";
                //var body = string.Concat("", "Người gửi: ", model.FullName, "<br>");
                //body = string.Concat(body, string.Concat("E-mail: ", model.Email), "<br>");
                //body = string.Concat(body, model.Content, "<br>");

                //await _sendMailService.SendMailSmtp("Email", toEmail, new[] { title, body });

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