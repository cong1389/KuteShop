using System.Collections.Generic;
using System.Web.Mvc;
using App.Domain.Entities.Data;
using App.Service.Manufacturers;

namespace App.Front.Controllers
{
    public class FlowStepController : Controller
    {
        private readonly IManufacturerService _manufacturerService;
        public FlowStepController(IManufacturerService manufacturerService)
        {
            _manufacturerService = manufacturerService;
        }

        public ActionResult FlowStepHome()
        {
            IEnumerable<Manufacturer> flowSteps = _manufacturerService.FindBy(x => x.Status == 1);

            return PartialView(flowSteps);
        }

    }
}