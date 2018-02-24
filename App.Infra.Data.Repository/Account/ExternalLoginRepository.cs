using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using App.Domain.Entities.Account;
using App.Domain.Interfaces.Repository;
using App.Infra.Data.Common;
using App.Infra.Data.DbFactory;

namespace App.Infra.Data.Repository.Account
{
	public class ExternalLoginRepository : RepositoryBaseAsync<ExternalLogin>, IExternalLoginRepository, IRepositoryBaseAsync<ExternalLogin>
	{
		public ExternalLoginRepository(IDbFactory dbFactory) : base(dbFactory)
		{
		}

		public ExternalLogin GetByProviderAndKey(string loginProvider, string providerKey)
		{
			ExternalLogin externalLogin = Get(x => x.LoginProvider == loginProvider && x.ProviderKey == providerKey, false);
			return externalLogin;
		}

		public Task<ExternalLogin> GetByProviderAndKeyAsync(string loginProvider, string providerKey)
		{
			Task<ExternalLogin> async = GetAsync(x => x.LoginProvider == loginProvider && x.ProviderKey == providerKey, false);
			return async;
		}

		public Task<ExternalLogin> GetByProviderAndKeyAsync(CancellationToken cancellationToken, string loginProvider, string providerKey)
		{
			Task<ExternalLogin> async = GetAsync(cancellationToken, x => x.LoginProvider == loginProvider && x.ProviderKey == providerKey, false);
			return async;
		}

		protected override IOrderedQueryable<ExternalLogin> GetDefaultOrder(IQueryable<ExternalLogin> query)
		{
			IOrderedQueryable<ExternalLogin> externalLogins = 
				from p in query
				orderby p.UserId
				select p;
			return externalLogins;
		}
	}
}