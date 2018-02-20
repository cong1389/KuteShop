using App.Domain.Entities.Menu;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using App.Domain.Entities.Data;

namespace App.Front.Models.Posts
{
    public class CategoryPostModel
    {
        public int NumberMenu { get; set; }

        public CategoryPostModel()
        {
            MenuLinks= new List<MenuLink>();
            Posts = new List<Post>();
        }

        public IEnumerable<MenuLink> MenuLinks;

        public IEnumerable<Post> Posts;


    }
}