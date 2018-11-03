using App.Core.Localization;
using App.Service.Common;
using Autofac;

namespace App.Framework.Plugins
{
    public class PluginMediator
	{
		private readonly ICommonServices _services;

		public PluginMediator(ICommonServices services, IComponentContext ctx)
		{
			this._services = services;

			T = NullLocalizer.Instance;
		}

		public Localizer T { get; set; }

	}
}
