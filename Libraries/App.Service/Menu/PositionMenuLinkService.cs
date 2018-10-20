using System.Collections.Generic;
using System.Text;
using App.Core.Caching;
using App.Core.Utilities;
using App.Infra.Data.Common;
using App.Infra.Data.Repository.PositionMenuLink;
using App.Infra.Data.UOW.Interfaces;

namespace App.Service.PositionMenuLink
{
    public class PositionMenuLinkService : BaseService<Domain.Menu.PositionMenuLink>, IPositionMenuLinkService
    {
        private const string CacheGenericcontrolKey = "db.PositionMenuLink.{0}";
        private readonly ICacheManager _cacheManager;

        private readonly IPositionMenuLinkRepository _attributeRepository;

        public PositionMenuLinkService(IUnitOfWork unitOfWork, IPositionMenuLinkRepository attributeRepository
            , ICacheManager cacheManager) : base(unitOfWork, attributeRepository)
        {
            _attributeRepository = attributeRepository;
            _cacheManager = cacheManager;
        }

        public Domain.Menu.PositionMenuLink GetById(int id, bool isCache = true)
        {
            Domain.Menu.PositionMenuLink genericControl;

            if (isCache)
            {
                var sbKey = new StringBuilder();
                sbKey.AppendFormat(CacheGenericcontrolKey, "GetById");
                sbKey.Append(id);

                var key = sbKey.ToString();
                genericControl = _cacheManager.Get<Domain.Menu.PositionMenuLink>(key);
                if (genericControl == null)
                {
                    genericControl = _attributeRepository.GetById(id);
                    _cacheManager.Put(key, genericControl);
                }
            }
            else
            {
                genericControl = _attributeRepository.GetById(id);
            }
            
            return genericControl;
        }
    }
}