using System;
using System.IO;
using System.Net;
using System.Net.Mail;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Xml;
using App.Aplication;
using Microsoft.AspNet.Identity;

namespace App.Service.MailSetting
{
    public class SendMailService : IIdentityMessageService, ISendMailService
    {
        private readonly IMailSettingService _mailSettingService;

        public SendMailService(IMailSettingService mailSettingService)
        {
            _mailSettingService = mailSettingService;
        }

        public Task SendAsync(IdentityMessage message)
        {
            return SendMailTrap(message);
        }

        public Task SendMailSmtp(string messageId, string toAddress, string[] bodyContent)
        {
            var mailSetting = _mailSettingService.Get(x => x.Status == 1);

            XmlDocument xmlDocument = new XmlDocument();
            string pathTempMailConcat = string.Concat(HttpContext.Current.Server.MapPath("\\"), Contains.TemplateMailBasicContact);
            if (File.Exists(pathTempMailConcat))
            {
                xmlDocument.Load(pathTempMailConcat);
                XmlNode xmlNodes = xmlDocument.SelectSingleNode(string.Concat("MailFormats/MailFormat[@Id='", messageId, "']"));
                var subject = xmlNodes.SelectSingleNode("Subject").InnerText;
                var body = xmlNodes.SelectSingleNode("Body").InnerText;
                if (bodyContent == null)
                {
                    throw new Exception("Mail format file not found.");
                }

                int i;
                for (i = 0; i <= bodyContent.Length - 1; i++)
                {
                    subject = subject.Replace(string.Concat(i.ToString(), "?"), bodyContent[i]);
                    body = body.Replace(string.Concat(i.ToString(), "?"), bodyContent[i]);
                }

                dynamic mailMessage = new MailMessage();
                mailMessage.From = new MailAddress(mailSetting.FromAddress);
                mailMessage.To.Add(toAddress);
                mailMessage.Subject = subject;
                mailMessage.IsBodyHtml = true;
                mailMessage.Body = body;

                SmtpClient smtpClient = new SmtpClient
                {
                    Host = mailSetting.SmtpClient,
                    EnableSsl = mailSetting.EnableSSL,
                    Port = Convert.ToInt32(mailSetting.SMTPPort),
                    Credentials = new NetworkCredential(mailSetting.UserID, mailSetting.Password)
                };
                try
                {
                    smtpClient.Send(mailMessage);
                }
                catch (SmtpFailedRecipientsException smtpFailedRecipientsException1)
                {
                    SmtpFailedRecipientsException smtpFailedRecipientsException = smtpFailedRecipientsException1;
                    for (int j = 0; j <= smtpFailedRecipientsException.InnerExceptions.Length; j++)
                    {
                        SmtpStatusCode statusCode = smtpFailedRecipientsException.InnerExceptions[j].StatusCode;
                        if (statusCode == SmtpStatusCode.MailboxBusy | statusCode == SmtpStatusCode.MailboxUnavailable)
                        {
                            Thread.Sleep(2000);
                            smtpClient.Send(mailMessage);
                        }
                    }
                }
            }

            return Task.FromResult(1);
        }

        public Task SendMailTrap(IdentityMessage message)
        {
            var client = new SmtpClient("smtp.mailtrap.io", 2525)
            {
                Credentials = new NetworkCredential("3ae049f5293edc", "c9036146acfb85"),
                EnableSsl = true
            };

            var from = new MailAddress("ddemo9698@gmail.com", "My Awesome Admin");
            var to = new MailAddress(message.Destination);

            var mail = new MailMessage(from, to)
            {
                Subject = message.Subject,
                Body = message.Body,
                IsBodyHtml = true,
            };

            client.Send(mail);

            return Task.FromResult(0);
        }
    }
}
