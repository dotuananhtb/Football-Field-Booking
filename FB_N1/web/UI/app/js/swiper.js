// ainimate sider
(function ($) {
    var Spanizer = (function () {
        var settings = {
            letters: $('.js-letters'),
        };
        return {
            init: function () {
                this.bind();
            },
            bind: function () {
                Spanizer.doSpanize();
            },
            doSpanize: function () {
                settings.letters.html(function (i, el) {
                    var spanize = $.trim(el).split("");
                    var template = '<span>' + spanize.join('</span><span>') + '</span>'
                    return template;
                });
            },
        };
    })();
    // Let's GO!
    Spanizer.init();
})(jQuery);


//  slider
var swiper = new Swiper(".mySwiper", {
    navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
    },
    slidesPerView: 1,

    autoplay: {
        delay: 6000,
        disableOnInteraction: false,
    },
});
var swiper = new Swiper(".testimonial-image", {
    spaceBetween: 22,
    slidesPerView: 3,
    freeMode: true,
    watchSlidesProgress: true,
});
var swiper2 = new Swiper(".mySwiper2", {
    speed: 1500,
    spaceBetween: 30,
    autoplay: {
        delay: 5000,
        disableOnInteraction: false,
    },
    thumbs: {
        swiper: swiper,
    },
});
var swiper = new Swiper(".testimonial-image2", {
    slidesPerView: 3,
    freeMode: true,
    watchSlidesProgress: true,
    pagination: {
        el: ".swiper-pagination",
        clickable: true,
    },
});
var swiper2 = new Swiper(".mySwiper3", {
    thumbs: {
        swiper: swiper,
    },
    speed: 1500,
    autoplay: {
        delay: 5000,
        disableOnInteraction: false,
    },
});
var swiper = new Swiper(".brand-logo", {
    autoplay: {
        delay: 0,
        disableOnInteraction: false,
    },
    slidesPerView: 2,
    loop: true,
    spaceBetween: 30,
    speed: 10000,
    observer: true,
    observeParents: true,

    breakpoints: {
        600: {
            slidesPerView: 2,
            spaceBetween: 0,
        },
        992: {
            slidesPerView: 3,
            spaceBetween: 0,
        },
        1200: {
            slidesPerView: 5,
            spaceBetween: 30,
        },
    },
});
var swiper = new Swiper(".serviceSwiper", {
    slidesPerView: 4,
    spaceBetween: 30,
    speed: 1500,
    autoplay: {
        delay: 5000,
        disableOnInteraction: false,
    },
    pagination: {
        el: ".swiper-pagination",
        clickable: true,
    },
    breakpoints: {
        0: {
            slidesPerView: 1,
            spaceBetween: 20,
        },
        500: {
            slidesPerView: 1,
            spaceBetween: 20,
        },
        768: {
            slidesPerView: 2,
        },
        1024: {
            slidesPerView: 4,
        },
    },
});
var swiper = new Swiper(".testimonialSwiper", {
    slidesPerView: 2,
    spaceBetween: 30,
    speed: 1500,
    autoplay: {
        delay: 5000,
        disableOnInteraction: false,
    },
    pagination: {
        el: ".swiper-pagination",
        clickable: true,
    },
    breakpoints: {
        0: {
            slidesPerView: 1,
        },
        500: {
            slidesPerView: 1,
        },
        768: {
            slidesPerView: 2,
        },
        1024: {
            slidesPerView: 2,
        },
    },
});
var swiper = new Swiper(".tour-package-swipper", {
    slidesPerView: 3,
    spaceBetween: 30,
    speed: 1500,
    navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
    },
    breakpoints: {
        0: {
            slidesPerView: 1,
        },
        600: {
            slidesPerView: 2,
        },
        1024: {
            slidesPerView: 3,
        },
    },
});
var swiper = new Swiper(".on-week-swipper", {
    slidesPerView: 3,
    spaceBetween: 30,
    observer: true,
    observeParents: true,
    speed: 1500,
    navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
    },
    breakpoints: {
        0: {
            slidesPerView: 1,
        },
        600: {
            slidesPerView: 2,
        },
        1024: {
            slidesPerView: 3,
        },
    },
});
var swiper = new Swiper(".populer-activities", {
    slidesPerView: 4,
    spaceBetween: 30,
    observer: true,
    speed: 1500,
    observeParents: true,
    navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
    },
    breakpoints: {
        0: {
            slidesPerView: 1,
        },
        500: {
            slidesPerView: 2,
        },
        767: {
            slidesPerView: 3,
        },
        1024: {
            slidesPerView: 4,
        },
    },
});
var swiper = new Swiper(".offer-package-swipper", {
    slidesPerView: 2,
    spaceBetween: 30,
    observer: true,
    observeParents: true,
    speed: 1500,
    navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
    },
    breakpoints: {
        0: {
            slidesPerView: 1,
        },
        600: {
            slidesPerView: 2,
        },
    },
});
var swiper = new Swiper(".tes-style3Swiper", {
    speed: 1500,
    autoplay: {
        delay: 5000,
        disableOnInteraction: false,
    },
    pagination: {
        el: ".swiper-pagination",
        clickable: true,
    },
});

var swiper = new Swiper(".mySwiperGalllery", {
    slidesPerView: 3,
    freeMode: true,
    watchSlidesProgress: true,
    pagination: {
        el: ".swiper-pagination",
        type: "fraction",
    },
});
var swiper2 = new Swiper(".mySwiper222", {
    spaceBetween: 10,
    speed: 1500,
    autoplay: {
        delay: 5000,
        disableOnInteraction: false,
    },
    pagination: {
        el: ".swiper-pagination",
        type: "fraction",
    },
    thumbs: {
        swiper: swiper,
    },
});

