using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using App.Domain.Common;
using App.Service.Orders;
using Domain.Entities.Customers;

namespace App.Service.Messages
{
    public class MessageModelProvider : IMessageModelProvider
    {
        public virtual void AddGlobalModelParts(MessageContext messageContext)
        {
            var model = messageContext.Model;

            model["Context"] = new Dictionary<string, object>
            {
                { "TemplateName", messageContext.MessageTemplate.Name },
                { "LanguageId", messageContext.Language.Id },
                { "LanguageCulture", messageContext.Language.LanguageCode },
                { "BaseUrl", messageContext.BaseUri.ToString() }
            };

            dynamic email = new ExpandoObject();
            email.Email = messageContext.EmailAccount.FromAddress;
            email.SenderName = messageContext.EmailAccount.UserID;
            email.DisplayName = messageContext.EmailAccount.UserID; // Alias
            model["Email"] = email;

            //model["Theme"] = CreateThemeModelPart(messageContext);
            //model["Customer"] = CreateModelPart(messageContext.Customer, messageContext);
            //model["Store"] = CreateModelPart(messageContext.Store, messageContext);
        }
    }
}
