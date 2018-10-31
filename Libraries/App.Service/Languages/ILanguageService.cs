using System.Collections.Generic;
using App.Core.Utilities;
using App.Domain.Interfaces.Services;
using App.Domain.Languages;

namespace App.Service.Languages
{
	public interface ILanguageService : IBaseService<Language>
	{
		void CreateLanguage(Language language);

		Language GetById(int id, bool isCache = true);

		IEnumerable<Language> PagedList(SortingPagingBuilder sortBuider, Paging page);

		int SaveLanguage();
	}
}