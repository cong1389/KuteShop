﻿using System;
using System.Collections.Generic;
using System.Linq;
using App.Aplication;
using App.Domain.Common;
using App.Domain.Orders;
using App.Service.Customers;
using App.Service.GenericAttribute;
using App.Service.Post;

namespace App.Service.Orders
{
    public class OrderProcessingService : IOrderProcessingService
    {
        private readonly IOrderService _orderService;
        public readonly IShoppingCartItemService ShoppingCartItemService;
        public readonly ICustomerService CustomerService;
        private readonly IGenericAttributeService _genericAttributeService;
        private readonly IPriceCalculationService _priceCalculationService;

        public OrderProcessingService(IOrderService orderService
            , IShoppingCartItemService shoppingCartItemService
            , ICustomerService customerService
            , IGenericAttributeService genericAttributeService
            , IPriceCalculationService priceCalculationService)
        {
            _orderService = orderService;
            ShoppingCartItemService = shoppingCartItemService;
            CustomerService = customerService;
            _genericAttributeService = genericAttributeService;
            _priceCalculationService = priceCalculationService;
        }

        public virtual PlaceOrderResult PlaceOrder(
           ProcessPaymentRequest processPaymentRequest,
           Dictionary<string, string> extraData)
        {
            PlaceOrderResult result = new PlaceOrderResult();
            var utcNow = DateTime.UtcNow;

            if (processPaymentRequest == null)
                throw new AggregateException("processPaymentRequest");

            if (processPaymentRequest.OrderGuid == Guid.Empty)
                processPaymentRequest.OrderGuid = Guid.NewGuid();

            try
            {
                var customer = CustomerService.GetById(processPaymentRequest.CustomerId, false);
                var cart = customer.GetCartItems();

                //Order total 
                decimal? orderTotal = null;
                if (cart != null)
                {
                    var subTotal = ShoppingCartItemService.GetCurrentCartSubTotal(cart);
                    orderTotal = subTotal;
                }

                //BillingAddress  
                var billingAddress = customer.BillingAddress;

                //Shiping method
                string shippingMethod = customer.GetAttribute("Customer", Contains.SelectedShippingOption, _genericAttributeService);

                var order = new Order
                {
                    StoreId = processPaymentRequest.StoreId,
                    OrderGuid = processPaymentRequest.OrderGuid,
                    CustomerId = customer.Id,
                    CustomerLanguageId = 1, // Draft code
                    CustomerTaxDisplayTypeId = 0, //Draft code
                    CustomerIp = "172.0.0.0", //Draft code
                    OrderSubtotalInclTax = 0, //Draft code
                    OrderSubtotalExclTax = 0, //Draft code
                    OrderSubTotalDiscountInclTax = decimal.Zero, //Draft code
                    OrderSubTotalDiscountExclTax = decimal.Zero,//Draft code
                    OrderShippingInclTax = decimal.Zero,//Draft code
                    OrderShippingExclTax = decimal.Zero,//Draft code
                    OrderShippingTaxRate = decimal.Zero,//Draft code
                    PaymentMethodAdditionalFeeInclTax = decimal.Zero,//Draft code
                    PaymentMethodAdditionalFeeExclTax = decimal.Zero,//Draft code
                    PaymentMethodAdditionalFeeTaxRate = decimal.Zero,//Draft code
                    TaxRates = string.Empty,//Draft code
                    OrderTax = decimal.Zero,//Draft code
                    BillingAddress = billingAddress,
                    PaidDateUtc = utcNow,
                    CreatedOnUtc = utcNow,
                    UpdatedOnUtc = utcNow,
                    PaymentMethodSystemName = processPaymentRequest.PaymentMethodSystemName,
                    CustomerCurrencyCode = "VNĐ",
                    CurrencyRate = decimal.Zero,
                    OrderTotal = orderTotal.Value,
                    ShippingMethod = shippingMethod,
                    ShippingStatus = ShippingStatus.ShippingNotRequired,

                    OrderStatus = OrderStatus.Pending,
                    PaymentStatus = PaymentStatus.Pending

                };

                _orderService.Create(order);

                result.PlacedOrder = order;

                //Insert OrderItem
                foreach (var sc in cart)
                {
                    decimal scSubTotal = _priceCalculationService.GetSubTotal(sc, true);
                    decimal scSubTotalInclTax = scSubTotal;

                    var orderItem = new OrderItem
                    {
                        OrderItemGuid = Guid.NewGuid(),
                        Order = order,
                        PostId = sc.PostId,
                        Quantity = sc.Quantity,
                        UnitPriceInclTax = sc.CustomerEnteredPrice,
                        PriceInclTax = scSubTotalInclTax
                    };

                    order.OrderItems.Add(orderItem);
                    _orderService.Update(order);
                }

                if (result.Success)
                {
                    //Delete
                    cart.ToList().ForEach(cr => ShoppingCartItemService.DeleteShoppingCartItem(cr, false));

                    CustomerService.ResetCheckoutData(customer, 1, false, true, true, true, true);

                }
            }
            catch
            {
                // ignored
            }

            return result;
        }
    }
}
