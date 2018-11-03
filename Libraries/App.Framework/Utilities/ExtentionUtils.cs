using System;
using System.IO;
using System.Threading;
using System.Web;
using App.Core.Extensions;
using App.Service.Media;

namespace App.Framework.Utilities
{
    public static class ExtentionUtils
	{
	    public static string ValidateImage(this string imagePath)
	    {
	        string src = string.Empty, url = string.Empty;
	        var query = "";
	        try
	        {
	            if (!string.IsNullOrEmpty(imagePath))
	            {
	                src = HttpContext.Current.Server.MapPath(String.Concat("~/", imagePath));

	                url = File.Exists(src) ? PictureService.BuildUrlCore(imagePath, query, null) : PictureService.BuildUrlCore(Constant.ImageNoExsits, query, null);
	            }
	            else
	            {
	                url = PictureService.BuildUrlCore(Constant.ImageNoExsits, query, null);
	            }
	        }
	        catch (Exception ex)
	        {
	            string exx = ex.Message;
	        }

	        return url;
	    }

	    public static string FormatPrice(this decimal? amount)
	    {
	        var cultureInfo = Thread.CurrentThread.CurrentCulture;

	        var fmt = cultureInfo.NumberFormat;
	        return amount?.ToString("C", fmt).Replace(",00", "");
	    }

	    public static string FormatPersent(this decimal? amount)
	    {
	        var cultureInfo = Thread.CurrentThread.CurrentCulture;

	        var fmt = cultureInfo.NumberFormat;

	        return $"{amount?.ToString("G29")}%";
	    }

        public static string CurrentHost => string.Concat("http://", HttpContext.Current.Request.Url.Authority);

	    public static bool IsHomePage()
	    {
	        var routeData = HttpContext.Current.Request.RequestContext.RouteData;

	        return routeData.GetRequiredString("controller").IsCaseInsensitiveEqual("Home") &&
	               routeData.GetRequiredString("action").IsCaseInsensitiveEqual("Index");
	    }

    }
}