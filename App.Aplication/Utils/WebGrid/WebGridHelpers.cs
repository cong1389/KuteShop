﻿using System;
using System.Web.Mvc;
using System.Web.Mvc.Html;

namespace App.Aplication.WebGrid
{
    public static class WebGridHelpers
    {
        //public static HtmlString WebGridFilter<T>(this HtmlHelper helper,
        //    IEnumerable<T> users, Func<T, string> property,
        //    string headingText) where T : class
        //{
        //    var model = new WebGridFilterModel
        //    {
        //        Users = users.GroupBy(property).Select(g => g.First()),
        //        Property = property,
        //        HeadingText = headingText
        //    };
        //    return helper.Partial("_webGridFilter", model);
        //}

        public static MvcHtmlString EditableTextBox(this HtmlHelper helper,string value, string name, string id)
        {
            // Text Display
            var span = new TagBuilder("span") { InnerHtml = value };
            span.AddCssClass("cell-value");

            // Input display.
            var formatName = HtmlHelper.GenerateIdFromName(name);

            var uniqueId = $"{formatName}_{id}";

            var input = helper.TextBox(uniqueId,
                value, new { @class = "hide input-sm" });

            var result = String.Concat(
                span.ToString(TagRenderMode.Normal),
                input.ToHtmlString()
                );

            return MvcHtmlString.Create(result);
        }

        public static MvcHtmlString EditableDateTime(this HtmlHelper helper,DateTime value, string name, string id)
        {
            // Text Display
            var span = new TagBuilder("span") { InnerHtml = value.ToString("yyyy-MM-dd") };
            span.AddCssClass("cell-value");

            // Input display.
            var formatName = HtmlHelper.GenerateIdFromName(name);

            var uniqueId = $"{formatName}_{id}";

            var input = helper.TextBox(uniqueId, value.ToString("yyyy-MM-dd"),
                new { type = "date", @class = "hide input-sm" });

            var result = String.Concat(
                span.ToString(TagRenderMode.Normal),
                input.ToHtmlString()
                );
            return MvcHtmlString.Create(result);
        }

    }
}
