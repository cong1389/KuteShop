using App.Core.Caching;
using App.Domain.Menus;
using App.Infra.Data.Common;
using App.Infra.Data.Repository.Menus;
using App.Infra.Data.UOW.Interfaces;
using System.Text;

namespace App.Service.Menus
{
    public class PositionMenuLinkService : BaseService<PositionMenuLink>, IPositionMenuLinkService
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

        public PositionMenuLink GetById(int id, bool isCache = true)
        {
            PositionMenuLink genericControl;

            if (isCache)
            {
                var sbKey = new StringBuilder();
                sbKey.AppendFormat(CacheGenericcontrolKey, "GetById");
                sbKey.Append(id);

                var key = sbKey.ToString();
                genericControl = _cacheManager.Get<PositionMenuLink>(key);
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