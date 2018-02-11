using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using App.Aplication.Extensions;
using App.Domain.Entities.Slide;
using App.Front.Models;
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
        public ActionResult GetSlideShow()
        {
            IEnumerable<SlideShow> slideShows = _slideShowService.FindBy(x => x.Status == 1, true);

            if (slideShows == null)
                return HttpNotFound();

            slideShows = slideShows.Select(x =>
            {
                return x.ToModel();
            });                    

            return PartialView(slideShows);
        }
    }
}