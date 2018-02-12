using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

namespace App.Domain.Common
{
	public static class Utils
	{
        public static IEnumerable<FieldInfo> GetConstants(this Type type)
        {
            var fields =
                from fi in type.GetFields(BindingFlags.Static | BindingFlags.Public | BindingFlags.FlattenHierarchy)
                where fi.IsLiteral && !fi.IsInitOnly
                select fi;

            return fields;
        }

        public static IEnumerable<T> GetConstantsValues<T>(this Type type)
        where T : class
        {
            IEnumerable<T> constants =
                from fi in type.GetConstants()
                select fi.GetRawConstantValue() as T;
            return constants;
        }
    }
}