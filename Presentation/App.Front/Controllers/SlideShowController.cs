using App.Core.Extensions;
using App.Front.Extensions;
using App.Front.Models;
using App.Service.Slides;
using System.Linq;
using System.Web.Mvc;

namespace App.Front.Controllers
{
    public class SlideShowController : FrontBaseController
    {
        private readonly ISlideShowService _slideShowService;

        public SlideShowController(ISlideShowService slideShowService)
        {
            _slideShowService = slideShowService;
        }

        [PartialCache("Long")]
        public ActionResult SlideShowHome()
        {
            var slideShows = _slideShowService.GetEnableOrDisables();

            if (!slideShows.IsAny())
            {
                return HttpNotFound();
            }

            slideShows = slideShows.Select(x => x.ToModel());

            return PartialView(slideShows);
        }
    }
}