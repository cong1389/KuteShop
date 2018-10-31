using System.Collections.Generic;
using System.Linq;
using App.Core.Utilities;
using App.Domain.ContactInfors;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;

namespace App.Infra.Data.Repository.ContactInfors
{
    public class ContactInfoRepository : RepositoryBase<ContactInformation>, IContactInfoRepository
    {
        public ContactInfoRepository(IDbFactory dbFactory) : base(dbFactory)
        {
        }

        public ContactInformation GetById(int id)
        {
            var contactInformation =
                FindBy(x
                => x.Id == id).FirstOrDefault();

            return contactInformation;
        }

        protected override IOrderedQueryable<ContactInformation> GetDefaultOrder(
            IQueryable<ContactInformation> query)
        {
            var contactInformations =
                from p in query
                orderby p.Id
                select p;

            return contactInformations;
        }

        public IEnumerable<ContactInformation> PagedList(Paging page)
        {
            return GetAllPagedList(page).ToList();
        }

        public IEnumerable<ContactInformation> PagedSearchList(SortingPagingBuilder sortBuider, Paging page)
        {
            var expression = PredicateBuilder.True<ContactInformation>();
            if (!string.IsNullOrEmpty(sortBuider.Keywords))
            {
                expression = expression.And(x =>
                    x.Title.ToLower().Contains(sortBuider.Keywords.ToLower()) ||
                    x.Email.ToLower().Contains(sortBuider.Keywords.ToLower()) ||
                    x.Address.ToLower().Contains(sortBuider.Keywords.ToLower()) ||
                    x.MobilePhone.ToLower().Contains(sortBuider.Keywords.ToLower()) ||
                    x.Hotline.ToLower().Contains(sortBuider.Keywords.ToLower()) ||
                    x.Fax.ToLower().Contains(sortBuider.Keywords.ToLower()));
            }
            return FindAndSort(expression, sortBuider.Sorts, page);
        }
    }
}