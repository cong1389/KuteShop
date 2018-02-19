using System;
using System.Web;
using System.Web.Mvc;
using App.Admin.Helpers;
using App.Aplication;

namespace App.Admin.Controllers
{
    public class UtilityController : Controller
    {
        private readonly IImagePlugin _imagePlugin;

        public UtilityController(IImagePlugin imagePlugin)
        {
            _imagePlugin = imagePlugin;
        }

        public ActionResult GoogleMap(string gLat, string gLag)
        {
            ViewBag.GLat = gLat;
            ViewBag.GLag = gLag;

            return View();
        }

        public ActionResult Upload()
        {
            HttpPostedFileBase item = HttpContext.Request.Files["upload"];
            string str = HttpContext.Request["CKEditorFuncNum"];

            Guid guid = Guid.NewGuid();

            string str1 = string.Concat(guid.ToString(), ".jpg");

            _imagePlugin.CropAndResizeImage(item, $"{Contains.PostFolder}", str1, ImageSize.WithOrignalSize, ImageSize.HeighthOrignalSize);

            string str2 = string.Concat("http://", HttpContext.Request.Url.Authority, "/", Contains.PostFolder, str1);
            HttpContext.Response.Write(string.Concat("<script>window.parent.CKEDITOR.tools.callFunction(", str, ", \"", str2, "\");</script>"));

            return new EmptyResult();
        }
    }
}