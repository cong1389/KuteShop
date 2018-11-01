using App.Domain.Entities.Orders;

namespace App.Service.Posts
{
    public interface IPriceCalculationService
    {
        decimal GetSubTotal(ShoppingCartItem shoppingCartItem, bool includeDiscounts);
    }
}
