using System.Collections.Generic;
using App.Core.Utils;
using App.Domain.Entities.Slide;
using App.Domain.Interfaces.Services;
using App.Infra.Data.Common;
using App.Infra.Data.Repository.Slide;
using App.Infra.Data.UOW.Interfaces;

namespace App.Service.Slide
{
    public class SlideShowService : BaseService<SlideShow>, ISlideShowService, IService
    {
        private readonly ISlideShowRepository _slideShowRepository;

        public SlideShowService(IUnitOfWork unitOfWork, ISlideShowRepository slideShowRepository) : base(unitOfWork, slideShowRepository)
        {
            _slideShowRepository = slideShowRepository;
        }

        public IEnumerable<SlideShow> PagedList(SortingPagingBuilder sortbuBuilder, Paging page)
        {
            return _slideShowRepository.PagedSearchList(sortbuBuilder, page);
        }
    }
}