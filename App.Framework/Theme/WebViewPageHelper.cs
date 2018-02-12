using App.Core.Extensions;
using App.Core.Localization;
using System.Web.Mvc;

namespace App.Framework.Theme
{
    public class WebViewPageHelper
    {
        private bool _initialized;

        public WebViewPageHelper()
        {
            T = NullLocalizer.Instance;
        }

        public Localizer T { get; set; }

        public void Initialize(ViewContext viewContext)
        {
            if (_initialized) return;

            viewContext.GetMasterControllerContext();
            _initialized = true;
        }
    }
}
