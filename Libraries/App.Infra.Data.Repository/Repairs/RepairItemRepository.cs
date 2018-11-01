﻿using App.Domain.Repairs;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;
using System.Linq;

namespace App.Infra.Data.Repository.Repairs
{
    public class RepairItemRepository : RepositoryBase<RepairItem>, IRepairItemRepository
    {
        public RepairItemRepository(IDbFactory dbFactory) : base(dbFactory)
        {
        }

        protected override IOrderedQueryable<RepairItem> GetDefaultOrder(IQueryable<RepairItem> query)
        {
            var orderItems =
                from p in query
                orderby p.Id
                select p;
            return orderItems;
        }
    }
}