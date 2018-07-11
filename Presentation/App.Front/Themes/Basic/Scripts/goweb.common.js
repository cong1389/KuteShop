
$(document).ready(function () {
    featurGoWeb.init();
});


var featurGoWeb = (function () {

    var slideOnHome = function () {
        if ($("#home-slider").length > 0 && $("#contenhomeslider").length > 0) {
            var slider = $("#contenhomeslider").bxSlider(
                {
                    nextText: '<i class="fa fa-angle-right"></i>',
                    prevText: '<i class="fa fa-angle-left"></i>',
                    auto: true
                }

            );
        }
    }

    var newsRelative = function () {
        var item = $(".gw-news-relative");
        if (item.length > 0) {
            item.each(function (index, el) {
                var config = $(this).data();
                config.nav = true;
                config.navText = ['<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>'];
                config.smartSpeed = "300";
                config.margin = 10;
                config.responsive = {
                    // breakpoint from 0 up
                    0: {
                        items: 2
                    },
                    // breakpoint from 480 up
                    480: {
                        items: 2
                    },
                    // breakpoint from 768 up
                    768: {
                        items: 3
                    },
                    1000: {
                        items: 5
                    }
                };
                if ($(this).hasClass("owl-style2")) {
                    config.animateOut = "fadeOut";
                    config.animateIn = "fadeIn";
                }
                $(this).owlCarousel(config);
            });
        }

    };

    var bannerTop = function () {
        var item = $(".gw-banner-top");
        if (item.length > 0) {
            item.each(function (index, el) {
                var config = $(this).data();
                config.dots = false;
                config.nav = true;
                config.navText = ['<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>'];
                config.smartSpeed = "300";
                config.margin = 10;
                config.responsive = {
                    // breakpoint from 0 up
                    0: {
                        items: 2
                    },
                    // breakpoint from 480 up
                    480: {
                        items: 2
                    },
                    // breakpoint from 768 up
                    768: {
                        items: 3
                    },
                    1000: {
                        items: 4
                    }
                };
                if ($(this).hasClass("owl-style2")) {
                    config.animateOut = "fadeOut";
                    config.animateIn = "fadeIn";
                }
                $(this).owlCarousel(config);
            });
        }

    };

    return {
        init: function () {
            slideOnHome();
            newsRelative();
            bannerTop();
        }

    }

})();

if (typeof EGA === "undefined") EGA = {};
EGA.product = {};
EGA.plugin = {};
EGA.addScript = {};
EGA.header = {};
EGA.filter = {};
EGA.options = {
    money_format: "{{amount}}₫"
}