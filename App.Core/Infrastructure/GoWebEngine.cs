using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
using App.Core.Data;
using App.Core.Infrastructure.DependencyManagement;
using App.Core.Plugins;
using Autofac;

namespace App.Core.Infrastructure
{
	public class GoWebEngine : IEngine
	{
	    private ContainerManager _containerManager;

        public ContainerManager ContainerManager
	    {
	        get { return _containerManager; }
	    }

		public void Initialize()
		{
			//RegisterDependencies();

			//if (DataSettings.DatabaseIsInstalled())
			//{
			//	RunStartupTasks();
			//}
		}
		
	}
}
