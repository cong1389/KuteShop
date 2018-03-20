using System.Threading.Tasks;
using Microsoft.AspNet.Identity;

namespace App.Service.Account
{
    public interface IEmailService
    {
        Task SendAsync(IdentityMessage message);
    }
}