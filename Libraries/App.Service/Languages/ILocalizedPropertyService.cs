using App.Core.Common;
using App.Core.Utilities;
using App.Domain.Interfaces.Services;
using App.Domain.Languages;
using System;
using System.Collections.Generic;
using System.Linq.Expressions;

namespace App.Service.Languages
{
    public interface ILocalizedPropertyService : IBaseService<LocalizedProperty>
    {
        void CreateLocalizedProperty(LocalizedProperty localizedProperty);

        LocalizedProperty GetById(int id, bool isCache = true);

        IEnumerable<LocalizedProperty> GetByEntityId(int entityId, bool isCache = true);

        LocalizedProperty GetByKey(int languageId,int entityId, string localeKeyGroup, string localeKey, bool isCache = true);

        IEnumerable<LocalizedProperty> PagedList(SortingPagingBuilder sortBuider, Paging page);

        int SaveLocalizedProperty();

        void SaveLocalizedValue<T>(
            T entity,
            Expression<Func<T, string>> keySelector,
            string localeValue,
            int languageId) where T : AuditableEntity<int>;

        void SaveLocalizedValueItem<T, TPropType>(
           T entity,
           Expression<Func<T, TPropType>> keySelector,
           string localeValue,
           int languageId) where T : AuditableEntity<int>;
        
    }
}