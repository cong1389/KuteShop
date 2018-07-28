using App.GoogleAnalytics.Models;
using SmartStore.ComponentModel;
using SmartStore.Core;
using SmartStore.Core.Logging;
using SmartStore.Services.Catalog;
using SmartStore.Services.Configuration;
using SmartStore.Services.Orders;
using SmartStore.Services.Stores;
using SmartStore.Web.Framework.Controllers;
using SmartStore.Web.Framework.Security;
using SmartStore.Web.Framework.Settings;
using System.Web.Mvc;

namespace App.GoogleAnalytics.Controllers
{
    public class WidgetsGoogleAnalyticsController : SmartController
    {
        private readonly IWorkContext _workContext;
		private readonly IStoreContext _storeContext;
		private readonly IStoreService _storeService;
        private readonly ISettingService _settingService;
        private readonly IOrderService _orderService;
        private readonly ICategoryService _categoryService;

        public WidgetsGoogleAnalyticsController(IWorkContext workContext,
			IStoreContext storeContext, IStoreService storeService,
			ISettingService settingService, IOrderService orderService,
            ICategoryService categoryService)
        {
            this._workContext = workContext;
			this._storeContext = storeContext;
			this._storeService = storeService;
            this._settingService = settingService;
            this._orderService = orderService;
            this._categoryService = categoryService;
        }

        [AdminAuthorize, ChildActionOnly, LoadSetting]
        public ActionResult Configure(GoogleAnalyticsSettings settings)
        {
           

            return View();
        }

        [HttpPost, AdminAuthorize, ChildActionOnly, ValidateInput(false)]
        public ActionResult Configure(ConfigurationModel model, FormCollection form)
        {

			return RedirectToConfiguration("SmartStore.GoogleAnalytics");
        }

        [ChildActionOnly]
        public ActionResult PublicInfo(string widgetZone)
        {
            string globalScript = "";
           
            return Content(globalScript);
        }
    }
}