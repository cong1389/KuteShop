using System.Web.Mvc;

namespace App.Core.Extensions
{
    public static class HttpExtensions
    {
        public static ControllerContext GetMasterControllerContext(this ControllerContext controllerContext)
        {
            var ctx = controllerContext;

            while (ctx.ParentActionViewContext != null)
            {
                ctx = ctx.ParentActionViewContext;
            }

            return ctx;
        }
    }
}
