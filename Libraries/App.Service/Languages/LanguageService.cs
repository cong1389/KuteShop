using App.Core.Caching;
using App.Core.Utilities;
using App.Infra.Data.Common;
using App.Infra.Data.Repository.Languages;
using App.Infra.Data.UOW.Interfaces;
using System.Collections.Generic;
using System.Text;
using App.Domain.Languages;

namespace App.Service.Languages
{
    public class LanguageService : BaseService<Language>, ILanguageService
    {
        private const string CacheLanguageKey = "db.Language.{0}";
        private readonly ICacheManager _cacheManager;

        private readonly ILanguageRepository _languageRepository;

        private readonly IUnitOfWork _unitOfWork;

        public LanguageService(IUnitOfWork unitOfWork
            , ILanguageRepository languageRepository
            , ICacheManager cacheManager) : base(unitOfWork, languageRepository)
        {
            _unitOfWork = unitOfWork;
            _languageRepository = languageRepository;
            _cacheManager = cacheManager;
        }

        public void CreateLanguage(Language language)
        {
            _languageRepository.Add(language);
        }

        public Language GetById(int id, bool isCache = true)
        {
            Language language;

            if (isCache)
            {
                var sbKey = new StringBuilder();
                sbKey.AppendFormat(CacheLanguageKey, "GetById");
                sbKey.Append(id);

                var key = sbKey.ToString();
                language = _cacheManager.Get<Language>(key);
                if (language == null)
                {
                    language = _languageRepository.GetById(id);
                    _cacheManager.Put(key, language);
                }
            }
            else
            {
                language = _languageRepository.GetById(id);
            }
            
            return language;
        }

        public IEnumerable<Language> PagedList(SortingPagingBuilder sortbuBuilder, Paging page)
        {
            return _languageRepository.PagedSearchList(sortbuBuilder, page);
        }

        public int SaveLanguage()
        {
            return _unitOfWork.Commit();
        }
    }
}