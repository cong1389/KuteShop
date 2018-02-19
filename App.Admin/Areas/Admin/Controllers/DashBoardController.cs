using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using System.Web.Mvc;
using App.Domain.Entities.Data;
using App.Service.News;
using App.Service.Post;

namespace App.Admin.Controllers
{
    public class DashBoardController : BaseAdminController
    {
        private readonly IPostService _postService;

        private readonly INewsService _newsService;

        public DashBoardController(IPostService postService, INewsService newsService)
        {
            _postService = postService;
            _newsService = newsService;
        }

        public async Task<JsonResult> GetNewRealtime()
        {
            INewsService newsService = _newsService;

            Expression<Func<News, bool>> status = x => x.Status >= 0;

            IEnumerable<News> top = newsService.GetTop(50, status, x => x.CreatedDate);
            IOrderedEnumerable<News> news = await Task.FromResult(
                from x in top
                orderby x.CreatedDate descending
                select x);

            IOrderedEnumerable<News> news1 = news;

            JsonResult jsonResult = Json(new { list = RenderRazorViewToString("_DashBoardNews", news) }, JsonRequestBehavior.AllowGet);
            return jsonResult;
        }

        public async Task<JsonResult> GetPostRealtime()
        {
            IPostService postService = _postService;
            Expression<Func<Post, bool>> status = x => x.Status >= 0;
            IEnumerable<Post> top = postService.GetTop(50, status, x => x.CreatedDate);
            IOrderedEnumerable<Post> posts = await Task.FromResult(
                from x in top
                orderby x.CreatedDate descending
                select x);
            IOrderedEnumerable<Post> posts1 = posts;
            JsonResult jsonResult = Json(new { success = true, list = RenderRazorViewToString("_DashBoardPost", posts1) }, JsonRequestBehavior.AllowGet);
            return jsonResult;
        }
    }
}