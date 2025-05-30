<%-- 
    Document   : header
    Created on : May 30, 2025, 8:15:12 AM
    Author     : Đỗ Tuấn Anh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <base href="${pageContext.request.contextPath}/UI/">
</head>

<!-- Main Header -->
<header class="main-header flex">
    <!-- Header Lower -->
    <div id="header">

        <div class="header-lower">
            <div class="tf-container full">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="inner-container flex justify-space align-center">
                            <!-- Logo Box -->
                            <div class="mobile-nav-toggler mobie-mt mobile-button">
                                <i class="icon-Vector3"></i>
                            </div>
                            <div class="logo-box">
                                <div class="logo">
                                    <a href="index.html">
                                        <img src="assets/images/logo.png" alt="Logo">
                                    </a>
                                </div>
                            </div>
                            <div class="nav-outer flex align-center">
                                <!-- Main Menu -->
                                <nav class="main-menu show navbar-expand-md">
                                    <div class="navbar-collapse collapse clearfix" id="navbarSupportedContent">
                                        <ul class="navigation clearfix">
                                            <li class="dropdown2">
                                                <a href="#">Home</a>
                                                <ul>
                                                    <li><a href="index.html">Home Page 01</a></li>
                                                    <li><a href="home2.html">Home Page 02</a></li>
                                                    <li><a href="home3.html">Home Page 03</a></li>
                                                    <li><a href="home4.html">Home Page 04</a></li>
                                                    <li><a href="home5.html">Home Page 05</a></li>
                                                </ul>
                                                <div class="dropdown2-btn"></div></li>
                                            <li class="dropdown2">
                                                <a href="#">Tour</a>
                                                <ul>
                                                    <li><a href="archieve-tour.html">Archieve tour</a>

                                                    </li>
                                                    <li><a href="tour-package-v2.html">Tour left sidebar</a>

                                                    </li>
                                                    <li><a href="tour-package-v4.html">Tour package </a>

                                                    </li>
                                                    <li><a href="tour-single.html">Tour Single </a>

                                                    </li>
                                                </ul>
                                                <div class="dropdown2-btn"></div></li>
                                            <li class="dropdown2"><a href="#">Destination</a>
                                                <ul>
                                                    <li><a href="tour-destination-v1.html">Destination
                                                            V1</a></li>
                                                    <li><a href="tour-destination-v2.html">Destination
                                                            V2</a></li>
                                                    <li><a href="tour-destination-v3.html">Destination
                                                            V3</a></li>
                                                    <li><a href="single-destination.html">Destination
                                                            Single</a></li>
                                                </ul>
                                                <div class="dropdown2-btn"></div></li>
                                            <li class="dropdown2 "><a href="#">Blog</a>
                                                <ul>
                                                    <li><a href="blog.html">Blog</a></li>
                                                    <li><a href="blog-details.html">Blog Detail</a></li>
                                                </ul>
                                                <div class="dropdown2-btn"></div></li>

                                            <li class="dropdown2"><a href="#">Pages</a>
                                                <ul>
                                                    <li><a href="about-us.html">About Us</a></li>
                                                    <li><a href="team.html">Team member</a></li>
                                                    <li><a href="gallery.html">Gallery</a></li>
                                                    <li><a href="terms-condition.html">Terms &amp; Condition</a>
                                                    </li>
                                                    <li><a href="help-center.html">Help center</a></li>
                                                </ul>
                                                <div class="dropdown2-btn"></div></li>
                                            <li class="dropdown2"><a href="#">Dashboard</a>
                                                <ul>
                                                    <li><a href="dashboard.html">Dashboard </a></li>
                                                    <li><a href="my-booking.html">My booking</a></li>
                                                    <li><a href="my-listing.html">My Listing</a></li>
                                                    <li><a href="add-tour.html">Add Tour</a></li>
                                                    <li><a href="my-favorite.html">My Favorites</a></li>
                                                    <li><a href="my-profile.html">My profile</a></li>
                                                </ul>
                                                <div class="dropdown2-btn"></div></li>
                                            <li><a href="contact-us.html">Contact</a></li>
                                        </ul>
                                    </div>
                                </nav>
                                <!-- Main Menu End-->
                            </div>
                            <div class="header-account flex align-center">
                                <div class="language">
                                    <div class="nice-select" tabindex="0">
                                        <img src="./assets/images/page/language.svg" alt=""><span class="current">English</span>
                                        <ul class="list">
                                            <li data-value="" class="option selected"><img src="./assets/images/page/language.svg" alt="">English
                                            </li>
                                            <li data-value="Vietnam" class="option"><img src="./assets/images/page/language.svg" alt="">Vietnam
                                            </li>
                                            <li data-value="German" class="option"><img src="./assets/images/page/language.svg" alt="">German
                                            </li>
                                            <li data-value="Russian" class="option"><img src="./assets/images/page/language.svg" alt="">Russian
                                            </li>
                                            <li data-value="Canada" class="option"><img src="./assets/images/page/language.svg" alt="">Canada
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="currency">
                                    <div class="nice-select" tabindex="0">
                                        <span class="current">USD</span>
                                        <ul class="list">
                                            <li data-value="" class="option selected">USD</li>
                                            <li data-value="vnd" class="option">VND</li>
                                            <li data-value="ero" class="option">ERO</li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="search-mobie relative">
                                    <div class="dropdown">
                                        <a type="button" class="show-search" data-bs-toggle="dropdown" aria-expanded="false">
                                            <i class="icon-Vector5"></i>
                                        </a>
                                        <ul class="dropdown-menu top-search">
                                            <form action="/" id="search-bar-widget">
                                                <input type="text" placeholder="Search here...">
                                                <button type="button"><i class="icon-search-2"></i></button>
                                            </form>
                                        </ul>
                                    </div> 
                                </div>
                                <div class="register">
                                    <ul class="flex align-center">
                                        <li class="">
                                            <a href="login.html"><i class="icon-user-1-1"></i>
                                                <span>Sign in</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div><div style="height: 184px; display: none;"></div>
    </div>

    <!-- End Header Lower -->


    <!-- Mobile Menu  -->
    <div class="close-btn"><span class="icon flaticon-cancel-1"></span></div>
    <div class="mobile-menu">
        <div class="menu-backdrop"></div>
        <nav class="menu-box">
            <div class="nav-logo"><a href="index.html">
                    <img src="assets/images/logo2.png" alt=""></a></div>
            <div class="bottom-canvas">
                <div class="menu-outer">

                    <div class="navbar-collapse collapse clearfix" id="navbarSupportedContent">
                        <ul class="navigation clearfix">
                            <li class="dropdown2">
                                <a href="#">Home</a>
                                <ul>
                                    <li><a href="index.html">Home Page 01</a></li>
                                    <li><a href="home2.html">Home Page 02</a></li>
                                    <li><a href="home3.html">Home Page 03</a></li>
                                    <li><a href="home4.html">Home Page 04</a></li>
                                    <li><a href="home5.html">Home Page 05</a></li>
                                </ul>
                                <div class="dropdown2-btn"></div></li>
                            <li class="dropdown2">
                                <a href="#">Tour</a>
                                <ul>
                                    <li><a href="archieve-tour.html">Archieve tour</a>

                                    </li>
                                    <li><a href="tour-package-v2.html">Tour left sidebar</a>

                                    </li>
                                    <li><a href="tour-package-v4.html">Tour package </a>

                                    </li>
                                    <li><a href="tour-single.html">Tour Single </a>

                                    </li>
                                </ul>
                                <div class="dropdown2-btn"></div></li>
                            <li class="dropdown2"><a href="#">Destination</a>
                                <ul>
                                    <li><a href="tour-destination-v1.html">Destination
                                            V1</a></li>
                                    <li><a href="tour-destination-v2.html">Destination
                                            V2</a></li>
                                    <li><a href="tour-destination-v3.html">Destination
                                            V3</a></li>
                                    <li><a href="single-destination.html">Destination
                                            Single</a></li>
                                </ul>
                                <div class="dropdown2-btn"></div></li>
                            <li class="dropdown2 "><a href="#">Blog</a>
                                <ul>
                                    <li><a href="blog.html">Blog</a></li>
                                    <li><a href="blog-details.html">Blog Detail</a></li>
                                </ul>
                                <div class="dropdown2-btn"></div></li>

                            <li class="dropdown2"><a href="#">Pages</a>
                                <ul>
                                    <li><a href="about-us.html">About Us</a></li>
                                    <li><a href="team.html">Team member</a></li>
                                    <li><a href="gallery.html">Gallery</a></li>
                                    <li><a href="terms-condition.html">Terms &amp; Condition</a>
                                    </li>
                                    <li><a href="help-center.html">Help center</a></li>
                                </ul>
                                <div class="dropdown2-btn"></div></li>
                            <li class="dropdown2"><a href="#">Dashboard</a>
                                <ul>
                                    <li><a href="dashboard.html">Dashboard </a></li>
                                    <li><a href="my-booking.html">My booking</a></li>
                                    <li><a href="my-listing.html">My Listing</a></li>
                                    <li><a href="add-tour.html">Add Tour</a></li>
                                    <li><a href="my-favorite.html">My Favorites</a></li>
                                    <li><a href="my-profile.html">My profile</a></li>
                                </ul>
                                <div class="dropdown2-btn"></div></li>
                            <li><a href="contact-us.html">Contact</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>
    </div>
    <!-- End Mobile Menu -->

</header>
<!-- End Main Header -->

