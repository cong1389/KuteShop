using App.Core.Infrastructure.DependencyManagement;

namespace App.Core.Infrastructure
{
    public interface IEngine
    {
        ContainerManager ContainerManager { get; }
        void Initialize();
        T Resolve<T>(string name = null) where T : class;
    }
}
