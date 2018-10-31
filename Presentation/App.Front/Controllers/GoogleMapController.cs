using App.Service.ContactInfors;
using System.Web.Mvc;

namespace App.Front.Controllers
{
    public class GoogleMapController : Controller
	{
		private readonly IContactInfoService _contactInfoService;

		public GoogleMapController(IContactInfoService contactInfoService)
		{
			_contactInfoService = contactInfoService;
		}

		public ActionResult ShowGoogleMap(int id)
		{
			var contactInformation = _contactInfoService.Get(x => x.Id == id);

			return View(contactInformation);
		}
	}
}