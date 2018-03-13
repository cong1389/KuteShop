using System.Linq;
using System.Web.Mvc;
using App.Aplication.Extensions;
using App.Front.Models;
using App.Front.Models.Localizeds;
using App.Service.Slide;

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
            var slideShows = _slideShowService.FindBy(x => x.Status == 1, true);

            if (slideShows == null)
            {
                return HttpNotFound();
            }

            slideShows = slideShows.Select(x => x.ToModel());                    

            return PartialView(slideShows);
        }
    }
}