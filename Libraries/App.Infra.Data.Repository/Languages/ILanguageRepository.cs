using System.Collections.Generic;
using App.Core.Utilities;
using App.Domain.Interfaces.Repository;
using App.Domain.Languages;

namespace App.Infra.Data.Repository.Languages
{
	public interface ILanguageRepository : IRepositoryBase<Language>
	{
		Language GetById(int id);

		IEnumerable<Language> PagedList(Paging page);

		IEnumerable<Language> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);
	}
}