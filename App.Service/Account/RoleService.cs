using System.Collections.Generic;
using System.Threading.Tasks;
using App.Core.Utils;
using App.Domain.Entities.Account;
using App.Infra.Data.Common;
using App.Infra.Data.Repository.Account;
using App.Infra.Data.UOW.Interfaces;

namespace App.Service.Account
{
	public class RoleService : BaseAsyncService<Role>, IRoleService
	{
	    private readonly IRoleRepository _roleRepository;

		public RoleService(IUnitOfWorkAsync unitOfWork, IRoleRepository roleRepository) : base(roleRepository, unitOfWork)
		{
            _roleRepository = roleRepository;
		}

		public Task<IEnumerable<Role>> PagedList(SortingPagingBuilder sortBuider, Paging page)
		{
			return _roleRepository.PagedSearchList(sortBuider, page);
		}
	}
}