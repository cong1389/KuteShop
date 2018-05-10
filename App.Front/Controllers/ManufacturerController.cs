using System.Web.Mvc;
using App.Service.Manufacturers;

namespace App.Front.Controllers
{
    public class ManufacturerController : Controller
    {
        private readonly IManufacturerService _manufacturerService;
        public ManufacturerController(IManufacturerService manufacturerService)
        {
            _manufacturerService = manufacturerService;
        }

        public ActionResult ManufacturerHome()
        {
            var flowSteps = _manufacturerService.FindBy(x => x.Status == 1);

            return PartialView(flowSteps);
        }

    }
}