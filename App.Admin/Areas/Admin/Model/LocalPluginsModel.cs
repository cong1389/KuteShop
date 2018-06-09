using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using App.Core.Collections;

namespace App.Admin.Areas.Admin.Model
{
	public class LocalPluginsModel : ModelBase
	{

		public LocalPluginsModel()
		{
			this.Groups = new Multimap<string, PluginModel>();
		}

		public Multimap<string, PluginModel> Groups { get; private set; }

		public ICollection<PluginModel> AllPlugins
		{
			get
			{
				return Groups.SelectMany(k => k.Value).ToList().AsReadOnly();
			}
		}

	}
}