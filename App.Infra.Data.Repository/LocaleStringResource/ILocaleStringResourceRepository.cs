using System.Collections.Generic;
using App.Core.Utils;
using App.Domain.Interfaces.Repository;

namespace App.Infra.Data.Repository.LocaleStringResource
{
	public interface ILocaleStringResourceRepository : IRepositoryBase<Domain.Entities.Language.LocaleStringResource>
	{
		Domain.Entities.Language.LocaleStringResource GetLocaleStringResourceById(int Id);

		IEnumerable<Domain.Entities.Language.LocaleStringResource> PagedList(Paging page);

		IEnumerable<Domain.Entities.Language.LocaleStringResource> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);
	}
}