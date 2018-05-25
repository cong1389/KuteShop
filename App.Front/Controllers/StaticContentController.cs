using App.Domain.Common;
using App.Domain.Entities.Data;
using App.Front.Extensions;
using App.Front.Models;
using App.Service.Menu;
using App.Service.Static;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace App.Front.Controllers
{
    public class StaticContentController : FrontBaseController
    {
        private readonly IStaticContentService _staticContentService;

        public StaticContentController(IStaticContentService staticContentService
            , IMenuLinkService menuLinkService
            )
        {
            _staticContentService = staticContentService;
        }

        //[PartialCache("Long")]
        [ChildActionOnly]
        public ActionResult Services(int menuId)
        {
            var staticContents = PrepareStaticContents(menuId);

            if (staticContents == null)
            {
                return HttpNotFound();
            }

            return PartialView(staticContents);
        }

        private IEnumerable<StaticContent> PrepareStaticContents(int menuId)
        {
            var staticContents = _staticContentService.GetStaticContents(menuId, (int)Status.Enable);

            return staticContents.Select(x => x.ToModel());
        }
    }
}