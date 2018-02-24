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
	public class BannerRepository : RepositoryBase<Banner>, IBannerRepository, IRepositoryBase<Banner>
	{
		public BannerRepository(IDbFactory dbFactory) : base(dbFactory)
		{
		}

		public Banner GetById(int Id)
		{
			Banner banner = FindBy(x => x.Id == Id, false).FirstOrDefault();
			return banner;
		}

		protected override IOrderedQueryable<Banner> GetDefaultOrder(IQueryable<Banner> query)
		{
			IOrderedQueryable<Banner> banners = 
				from p in query
				orderby p.Id
				select p;
			return banners;
		}

		public IEnumerable<Banner> PagedList(Paging page)
		{
			return GetAllPagedList(page).ToList();
		}

		public IEnumerable<Banner> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
		{
			Expression<Func<Banner, bool>> expression = PredicateBuilder.True<Banner>();
			return FindAndSort(expression, sortBuider.Sorts, page);
		}
	}
}