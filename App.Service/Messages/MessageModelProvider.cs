using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using App.Core.Common;
using App.Core.ComponentModel;
using App.Core.Extensions;
using App.Core.Templating;
using App.Domain.Common;
using App.Domain.Orders;
using App.Service.Orders;
using Domain.Entities.Customers;

namespace App.Service.Messages
{
    public partial class MessageModelProvider : IMessageModelProvider
    {
        public virtual void AddGlobalModelParts(MessageContext messageContext)
        {
            var model = messageContext.Model;

            model["Context"] = new Dictionary<string, object>
            {
                { "TemplateName", messageContext.MessageTemplate.Name },
                { "LanguageId", messageContext.Language.Id },
                { "LanguageCulture", messageContext.Language.LanguageCode }
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

        protected virtual object CreateModelPart(Address part, MessageContext messageContext)
        {
            //var settings = _services.Resolve<AddressSettings>();
            //var languageId = messageContext.Language?.Id ?? messageContext.LanguageId;

            var salutation = part.Salutation.NullEmpty();
            var title = part.Title.NullEmpty();
            //var company = settings.CompanyEnabled ? part.Company : null;
            //var firstName = part.FirstName.NullEmpty();
            //var lastName = part.LastName.NullEmpty();
            //var street1 = settings.StreetAddressEnabled ? part.Address1 : null;
            //var street2 = settings.StreetAddress2Enabled ? part.Address2 : null;
            //var zip = settings.ZipPostalCodeEnabled ? part.ZipPostalCode : null;
            //var city = settings.CityEnabled ? part.City : null;
            //var country = settings.CountryEnabled ? part.Country?.GetLocalized(x => x.Name, languageId ?? 0).NullEmpty() : null;
            //var state = settings.StateProvinceEnabled ? part.StateProvince?.GetLocalized(x => x.Name, languageId ?? 0).NullEmpty() : null;

            var m = new Dictionary<string, object>
            {
                { "Title", title },
                //{ "Salutation", salutation },
                //{ "FullSalutation", part.GetFullSalutaion().NullEmpty() },
                //{ "FullName", part.GetFullName(false).NullEmpty() },
                //{ "Company", company },
                //{ "FirstName", firstName },
                //{ "LastName", lastName },
                //{ "Street1", street1 },
                //{ "Street2", street2 },
                //{ "Country", country },
                //{ "CountryId", part.Country?.Id },
                //{ "CountryAbbrev2", settings.CountryEnabled ? part.Country?.TwoLetterIsoCode.NullEmpty() : null },
                //{ "CountryAbbrev3", settings.CountryEnabled ? part.Country?.ThreeLetterIsoCode.NullEmpty() : null },
                //{ "State", state },
                //{ "StateAbbrev", settings.StateProvinceEnabled ? part.StateProvince?.Abbreviation.NullEmpty() : null },
                //{ "City", city },
                //{ "ZipCode", zip },
                //{ "Email", part.Email.NullEmpty() },
                //{ "Phone", settings.PhoneEnabled ? part.PhoneNumber : null },
                //{ "Fax", settings.FaxEnabled ? part.FaxNumber : null }
            };

            //m["NameLine"] = Concat(salutation, title, firstName, lastName);
            //m["StreetLine"] = Concat(street1, street2);
            //m["CityLine"] = Concat(zip, city);
            //m["CountryLine"] = Concat(country, state);

            return m;
        }
    }
}
