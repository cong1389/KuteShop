using System.Web;

namespace App.Core.Collections
{
    public class QueryString
    {
        public static string GetParameter(string param, string defaultValue)
        {
            string stringValue = HttpContext.Current.Request.QueryString[param];
            if (null == stringValue)
            {
                return defaultValue;
            }

            stringValue = stringValue.Contains("?") ? stringValue.Split('?')[0] : stringValue;
            return stringValue;

        }
    }
}
