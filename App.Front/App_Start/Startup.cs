using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using Microsoft.AspNet.Identity;
using Microsoft.Owin;
using Microsoft.Owin.Security.Cookies;
using Owin;

namespace App.Front
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
            AreaRegistration.RegisterAllAreas();
            //GlobalConfiguration.Configure(new Action<HttpConfiguration>(WebApiConfig.Register));
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            app.MapSignalR();
        }

        public void ConfigureAuth(IAppBuilder app)
        {
            //string str =
            //    (new UrlHelper(HttpContext.Current.Request.RequestContext)).Action("Login", "User", new {area = ""});
            //app.UseCookieAuthentication(new CookieAuthenticationOptions
            //{
            //    AuthenticationType = "ApplicationCookie",
            //    LoginPath = new PathString(str)
            //});
            //app.UseExternalSignInCookie("ExternalCookie");

            string loginUrl = new UrlHelper(HttpContext.Current.Request.RequestContext).Action("Login", "User", new { area = "" });

            // Enable the application to use a cookie to store
            // information for the signed in user
            app.UseCookieAuthentication(new CookieAuthenticationOptions
            {
                AuthenticationType =
                    DefaultAuthenticationTypes.ApplicationCookie,
                LoginPath = new PathString(loginUrl)
            });

            // Use a cookie to temporarily store information about
            // a user logging in with a third party login provider
            app.UseExternalSignInCookie(
                DefaultAuthenticationTypes.ExternalCookie);

            app.UseGoogleAuthentication(
                clientId: "264629127668-pp28sk9b98o9hdvagvqimm1to2qjpejf.apps.googleusercontent.com",
                clientSecret: "OE3P6-4o0zVCd-k8QQ415oVn");

            // Uncomment the following lines to enable logging in
            // with third party login providers
            //app.UseMicrosoftAccountAuthentication(
            // clientId: "",
            // clientSecret: "");

            //app.UseTwitterAuthentication(
            // consumerKey: "",
            // consumerSecret: "");

            app.UseFacebookAuthentication(
             appId: "1318503118251337",
             appSecret: "2b816c9bb9637eddfb8056aaca4abe1b");

        }
    }
}