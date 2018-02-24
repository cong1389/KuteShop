using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using App.Core.Utils;
using App.Domain.Entities.Ads;
using App.Domain.Interfaces.Repository;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;

namespace App.Infra.Data.Repository.Ads
{
	public class PageBannerRepository : RepositoryBase<PageBanner>, IPageBannerRepository, IRepositoryBase<PageBanner>
	{
		public PageBannerRepository(IDbFactory dbFactory) : base(dbFactory)
		{
		}

		public PageBanner GetById(int Id)
		{
			PageBanner pageBanner = FindBy(x => x.Id == Id, false).FirstOrDefault();
			return pageBanner;
		}

		protected override IOrderedQueryable<PageBanner> GetDefaultOrder(IQueryable<PageBanner> query)
		{
			IOrderedQueryable<PageBanner> pageBanners = 
				from p in query
				orderby p.Id
				select p;
			return pageBanners;
		}

		public IEnumerable<PageBanner> PagedList(Paging page)
		{
			return GetAllPagedList(page).ToList();
		}

		public IEnumerable<PageBanner> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
		{
			Expression<Func<PageBanner, bool>> expression = PredicateBuilder.True<PageBanner>();
			return FindAndSort(expression, sortBuider.Sorts, page);
		}
	}
}