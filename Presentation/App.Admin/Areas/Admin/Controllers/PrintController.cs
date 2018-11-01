using App.Service.Repairs;
using System.Web.Mvc;

namespace App.Admin.Controllers
{
    public class PrintController : Controller
    {
        private readonly IRepairService _orderService;

        public PrintController(IRepairService orderService)
        {
            _orderService = orderService;
        }

        public ActionResult Bill(int id)
        {
            var order = _orderService.Get(x => x.Id == id);
            return View(order);
        }

        public ActionResult Warranty(int id)
        {
            var order = _orderService.Get(x => x.Id == id);
            return View(order);
        }
    }
}