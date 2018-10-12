﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace App.Core.Plugins
{
	public interface IPlugin
	{
		/// <summary>
		/// Gets or sets the plugin descriptor
		/// </summary>
		PluginDescriptor PluginDescriptor { get; set; }

		/// <summary>
		/// Install plugin
		/// </summary>
		void Install();

		/// <summary>
		/// Uninstall plugin
		/// </summary>
		void Uninstall();
	}
}