using App.Domain.Posts;
using App.Infra.Data.Common;
using App.Infra.Data.RepositoryAsync.Posts;
using App.Infra.Data.UOW.Interfaces;

namespace App.AsyncService.Posts
{
    public class PostAsynService : BaseAsyncService<Post>, IPostAsynService
	{
	    public PostAsynService(IPostRepositoryAsync postRepository, IUnitOfWorkAsync unitOfWork) : base(postRepository,
	        unitOfWork)
		{
		}
	}
}