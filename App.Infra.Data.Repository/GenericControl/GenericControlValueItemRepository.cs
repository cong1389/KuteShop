using System.Linq;
using App.Domain.Entities.GenericControl;
using App.Domain.Interfaces.Repository;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;

namespace App.Infra.Data.Repository.GenericControl
{
	public class GenericControlValueItemRepository : RepositoryBase<GenericControlValueItem>, IGenericControlValueItemRepository, IRepositoryBase<GenericControlValueItem>
	{
		public GenericControlValueItemRepository(IDbFactory dbFactory) : base(dbFactory)
		{
		}

		protected override IOrderedQueryable<GenericControlValueItem> GetDefaultOrder(IQueryable<GenericControlValueItem> query)
		{
			IOrderedQueryable<GenericControlValueItem> genericControlValueItem = 
				from p in query
				orderby p.Id
				select p;

			return genericControlValueItem;
		}

		public GenericControlValueItem GetById(int id)
		{
			GenericControlValueItem GenericControlValueItem = FindBy(x => x.Id == id, false).FirstOrDefault();
			return GenericControlValueItem;
		}
	}
}