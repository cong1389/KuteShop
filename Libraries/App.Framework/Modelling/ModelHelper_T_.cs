using System.Collections.Generic;

namespace App.Framework.Modelling
{
	public class ModelHelper<T>
	{
		public IEnumerable<T> Result
		{
			get;
			set;
		}

		public int TotalRecords
		{
			get;
			set;
		}
	}
}