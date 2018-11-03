using System;
using System.Web;

namespace App.Framework.Extensions
{
    public static class HttpExtension
    {
        public static bool ExistsCokiee(this HttpCookieCollection cookieCollection, string name)
        {
            if (cookieCollection == null)
            {
                throw new ArgumentNullException("cookieCollection");
            }
            return cookieCollection[name] != null;
        }

        public static bool ExistsFile(this HttpPostedFileBase file)
        {
            return file != null && file.ContentLength > 0;
        }
    }
}
