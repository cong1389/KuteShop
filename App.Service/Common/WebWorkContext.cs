﻿using App.Service.Customers;
using App.Service.GenericAttribute;
using App.Service.Language;
using Domain.Entities.Customers;
using System;
using System.Web;
using System.Net;
using App.Core.Extensions;
using Microsoft.AspNet.Identity;
using App.Domain.Entities.Identity;
using App.Aplication.Extensions;
using App.Domain.Common;

namespace App.Service.Common
{
    public partial class WebWorkContext : IWorkContext
    {
        //private HttpContextBase _httpContextBase = new HttpContextWrapper(HttpContext.Current);

        private readonly HttpContextBase _httpContextBase;

        private readonly ILanguageService _languageService;

        private readonly IGenericAttributeService _genericAttributeService;

        private readonly ICustomerService _customerService;

        private App.Domain.Entities.Language.Language _cachedLanguage;

        private Customer _cachedCustomer;

        protected readonly UserManager<IdentityUser, Guid> _userManager;

        public WebWorkContext(IGenericAttributeService genericAttributeService, ILanguageService languageService, ICustomerService customerService
            , UserManager<IdentityUser, Guid> userManager
        )
        {
            _genericAttributeService = genericAttributeService;
            _languageService = languageService;
            _customerService = customerService;
            _httpContextBase = new HttpContextWrapper(HttpContext.Current);
            _userManager = userManager;
        }

        public App.Domain.Entities.Language.Language WorkingLanguage
        {
            get
            {
                if (_cachedLanguage != null)
                    return _cachedLanguage;

                Domain.Entities.Data.GenericAttribute attribute = _genericAttributeService.GetByKey(CurrentCustomer.Id, "Customer", "LanguageId");

                if (attribute == null)
                {
                    SetCustomerLanguage(languageId: 1, storeId: 1);
                    attribute = _genericAttributeService.GetByKey(CurrentCustomer.Id, "Customer", "LanguageId");
                }

                _cachedLanguage = _languageService.GetById(int.Parse(attribute.Value));

                return _cachedLanguage;
            }
            set
            {
                var languageId = value != null ? value.Id : 1;
                SetCustomerLanguage(languageId, 1);
                _cachedLanguage = null;
            }
        }


        private void SetCustomerLanguage(int languageId, int storeId)
        {
            App.Domain.Entities.Data.GenericAttribute objAttribute = new App.Domain.Entities.Data.GenericAttribute
            {
                EntityId = CurrentCustomer.Id,
                KeyGroup = "Customer",
                Key = "LanguageId",
                Value = languageId.ToString(),
                StoreId = storeId,
                CreatedDate = DateTime.Now,
                UpdatedDate = DateTime.Now
            };

            var attribute = _genericAttributeService.GetByKey(objAttribute.EntityId
                , objAttribute.KeyGroup, objAttribute.Key);

            if (attribute == null)
                _genericAttributeService.Create(objAttribute);
            else
            {
                attribute.Value = languageId.ToString();
                _genericAttributeService.Update(attribute);
            }
        }

        public Customer CurrentCustomer
        {
            get
            {
                if (_cachedCustomer != null)
                    return _cachedCustomer;

                Customer customer = null;

                //Get user registered
                if (_httpContextBase.User.Identity.IsAuthenticated)
                {
                    string userId = _httpContextBase.User.Identity.GetUserId();

                    //Kiểm tra nếu chưa có user trong table Customer thì create new customer
                    //Load customer đã có 
                    Customer customerExsist = _customerService.GetByGuid(Guid.Parse(userId), isCache: false);
                    if (customerExsist == null || !customerExsist.Active)
                    {
                        IdentityUser objUser = _userManager.FindById(Guid.Parse(userId));
                        customerExsist = objUser.ToModel();
                        customerExsist.CustomerGuid = Guid.Parse(userId);                       
                        customerExsist.Active = true;
                        customerExsist.Deleted = false;                       

                        //Create address and BillingAddress
                        var objAddress = new Address
                        {
                            Email = objUser.Email,
                            FirstName = objUser.FirstName,
                            LastName = objUser.LastName,
                            Address1 = objUser.Address,
                            PhoneNumber=objUser.Phone,
                            City=objUser.City
                        };

                        customerExsist.Addresses.Add(objAddress);
                        customerExsist.BillingAddress = objAddress;
                        
                        _customerService.Create(customerExsist);
                        _customerService.Update(customerExsist);

                    }

                    customer = customerExsist;
                }
                else
                {
                    //Load guest customer
                    customer = GetGuestCustomer();
                }

                _cachedCustomer = customer;
                return _cachedCustomer;
            }
            set
            {
                _cachedCustomer = value;
            }
        }

        protected virtual Customer GetGuestCustomer()
        {
            Customer customer = null;
            Guid customerGuid = Guid.Empty;

            var anonymousId = _httpContextBase.Request.AnonymousID;

            if (anonymousId != null && anonymousId.HasValue())
            {
                Guid.TryParse(anonymousId, out customerGuid);
            }

            if (customerGuid == Guid.Empty)
            {
                _httpContextBase.Response.StatusCode = (int)HttpStatusCode.Unauthorized;
                _httpContextBase.Response.End();
            }

            //Load customer đã có 
            customer = _customerService.GetByGuid(customerGuid, isCache: false);

            if (customer == null || customer.Deleted || !customer.Active)
            {
                var objCustomer = new Customer
                {
                    CustomerGuid = customerGuid == null ? Guid.NewGuid() : customerGuid,
                    Active = true,
                    CreatedOnUtc = DateTime.UtcNow,
                    LastLoginDateUtc = DateTime.UtcNow,
                    LastActivityDateUtc = DateTime.UtcNow
                };

                //Create customer
                _customerService.Create(objCustomer);

                //Get lai customer
                customer = _customerService.GetByGuid(customerGuid, isCache: false);
            }

            return customer;
        }
    }
}
