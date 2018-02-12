using System.Collections.Generic;
using App.Core.Utils;
using App.Domain.Interfaces.Services;
using App.Infra.Data.Common;
using App.Infra.Data.Repository.Repairs;
using App.Infra.Data.UOW.Interfaces;

namespace App.Service.Repairs
{
    public class RepairService : BaseService<Domain.Entities.Data.Repair>, IRepairService, IBaseService<Domain.Entities.Data.Repair>, IService
    {
        private readonly IRepairRepository _orderRepository;

        private readonly IUnitOfWork _unitOfWork;

        public RepairService(IUnitOfWork unitOfWork, IRepairRepository orderRepository) : base(unitOfWork, orderRepository)
        {
            _unitOfWork = unitOfWork;
            _orderRepository = orderRepository;
        }

        public IEnumerable<Domain.Entities.Data.Repair> PagedList(SortingPagingBuilder sortbuBuilder, Paging page)
        {
            return _orderRepository.PagedSearchList(sortbuBuilder, page);
        }
    }
}