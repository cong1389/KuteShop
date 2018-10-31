using App.Core.Utilities;
using App.Domain.Interfaces.Repository;
using App.Domain.ServerMails;
using System.Collections.Generic;

namespace App.Infra.Data.Repository.MailSetting
{
    public interface IMailSettingRepository : IRepositoryBase<ServerMailSetting>
	{
		ServerMailSetting GetById(int id);

		IEnumerable<ServerMailSetting> PagedList(Paging page);

		IEnumerable<ServerMailSetting> PagedSearchList(SortingPagingBuilder sortBuider, Paging page);
	}
}