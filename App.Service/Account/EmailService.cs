using System.Net;
using System.Net.Mail;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;


namespace App.Service.Account
{
    public class EmailService : IIdentityMessageService, IEmailService
    {
        public Task SendAsync(IdentityMessage message)
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
