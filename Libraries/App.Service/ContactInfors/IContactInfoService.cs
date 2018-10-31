using System.Collections.Generic;
using App.Core.Utilities;
using App.Domain.ContactInfors;
using App.Domain.Interfaces.Services;

namespace App.Service.ContactInfors
{
	public interface IContactInfoService : IBaseService<ContactInformation>
	{
        ContactInformation GetById(int id, bool isCache = true);

		IEnumerable<ContactInformation> PagedList(SortingPagingBuilder sortBuider, Paging page);

	    ContactInformation GetTypeAddress(int typeAddress, bool isCache = true);

	    IEnumerable<ContactInformation> GetEnableOrDisables(bool enable = true,
	        bool isCache = true);


	}
}