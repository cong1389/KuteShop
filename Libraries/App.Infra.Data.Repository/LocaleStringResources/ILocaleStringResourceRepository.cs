using System.Collections.Generic;
using App.Core.Utilities;
using App.Domain.Interfaces.Repository;
using App.Domain.Languages;

namespace App.Infra.Data.Repository.LocaleStringResources
{
    public interface ILocaleStringResourceRepository : IRepositoryBase<LocaleStringResource>
	{
		LocaleStringResource GetLocaleStringResourceById(int id);

		IEnumerable<LocaleStringResource> PagedList(Paging page);

		IEnumerable<LocaleStringResource> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);
	}
}