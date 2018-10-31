using App.Core.Utilities;
using App.Infra.Data.Common;
using App.Infra.Data.Repository.Repairs;
using App.Infra.Data.UOW.Interfaces;
using System.Collections.Generic;

namespace App.Service.Repairs
{
    public class RepairService : BaseService<Domain.Repairs.Repair>, IRepairService
    {
        private readonly IRepairRepository _orderRepository;

        public RepairService(IUnitOfWork unitOfWork, IRepairRepository orderRepository) : base(unitOfWork, orderRepository)
        {
            _orderRepository = orderRepository;
        }

        public IEnumerable<Domain.Repairs.Repair> PagedList(SortingPagingBuilder sortbuBuilder, Paging page)
        {
            return _orderRepository.PagedSearchList(sortbuBuilder, page);
        }
    }
}