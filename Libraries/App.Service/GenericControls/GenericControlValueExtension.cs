using System.Linq;
using System.Web.Mvc;
using App.Domain.GenericControls;

namespace App.Service.GenericControls
{
    public static class GenericControlValueExtension
    {
        public static string GetValueItem(this GenericControlValue genericControlValue, int entityId)
        {
            var itemService = DependencyResolver.Current.GetService<IGenericControlValueItemService>();

            var valueItem = itemService.GetByOption(genericControlValue.Id, entityId,isCache:false);

            return valueItem.Any() ? valueItem.FirstOrDefault().Value : null;
        }
    }
}
