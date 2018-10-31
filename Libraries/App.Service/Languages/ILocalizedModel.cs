using System.Collections.Generic;

namespace App.Service.Languages
{
    public interface ILocalizedModel
    {
    }

    public interface ILocalizedModel<TLocalizedModel> : ILocalizedModel
    {
        IList<TLocalizedModel> Locales { get; set; }
    }
}
