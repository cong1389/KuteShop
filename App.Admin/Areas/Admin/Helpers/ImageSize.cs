using System.Configuration;

namespace App.Admin.Helpers
{
    public static class ImageSize
	{
		public static int WidthDefaultSize
		{
			get
			{
				if (string.IsNullOrEmpty(ConfigurationManager.AppSettings["WidthDefaultSize"]))
				{
					return int.Parse(ConfigurationManager.AppSettings["WidthDefaultSize"]);
				}
				return int.Parse(ConfigurationManager.AppSettings["WidthDefaultSize"]);
			}
		}

		public static int HeighthDefaultSize
		{
			get
			{
				if (string.IsNullOrEmpty(ConfigurationManager.AppSettings["HeighthDefaultSize"]))
				{
                    return int.Parse(ConfigurationManager.AppSettings["HeightDefaulSize"]);
                }
				return int.Parse(ConfigurationManager.AppSettings["HeighthDefaultSize"]);
			}
		}

		
    }
}