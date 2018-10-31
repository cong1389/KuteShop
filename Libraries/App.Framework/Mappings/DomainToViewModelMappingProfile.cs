using App.Domain.Ads;
using App.Domain.Brandes;
using App.Domain.Common;
using App.Domain.ContactInfors;
using App.Domain.Entities.Attribute;
using App.Domain.Entities.Data;
using App.Domain.Entities.Identity;
using App.Domain.Entities.Orders;
using App.Domain.Entities.Payments;
using App.Domain.Entities.Slide;
using App.Domain.GenericControls;
using App.Domain.Languages;
using App.Domain.Locations;
using App.Domain.Manufacturers;
using App.Domain.Menus;
using App.Domain.News;
using App.Domain.Orders;
using App.Domain.Posts;
using App.Domain.Repairs;
using App.Domain.ServerMails;
using App.Domain.SettingSeoes;
using App.Domain.Shippings;
using App.Domain.StaticContents;
using App.Domain.Systems;
using App.FakeEntity.Ads;
using App.FakeEntity.Attribute;
using App.FakeEntity.Brandes;
using App.FakeEntity.Common;
using App.FakeEntity.ContactInformations;
using App.FakeEntity.Gallery;
using App.FakeEntity.GenericControls;
using App.FakeEntity.Languages;
using App.FakeEntity.Location;
using App.FakeEntity.Manufacturers;
using App.FakeEntity.Menus;
using App.FakeEntity.News;
using App.FakeEntity.Orders;
using App.FakeEntity.Payments;
using App.FakeEntity.Post;
using App.FakeEntity.Repairs;
using App.FakeEntity.ServerMails;
using App.FakeEntity.SettingSeoes;
using App.FakeEntity.Shippings;
using App.FakeEntity.Slide;
using App.FakeEntity.Static;
using App.FakeEntity.Systems;
using App.FakeEntity.User;
using AutoMapper;

namespace App.Framework.Mappings
{
    public class DomainToViewModelMappingProfile : Profile
    {
        public override string ProfileName => "DomainToViewModelMappings";

        public DomainToViewModelMappingProfile()
        {
            CreateMap<Language, LanguageFormViewModel>();
            CreateMap<ServerMailSetting, ServerMailSettingViewModel>();
            CreateMap<ContactInformation, ContactInforViewModel>();
            CreateMap<SystemSetting, SystemSettingViewModel>();
            CreateMap<MenuLink, MenuLinkViewModel>();
            CreateMap<PositionMenuLink, PositionMenuLinkViewModel>();
            CreateMap<Province, ProvinceViewModel>();
            CreateMap<District, DistrictViewModel>();

            CreateMap<Post, PostViewModel>();
            CreateMap<PostGallery, PostGalleryViewModel>();

            CreateMap<News, NewsViewModel>();
            CreateMap<SettingSeoGlobal, SettingSeoGlobalViewModel>();
            CreateMap<PageBanner, PageBannerViewModel>();
            CreateMap<Banner, BannerViewModel>();
            CreateMap<StaticContent, StaticContentViewModel>();
            CreateMap<GalleryImage, GalleryImageViewModel>();
            CreateMap<Manufacturer, ManufacturerViewModel>();
            CreateMap<IdentityUser, RegisterFormViewModel>();
            CreateMap<AttributeValue, AttributeValueViewModel>();
            CreateMap<Attribute, AttributeViewModel>();
            CreateMap<SlideShow, SlideShowViewModel>();

            CreateMap<Brand, BrandViewModel>();
            CreateMap<Repair, RepairViewModel>();
            CreateMap<RepairGallery, RepairGalleryViewModel>();
            CreateMap<RepairItem, RepairItemViewModel>();
            CreateMap<LocalizedProperty, LocalizedPropertyViewModel>();
            CreateMap<LocaleStringResource, LocaleStringResourceViewModel>();

            CreateMap<GenericControl, GenericControlViewModel>();
            CreateMap<GenericControlValue, GenericControlValueViewModel>();
            CreateMap<GenericControlValueItem, GenericControlValueItemViewModel>();

            CreateMap<ShoppingCartItem, ShoppingCartItemViewModel>();

            CreateMap<Address, AddressViewModel>();

            CreateMap<PaymentMethod, PaymentMethodViewModel>();

            CreateMap<ShippingMethod, ShippingMethodViewModel>();

            CreateMap<Order, OrderViewModel>();
            CreateMap<OrderItem, OrderItemViewModel>();
        }
    }
}