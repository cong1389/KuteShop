using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.Hosting;
using System.Web.Security;
using App.Core.Extensions;
using App.Core.Infrastructure;
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

	                url = File.Exists(src) ? PictureService.BuildUrlCore(imagePath, query, null) : PictureService.BuildUrlCore(Contains.ImageNoExsits, query, null);
	            }
	            else
	            {
	                url = PictureService.BuildUrlCore(Contains.ImageNoExsits, query, null);
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
    }
}