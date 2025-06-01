/**
  * isMobile
  * Parallax
  * flatCounter
  * goTop
  * toggleMenu
  * topSearch
  * flatProgressBar
  * popUpLightBox
  * Preloader
  * donatProgress
  * dropdown
  * video
  * checkViewListing
  * iconbar
  * retinaLogos
  * headerFixed
  * popupGallery
  * tabs
  * dropdown
  * click search form
*/

; (function ($) {

    "use strict";

    var isMobile = {
        Android: function () {
            return navigator.userAgent.match(/Android/i);
        },
        BlackBerry: function () {
            return navigator.userAgent.match(/BlackBerry/i);
        },
        iOS: function () {
            return navigator.userAgent.match(/iPhone|iPad|iPod/i);
        },
        Opera: function () {
            return navigator.userAgent.match(/Opera Mini/i);
        },
        Windows: function () {
            return navigator.userAgent.match(/IEMobile/i);
        },
        any: function () {
            return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
        }
    };

    var Parallax = function () {
        if ($().parallax && isMobile.any() == null) {
            $(".parallax").parallax("50%", 0.2);
        }
    };

    var flatCounter = function () {
        if ($(document.body).hasClass("counter-scroll")) {
            var a = 0;
            $(window).scroll(function () {
                var oTop = $(".tf-countto").offset().top - window.innerHeight;
                if (a === 0 && $(window).scrollTop() > oTop) {
                    if ($().countTo) {
                        $(".tf-countto")
                            .find(".number-counter")
                            .each(function () {
                                var to = $(this).data("to"),
                                    speed = $(this).data("speed"),
                                    dec = $(this).data("dec");
                                $(this).countTo({
                                    to: to,
                                    speed: speed,
                                    decimals: dec,
                                });
                            });
                    }
                    a = 1;
                }
            });
        }
    };

    var goTop = function () {
        $(window).scroll(function () {
            if ($(this).scrollTop() > 800) {
                $('#scroll-top').addClass('show');
            } else {
                $('#scroll-top').removeClass('show');
            }
        });

        $('#scroll-top').on('click', function () {
            $("html, body").animate({ scrollTop: 0 }, 300, 'easeInOutExpo');
            return false;
        });
    };

    var toggleMenu = function () {
        $(".header-menu").on("click", function () {
            $(".side-menu__block").addClass("active");
        });

        $(".side-menu__block-overlay,.side-menu__toggler, .scrollToLink").on(
            "click",
            function (e) {
                $(".side-menu__block").removeClass("active");
                e.preventDefault();
            }
        );
    }


    var flatProgressBar = function () {
        $('.couter').appear(function () {
            $('.chart').easyPieChart({
                easing: 'easeOut',
                lineWidth: 3,
                size: 68,
                scaleColor: false,
                barColor: '#FFF5E0',
                trackColor: '#FFA920',
                animate: 5000,
                onStep: function (from, to, percent) {
                    $(this.el).find('.percent').text(Math.round(percent));
                },
                rotate: 0,
            });

        }, {
            offset: 400
        });
    };

    var popUpLightBox = function () {
        if ($(".lightbox-image").length) {
            $(".lightbox-image").fancybox({
                openEffect: "fade",
                closeEffect: "fade",
                helpers: {
                    media: {}
                }
            });
        }
    };

    var Preloader = function () {
        setTimeout(function () {
            $(".preload").fadeOut("slow", function () {
                $(this).remove();
            });
        }, 400);
    };

    var donatProgress = function () {
        $(".content-progress-box").appear(function () {
            $('.progress-bar').each(function () {
                $(this).find('.progress-content').animate({
                    width: $(this).attr('data-percentage')
                }, 2000);

                $(this).find('.progress-number-mark').animate(
                    { left: $(this).attr('data-percentage') },
                    {
                        duration: 2000,
                        step: function (now, fx) {
                            var data = Math.round(now);
                            $(this).find('.percent').html(data + '%');
                        }
                    });
            });
        });
    };

    var dropdown = function (id) {
        var obj = $(id + '.dropdown');
        var btn = obj.find('.btn-selector');
        var dd = obj.find('ul');
        var opt = dd.find('li');
        dd.hide();
        obj.on("mouseenter", function () {
            dd.show();
            dd.addClass('show');
            $(this).css("z-index", 1000);
        }).on("mouseleave", function () {
            dd.hide();
            $(this).css("z-index", "auto")
            dd.removeClass('show');
        })

        opt.on("click", function () {
            dd.hide();
            var txt = $(this).text();
            opt.removeClass("active");
            $(this).addClass("active");
            btn.text(txt);
        });
    }

    var video = function () {
        if ($('div').hasClass('video-wrap')) {
            $('.widget-videos').magnificPopup({
                type: 'iframe'
            });
        }
    };

    //tab-lisst
    var onClickViewListingType = function () {
        if ($('.tf-my-listing').length > 0) {
            $('a.btn-display-listing-grid').click(function (event) {
                event.preventDefault();
                localStorage.setItem('VIEW_LISTING_TYPE', 'grid');
                checkViewListing();
            });
            $('a.btn-display-listing-list').click(function (event) {
                event.preventDefault();
                localStorage.setItem('VIEW_LISTING_TYPE', 'list');
                checkViewListing();
            });
        }
    };

    var checkViewListing = function () {
        if ($('.tf-my-listing').length > 0) {
            var type = localStorage.getItem('VIEW_LISTING_TYPE');
            switch (type) {
                case 'grid':
                    $('.listing-list-car-wrap').find('.listing-list-car-grid').removeClass('listing-list-car-list');
                    $('a.btn-display-listing-grid').addClass('active');
                    $('a.btn-display-listing-list').removeClass('active');
                    break;
                case 'list':
                    $('.listing-list-car-wrap').find('.listing-list-car-grid').addClass('listing-list-car-list');
                    $('a.btn-display-listing-list').addClass('active');
                    $('a.btn-display-listing-grid').removeClass('active');
                    break;
                default:
                    break;
            }
        }
    }

    var iconbar = function () {
        $("#pagee .icon-bars").on("click", function () {
            $(".sidebar-dashboard").toggleClass("actives");
        });

        $("#pagee .icon-bars").on("click", function (e) {
            $(".has-dashboard").toggleClass("actives");
            e.preventDefault();

        });
    }

    var retinaLogos = function () {
        var retina = window.devicePixelRatio > 1 ? true : false;
        if (retina) {
            $('#site-logo-inner').find('img').attr({ src: 'assets/images/logo/logo@2x.png', width: '197', height: '48' });

            $('#logo-footer.style').find('img').attr({ src: 'assets/images/logo/logo-footer@2x.png', width: '197', height: '48' });
            $('#logo-footer.style2').find('img').attr({ src: 'assets/images/logo/logo@2x.png', width: '197', height: '48' });
        }
    };

    var headerFixed = function () {
        if ($('body').hasClass('header-fixed')) {
            var nav = $('.header-lower');
            if (nav.length) {
                var
                    offsetTop = nav.offset().top,
                    headerHeight = nav.height(),
                    injectSpace = $("<div>", {
                        height: headerHeight
                    }).insertAfter(nav);
                injectSpace.hide();

                $(window).on('load scroll', function () {
                    if ($(window).scrollTop() > offsetTop + headerHeight) {
                        nav.addClass('is-fixed');
                        injectSpace.show();
                    } else {
                        nav.removeClass('is-fixed');
                        injectSpace.hide();
                    }

                    if ($(window).scrollTop() > 500) {
                        nav.addClass('is-small');
                    } else {
                        nav.removeClass('is-small');
                    }
                })
            }
        }
    };

    // img upload style 1
    $("#profileimg").click(function (e) {
        $("#tf-upload-img").click();
    });

    // click search form
    $('.pull-right').on('click', function (e) {
        e.preventDefault();

        $(this).toggleClass("click");
        $(".wd-search-form").toggleClass("show").delay(800);

    });

    var width = $(window).width();
    if (width < 1500) {
        $(".js-letters").removeClass("wow").show();
    }

    $('.wd-search .icon-icon-filter').on('click', function (e) {
        e.preventDefault();

        $(this).toggleClass("click");
        $(".wd-search-form").toggleClass("show").delay(800);

    });

    new WOW().init();


    // Dom Ready
    $(function () {
        goTop();
        donatProgress();
        popUpLightBox();
        onClickViewListingType();
        checkViewListing();
        toggleMenu();
        Parallax();
        retinaLogos();
        headerFixed();
        flatCounter();
        flatProgressBar();
        dropdown('#item_category');
        dropdown('#item_category2');
        donatProgress();
        iconbar();
        video();
        Preloader();
    });

})(jQuery);

