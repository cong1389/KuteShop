using App.Domain.Menus;
using App.Domain.Posts;
using System.Collections.Generic;

namespace App.Front.Models.Posts
{
    public class CategoryPostModel
    {
        public IEnumerable<MenuLink> MenuLinks;
        public IEnumerable<Post> Posts;

        public int NumberMenu { get; set; }

        public CategoryPostModel()
        {
            MenuLinks = new List<MenuLink>();
            Posts = new List<Post>();
        }
    }
}