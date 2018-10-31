using App.Core.Utilities;
using App.Domain.Interfaces.Services;
using App.Domain.ServerMails;
using System.Collections.Generic;

namespace App.Service.MailSetting
{
    public interface IMailSettingService : IBaseService<ServerMailSetting>
	{
		ServerMailSetting GetById(int id);

		ServerMailSetting GetActive();

		IEnumerable<ServerMailSetting> PagedList(SortingPagingBuilder sortBuider, Paging page);
	}
}