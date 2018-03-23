using System.Threading.Tasks;
using Microsoft.AspNet.Identity;

namespace App.Service.MailSetting
{
    public interface ISendMailService
    {
        Task SendAsync(IdentityMessage message);
        Task SendMailSmtp(string messageId, string toAddress, string[] bodyContent);
        Task SendMailTrap(IdentityMessage message);
    }
}