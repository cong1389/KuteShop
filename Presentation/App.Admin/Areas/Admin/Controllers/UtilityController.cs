using App.Admin.Helpers;
using App.Framework.Utilities;
using App.Service.Media;
using System;
using System.Web.Mvc;

namespace App.Admin.Controllers
{
    public class UtilityController : Controller
    {
        private readonly IImageService _imageService;

        public UtilityController(IImageService imageService)
        {
            _imageService = imageService;
        }

        public ActionResult GoogleMap(string gLat, string gLag)
        {
            ViewBag.GLat = gLat;
            ViewBag.GLag = gLag;

            return View();
        }

        public ActionResult Upload()
        {
            var item = HttpContext.Request.Files["upload"];
            var str = HttpContext.Request["CKEditorFuncNum"];

            var guid = Guid.NewGuid();

            var str1 = string.Concat(guid.ToString(), ".jpg");

            _imageService.CropAndResizeImage(item, $"{Constant.PostFolder}", str1, ImageSize.WidthDefaultSize, ImageSize.HeightDefaultSize);

            var str2 = string.Concat("http://", HttpContext.Request.Url.Authority, "/", Constant.PostFolder, str1);
            HttpContext.Response.Write(string.Concat("<script>window.parent.CKEDITOR.tools.callFunction(", str, ", \"", str2, "\");</script>"));

            return new EmptyResult();
        }
    }
}