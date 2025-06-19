/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


 new Swiper(".fieldSwiper", {
        loop: true,
        spaceBetween: 30,
        slidesPerView: 1,
        breakpoints: {
        576: {
        slidesPerView: 2
        },
                992: {
                slidesPerView: 4
                }
        },
       
        autoplay: {
        delay: 2500,
                disableOnInteraction: false
        }
 });



