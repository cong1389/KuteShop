using System.Collections.Generic;
using App.Core.Utilities;
using App.Domain.ContactInfors;
using App.Domain.Interfaces.Repository;

namespace App.Infra.Data.Repository.ContactInfors
{
    public interface IContactInfoRepository : IRepositoryBase<ContactInformation>
	{
        ContactInformation GetById(int id);

		IEnumerable<ContactInformation> PagedList(Paging page);

		IEnumerable<ContactInformation> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);
	}
}