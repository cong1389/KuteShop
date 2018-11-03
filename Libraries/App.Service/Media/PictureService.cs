using App.Core.Extensions;
using System.Text;
using System.Web;
using System.Web.Hosting;

namespace App.Service.Media
{
    public static class PictureService
    {
        public static string BuildUrlCore(string virtualPath, string query, string host)
        {
            string appPath = "/", _host = string.Empty;
            if (HostingEnvironment.IsHosted)
            {
                appPath = HostingEnvironment.ApplicationVirtualPath.EmptyNull();
                var uri = HttpContext.Current.Request.Url;
                _host = "//{0}{1}".FormatInvariant(uri.Authority, appPath);
            }

            var _appPath = appPath.EnsureEndsWith("/");

            if (host == null)
            {
                host = _host;
            }
            else if (host == string.Empty)
            {
                host = _appPath;
            }
            else
            {
                host = host.EnsureEndsWith("/");
            }

            var sb = new StringBuilder(host, 100);

            // Strip leading "/", the host/apppath has this already
            if (virtualPath[0] == '/')
            {
                virtualPath = virtualPath.Substring(1);
            }

            // Append media path
            sb.Append(virtualPath);

            // Append query
            if (!string.IsNullOrEmpty(query))
            {
                if (query[0] != '?') sb.Append("?");
                sb.Append(query);
            }

            return sb.ToString();
        }
    }
}
