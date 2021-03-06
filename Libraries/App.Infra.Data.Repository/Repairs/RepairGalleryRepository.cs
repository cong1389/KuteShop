using App.Domain.Repairs;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;
using System.Linq;

namespace App.Infra.Data.Repository.Repairs
{
    public class RepairGalleryRepository : RepositoryBase<RepairGallery>, IRepairGalleryRepository
	{
		public RepairGalleryRepository(IDbFactory dbFactory) : base(dbFactory)
		{
		}

        protected override IOrderedQueryable<RepairGallery> GetDefaultOrder(IQueryable<RepairGallery> query)
        {
            var repairGalleries =
                from p in query
                orderby p.Id
                select p;
            return repairGalleries;
        }
    }
}