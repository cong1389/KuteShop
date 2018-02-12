using System.Linq;
using App.Domain.Entities.Orders;

namespace App.Service.Orders
{
    public class OrderTotalCalculationService : IOrderTotalCalculationService
    {
        public decimal GetCurrentCartSubTotal(IOrderedEnumerable<ShoppingCartItem> cart)
        {
            decimal subTotal = decimal.Zero;

            if (cart == null || !cart.Any())
            {
                return subTotal;
            }

            subTotal = (from mul in cart
                        select mul.Quantity * mul.CustomerEnteredPrice).Sum();

            return subTotal;
        }
    }
}
