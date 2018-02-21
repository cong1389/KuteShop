﻿using App.Core.Utils;
using App.Domain.Common;
using App.Domain.Interfaces.Repository;
using System.Collections.Generic;

namespace App.Infra.Data.Repository.Addresses
{
    public interface IAddressRepository : IRepositoryBase<Address>
    {
        Address GetById(int id);

        IEnumerable<Address> PagedList(Paging page);

        IEnumerable<Address> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);
    }
}
