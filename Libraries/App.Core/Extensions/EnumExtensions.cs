using System;
using System.ComponentModel.DataAnnotations;
using System.Reflection;

namespace App.Core.Extensions
{
    public static class EnumExtensions
    {
        public static string ToDisplay(this Enum value)
        {
            string empty;
            if (value != null)
            {
                FieldInfo field = value.GetType().GetField(value.ToString());
                if (field == null)
                {
                    empty = string.Empty;
                }
                else
                {
                    DisplayAttribute[] customAttributes = (DisplayAttribute[])field.GetCustomAttributes(typeof(DisplayAttribute), false);
                    empty = customAttributes.Length != 0 ? customAttributes[0].GetName() : value.ToString();
                }
            }
            else
            {
                empty = "";
            }
            return empty;
        }
    }
}
