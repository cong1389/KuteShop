using App.Core.Common;
using App.Domain.Entities.Attribute;
using App.Domain.Galleries;
using App.Domain.Manufacturers;
using App.Domain.Menus;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace App.Domain.Posts
{
    public class Post : AuditableEntity<int>
    {
        public virtual ICollection<AttributeValue> AttributeValues
        {
            get;
            set;
        }

        public string Description
        {
            get;
            set;
        }

        public decimal? Discount
        {
            get;
            set;
        }

        public DateTime? EndDate
        {
            get;
            set;
        }

        public virtual ICollection<GalleryImage> GalleryImages
        {
            get;
            set;
        }

        public virtual ICollection<PostGallery> PostGallerys
        {
            get;
            set;
        }

        public string ImageBigSize
        {
            get;
            set;
        }

        public string ImageMediumSize
        {
            get;
            set;
        }

        public string ImageSmallSize
        {
            get;
            set;
        }

        public string Language
        {
            get;
            set;
        }

        public int MenuId
        {
            get;
            set;
        }

        [ForeignKey("MenuId")]
        public virtual MenuLink MenuLink
        {
            get;
            set;
        }


        public int ManufacturerId
        {
            get;
            set;
        }

        [ForeignKey("ManufacturerId")]
        public virtual Manufacturer Manufacturer
        {
            get;
            set;
        }

        public string MetaDescription
        {
            get;
            set;
        }

        public string MetaKeywords
        {
            get;
            set;
        }

        public string MetaTitle
        {
            get;
            set;
        }

        public bool OldOrNew
        {
            get;
            set;
        }

        public int OrderDisplay
        {
            get;
            set;
        }

        public bool OutOfStock
        {
            get;
            set;
        }

        public int PostType
        {
            get;
            set;
        }

        public decimal? Price
        {
            get;
            set;
        }

        public string ProductCode
        {
            get;
            set;
        }

        public bool ShowOnHomePage
        {
            get;
            set;
        }

        public bool ProductHot
        {
            get;
            set;
        }

        public bool ProductNew
        {
            get;
            set;
        }

        public string SeoUrl
        {
            get;
            set;
        }

        public string ShortDesc
        {
            get;
            set;
        }

        public DateTime? StartDate
        {
            get;
            set;
        }

        public int Status
        {
            get;
            set;
        }

        public string TechInfo
        {
            get;
            set;
        }

        public string Title
        {
            get;
            set;
        }

        public int ViewCount
        {
            get;
            set;
        }

        public string VirtualCategoryId
        {
            get;
            set;
        }

        public string VirtualCatUrl
        {
            get;
            set;
        }


        public Post()
        {
        }
    }
}