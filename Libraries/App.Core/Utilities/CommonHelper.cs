using App.Core.Extensions;
using App.Core.Infrastructure;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Hosting;
using System.Web.Security;

namespace App.Core.Utilities
{
    public static class CommonHelper
	{
		public static bool IsTruthy(object value)
		{
			if (value == null)
				return false;

			switch (value)
			{
				case string x:
					return x.HasValue();
				case bool x:
					return x;
				case DateTime x:
					return x > DateTime.MinValue;
				case TimeSpan x:
					return x > TimeSpan.MinValue;
				case Guid x:
					return x != Guid.Empty;
				case IComparable x:
					return x.CompareTo(0) != 0;
				case IEnumerable<object> x:
					return x.Any();
				case IEnumerable x:
					return x.GetEnumerator().MoveNext();
			}

			if (value.GetType().IsNullable(out var wrappedType))
			{
				return IsTruthy(Convert.ChangeType(value, wrappedType));
			}

			return true;
		}

	    public static string MapPath(string path, bool findAppRoot = true)
	    {
	        if (HostingEnvironment.IsHosted)
	        {
	            return HostingEnvironment.MapPath(path);
	        }

	        // not hosted. For example, running in unit tests or EF tooling
	        var baseDirectory = AppDomain.CurrentDomain.BaseDirectory;
	        path = path.Replace("~/", "").TrimStart('/').Replace('/', '\\');

	        var testPath = Path.Combine(baseDirectory, path);

	        return testPath;
	    }

	    public static T GetAppSetting<T>(string key, T defValue = default(T))
	    {
	        var setting = ConfigurationManager.AppSettings[key];

	        if (setting == null)
	        {
	            return defValue;
	        }

	        return setting.Convert<T>();
	    }

	    public static string GetBaseUrl => HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority);

        public static string ApplicationName => Membership.ApplicationName.ToLower();

        public static int PageSize => int.Parse(ConfigurationManager.AppSettings["ItemsPerPage"]);

      
        
        public static long GetTime()
        {
            DateTime dateTime = new DateTime(1970, 1, 1);
            TimeSpan universalTime = DateTime.Now.ToUniversalTime() - dateTime;

            return (long)(universalTime.TotalMilliseconds + 0.5);
        }

        public static string FolderName(string fileName = null)
        {
            string result = $"{DateTime.UtcNow:yyyyMMdd}";

            if (fileName != null)
            {
                var firstCharsa = fileName.Where((ch, index) => ch != ' ' && (index == 0 || fileName[index - 1] == ' '));
                var firstLeter = string.Join("", firstCharsa.ToArray()).NonAccent().ToUpper();

                result = $"{DateTime.UtcNow.Year}.{firstLeter}";
            }

            return result;
        }


      

        
    }
}
