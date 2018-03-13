﻿using System.Collections.Generic;

namespace App.Core.Caching
{
    public interface ISet : IEnumerable<string>
    {
        bool Add(string item);
        void Clear();
        bool Contains(string item);
        bool Remove(string item);
        bool Move(string destinationKey, string item);

        long UnionWith(params string[] keys);
        long IntersectWith(params string[] keys);
        long ExceptWith(params string[] keys);

        int Count { get; }
    }
}
