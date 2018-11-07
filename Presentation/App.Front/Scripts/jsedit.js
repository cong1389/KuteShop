

jQuery(document).ready(function () {
    toggleMobileNavigation();
});

// Toggle mobile navigation

function toggleMobileNavigation() {

    var navbar = jQuery("#navbar");

    var openBtn = jQuery(".navbar-header .open-btn");

    var closeBtn = jQuery("#navbar .close-navbar");



    openBtn.on("click", function () {

        if (!navbar.hasClass("slideInn")) {

            navbar.addClass("slideInn");

        }

        return false;

    })



    closeBtn.on("click", function () {

        if (navbar.hasClass("slideInn")) {

            navbar.removeClass("slideInn");

        }

        return false;

    })

}