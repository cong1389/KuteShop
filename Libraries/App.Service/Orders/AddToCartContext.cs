using App.Domain.Entities.Orders;
using App.Domain.Customers;

namespace App.Service.Orders
{
    public class AddToCartContext
    {
        public App.Domain.Posts.Post Post { get; set; }

        public Customer Customers { get; set; }

        public ShoppingCartItem ShoppingCart { get; set; }

        public decimal Price { get; set; }

        public int Quantity { get; set; }

    }
}
