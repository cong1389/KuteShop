using App.Domain.ServerMails;
using Microsoft.AspNet.Identity;
using System.Threading.Tasks;

namespace App.Service.Messages
{
    public interface ISendMailService
    {
        Task SendAsync(IdentityMessage message);
        Task SendMailSmtp(SendMail message);
        Task SendMailTrap(IdentityMessage message);
    }
}