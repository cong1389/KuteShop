using System.Web.Mvc;
using App.Domain.Entities.GlobalSetting;
using App.Service.ContactInformation;

namespace App.Front.Controllers
{
	public class GoogleMapController : Controller
	{
		private IContactInfoService _contactInfoService;

		public GoogleMapController(IContactInfoService contactInfoService)
		{
			_contactInfoService = contactInfoService;
		}

		public ActionResult ShowGoogleMap(int id)
		{
			ContactInformation contactInformation = _contactInfoService.Get(x => x.Id == id, false);
			return View(contactInformation);
		}
	}
}