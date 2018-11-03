using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
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
