using System;
using System.Collections.Generic;
using System.IO;
using System.Web;

namespace App.Core.Logging
{
    public static class LogText
    {
        public static bool Log(string txt)
        {
            bool flag;
            try
            {
                HttpContext current = HttpContext.Current;
                string str = "";
                if (current != null)
                {
                    str = current.Request.Url.ToString();
                }
                if (!Directory.Exists(HttpContext.Current.Server.MapPath("~/Logs")))
                {
                    Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~/Logs"));
                }
                DateTime now = DateTime.Now;
                string str1 = $"Logs/{now:yyyyMMdd}.txt";
                if (!File.Exists(string.Concat(current.Server.MapPath("~/"), str1)))
                {
                    File.Create(string.Concat(current.Server.MapPath("~/"), str1));
                }
                FileStream fileStream = File.Open(string.Concat(current.Server.MapPath("~/"), str1), FileMode.Open);
                File.ReadAllLines(string.Concat(current.Server.MapPath("~/"), str1));
                List<string> strs = new List<string>
                {
                    $"{DateTime.Now}\t{txt}\t{str}\r\n"
                };
                File.AppendAllText(string.Concat(current.Server.MapPath("~/"), str1), string.Join(Environment.NewLine, strs));
                fileStream.Close();
                flag = true;
                return flag;
            }
            catch
            {
            }
            flag = false;
            return flag;
        }
    }
}
