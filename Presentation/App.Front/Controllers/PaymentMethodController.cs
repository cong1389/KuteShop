using App.FakeEntity.Payments;
using App.Framework.UI.Extensions;
using App.Front.Extensions;
using App.Service.PaymentMethodes;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace App.Front.Controllers
{
    public class PaymentMethodController : Controller
    {
        private readonly IPaymentMethodService _paymentMethodService;

        public PaymentMethodController(IPaymentMethodService paymentMethodService)
        {
            _paymentMethodService = paymentMethodService;
        }

        [HttpPost]
        public JsonResult PaymentMethodFooter()
        {
            var model = PreparePaymentMethod();

            var jsonResult =
                Json(new { success = true, list = this.RenderRazorViewToString("_PaymentMethodFooter", model) },
                    JsonRequestBehavior.AllowGet);

            return jsonResult;
        }

        private IEnumerable<PaymentMethodViewModel> PreparePaymentMethod()
        {
            var paymentMethods = _paymentMethodService.GetAll();

            return paymentMethods.Select(x => x.ToModel());
        }
    }
}