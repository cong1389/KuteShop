using App.Core.Utilities;
using App.Domain.Interfaces.Repository;
using App.Domain.Languages;
using System.Collections.Generic;

namespace App.Infra.Data.Repository.Languages
{
    public interface ILocalizedPropertyRepository : IRepositoryBase<LocalizedProperty>
	{
		LocalizedProperty GetId(int id);

		IEnumerable<LocalizedProperty> PagedList(Paging page);

		IEnumerable<LocalizedProperty> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);
	}
}