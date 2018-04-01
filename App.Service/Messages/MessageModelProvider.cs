using System;
using System.Collections.Generic;
using System.Dynamic;
using App.Core.Common;
using App.Core.ComponentModel;
using App.Core.Extensions;
using App.Core.IO.VirtualPath;
using App.Core.Templating;
using App.Domain.Entities.GlobalSetting;
using App.Domain.Orders;
using App.Service.Common;
using App.Service.SystemApp;

namespace App.Service.Messages
{
    public partial class MessageModelProvider : IMessageModelProvider
    {
        private readonly ICommonServices _services;
        private readonly IVirtualPathProvider _vpp;

        public MessageModelProvider(ICommonServices services, IVirtualPathProvider vpp)
        {
            _services = services;
            _vpp = vpp;
        }

        public virtual void AddGlobalModelParts(MessageContext messageContext)
        {
            var model = messageContext.Model;

            model["Context"] = new Dictionary<string, object>
            {
                { "TemplateName", messageContext.MessageTemplate.Name },
                { "LanguageId", messageContext.Language.Id },
                { "LanguageCulture", messageContext.Language.LanguageCode },
                { "BaseUrl", messageContext.BaseUri }
            };

            dynamic email = new ExpandoObject();
            email.Email = messageContext.EmailAccount.FromAddress;
            email.SenderName = messageContext.EmailAccount.UserID;
            email.DisplayName = messageContext.EmailAccount.UserID; // Alias
            model["Email"] = email;
            model["Theme"] = CreateThemeModelPart(messageContext);
            //model["Customer"] = CreateModelPart(messageContext.Customer, messageContext);
            model["Store"] = CreateModelPart(messageContext.SystemSettings, messageContext);
        }

        public virtual void AddModelPart(object part, MessageContext messageContext, string name = null)
        {
            var model = messageContext.Model;

            name = name.NullEmpty() ?? ResolveModelName(part);

            object modelPart = null;

            switch (part)
            {
                case INamedModelPart x:
                    modelPart = x;
                    break;
                case IModelPart x:
                    MergeModelBag(x, model, messageContext);
                    break;
                case Order x:
                    modelPart = CreateModelPart(x, messageContext);
                    break;

            }

            if (modelPart != null)
            {
                if (name.IsEmpty())
                {
                    throw new Exception($"Could not resolve a model key for part '{modelPart.GetType().Name}'. Use an instance of 'NamedModelPart' class to pass model with name.");
                }

                if (model.TryGetValue(name, out var existing))
                {
                    // A model part with the same name exists in model already...
                    if (existing is IDictionary<string, object> x)
                    {
                        // but it's a dictionary which we can easily merge with
                        x.Merge(FastProperty.ObjectToDictionary(modelPart), true);
                    }
                    else
                    {
                        // Wrap in HybridExpando and merge
                        var he = new HybridExpando(existing, true);
                        he.Merge(FastProperty.ObjectToDictionary(modelPart), true);
                        model[name] = he;
                    }
                }
                else
                {
                    // Put part to model as new property
                    model[name] = modelPart;
                }
            }
        }

        public string ResolveModelName(object model)
        {
            string name = null;
            var type = model.GetType();

            try
            {
                if (model is BaseEntity be)
                {
                    name = be.GetUnproxiedType().Name;
                }
                else if (model is ITestModel te)
                {
                    name = te.ModelName;
                }
                else if (model is INamedModelPart mp)
                {
                    name = mp.ModelPartName;
                }
                else if (type.IsPlainObjectType())
                {
                    name = type.Name;
                }
            }
            catch { }

            return name;
        }

        protected virtual void MergeModelBag(IModelPart part, IDictionary<string, object> model, MessageContext messageContext)
        {
            if (!(model.Get("Bag") is IDictionary<string, object> bag))
            {
                model["Bag"] = bag = new Dictionary<string, object>();
            }

            var source = part as IDictionary<string, object>;
            bag.Merge(source);
        }

        protected virtual object CreateThemeModelPart(MessageContext messageContext)
        {
            var m = new Dictionary<string, object>
            {
                { "FontFamily", "-apple-system, system-ui, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif" },
                { "BodyBg", "#f2f4f6" },
                { "BodyColor", "#555" },
                { "TitleColor", "#2f3133" },
                { "ContentBg", "#fff" },
                { "ShadeColor", "#e2e2e2" },
                { "LinkColor", "#0066c0" },
                { "BrandPrimary", "#3f51b5" },
                { "BrandSuccess", "#4caf50" },
                { "BrandWarning", "#ff9800" },
                { "BrandDanger", "#f44336" },
                { "MutedColor", "#a5a5a5" },
            };

            return m;
        }

        protected virtual object CreateModelPart(MessageContext messageContext)
        {
            var host = messageContext.BaseUri.ToString();
            //var logoInfo = _services.PictureService.GetPictureInfo(messageContext.Store.LogoPictureId);

            // Issue: https://github.com/smartstoreag/SmartStoreNET/issues/1321

            var m = new Dictionary<string, object>
            {
                { "Email", messageContext.EmailAccount.FromAddress },
                { "EmailName", messageContext.EmailAccount.FromAddress },
                { "Name", "" },
                { "Url", host },
                { "Cdn", "" },
                { "PrimaryStoreCurrency", "" },
                { "PrimaryExchangeRateCurrency","" },
                { "Logo", "" },
                { "Company", "" },
                { "Contact","" },
                { "Bank", "" },
                { "Copyright", "" }
            };

            return m;
        }

        protected virtual object CreateModelPart(SystemSetting part, MessageContext messageContext)
        {
            var host = messageContext.BaseUri.ToString();

            var m = new Dictionary<string, object>
            {
                { "Title", part.Title},
                { "LogoSrc",_vpp.Combine(host, part.LogoImage) },
            };

            //m["NameLine"] = Concat(salutation, title, firstName, lastName);
            //m["StreetLine"] = Concat(street1, street2);
            //m["CityLine"] = Concat(zip, city);
            //m["CountryLine"] = Concat(country, state);

            return m;
        }
    }
}
