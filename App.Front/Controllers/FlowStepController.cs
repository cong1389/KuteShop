using System.Collections.Generic;
using System.Web.Mvc;
using App.Domain.Entities.Data;
using App.Service.Step;

namespace App.Front.Controllers
{
    public class FlowStepController : Controller
    {
        private readonly IFlowStepService _flowStepService;
        public FlowStepController(IFlowStepService flowStepService)
        {
            _flowStepService = flowStepService;
        }

        public ActionResult FlowStepHome()
        {
            IEnumerable<FlowStep> flowSteps = _flowStepService.FindBy(x => x.Status == 1, false);

            return PartialView(flowSteps);
        }

    }
}