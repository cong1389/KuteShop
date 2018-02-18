using System.Collections.Generic;
using System.Web.Mvc;
using App.Domain.Entities.Attribute;
using App.Front.Models;
using App.Service.Attribute;

namespace App.Front.Controllers
{
    public class SearchBoxController : Controller
    {
        private readonly IAttributeService _attributeService;

        public SearchBoxController(IAttributeService attributeService)
        {
            _attributeService = attributeService;
        }

        public ActionResult SearchMenu()
        {
            SeachConditions seachConditions = new SeachConditions();

            return PartialView(seachConditions);
        }

        public ActionResult SearchMenuMobile()
        {
            SeachConditions seachConditions = new SeachConditions();

            return PartialView(seachConditions);
        }

        public ActionResult GetAttributeSearchBox(List<int> attributes = null)
        {
            ViewBag.Attributes = attributes;

            IEnumerable<Attribute> ieAttributes = _attributeService.FindBy(x => x.Status == 1, false);

            return PartialView(ieAttributes);
        }

        public ActionResult SearchBoxSideBar(int? productOld, int? productNew, List<int> attributes = null,
            List<double> prices = null, List<int> proAttrs = null, string virtualId = null)
        {
            ViewBag.Attributes = attributes;
            ViewBag.ProAttrs = proAttrs;
            ViewBag.Prices = prices;
            ViewBag.ProductOld = productOld;
            ViewBag.ProductNew = productNew;
            ViewBag.VirtualId = virtualId;

            return PartialView();
        }
    }
}