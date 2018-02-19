using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using App.Admin.Helpers;
using App.Aplication.Extensions;
using App.Core.Utils;
using App.Domain.Orders;
using App.FakeEntity.Orders;
using App.Framework.Ultis;
using App.Service.Orders;
using AutoMapper;
using Resources;

namespace App.Admin.Controllers
{
    public class OrderController : BaseAdminController
    {
        private readonly IOrderService _orderService;

        public OrderController(IOrderService orderService)
        {
            _orderService = orderService;
        }

        public ActionResult Edit(int id)
        {
            var order = _orderService.GetById(id);

            if (order == null || order.Deleted)
                return RedirectToAction("Index");

            OrderViewModel model = new OrderViewModel();
            model = order.ToModel(model);

            PrepareOrderDetailsModel(model, order);

            return View(model);
        }

        [NonAction]
        private void PrepareOrderDetailsModel(OrderViewModel model, Order order)
        {
            if (order == null)
                throw new ArgumentNullException("order");

            if (model == null)
                throw new ArgumentNullException("model");

            //Post item
            foreach (var orderItem in order.OrderItems)
            {
                var orderItemModel = new OrderViewModel.OrderItemModel
                {
                    Id = orderItem.Id,
                    PostId = orderItem.PostId,
                    PostName = orderItem.Post.Title,
                    Quantity = orderItem.Quantity,
                    UnitPriceInclTax = orderItem.UnitPriceInclTax,
                    SubTotalInclTax = orderItem.PriceInclTax
                };

                model.Items.Add(orderItemModel);
            }

        }

        [HttpPost]
        [RequiredPermisson(Roles = "ViewOrder")]
        public ActionResult Edit(OrderViewModel orderView, string returnUrl)
        {
            ActionResult action;
            try
            {
                if (!ModelState.IsValid)
                {
                    ModelState.AddModelError("", MessageUI.ErrorMessage);
                    return View(orderView);
                }

                Order map = Mapper.Map<OrderViewModel, Order>(orderView);

                _orderService.Update(map);

                Response.Cookies.Add(new HttpCookie("system_message", string.Format(MessageUI.UpdateSuccess, FormUI.Order)));
                if (!Url.IsLocalUrl(returnUrl) || returnUrl.Length <= 1 || !returnUrl.StartsWith("/") || returnUrl.StartsWith("//") || returnUrl.StartsWith("/\\"))
                {
                    action = RedirectToAction("Index");
                }
                else
                {
                    action = Redirect(returnUrl);
                }
            }
            catch (Exception ex)
            {
                ExtentionUtils.Log(string.Concat("Order.Edit: ", ex.Message));
                return View(orderView);
            }
            return action;
        }

        [RequiredPermisson(Roles = "DeleteOrder")]
        public ActionResult Delete(string[] ids)
        {
            try
            {
                if (ids.Length != 0)
                {
                    IEnumerable<Order> order =
                        from id in ids
                        select _orderService.GetById(int.Parse(id));

                    _orderService.BatchDelete(order);
                }
            }
            catch (Exception ex)
            {
                ExtentionUtils.Log(string.Concat("Order.Delete: ", ex.Message));
            }
            return RedirectToAction("Index");
        }

        public ActionResult Index(int page = 1, string keywords = "")
        {
            ViewBag.Keywords = keywords;
            SortingPagingBuilder sortingPagingBuilder = new SortingPagingBuilder
            {
                Keywords = keywords,
                Sorts = new SortBuilder
                {
                    ColumnName = "Id",
                    ColumnOrder = SortBuilder.SortOrder.Descending
                }
            };
            Paging paging = new Paging
            {
                PageNumber = page,
                PageSize = PageSize,
                TotalRecord = 0
            };

            IEnumerable<Order> orders = _orderService.PagedList(sortingPagingBuilder, paging);

            OrderViewModel orderViewModel = new OrderViewModel();
            IEnumerable<OrderViewModel> model = orders.Select(m =>
            {
                return m.ToModel(orderViewModel);
            });

            if (model != null && model.Any())
            {
                Helper.PageInfo pageInfo = new Helper.PageInfo(ExtentionUtils.PageSize, page, paging.TotalRecord, i => Url.Action("Index", new { page = i, keywords }));
                ViewBag.PageInfo = pageInfo;
            }

            return View(model);
        }
    }
}