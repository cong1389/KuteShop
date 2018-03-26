using System.Collections.Generic;

namespace App.Core.Extensions
{
    public static class DictionaryExtensions
	{
	    public static TValue Get<TKey, TValue>(this IDictionary<TKey, TValue> instance, TKey key)
	    {
	        instance.TryGetValue(key, out var val);
	        return val;
	    }
    }
}
