using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using App.Aplication;
using App.Domain.Entities.GlobalSetting;
using App.Domain.Entities.Location;
using App.Front.Models;
using App.Service.ContactInformation;
using App.Service.Locations;
using Newtonsoft.Json;

namespace App.Front.Controllers
{
	public class StoreListController : FrontBaseController
	{
		private readonly IProvinceService _provinceService;

		private readonly IContactInfoService _contactInfoService;

		public StoreListController(IProvinceService provinceService, IContactInfoService contactInfoService)
		{
			_provinceService = provinceService;
			_contactInfoService = contactInfoService;
		}

		public ActionResult GetStoreListByProvince(int Id)
		{
			if (!Request.IsAjaxRequest())
			{
				return Json(new { success = false });
			}
			IEnumerable<ContactInformation> ContactInformations = _contactInfoService.FindBy(x => x.Status == 1 && x.ProvinceId == (int?)Id, true);
			List<StoreList> storeLists = new List<StoreList>();
			if (ContactInformations.IsAny())
			{
				storeLists.AddRange(
					from item in ContactInformations
					select new StoreList
					{
						Address = item.Address,
						Lat = item.Lat,
						Lng = item.Lag,
						Phone = item.MobilePhone,
						Title = item.Title
					});
			}
			return Json(new { data = storeLists, success = true });
		}

		public ActionResult Index(int Id)
		{
			Province province = _provinceService.GetTop(1, x => x.Status == 1, x => x.OrderDisplay).FirstOrDefault();
			IEnumerable<Province> top = _provinceService.GetTop(2147483647, x => x.Status == 1, x => x.OrderDisplay);
			ViewBag.Provinces = top;
			IEnumerable<ContactInformation> ContactInformations = _contactInfoService.FindBy(x => x.Status == 1 && x.ProvinceId == (int?)province.Id, true);
			List<StoreList> storeLists = new List<StoreList>();
			if (ContactInformations.IsAny())
			{
				storeLists.AddRange(
					from item in ContactInformations
					select new StoreList
					{
						Address = item.Address,
						Lat = item.Lat,
						Lng = item.Lag,
						Phone = item.MobilePhone,
						Title = item.Title,
						NumberOfStore = item.NumberOfStore
					});
				ViewBag.Data = JsonConvert.SerializeObject(storeLists);
			}
			return PartialView(ContactInformations);
		}
	}
}