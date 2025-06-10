<%-- 
    Document   : trang-chu
    Created on : 31 thg 5, 2025, 11:53:41
    Author     : Asus
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">

    <head>
        <meta charset="utf-8">
            <base href="${pageContext.request.contextPath}/UI/">

                <title>Vitour - Travel & Tour Booking HTML Template</title>

                <meta name="author" content="themesflat.com">
                    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

                        <link rel="stylesheet" href="app/css/app.css">
                            <link rel="stylesheet" type="text/css" href="app/css/magnific-popup.css">
                                <link rel="stylesheet" type="text/css" href="app/css/jquery.fancybox.min.css">
                                    <link rel="stylesheet" type="text/css" href="app/css/textanimation.css">

                                        <!-- Favicon and Touch Icons  -->
                                        <link rel="shortcut icon" href="assets/images/favico.png">
                                            <link rel="apple-touch-icon-precomposed" href="assets/images/favico.png">

                                                </head>

                                                <body class="body header-fixed counter-scroll">

                                                    <div class="preload preload-container">
                                                        <svg class="pl" width="240" height="240" viewBox="0 0 240 240">
                                                            <circle class="pl__ring pl__ring--a" cx="120" cy="120" r="105" fill="none" stroke="#000" stroke-width="20"
                                                                    stroke-dasharray="0 660" stroke-dashoffset="-330" stroke-linecap="round"></circle>
                                                            <circle class="pl__ring pl__ring--b" cx="120" cy="120" r="35" fill="none" stroke="#000" stroke-width="20"
                                                                    stroke-dasharray="0 220" stroke-dashoffset="-110" stroke-linecap="round"></circle>
                                                            <circle class="pl__ring pl__ring--c" cx="85" cy="120" r="70" fill="none" stroke="#000" stroke-width="20"
                                                                    stroke-dasharray="0 440" stroke-linecap="round"></circle>
                                                            <circle class="pl__ring pl__ring--d" cx="155" cy="120" r="70" fill="none" stroke="#000" stroke-width="20"
                                                                    stroke-dasharray="0 440" stroke-linecap="round"></circle>
                                                        </svg>
                                                    </div>

                                                    <!-- /preload -->

                                                    <div id="wrapper">
                                                        <div id="pagee" class="clearfix">


                                                            <jsp:include page="header.jsp" />
                                                            <!-- End Main Header -->
                                                            <main id="main">


                                                                <!-- Widget Slider -->

                                                                <!-- Widget Slider -->

                                                                <!-- Widget Select Form -->
                                                                <div class="mt--82 z-index4 relative fadeInUp wow">
                                                                    <div class="tf-container">
                                                                        <div class="row">
                                                                            <div class="col-lg-12">



                                                                                </form>
                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                        </div>
                                                        <!-- Widget Select Form -->

                                                        <!-- Widget Aboutus -->

                                                        <!-- Widget Aboutus -->

                                                        <!-- Widget Tourpackage -->
                                                        <section class="tour-package pd-main">
                                                            <div class="tf-container w-1456">
                                                                <div class="row">
                                                                    <div class="col-lg-12">
                                                                        <div class="center m0-auto w-text-heading">

                                                                            <h2 class="title-heading mb-40 fadeInUp wow">Đề xuất sân bóng dành cho bạn 
                                                                            </h2>
                                                                        </div>
                                                                        <div class="tab-tour-list">

                                                                            <div class="tab-content" id="myTabContent">
                                                                                <div class="tab-pane fade show active" id="new-york-tab-pane" role="tabpanel"
                                                                                     aria-labelledby="new-york-tab" tabindex="0">

                                                                                    <div class="row">


                                                                                        <c:forEach items="${fieldList}" var="item">









                                                                                            <div class="col-sm-6 col-lg-3">

                                                                                                <div class="tour-listing">
                                                                                                    <a href="tour-single.html" class="tour-listing-image">

                                                                                                        <img src="${item.image}"
                                                                                                             alt="Image Listing">

                                                                                                    </a>
                                                                                                    <div class="tour-listing-content">

                                                                                                        <span class="map"><i class="icon-Vector4"></i>${item.address}</span>

                                                                                                        <h4 class="title-tour-list"><a href="tour-single.html">${item.fieldName}</a>
                                                                                                        </h4>

                                                                                                        <div class="icon-box flex-three">
                                                                                                            <div class="icons flex-three">
                                                                                                                <i class="icon-time-left"></i>
                                                                                                                <span>${item.status}</span>
                                                                                                            </div>
                                                                                                            <div class="icons flex-three">
                                                                                                                <svg width="21" height="16" viewBox="0 0 21 16"
                                                                                                                     fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                                                                    <path
                                                                                                                        d="M4.34766 4.79761C4.34766 2.94013 5.85346 1.43433 7.71094 1.43433C9.56841 1.43433 11.0742 2.94013 11.0742 4.79761C11.0742 6.65508 9.56841 8.16089 7.71094 8.16089C5.85346 8.16089 4.34766 6.65508 4.34766 4.79761Z"
                                                                                                                        stroke="#4DA528" stroke-width="1.7"
                                                                                                                        stroke-miterlimit="10"
                                                                                                                        stroke-linecap="round"
                                                                                                                        stroke-linejoin="round" />
                                                                                                                    <path
                                                                                                                        d="M9.5977 15.1797H2.46098C1.34827 15.1797 0.558268 14.0954 0.898984 13.0362C1.80408 10.222 4.57804 8.18566 7.69301 8.18566C9.17897 8.18566 10.5566 8.64906 11.6895 9.43922"
                                                                                                                        stroke="#4DA528" stroke-width="1.7"
                                                                                                                        stroke-miterlimit="10"
                                                                                                                        stroke-linecap="round"
                                                                                                                        stroke-linejoin="round" />
                                                                                                                    <path d="M17.1035 15.1797V9.02734"
                                                                                                                          stroke="#4DA528" stroke-width="1.7"
                                                                                                                          stroke-miterlimit="10"
                                                                                                                          stroke-linecap="round"
                                                                                                                          stroke-linejoin="round" />
                                                                                                                    <path d="M20.1797 12.1035H14.0273"
                                                                                                                          stroke="#4DA528" stroke-width="1.7"
                                                                                                                          stroke-miterlimit="10"
                                                                                                                          stroke-linecap="round"
                                                                                                                          stroke-linejoin="round" />
                                                                                                                </svg>
                                                                                                                <span>${item.fieldTypeName}</span>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                        <div class="flex-two">
                                                                                                            <div class="price-box flex-three">
                                                                                                                <p>From <span class="price-sale"> ${item.minPrice}$</span></p>

                                                                                                            </div>
                                                                                                            <div class="icon-bookmark">
                                                                                                                <i class="icon-Vector-151"></i>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>

                                                                                                </div>

                                                                                            </div>



                                                                                        </c:forEach>
                                                                                    </div>

                                                                                    <div class="row">

                                                                                        <div class="col-lg-12 center mt-44">

                                                                                            <a href="archieve-tour.html" class="btn-main">
                                                                                                <p class="btn-main-text">Xem tất cả sân</p>
                                                                                                <p class="btn-main-text">${i.description}</p>

                                                                                                <p class="iconer">
                                                                                                    <i class="icon-13"></i>
                                                                                                </p>
                                                                                            </a>
                                                                                            <!--                                                                                        <c:if test="${not empty field}">
                                                                                                <p>List rỗng hoặc chưa nhận được dữ liệu</p>
                                                                                            </c:if>
                                                                                            <c:forEach items="${field}" var="i">
                                                                                                ${i.description}
                                                                                            </c:forEach>    -->
                                                                                        </div>

                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                                                
                                                                                                
                                                                                                
                                                                    </div>
                                                                </div>

                                                            </div>

                                                        </section>
                                                                                                <section class="tour-package pd-main">
                                                            <div class="tf-container w-1456">
                                                                <div class="row">
                                                                    <div class="col-lg-12">
                                                                        <div class="center m0-auto w-text-heading">

                                                                            <h2 class="title-heading mb-40 fadeInUp wow">Sản phẩm của chúng tôi 
                                                                            </h2>
                                                                        </div>
                                                                        <div class="tab-tour-list">

                                                                            <div class="tab-content" id="myTabContent">
                                                                                <div class="tab-pane fade show active" id="new-york-tab-pane" role="tabpanel"
                                                                                     aria-labelledby="new-york-tab" tabindex="0">

                                                                                    <div class="row">


                                                                                        <c:forEach items="${plist}" var="plist">









                                                                                            <div class="col-sm-6 col-lg-3">

                                                                                                <div class="tour-listing">
                                                                                                    <a href="tour-single.html" class="tour-listing-image">

                                                                                                        <img src="${plist.productImage}"
                                                                                                             alt="Image Listing">

                                                                                                    </a>
                                                                                                    <div class="tour-listing-content">

                                                                                                        <span class="map"><i class="icon-Vector4"></i>${plist.productStatus}</span>

                                                                                                        <h4 class="title-tour-list"><a href="tour-single.html">${plist.productName}</a>
                                                                                                        </h4>

                                                                                                        <div class="icon-box flex-three">
<!--                                                                                                            <div class="icons flex-three">
                                                                                                                <i class="icon-time-left"></i>
                                                                                                                <span>${plist.productStatus}</span>
                                                                                                            </div>-->
                                                                                                            <div class="icons flex-three">
                                                                                                                <svg width="21" height="16" viewBox="0 0 21 16"
                                                                                                                     fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                                                                    <path
                                                                                                                        d="M4.34766 4.79761C4.34766 2.94013 5.85346 1.43433 7.71094 1.43433C9.56841 1.43433 11.0742 2.94013 11.0742 4.79761C11.0742 6.65508 9.56841 8.16089 7.71094 8.16089C5.85346 8.16089 4.34766 6.65508 4.34766 4.79761Z"
                                                                                                                        stroke="#4DA528" stroke-width="1.7"
                                                                                                                        stroke-miterlimit="10"
                                                                                                                        stroke-linecap="round"
                                                                                                                        stroke-linejoin="round" />
                                                                                                                    <path
                                                                                                                        d="M9.5977 15.1797H2.46098C1.34827 15.1797 0.558268 14.0954 0.898984 13.0362C1.80408 10.222 4.57804 8.18566 7.69301 8.18566C9.17897 8.18566 10.5566 8.64906 11.6895 9.43922"
                                                                                                                        stroke="#4DA528" stroke-width="1.7"
                                                                                                                        stroke-miterlimit="10"
                                                                                                                        stroke-linecap="round"
                                                                                                                        stroke-linejoin="round" />
                                                                                                                    <path d="M17.1035 15.1797V9.02734"
                                                                                                                          stroke="#4DA528" stroke-width="1.7"
                                                                                                                          stroke-miterlimit="10"
                                                                                                                          stroke-linecap="round"
                                                                                                                          stroke-linejoin="round" />
                                                                                                                    <path d="M20.1797 12.1035H14.0273"
                                                                                                                          stroke="#4DA528" stroke-width="1.7"
                                                                                                                          stroke-miterlimit="10"
                                                                                                                          stroke-linecap="round"
                                                                                                                          stroke-linejoin="round" />
                                                                                                                </svg>
                                                                                                                <span>${plist.productDescription}</span>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                        <div class="flex-two">
                                                                                                            <div class="price-box flex-three">
                                                                                                                <p>Giá <span class="price-sale"> ${plist.productPrice}$</span></p>

                                                                                                            </div>
                                                                                                            <div class="icon-bookmark">
                                                                                                                <i class="icon-Vector-151"></i>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>

                                                                                                </div>

                                                                                            </div>



                                                                                        </c:forEach>
                                                                                    </div>

                                                                                    <div class="row">

                                                                                        <div class="col-lg-12 center mt-44">

                                                                                            <a href="archieve-tour.html" class="btn-main">
                                                                                                <p class="btn-main-text">Xem tất sản phẩm</p>
                                                                                                <p class="btn-main-text">${i.description}</p>

                                                                                                <p class="iconer">
                                                                                                    <i class="icon-13"></i>
                                                                                                </p>
                                                                                            </a>
                                                                                            <!--                                                                                        <c:if test="${not empty field}">
                                                                                                <p>List rỗng hoặc chưa nhận được dữ liệu</p>
                                                                                            </c:if>
                                                                                            <c:forEach items="${field}" var="i">
                                                                                                ${i.description}
                                                                                            </c:forEach>    -->
                                                                                        </div>

                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                            </div>

                                                        </section>
                                                        <!-- Widget Tourpackage -->

                                                        <!-- Widget activities -->

                                                        <!-- Widget activities -->

                                                        <!-- Widget Offer Package -->




                                                        <!-- Widget Counter -->

                                                        <!-- Widget Counter -->

                                                        <!-- Widget destination -->

                                                        <!-- Widget destination -->

                                                        <!-- Widget Brand logo -->

                                                        <!-- Widget Brand logo -->

                                                        <!-- Widget Adventure -->

                                                        <!-- Widget Adventure -->

                                                        <!-- Widget Testimonial -->

                                                        <!-- Widget Testimonial -->

                                                        <!-- Widget Banner Contact -->

                                                        <!-- Widget Banner Contact -->

                                                        <!-- Widget Banner Blog -->

                                                        <!-- Widget Banner Blog -->



                                                        </main>


                                                        <jsp:include page="footer.jsp" />
                                                        <!-- Bottom -->
                                                    </div>
                                                    <!-- /#page -->
                                                    </div>

                                                    <!-- Modal Popup Bid -->

                                                    <a id="scroll-top" class="button-go"></a>

                                                    <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight">
                                                        <div class="offcanvas-header">
                                                            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                                                        </div>
                                                        <div class="offcanvas-body">
                                                            <div class="logo-canvas">
                                                                <img src="./assets/images/logo.png" alt="image">
                                                            </div>
                                                            <p class="des">The world’s first and largest digital market
                                                                for crypto collectibles and non-fungible
                                                            </p>
                                                            <ul class="canvas-info">
                                                                <li class="flex-three">
                                                                    <i class="icon-noun-mail-5780740-1"></i>
                                                                    <p>Info@webmail.com</p>
                                                                </li>
                                                                <li class="flex-three">
                                                                    <i class="icon-Group-9"></i>
                                                                    <p>684 555-0102 490</p>
                                                                </li>
                                                                <li class="flex-three">
                                                                    <i class="icon-Layer-19"></i>
                                                                    <p>6391 Elgin St. Celina, NYC 10299</p>
                                                                </li>
                                                            </ul>
                                                            <ul class="social flex-three">
                                                                <li>
                                                                    <a href="#">
                                                                        <i class="icon-icon-2"></i>
                                                                    </a>
                                                                </li>
                                                                <li>
                                                                    <a href="#">
                                                                        <i class="icon-icon-1"></i>
                                                                    </a>
                                                                </li>
                                                                <li>
                                                                    <a href="#">
                                                                        <i class="icon-8"></i>
                                                                    </a>
                                                                </li>
                                                                <li>
                                                                    <a href="#">
                                                                        <i class="icon-6"></i>
                                                                    </a>
                                                                </li>
                                                            </ul>

                                                        </div>
                                                    </div>

                                                    <!-- Javascript -->
                                                    <script src="app/js/jquery.min.js"></script>
                                                    <script src="app/js/jquery.nice-select.min.js"></script>
                                                    <script src="app/js/bootstrap.min.js"></script>
                                                    <script src="app/js/swiper-bundle.min.js"></script>
                                                    <script src="app/js/swiper.js"></script>
                                                    <script src="app/js/plugin.js"></script>
                                                    <script src="app/js/count-down.js"></script>
                                                    <script src="app/js/countto.js"></script>
                                                    <script src="app/js/jquery.fancybox.js"></script>
                                                    <script src="app/js/jquery.magnific-popup.min.js"></script>
                                                    <script src="app/js/price-ranger.js"></script>
                                                    <script src="app/js/textanimation.js"></script>
                                                    <script src="app/js/wow.min.js"></script>
                                                    <script src="app/js/shortcodes.js"></script>
                                                    <script src="app/js/main.js"></script>

                                                </body>

                                                </html>
