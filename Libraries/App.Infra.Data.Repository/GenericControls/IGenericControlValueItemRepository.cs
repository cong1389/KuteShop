using App.Domain.GenericControls;
using App.Domain.Interfaces.Repository;

namespace App.Infra.Data.Repository.GenericControls
{
	public interface IGenericControlValueItemRepository : IRepositoryBase<GenericControlValueItem>
	{
        GenericControlValueItem GetById(int id);
	}
}