﻿using System.Collections.Generic;
using App.Domain.Entities.Data;
using App.Domain.Entities.Orders;

namespace App.Front.Models.ShoppingCart
{
    public class MiniShoppingCartModel
    {
        public IEnumerable<Post> Items { get; set; }

        public IEnumerable<ShoppingCartItem> ShoppingCarts { get; set; }

        public string SubTotal { get; set; }

        public MiniShoppingCartModel()
        {
            Items = new List<Post>();
            ShoppingCarts = new List<ShoppingCartItem>();
        }

        public int TotalProducts { get; set; }
    }
}