using System.Collections.Generic;

namespace App.Admin.Helpers
{
	public class MenuNav
	{
		public List<MenuNav> ChildNavMenu
		{
			get;
			set;
		}

		public int MenuId
		{
			get;
			set;
		}

		public string MenuName
		{
			get;
			set;
		}

		public int? ParentId
		{
			get;
			set;
		}

		public MenuNav()
		{
		}
	}
}