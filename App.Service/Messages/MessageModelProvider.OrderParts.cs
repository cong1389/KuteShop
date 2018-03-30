using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using App.Core.ComponentModel;
using App.Core.Extensions;
using App.Domain.Orders;

namespace App.Service.Messages
{
    public partial class MessageModelProvider
    {
        protected virtual object CreateModelPart(Order part, MessageContext messageContext)
        {
            var allow = new HashSet<string>
            {
                nameof(part.Id),
                nameof(part.OrderNumber),
                nameof(part.OrderGuid),
                nameof(part.StoreId),
                nameof(part.OrderStatus),
                nameof(part.PaymentStatus),
                nameof(part.ShippingStatus),
                //nameof(part.CustomerTaxDisplayType),
                //nameof(part.TaxRatesDictionary),
                nameof(part.VatNumber),
                nameof(part.AffiliateId),
                nameof(part.CustomerIp),
                nameof(part.CardType),
                nameof(part.CardName),
                nameof(part.MaskedCreditCardNumber),
                nameof(part.DirectDebitAccountHolder),
                nameof(part.DirectDebitBankCode), // TODO: (mc) Liquid > Bank data (?)
				nameof(part.PurchaseOrderNumber),
                nameof(part.ShippingMethod),
                nameof(part.PaymentMethodSystemName),
                nameof(part.ShippingRateComputationMethodSystemName)
				// TODO: (mc) Liquid > More whitelisting?
			};

            var m = new HybridExpando(part, allow, MemberOptMethod.Allow);
            var d = m as dynamic;

            d.ID = part.Id;
            d.Billing = CreateModelPart(part.BillingAddress, messageContext);
            if (part.ShippingAddress != null)
            {
               // d.Shipping = part.ShippingAddress.IsPostalDataEqual(part.BillingAddress) == true ? null : CreateModelPart(part.ShippingAddress, messageContext);
            }
            d.CustomerEmail = part.BillingAddress.Email.NullEmpty();
            d.CustomerComment = part.CustomerOrderComment.NullEmpty();
            d.Status = 1;
            //d.Disclaimer = GetTopic("Disclaimer", messageContext);
            //d.ConditionsOfUse = GetTopic("ConditionsOfUse", messageContext);
            //d.Status = part.OrderStatus.GetLocalizedEnum(_services.Localization, messageContext.Language.Id);
            d.CreatedOn = part.CreatedOnUtc;
            //d.PaidOn = ToUserDate(part.PaidDateUtc, messageContext);

            // Payment method
            var paymentMethodName = part.PaymentMethodSystemName;
            //var paymentMethod = _services.Resolve<IProviderManager>().GetProvider<IPaymentMethod>(part.PaymentMethodSystemName);
            //if (paymentMethod != null)
            //{
            //    //paymentMethodName = GetLocalizedValue(messageContext, paymentMethod.Metadata, nameof(paymentMethod.Metadata.FriendlyName), x => x.FriendlyName);
            //}
            d.PaymentMethod = paymentMethodName.NullEmpty();

            //d.Url = part.Customer != null && !part.Customer.IsGuest()
            //    ? BuildActionUrl("Details", "Order", new { id = part.Id, area = "" }, messageContext)
            //    : null;

            //// Overrides
            m.Properties["OrderNumber"] = "123";
            //m.Properties["AcceptThirdPartyEmailHandOver"] = GetBoolResource(part.AcceptThirdPartyEmailHandOver, messageContext);

            //// Items, Totals & Co.
            //d.Items = part.OrderItems.Where(x => x.Product != null).Select(x => CreateModelPart(x, messageContext)).ToList();
            //d.Totals = CreateOrderTotalsPart(part, messageContext);

            //// Checkout Attributes
            //if (part.CheckoutAttributeDescription.HasValue())
            //{
            //    d.CheckoutAttributes = HtmlUtils.ConvertPlainTextToTable(HtmlUtils.ConvertHtmlToPlainText(part.CheckoutAttributeDescription)).NullEmpty();
            //}

            //PublishModelPartCreatedEvent<Order>(part, m);

            return m;
        }
    }
}
