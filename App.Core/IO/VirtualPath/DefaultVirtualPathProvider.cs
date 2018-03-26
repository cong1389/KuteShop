using System;
using System.Collections.Generic;
using System.IO;
using System.Web.Caching;
using System.Web.Hosting;

namespace App.Core.IO.VirtualPath
{
	public class DefaultVirtualPathProvider : IVirtualPathProvider
	{
	    public DefaultVirtualPathProvider()
	    {
	    }
        
	    public virtual bool FileExists(string virtualPath)
		{
			return HostingEnvironment.VirtualPathProvider.FileExists(virtualPath);
		}

	    public virtual string GetFileHash(string virtualPath, IEnumerable<string> dependencies)
	    {
	        return HostingEnvironment.VirtualPathProvider.GetFileHash(virtualPath, dependencies);
	    }

	    public virtual CacheDependency GetCacheDependency(string virtualPath, IEnumerable<string> dependencies, DateTime utcStart)
	    {
	        return HostingEnvironment.VirtualPathProvider.GetCacheDependency(virtualPath, dependencies, utcStart);
	    }

		public virtual Stream OpenFile(string virtualPath)
		{
			return HostingEnvironment.VirtualPathProvider.GetFile(virtualPath).Open();
		}
	}
}
