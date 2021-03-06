using System.Collections.Generic;
using App.Core.Common;
using App.Domain.Posts;

namespace App.Domain.Manufacturers
{
    public class Manufacturer : AuditableEntity<int>
	{
		public string Description
		{
			get;
			set;
		}

		public string ImageUrl
		{
			get;
			set;
		}

		public int OrderDisplay
		{
			get;
			set;
		}

		public string OtherLink
		{
			get;
			set;
		}

		public int Status
		{
			get;
			set;
		}

		public string Title
		{
			get;
			set;
		}

	    public virtual ICollection<Post> Posts
        {
	        get;
	        set;
	    }

        public Manufacturer()
		{
		}
	}
}