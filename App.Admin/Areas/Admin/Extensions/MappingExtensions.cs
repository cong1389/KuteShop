using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using App.Admin.Areas.Admin.Model;
using App.Core.Plugins;
using AutoMapper;

namespace App.Admin.Areas.Admin.Extensions
{
    public static class MappingExtensions
    {
        public static PluginModel ToModel(this PluginDescriptor entity)
        {
            return Mapper.Map<PluginDescriptor, PluginModel>(entity);
        }
    }
}