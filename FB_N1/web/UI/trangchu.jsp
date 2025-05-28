<%-- 
    Document   : trangchu
    Created on : May 27, 2025, 10:02:40 PM
    Author     : Đỗ Tuấn Anh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="zxx">

    <head>

        <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">

                <title>Travelin - Travel Tour Booking HTML Templates</title>
                <!-- Favicon -->
                <style>
                    @keyframes fadein {
                        from {
                            opacity: 0;
                            transform: translateY(-20px);
                        }
                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }

                    @keyframes fadeout {
                        from {
                            opacity: 1;
                        }
                        to {
                            opacity: 0;
                        }
                    }
                    .modal-wrapper-top {
                        padding-top: 0;
                        margin-top: 0;
                    }

                    .modal-dialog {
                        margin-top: 1px !important;
                    }

                    .tooltip-error {
                        position: absolute;
                        background: #f44336;
                        color: white;
                        padding: 6px 10px;
                        border-radius: 8px;
                        font-size: 13px;
                        z-index: 9999;
                        box-shadow: 0 2px 8px rgba(0,0,0,0.2);
                        max-width: 250px;
                        white-space: nowrap;
                    }


                </style>
                <link rel="shortcut icon" type="image/x-icon" href="images/favicon.png">
                    <!-- Bootstrap core CSS -->
                    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
                        <!--Custom CSS-->
                        <link href="css/style.css" rel="stylesheet" type="text/css">
                            <!--Plugin CSS-->
                            <link href="css/plugin.css" rel="stylesheet" type="text/css">

                                <!--Font Awesome-->
                                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
                                    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css">

                                        <link rel="stylesheet" href="fonts/line-icons.css" type="text/css">
                                            </head>

                                            <body>

                                                <!-- Preloader -->
                                                <div id="preloader">
                                                    <div id="status"></div>
                                                </div>
                                                <!-- Preloader Ends -->

                                                <!-- header starts -->
                                                <header class="main_header_area">
                                                    <div class="header-content py-1 bg-theme">
                                                        <div class="container d-flex align-items-center justify-content-between">
                                                            <div class="links">
                                                                <ul>
                                                                    <li><a href="#" class="white"><i class="icon-calendar white"></i> Thursday, Mar 26, 2021</a>
                                                                    </li>
                                                                    <li><a href="#" class="white"><i class="icon-location-pin white"></i> Hollywood, America</a>
                                                                    </li>
                                                                    <li><a href="#" class="white"><i class="icon-clock white"></i> Mon-Fri: 10 AM – 5 PM</a></li>
                                                                </ul>
                                                            </div>
                                                            <div class="links float-right">
                                                                <ul>
                                                                    <li><a href="#" class="white"><i class="fab fa-facebook" aria-hidden="true"></i></a></li>
                                                                    <li><a href="#" class="white"><i class="fab fa-twitter" aria-hidden="true"></i></a></li>
                                                                    <li><a href="#" class="white"><i class="fab fa-instagram" aria-hidden="true"></i></a></li>
                                                                    <li><a href="#" class="white"><i class="fab fa-linkedin " aria-hidden="true"></i></a></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- Navigation Bar -->
                                                    <div class="header_menu" id="header_menu">
                                                        <nav class="navbar navbar-default">
                                                            <div class="container">
                                                                <div class="navbar-flex d-flex align-items-center justify-content-between w-100 pb-3 pt-3">
                                                                    <!-- Brand and toggle get grouped for better mobile display -->
                                                                    <div class="navbar-header">
                                                                        <a class="navbar-brand" href="index.html">
                                                                            <img src="images/logo.png" alt="image">
                                                                        </a>
                                                                    </div>
                                                                    <!-- Collect the nav links, forms, and other content for toggling -->
                                                                    <div class="navbar-collapse1 d-flex align-items-center" id="bs-example-navbar-collapse-1">
                                                                        <ul class="nav navbar-nav" id="responsive-menu">
                                                                            <li class="dropdown submenu active">
                                                                                <a href="index.html" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Home <i class="icon-arrow-down" aria-hidden="true"></i></a>
                                                                                <ul class="dropdown-menu">
                                                                                    <li><a href="index.html">Homepage Default</a></li>
                                                                                    <li><a href="index-1.html">Homepage 1</a></li>
                                                                                    <li><a href="index-2.html">Homepage 2</a></li>
                                                                                    <li><a href="index-3.html">Homepage 3</a></li>
                                                                                    <li><a href="index-4.html">Homepage 4</a></li>
                                                                                    <li><a href="index-5.html">Homepage 5</a></li>
                                                                                    <li class="submenu dropdown">
                                                                                        <a href="#" class="dropdown-toggle d-flex align-items-center" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Flights <i class="fa fa-angle-right" aria-hidden="true"></i></a> 
                                                                                        <ul class="dropdown-menu">
                                                                                            <li><a href="index-flight.html">Flight Homepage</a></li>
                                                                                            <li><a href="flight-grid.html">Flight Grid</a></li>
                                                                                            <li><a href="flight-list.html">Flight List</a></li>
                                                                                            <li><a href="flight-detail.html">Flight Detail</a></li>
                                                                                        </ul>
                                                                                    </li>
                                                                                    <li class="submenu dropdown">
                                                                                        <a href="#" class="dropdown-toggle d-flex align-items-center" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Cars <i class="fa fa-angle-right" aria-hidden="true"></i></a> 
                                                                                        <ul class="dropdown-menu">
                                                                                            <li><a href="index-car.html">Car Homepage</a></li>
                                                                                            <li><a href="car-grid.html">Car Grid</a></li>
                                                                                            <li><a href="car-list.html">Car List</a></li>
                                                                                            <li><a href="car-detail.html">Car Detail</a></li>
                                                                                        </ul>
                                                                                    </li>
                                                                                    <li class="submenu dropdown">
                                                                                        <a href="#" class="dropdown-toggle d-flex align-items-center" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Cruise <i class="fa fa-angle-right" aria-hidden="true"></i></a> 
                                                                                        <ul class="dropdown-menu">
                                                                                            <li><a href="index-cruise.html">Cruise Homepage</a></li>
                                                                                            <li><a href="cruise-grid.html">Cruise Grid</a></li>
                                                                                            <li><a href="cruise-list.html">Cruise List</a></li>
                                                                                            <li><a href="cruise-detail.html">Cruise Detail</a></li>
                                                                                        </ul>
                                                                                    </li>
                                                                                </ul>
                                                                            </li>

                                                                            <li><a href="about.html">About Us</a></li>

                                                                            <li class="submenu dropdown">
                                                                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Destinations <i class="icon-arrow-down" aria-hidden="true"></i></a> 
                                                                                <ul class="dropdown-menu">
                                                                                    <li><a href="destination-list.html">Destination List</a></li>
                                                                                    <li><a href="destination-detail.html">Destination Detail</a></li>
                                                                                </ul> 
                                                                            </li>
                                                                            <li class="submenu dropdown">
                                                                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Tours <i class="icon-arrow-down" aria-hidden="true"></i></a> 
                                                                                <ul class="dropdown-menu">
                                                                                    <li class="submenu dropdown">
                                                                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Tour List<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                                                                        <ul class="dropdown-menu">
                                                                                            <li><a href="tour-list.html">Tour List Leftsidebar</a></li>
                                                                                            <li><a href="tour-list1.html">Tour List Rightsidebar</a></li>
                                                                                            <li><a href="tour-list2.html">Tour List Fullwidth</a></li>
                                                                                        </ul>
                                                                                    </li>
                                                                                    <li class="submenu dropdown">
                                                                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Tour Grid<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                                                                        <ul class="dropdown-menu">
                                                                                            <li><a href="tour-grid.html">Tour Grid Leftsidebar</a></li>
                                                                                            <li><a href="tour-grid1.html">Tour Grid Rightsidebar</a></li>
                                                                                            <li><a href="tour-grid2.html">Tour Grid Fullwidth</a></li>
                                                                                        </ul>
                                                                                    </li>
                                                                                    <li class="submenu dropdown">
                                                                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Tour Single<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                                                                        <ul class="dropdown-menu">
                                                                                            <li><a href="tour-single.html">Tour Single Leftsidebar</a></li>
                                                                                            <li><a href="tour-single1.html">Tour Single Rightsidebar</a></li>
                                                                                            <li><a href="tour-single2.html">Tour Single Fullwidth</a></li>
                                                                                        </ul>
                                                                                    </li>
                                                                                </ul> 
                                                                            </li>
                                                                            <li class="submenu dropdown">
                                                                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Pages <i class="icon-arrow-down" aria-hidden="true"></i></a> 
                                                                                <ul class="dropdown-menu">
                                                                                    <li><a href="team.html">Our Guide</a></li>
                                                                                    <li><a href="booking.html">Booking</a></li>
                                                                                    <li><a href="confirmation.html">confirmation</a></li>
                                                                                    <li class="submenu dropdown">
                                                                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Services<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                                                                        <ul class="dropdown-menu">
                                                                                            <li><a href="services.html">Services Lists</a></li>
                                                                                            <li><a href="services-detail.html">Service Detail</a></li>
                                                                                        </ul>
                                                                                    </li>
                                                                                    <li class="submenu dropdown">
                                                                                        <a href="gallery.html" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Gallery<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                                                                        <ul class="dropdown-menu">
                                                                                            <li><a href="gallery.html">Gallery</a></li>
                                                                                            <li><a href="gallery1.html">Gallery Masonry</a></li>
                                                                                        </ul>
                                                                                    </li>
                                                                                    <li class="submenu dropdown">
                                                                                        <a href="404.html" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Error<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                                                                        <ul class="dropdown-menu">
                                                                                            <li><a href="404.html">Error Page 1</a></li>
                                                                                            <li><a href="404-1.html">Error Page 2</a></li>
                                                                                        </ul>
                                                                                    </li>
                                                                                    <li><a href="login.html">Login|Register</a></li>
                                                                                    <li><a href="comingsoon.html">Coming Soon</a></li>
                                                                                    <li><a href="testimonials.html">Testimonials</a></li>
                                                                                    <li><a href="faq.html">Faq</a></li>
                                                                                    <li><a href="contact.html">Contact Us</a></li>
                                                                                    <li><a href="dashboard/dashboard.html">Dashboard</a></li>
                                                                                </ul> 
                                                                            </li>
                                                                            <li class="submenu dropdown">
                                                                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Blog <i class="icon-arrow-down" aria-hidden="true"></i></a> 
                                                                                <ul class="dropdown-menu">
                                                                                    <li class="submenu dropdown">
                                                                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Blog Grid<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                                                                        <ul class="dropdown-menu">
                                                                                            <li><a href="post-grid-1.html">Blog Grid 1</a></li>
                                                                                            <li><a href="post-grid-2.html">Blog Grid 2</a></li>
                                                                                            <li><a href="post-grid-3.html">Blog Grid 3</a></li>
                                                                                        </ul>
                                                                                    </li>
                                                                                    <li class="submenu dropdown">
                                                                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Blog List<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                                                                        <ul class="dropdown-menu">
                                                                                            <li><a href="post-list-1.html">Blog List 1</a></li>
                                                                                            <li><a href="post-list-2.html">Blog List 2</a></li>
                                                                                            <li><a href="post-list-3.html">Blog List 3</a></li>
                                                                                        </ul>
                                                                                    </li>
                                                                                    <li class="submenu dropdown">
                                                                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Blog Single<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                                                                        <ul class="dropdown-menu">
                                                                                            <li><a href="detail-1.html">Blog Single 1</a></li>
                                                                                            <li><a href="detail-2.html">Blog Single 2</a></li>
                                                                                            <li><a href="detail-3.html">Blog Single 3</a></li>
                                                                                        </ul>
                                                                                    </li>
                                                                                </ul>
                                                                            </li>
                                                                            <li class="search-main"><a href="#search1" class="mt_search"><i class="fa fa-search"></i></a></li>
                                                                        </ul>
                                                                    </div><!-- /.navbar-collapse -->  
                                                                    <div class="register-login d-flex align-items-center">
                                                                        <a href="#" data-bs-toggle="modal" data-bs-target="#exampleModal" class="me-3">
                                                                            <i class="icon-user"></i> Login/Register
                                                                        </a>
                                                                        <a href="#" class="nir-btn white">Book Now</a>
                                                                    </div>

                                                                    <div id="slicknav-mobile"></div>
                                                                </div>
                                                            </div><!-- /.container-fluid -->
                                                        </nav>
                                                    </div>
                                                    <!-- Navigation Bar Ends -->
                                                </header>
                                                <!-- header ends -->
                                                <div class="tet"></div>

                                                <!-- banner starts -->
                                                <section class="banner pt-10 pb-0 overflow-hidden" style="background-image:url(images/testimonial.png);">
                                                    <div class="container">
                                                        <div class="banner-in">
                                                            <div class="row align-items-center">
                                                                <div class="col-lg-6 mb-4">
                                                                    <div class="banner-content text-lg-start text-center">
                                                                        <h4 class="theme mb-0">Explore The World</h4>
                                                                        <h1>Start Planning Your Dream Trip Today!</h1>
                                                                        <p class="mb-4">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
                                                                            tempor incididunt ut labore</p>
                                                                        <div class="book-form">
                                                                            <div class="row d-flex align-items-center justify-content-between">
                                                                                <div class="col-lg-6 mb-2">
                                                                                    <div class="form-group">
                                                                                        <div class="input-box">
                                                                                            <select class="niceSelect">
                                                                                                <option value="1">Destination</option>
                                                                                                <option value="2">Argentina</option>
                                                                                                <option value="3">Belgium</option>
                                                                                                <option value="4">Canada</option>
                                                                                                <option value="5">Denmark</option>
                                                                                            </select>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-lg-6 mb-2">
                                                                                    <div class="form-group">
                                                                                        <div class="input-box">
                                                                                            <input type="date" name="date">
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-lg-6 mb-2">
                                                                                    <div class="form-group">
                                                                                        <div class="input-box">
                                                                                            <select class="niceSelect">
                                                                                                <option value="1">Travel Type</option>
                                                                                                <option value="2">City Tour</option>
                                                                                                <option value="3">Family Tour</option>
                                                                                            </select>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-lg-6 mb-2">
                                                                                    <div class="form-group">
                                                                                        <div class="input-box">
                                                                                            <select class="niceSelect">
                                                                                                <option value="1">Tour Duration</option>
                                                                                                <option value="2">5 days</option>
                                                                                                <option value="3">7 Days</option>
                                                                                            </select>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-lg-12">
                                                                                    <div class="form-group mb-0 text-center">
                                                                                        <a href="#" class="nir-btn w-100"><i class="fa fa-search mr-2"></i> Search
                                                                                            Now</a>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-6 mb-4">
                                                                    <div class="banner-image">
                                                                        <img src="images/travel.png" alt="">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="category-main-inner border-t pt-1">
                                                                <div class="row side-slider">
                                                                    <div class="col-lg-3 col-md-6 my-4">
                                                                        <div class="category-item box-shadow p-3 py-4 text-center bg-white rounded overflow-hidden">
                                                                            <div class="trending-topic-content">
                                                                                <img src="images/icons/004-camping-tent.png" class="mb-1 d-inline-block" alt="">
                                                                                    <h4 class="mb-0"><a href="tour-grid.html">Camping</a></h4>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-3 col-md-6 my-4">
                                                                        <div class="category-item box-shadow p-3 py-4 text-center bg-white rounded overflow-hidden">
                                                                            <div class="trending-topic-content text-center">
                                                                                <img src="images/icons/003-hiking.png" class="mb-1 d-inline-block" alt="">
                                                                                    <h4 class="mb-0"><a href="tour-grid.html">Hiking</a></h4>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-3 col-md-6 my-4">
                                                                        <div class="category-item box-shadow p-3 py-4 text-center bg-white rounded overflow-hidden">
                                                                            <div class="trending-topic-content">
                                                                                <img src="images/icons/005-sunbed.png" class="mb-1 d-inline-block" alt="">
                                                                                    <h4 class="mb-0"><a href="tour-grid.html">Beach Tours</a></h4>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-3 col-md-6 my-4">
                                                                        <div class="category-item box-shadow p-3 py-4 text-center bg-white rounded overflow-hidden">
                                                                            <div class="trending-topic-content">
                                                                                <img src="images/icons/006-surf.png" class="mb-1 d-inline-block" alt="">
                                                                                    <h4 class="mb-0"><a href="tour-grid.html">Surfing</a></h4>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-3 col-md-6 my-4">
                                                                        <div class="category-item box-shadow p-3 py-4 text-center bg-white rounded overflow-hidden">
                                                                            <div class="trending-topic-content">
                                                                                <img src="images/icons/002-safari.png" class="mb-1 d-inline-block" alt="">
                                                                                    <h4 class="mb-0"><a href="tour-grid.html">Safari</a></h4>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-3 col-md-6 my-4">
                                                                        <div class="category-item box-shadow p-3 py-4 text-center bg-white rounded overflow-hidden">
                                                                            <div class="trending-topic-content">
                                                                                <img src="images/icons/008-cycling.png" class="mb-1 d-inline-block" alt="">
                                                                                    <h4 class="mb-0"><a href="tour-grid.html">Cycling</a></h4>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-3 col-md-6 my-4">
                                                                        <div class="category-item box-shadow p-3 py-4 text-center bg-white rounded overflow-hidden">
                                                                            <img src="images/icons/007-hiking-1.png" class="mb-1 d-inline-block" alt="">
                                                                                <div class="trending-topic-content">
                                                                                    <h4 class="mb-0"><a href="tour-grid.html">Trekings</a></h4>
                                                                                </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </section>

                                                <!-- about-us starts -->
                                                <section class="about-us pb-6 pt-6" style="background-image:url(images/shape4.png);
                                                         background-position:center;">
                                                    <div class="container">

                                                        <div class="section-title mb-6 w-50 mx-auto text-center">
                                                            <h4 class="mb-1 theme1">3 Step of The Perfect Tour</h4>
                                                            <h2 class="mb-1">Find <span class="theme">Travel Perfection</span></h2>
                                                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.
                                                            </p>
                                                        </div>

                                                        <!-- why us starts -->
                                                        <div class="why-us">
                                                            <div class="why-us-box">
                                                                <div class="row">
                                                                    <div class="col-lg-3 col-md-6 col-sm-6 mb-4">
                                                                        <div class="why-us-item text-center p-4 py-5 border rounded bg-white">
                                                                            <div class="why-us-content">
                                                                                <div class="why-us-icon">
                                                                                    <i class="icon-flag theme"></i>
                                                                                </div>
                                                                                <h4><a href="about.html">Tell Us What You want To Do</a></h4>
                                                                                <p class="mb-0">Lorem ipsum dolor sit amet, consectetur adipiscing.</p>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-3 col-md-6 col-sm-6 mb-4">
                                                                        <div class="why-us-item text-center p-4 py-5 border rounded bg-white">
                                                                            <div class="why-us-content">
                                                                                <div class="why-us-icon">
                                                                                    <i class="icon-location-pin theme"></i>
                                                                                </div>
                                                                                <h4><a href="about.html">Share Your Travel Locations</a></h4>
                                                                                <p class="mb-0">Lorem ipsum dolor sit amet, consectetur adipiscing.</p>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-3 col-md-6 col-sm-6 mb-4">
                                                                        <div class="why-us-item text-center p-4 py-5 border rounded bg-white">
                                                                            <div class="why-us-content">
                                                                                <div class="why-us-icon">
                                                                                    <i class="icon-directions theme"></i>
                                                                                </div>
                                                                                <h4><a href="about.html">Share Your Travel Preference</a></h4>
                                                                                <p class="mb-0">Lorem ipsum dolor sit amet, consectetur adipiscing.</p>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-3 col-md-6 col-sm-6 mb-4">
                                                                        <div class="why-us-item text-center p-4 py-5 border rounded bg-white">
                                                                            <div class="why-us-content">
                                                                                <div class="why-us-icon">
                                                                                    <i class="icon-compass theme"></i>
                                                                                </div>
                                                                                <h4><a href="about.html">We are 100% Trusted Tour Agency</a></h4>
                                                                                <p class="mb-0">Lorem ipsum dolor sit amet, consectetur adipiscing.</p>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!-- why us ends -->
                                                    </div>
                                                    <div class="white-overlay"></div>
                                                </section>
                                                <!-- about-us ends -->

                                                <!-- top Destination starts -->
                                                <section class="trending pb-5 pt-0">
                                                    <div class="container">
                                                        <div class="section-title mb-6 w-50 mx-auto text-center">
                                                            <h4 class="mb-1 theme1">Top Destinations</h4>
                                                            <h2 class="mb-1">Explore <span class="theme">Top Destinations</span></h2>
                                                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.
                                                            </p>
                                                        </div>
                                                        <div class="row align-items-center">
                                                            <div class="col-lg-5 mb-4">
                                                                <div class="trend-item1">
                                                                    <div class="trend-image position-relative rounded">
                                                                        <img src="images/destination/destination1.jpg" alt="image">
                                                                            <div
                                                                                class="trend-content d-flex align-items-center justify-content-between position-absolute bottom-0 p-4 w-100 z-index">
                                                                                <div class="trend-content-title">
                                                                                    <h5 class="mb-0"><a href="tour-grid.html" class="theme1">England</a></h5>
                                                                                    <h3 class="mb-0 white">London</h3>
                                                                                </div>
                                                                                <span class="white bg-theme p-1 px-2 rounded">15 Tours</span>
                                                                            </div>
                                                                            <div class="color-overlay"></div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-7">
                                                                <div class="row">
                                                                    <div class="col-lg-6 col-md-6 col-sm-6 mb-4">
                                                                        <div class="trend-item1">
                                                                            <div class="trend-image position-relative rounded">
                                                                                <img src="images/destination/destination17.jpg" alt="image">
                                                                                    <div
                                                                                        class="trend-content d-flex align-items-center justify-content-between position-absolute bottom-0 p-4 w-100 z-index">
                                                                                        <div class="trend-content-title">
                                                                                            <h5 class="mb-0"><a href="tour-grid.html" class="theme1">Italy</a>
                                                                                            </h5>
                                                                                            <h3 class="mb-0 white">Caspian Valley</h3>
                                                                                        </div>
                                                                                        <span class="white bg-theme p-1 px-2 rounded">18 Tours</span>
                                                                                    </div>
                                                                                    <div class="color-overlay"></div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-6 col-md-6 col-sm-6 mb-4">
                                                                        <div class="trend-item1">
                                                                            <div class="trend-image position-relative rounded">
                                                                                <img src="images/destination/destination14.jpg" alt="image">
                                                                                    <div
                                                                                        class="trend-content d-flex align-items-center justify-content-between position-absolute bottom-0 p-4 w-100 z-index">
                                                                                        <div class="trend-content-title">
                                                                                            <h5 class="mb-0"><a href="tour-grid.html" class="theme1">Tokyo</a>
                                                                                            </h5>
                                                                                            <h3 class="mb-0 white">Japan</h3>
                                                                                        </div>
                                                                                        <span class="white bg-theme p-1 px-2 rounded">21 Tours</span>
                                                                                    </div>
                                                                                    <div class="color-overlay"></div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-6 col-md-6 col-sm-6 mb-4">
                                                                        <div class="trend-item1">
                                                                            <div class="trend-image position-relative rounded">
                                                                                <img src="images/destination/destination15.jpg" alt="image">
                                                                                    <div
                                                                                        class="trend-content d-flex align-items-center justify-content-between position-absolute bottom-0 p-4 w-100">
                                                                                        <div class="trend-content-title">
                                                                                            <h5 class="mb-0"><a href="tour-grid.html" class="theme1">Moscow</a>
                                                                                            </h5>
                                                                                            <h3 class="mb-0 white">Russia</h3>
                                                                                        </div>
                                                                                        <span class="white bg-theme p-1 px-2 rounded">15 Tours</span>
                                                                                    </div>
                                                                                    <div class="color-overlay"></div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-6 col-md-6 col-sm-6 mb-4">
                                                                        <div class="trend-item1">
                                                                            <div class="trend-image position-relative rounded">
                                                                                <img src="images/destination/destination16.jpg" alt="image">
                                                                                    <div
                                                                                        class="trend-content d-flex align-items-center justify-content-between position-absolute bottom-0 p-4 w-100 z-index">
                                                                                        <div class="trend-content-title">
                                                                                            <h5 class="mb-0"><a href="tour-grid.html" class="theme1">Florida</a>
                                                                                            </h5>
                                                                                            <h3 class="mb-0 white">America</h3>
                                                                                        </div>
                                                                                        <span class="white bg-theme p-1 px-2 rounded">32 Tours</span>
                                                                                    </div>
                                                                                    <div class="color-overlay"></div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </section>
                                                <!-- top Destination ends -->

                                                <!-- about-us starts -->
                                                <section class="about-us pt-0" style="background-image:url(images/bg/bg-trans.png);">
                                                    <div class="container">
                                                        <div class="about-image-box">
                                                            <div class="row d-flex align-items-center justify-content-between">
                                                                <div class="col-lg-6 mb-4 pe-4">
                                                                    <div class="about-image overflow-hidden">
                                                                        <img src="images/travel1.png" alt="">
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-6 mb-4 ps-4">
                                                                    <div class="about-content text-center text-lg-start mb-4">
                                                                        <h4 class="theme d-inline-block mb-0">Get To Know Us</h4>
                                                                        <h2 class="border-b mb-2 pb-1">Explore All Tour of the world with us.</h2>
                                                                        <p class="border-b mb-2 pb-2">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
                                                                            do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
                                                                            quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
                                                                            consequat.<br><br>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui
                                                                                    officia deserunt mollit anim id est laborum.</p>
                                                                                    <div class="about-listing">
                                                                                        <ul class="d-flex justify-content-between">
                                                                                            <li><i class="icon-location-pin theme"></i> Tour Guide</li>
                                                                                            <li><i class="icon-briefcase theme"></i> Friendly Price</li>
                                                                                            <li><i class="icon-folder theme"></i> Reliable Tour Package</li>
                                                                                        </ul>
                                                                                    </div>
                                                                                    </div>
                                                                                    </div>
                                                                                    <div class="col-lg-12">
                                                                                        <!-- Counter -->
                                                                                        <div class="counter-main w-75 float-end">
                                                                                            <div class="counter p-4 pb-0 box-shadow bg-white rounded">
                                                                                                <div class="row">
                                                                                                    <div class="col-lg-3 col-md-6 col-sm-6 mb-4">
                                                                                                        <div class="counter-item border-end pe-4">
                                                                                                            <div class="counter-content">
                                                                                                                <h2 class="value mb-0 theme">20</h2>
                                                                                                                <span class="m-0">Years Experiences</span>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>

                                                                                                    <div class="col-lg-3 col-md-6 col-sm-6 mb-4">
                                                                                                        <div class="counter-item border-end pe-4">
                                                                                                            <div class="counter-content">
                                                                                                                <h2 class="value mb-0 theme">530</h2>
                                                                                                                <span class="m-0">Tour Packages</span>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>

                                                                                                    <div class="col-lg-3 col-md-6 col-sm-6 mb-4">
                                                                                                        <div class="counter-item border-end pe-4">
                                                                                                            <div class="counter-content">
                                                                                                                <h2 class="value mb-0 theme">850</h2>
                                                                                                                <span class="m-0">Happy Customers</span>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>

                                                                                                    <div class="col-lg-3 col-md-6 col-sm-6 mb-4">
                                                                                                        <div class="counter-item">
                                                                                                            <div class="counter-content">
                                                                                                                <h2 class="value mb-0 theme">320</h2>
                                                                                                                <span class="m-0">Award Winning</span>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>


                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                        <!-- End Counter -->
                                                                                    </div>
                                                                                    </div>
                                                                                    </div>
                                                                                    </div>
                                                                                    <div class="white-overlay"></div>
                                                                                    </section>
                                                                                    <!-- about-us ends -->

                                                                                    <!-- best tour Starts -->
                                                                                    <section class="trending pb-0">
                                                                                        <div class="container">
                                                                                            <div class="row align-items-center justify-content-between mb-6 ">
                                                                                                <div class="col-lg-7">
                                                                                                    <div class="section-title text-center text-lg-start">
                                                                                                        <h4 class="mb-1 theme1">Top Pick</h4>
                                                                                                        <h2 class="mb-1">Best <span class="theme">Tour Packages</span></h2>
                                                                                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut
                                                                                                            labore.</p>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="col-lg-5">

                                                                                                </div>
                                                                                            </div>
                                                                                            <div class="trend-box">
                                                                                                <div class="row item-slider">
                                                                                                    <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
                                                                                                        <div class="trend-item rounded box-shadow">
                                                                                                            <div class="trend-image position-relative">
                                                                                                                <img src="images/trending/trending2.jpg" alt="image" class="">
                                                                                                                    <div class="color-overlay"></div>
                                                                                                            </div>
                                                                                                            <div class="trend-content p-4 pt-5 position-relative">
                                                                                                                <div class="trend-meta bg-theme white px-3 py-2 rounded">
                                                                                                                    <div class="entry-author">
                                                                                                                        <i class="icon-calendar"></i>
                                                                                                                        <span class="fw-bold"> 9 Days Tours</span>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                                <h5 class="theme mb-1"><i class="flaticon-location-pin"></i> Croatia</h5>
                                                                                                                <h3 class="mb-1"><a href="tour-grid.html">Piazza Castello</a></h3>
                                                                                                                <div class="rating-main d-flex align-items-center pb-2">
                                                                                                                    <div class="rating">
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                    </div>
                                                                                                                    <span class="ms-2">(12)</span>
                                                                                                                </div>
                                                                                                                <p class=" border-b pb-2 mb-2">Duis aute irure dolor in reprehenderit in voluptate velit
                                                                                                                    esse cillum</p>
                                                                                                                <div class="entry-meta">
                                                                                                                    <div class="entry-author d-flex align-items-center">
                                                                                                                        <p class="mb-0"><span class="theme fw-bold fs-5"> $170.00</span> | Per person
                                                                                                                        </p>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                    <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
                                                                                                        <div class="trend-item box-shadow rounded">
                                                                                                            <div class="trend-image position-relative">
                                                                                                                <img src="images/trending/trending3.jpg" alt="image">
                                                                                                                    <div class="color-overlay"></div>
                                                                                                            </div>
                                                                                                            <div class="trend-content p-4 pt-5 position-relative">
                                                                                                                <div class="trend-meta bg-theme white px-3 py-2 rounded">
                                                                                                                    <div class="entry-author">
                                                                                                                        <i class="icon-calendar"></i>
                                                                                                                        <span class="fw-bold"> 9 Days Tours</span>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                                <h5 class="theme mb-1"><i class="flaticon-location-pin"></i> Greece</h5>
                                                                                                                <h3 class="mb-1"><a href="tour-grid.html">Santorini, Oia</a></h3>
                                                                                                                <div class="rating-main d-flex align-items-center pb-2">
                                                                                                                    <div class="rating">
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                    </div>
                                                                                                                    <span class="ms-2">(38)</span>
                                                                                                                </div>
                                                                                                                <p class=" border-b pb-2 mb-2">Duis aute irure dolor in reprehenderit in voluptate velit
                                                                                                                    esse cillum</p>
                                                                                                                <div class="entry-meta">
                                                                                                                    <div class="entry-author d-flex align-items-center">
                                                                                                                        <p class="mb-0"><span class="theme fw-bold fs-5"> $180.00</span> | Per person
                                                                                                                        </p>
                                                                                                                    </div>
                                                                                                                </div>

                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                    <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
                                                                                                        <div class="trend-item box-shadow rounded">
                                                                                                            <div class="trend-image position-relative">
                                                                                                                <img src="images/trending/trending4.jpg" alt="image">
                                                                                                                    <div class="color-overlay"></div>
                                                                                                            </div>
                                                                                                            <div class="trend-content p-4 pt-5 position-relative">
                                                                                                                <div class="trend-meta bg-theme white px-3 py-2 rounded">
                                                                                                                    <div class="entry-author">
                                                                                                                        <i class="icon-calendar"></i>
                                                                                                                        <span class="fw-bold"> 9 Days Tours</span>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                                <h5 class="theme mb-1"><i class="flaticon-location-pin"></i> Maldives</h5>
                                                                                                                <h3 class="mb-1"><a href="tour-grid.html">Hurawalhi Island</a></h3>
                                                                                                                <div class="rating-main d-flex align-items-center pb-2">
                                                                                                                    <div class="rating">
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                    </div>
                                                                                                                    <span class="ms-2">(18)</span>
                                                                                                                </div>
                                                                                                                <p class=" border-b pb-2 mb-2">Duis aute irure dolor in reprehenderit in voluptate velit
                                                                                                                    esse cillum</p>
                                                                                                                <div class="entry-meta">
                                                                                                                    <div class="entry-author d-flex align-items-center">
                                                                                                                        <p class="mb-0"><span class="theme fw-bold fs-5"> $260.00</span> | Per person
                                                                                                                        </p>
                                                                                                                    </div>
                                                                                                                </div>

                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                    <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
                                                                                                        <div class="trend-item box-shadow rounded">
                                                                                                            <div class="trend-image position-relative">
                                                                                                                <img src="images/trending/trending1.jpg" alt="image">
                                                                                                                    <div class="color-overlay"></div>
                                                                                                            </div>
                                                                                                            <div class="trend-content p-4 pt-5 position-relative">
                                                                                                                <div class="trend-meta bg-theme white px-3 py-2 rounded">
                                                                                                                    <div class="entry-author">
                                                                                                                        <i class="icon-calendar"></i>
                                                                                                                        <span class="fw-bold"> 5 Days Tours</span>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                                <h5 class="theme mb-1"><i class="flaticon-location-pin"></i> Greece</h5>
                                                                                                                <h3 class="mb-1"><a href="tour-grid.html">Santorini, Oia</a></h3>
                                                                                                                <div class="rating-main d-flex align-items-center pb-2">
                                                                                                                    <div class="rating">
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                    </div>
                                                                                                                    <span class="ms-2">(38)</span>
                                                                                                                </div>
                                                                                                                <p class=" border-b pb-2 mb-2">Duis aute irure dolor in reprehenderit in voluptate velit
                                                                                                                    esse cillum</p>
                                                                                                                <div class="entry-meta">
                                                                                                                    <div class="entry-author d-flex align-items-center">
                                                                                                                        <p class="mb-0"><span class="theme fw-bold fs-5"> $180.00</span> | Per person
                                                                                                                        </p>
                                                                                                                    </div>
                                                                                                                </div>

                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </section>
                                                                                    <!-- best tour Ends -->

                                                                                    <!-- Last Minute Deal Starts -->
                                                                                    <section class="trending pb-0 pt-6" style="background-image: url(images/shape2.png);">
                                                                                        <div class="container">
                                                                                            <div class="section-title mb-6 w-75 mx-auto text-center">
                                                                                                <h4 class="mb-1 theme1">Top Deals</h4>
                                                                                                <h2 class="mb-1">The Last <span class="theme">Minute Deals</span></h2>
                                                                                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.
                                                                                                </p>
                                                                                            </div>
                                                                                            <div class="trend-box">
                                                                                                <div class="row">
                                                                                                    <div class="col-lg-5 mb-4">
                                                                                                        <div class="trend-item1 rounded box-shadow mb-4">
                                                                                                            <div class="trend-image position-relative">
                                                                                                                <img src="images/trending/trendingb-2.jpg" alt="image" class="">
                                                                                                                    <div class="trend-content1 p-4">
                                                                                                                        <h5 class="theme1 mb-1"><i class="flaticon-location-pin"></i> Norway</h5>
                                                                                                                        <h3 class="mb-1 white"><a href="tour-grid.html" class="white">Norway Lake</a>
                                                                                                                        </h3>
                                                                                                                        <div class="rating-main d-flex align-items-center pb-2">
                                                                                                                            <div class="rating">
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                            </div>
                                                                                                                            <span class="ms-2 white">(16)</span>
                                                                                                                        </div>
                                                                                                                        <div class="entry-meta d-flex align-items-center justify-content-between">
                                                                                                                            <div class="entry-author d-flex align-items-center">
                                                                                                                                <p class="mb-0 white"><span class="theme1 fw-bold fs-5"> $180.00</span> |
                                                                                                                                    Per person</p>
                                                                                                                            </div>
                                                                                                                            <div class="entry-author">
                                                                                                                                <i class="icon-calendar white"></i>
                                                                                                                                <span class="fw-bold white"> 6 Days Tours</span>
                                                                                                                            </div>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                    <div class="overlay"></div>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                        <div class="trend-item1 rounded box-shadow mb-4">
                                                                                                            <div class="trend-image position-relative">
                                                                                                                <img src="images/trending/trending-large.jpg" alt="image" class="">
                                                                                                                    <div class="trend-content1 p-4">
                                                                                                                        <h5 class="theme1 mb-1"><i class="flaticon-location-pin"></i> Egpyt</h5>
                                                                                                                        <h3 class="mb-1 white"><a href="tour-grid.html" class="white">Pyramid Land</a>
                                                                                                                        </h3>
                                                                                                                        <div class="rating-main d-flex align-items-center pb-2">
                                                                                                                            <div class="rating">
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                            </div>
                                                                                                                            <span class="ms-2 white">(16)</span>
                                                                                                                        </div>
                                                                                                                        <div class="entry-meta d-flex align-items-center justify-content-between">
                                                                                                                            <div class="entry-author d-flex align-items-center">
                                                                                                                                <p class="mb-0 white"><span class="theme1 fw-bold fs-5"> $180.00</span> |
                                                                                                                                    Per person</p>
                                                                                                                            </div>
                                                                                                                            <div class="entry-author">
                                                                                                                                <i class="icon-calendar white"></i>
                                                                                                                                <span class="fw-bold white"> 6 Days Tours</span>
                                                                                                                            </div>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                    <div class="overlay"></div>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                        <div class="trend-item1 rounded box-shadow">
                                                                                                            <div class="trend-image position-relative">
                                                                                                                <img src="images/trending/trendingb-1.jpg" alt="image" class="">
                                                                                                                    <div class="trend-content1 p-4">
                                                                                                                        <h5 class="theme1 mb-1"><i class="flaticon-location-pin"></i> Usa</h5>
                                                                                                                        <h3 class="mb-1 white"><a href="tour-grid.html" class="white">New York
                                                                                                                                City</a></h3>
                                                                                                                        <div class="rating-main d-flex align-items-center pb-2">
                                                                                                                            <div class="rating">
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                            </div>
                                                                                                                            <span class="ms-2 white">(12)</span>
                                                                                                                        </div>
                                                                                                                        <div class="entry-meta d-flex align-items-center justify-content-between">
                                                                                                                            <div class="entry-author d-flex align-items-center">
                                                                                                                                <p class="mb-0 white"><span class="theme1 fw-bold fs-5"> $140.00</span> |
                                                                                                                                    Per person</p>
                                                                                                                            </div>
                                                                                                                            <div class="entry-author">
                                                                                                                                <i class="icon-calendar white"></i>
                                                                                                                                <span class="fw-bold white"> 3 Days Tours</span>
                                                                                                                            </div>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                    <div class="overlay"></div>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                    <div class="col-lg-7">
                                                                                                        <div class="row">
                                                                                                            <div class="col-lg-6 col-md-6 mb-4">
                                                                                                                <div class="trend-item rounded box-shadow">
                                                                                                                    <div class="trend-image position-relative">
                                                                                                                        <img src="images/trending/trending1.jpg" alt="image" class="">
                                                                                                                            <div class="color-overlay"></div>
                                                                                                                    </div>
                                                                                                                    <div class="trend-content p-4 pt-5 position-relative bg-white">
                                                                                                                        <div class="trend-meta bg-theme white px-3 py-2 rounded">
                                                                                                                            <div class="entry-author">
                                                                                                                                <i class="icon-calendar"></i>
                                                                                                                                <span class="fw-bold"> 4 Days Tours</span>
                                                                                                                            </div>
                                                                                                                        </div>
                                                                                                                        <h5 class="theme mb-1"><i class="flaticon-location-pin"></i> Spain</h5>
                                                                                                                        <h3 class="mb-1"><a href="tour-grid.html">Barcelona city beach</a></h3>
                                                                                                                        <div class="rating-main d-flex align-items-center pb-2">
                                                                                                                            <div class="rating">
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                            </div>
                                                                                                                            <span class="ms-2">(21)</span>
                                                                                                                        </div>
                                                                                                                        <p class=" border-b pb-2 mb-2">Duis aute irure dolor in reprehenderit in
                                                                                                                            voluptate velit esse cillum</p>
                                                                                                                        <div class="entry-meta">
                                                                                                                            <div class="entry-author d-flex align-items-center">
                                                                                                                                <p class="mb-0"><span class="theme fw-bold fs-5"> $220.00</span> | Per
                                                                                                                                    person</p>
                                                                                                                            </div>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                            <div class="col-lg-6 col-md-6 mb-4">
                                                                                                                <div class="trend-item rounded box-shadow">
                                                                                                                    <div class="trend-image position-relative">
                                                                                                                        <img src="images/trending/trending2.jpg" alt="image" class="">
                                                                                                                            <div class="color-overlay"></div>
                                                                                                                    </div>
                                                                                                                    <div class="trend-content p-4 pt-5 position-relative bg-white">
                                                                                                                        <div class="trend-meta bg-theme white px-3 py-2 rounded">
                                                                                                                            <div class="entry-author">
                                                                                                                                <i class="icon-calendar"></i>
                                                                                                                                <span class="fw-bold"> 7 Days Tours</span>
                                                                                                                            </div>
                                                                                                                        </div>
                                                                                                                        <h5 class="theme mb-1"><i class="flaticon-location-pin"></i> Indonesia</h5>
                                                                                                                        <h3 class="mb-1"><a href="tour-grid.html">Bali Province</a></h3>
                                                                                                                        <div class="rating-main d-flex align-items-center pb-2">
                                                                                                                            <div class="rating">
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                            </div>
                                                                                                                            <span class="ms-2">(11)</span>
                                                                                                                        </div>
                                                                                                                        <p class=" border-b pb-2 mb-2">Duis aute irure dolor in reprehenderit in
                                                                                                                            voluptate velit esse cillum</p>
                                                                                                                        <div class="entry-meta">
                                                                                                                            <div class="entry-author d-flex align-items-center">
                                                                                                                                <p class="mb-0"><span class="theme fw-bold fs-5"> $210.00</span> | Per
                                                                                                                                    person</p>
                                                                                                                            </div>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                            <div class="col-lg-6 col-md-6 mb-4">
                                                                                                                <div class="trend-item rounded box-shadow">
                                                                                                                    <div class="trend-image position-relative">
                                                                                                                        <img src="images/trending/trending3.jpg" alt="image" class="">
                                                                                                                            <div class="color-overlay"></div>
                                                                                                                    </div>
                                                                                                                    <div class="trend-content p-4 pt-5 position-relative bg-white">
                                                                                                                        <div class="trend-meta bg-theme white px-3 py-2 rounded">
                                                                                                                            <div class="entry-author">
                                                                                                                                <i class="icon-calendar"></i>
                                                                                                                                <span class="fw-bold"> 3 Days Tours</span>
                                                                                                                            </div>
                                                                                                                        </div>
                                                                                                                        <h5 class="theme mb-1"><i class="flaticon-location-pin"></i> Russia</h5>
                                                                                                                        <h3 class="mb-1"><a href="tour-grid.html">Red City Land</a></h3>
                                                                                                                        <div class="rating-main d-flex align-items-center pb-2">
                                                                                                                            <div class="rating">
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                            </div>
                                                                                                                            <span class="ms-2">(25)</span>
                                                                                                                        </div>
                                                                                                                        <p class=" border-b pb-2 mb-2">Duis aute irure dolor in reprehenderit in
                                                                                                                            voluptate velit esse cillum</p>
                                                                                                                        <div class="entry-meta">
                                                                                                                            <div class="entry-author d-flex align-items-center">
                                                                                                                                <p class="mb-0"><span class="theme fw-bold fs-5"> $120.00</span> | Per
                                                                                                                                    person</p>
                                                                                                                            </div>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                            <div class="col-lg-6 col-md-6 mb-4">
                                                                                                                <div class="trend-item rounded box-shadow">
                                                                                                                    <div class="trend-image position-relative">
                                                                                                                        <img src="images/trending/trending4.jpg" alt="image" class="">
                                                                                                                            <div class="color-overlay"></div>
                                                                                                                    </div>
                                                                                                                    <div class="trend-content p-4 pt-5 position-relative bg-white">
                                                                                                                        <div class="trend-meta bg-theme white px-3 py-2 rounded">
                                                                                                                            <div class="entry-author">
                                                                                                                                <i class="icon-calendar"></i>
                                                                                                                                <span class="fw-bold"> 5 Days Tours</span>
                                                                                                                            </div>
                                                                                                                        </div>
                                                                                                                        <h5 class="theme mb-1"><i class="flaticon-location-pin"></i> Bangladesh</h5>
                                                                                                                        <h3 class="mb-1"><a href="tour-grid.html">Cox's bazar Beach</a></h3>
                                                                                                                        <div class="rating-main d-flex align-items-center pb-2">
                                                                                                                            <div class="rating">
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                                <span class="fa fa-star checked"></span>
                                                                                                                            </div>
                                                                                                                            <span class="ms-2">(32)</span>
                                                                                                                        </div>
                                                                                                                        <p class=" border-b pb-2 mb-2">Duis aute irure dolor in reprehenderit in
                                                                                                                            voluptate velit esse cillum</p>
                                                                                                                        <div class="entry-meta">
                                                                                                                            <div class="entry-author d-flex align-items-center">
                                                                                                                                <p class="mb-0"><span class="theme fw-bold fs-5"> $100.00</span> | Per
                                                                                                                                    person</p>
                                                                                                                            </div>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>

                                                                                            </div>
                                                                                        </div>
                                                                                    </section>
                                                                                    <!-- Last Minute Deal Ends -->

                                                                                    <!-- Discount action starts -->
                                                                                    <section class="discount-action pt-6"
                                                                                             style="background-image:url(images/section-bg1.png);
                                                                                             background-position:center;">
                                                                                        <div class="section-shape section-shape1 top-inherit bottom-0"
                                                                                             style="background-image: url(images/shape8.png);"></div>
                                                                                        <div class="container">
                                                                                            <div class="call-banner rounded pt-10 pb-14">
                                                                                                <div class="call-banner-inner w-75 mx-auto text-center px-5">
                                                                                                    <div class="trend-content-main">
                                                                                                        <div class="trend-content mb-5 pb-2 px-5">
                                                                                                            <h5 class="mb-1 theme">Love Where Your're Going</h5>
                                                                                                            <h2><a href="detail-fullwidth.html">Explore Your Life, <span class="theme1"> Travel Where
                                                                                                                        You Want!</span></a></h2>
                                                                                                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt
                                                                                                                ut labore et dolore magna aliqua.</p>
                                                                                                        </div>
                                                                                                        <div class="video-button text-center position-relative">
                                                                                                            <div class="call-button text-center">
                                                                                                                <button type="button" class="play-btn js-video-button" data-video-id="152879427"
                                                                                                                        data-channel="vimeo">
                                                                                                                    <i class="fa fa-play bg-blue"></i>
                                                                                                                </button>
                                                                                                            </div>
                                                                                                            <div class="video-figure"></div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="white-overlay"></div>
                                                                                    </section>
                                                                                    <!-- Discount action Ends -->

                                                                                    <!-- offer Packages Starts -->
                                                                                    <section class="trending pb-0 pt-4">
                                                                                        <div class="container">
                                                                                            <div class="section-title mb-6 w-75 mx-auto text-center">
                                                                                                <h4 class="mb-1 theme1">Top Offers</h4>
                                                                                                <h2 class="mb-1">Special <span class="theme">Offers & Discount </span> Packages</h2>
                                                                                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.
                                                                                                </p>
                                                                                            </div>
                                                                                            <div class="trend-box">
                                                                                                <div class="row">
                                                                                                    <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
                                                                                                        <div class="trend-item rounded box-shadow bg-white">
                                                                                                            <div class="trend-image position-relative">
                                                                                                                <img src="images/trending/trending3.jpg" alt="image" class="">
                                                                                                                    <div class="ribbon ribbon-top-left"><span class="fw-bold">20% OFF</span></div>
                                                                                                                    <div class="color-overlay"></div>
                                                                                                            </div>
                                                                                                            <div class="trend-content p-4 pt-5 position-relative">
                                                                                                                <div class="trend-meta bg-theme white px-3 py-2 rounded">
                                                                                                                    <div class="entry-author">
                                                                                                                        <i class="icon-calendar"></i>
                                                                                                                        <span class="fw-bold"> 9 Days Tours</span>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                                <h5 class="theme mb-1"><i class="flaticon-location-pin"></i> Croatia</h5>
                                                                                                                <h3 class="mb-1"><a href="tour-grid.html">Piazza Castello</a></h3>
                                                                                                                <div class="rating-main d-flex align-items-center pb-2">
                                                                                                                    <div class="rating">
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                    </div>
                                                                                                                    <span class="ms-2">(12)</span>
                                                                                                                </div>
                                                                                                                <p class=" border-b pb-2 mb-2">Duis aute irure dolor in reprehenderit in voluptate velit
                                                                                                                    esse cillum</p>
                                                                                                                <div class="entry-meta">
                                                                                                                    <div class="entry-author d-flex align-items-center">
                                                                                                                        <p class="mb-0"><span class="theme fw-bold fs-5"> $170.00</span> | Per person
                                                                                                                        </p>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                    <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
                                                                                                        <div class="trend-item box-shadow rounded bg-white">
                                                                                                            <div class="trend-image position-relative">
                                                                                                                <img src="images/trending/trending1.jpg" alt="image">
                                                                                                                    <div class="ribbon ribbon-top-left"><span class="fw-bold">30% OFF</span></div>
                                                                                                                    <div class="color-overlay"></div>
                                                                                                            </div>
                                                                                                            <div class="trend-content p-4 pt-5 position-relative">
                                                                                                                <div class="trend-meta bg-theme white px-3 py-2 rounded">
                                                                                                                    <div class="entry-author">
                                                                                                                        <i class="icon-calendar"></i>
                                                                                                                        <span class="fw-bold"> 9 Days Tours</span>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                                <h5 class="theme mb-1"><i class="flaticon-location-pin"></i> Greece</h5>
                                                                                                                <h3 class="mb-1"><a href="tour-grid.html">Santorini, Oia</a></h3>
                                                                                                                <div class="rating-main d-flex align-items-center pb-2">
                                                                                                                    <div class="rating">
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                    </div>
                                                                                                                    <span class="ms-2">(38)</span>
                                                                                                                </div>
                                                                                                                <p class=" border-b pb-2 mb-2">Duis aute irure dolor in reprehenderit in voluptate velit
                                                                                                                    esse cillum</p>
                                                                                                                <div class="entry-meta">
                                                                                                                    <div class="entry-author d-flex align-items-center">
                                                                                                                        <p class="mb-0"><span class="theme fw-bold fs-5"> $180.00</span> | Per person
                                                                                                                        </p>
                                                                                                                    </div>
                                                                                                                </div>

                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                    <div class="col-lg-4 mb-4">
                                                                                                        <div class="trend-item box-shadow rounded bg-white">
                                                                                                            <div class="trend-image position-relative">
                                                                                                                <img src="images/trending/trending2.jpg" alt="image">
                                                                                                                    <div class="ribbon ribbon-top-left"><span class="fw-bold">15% OFF</span></div>
                                                                                                                    <div class="color-overlay"></div>
                                                                                                            </div>
                                                                                                            <div class="trend-content p-4 pt-5 position-relative">
                                                                                                                <div class="trend-meta bg-theme white px-3 py-2 rounded">
                                                                                                                    <div class="entry-author">
                                                                                                                        <i class="icon-calendar"></i>
                                                                                                                        <span class="fw-bold"> 9 Days Tours</span>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                                <h5 class="theme mb-1"><i class="flaticon-location-pin"></i> Maldives</h5>
                                                                                                                <h3 class="mb-1"><a href="tour-grid.html">Hurawalhi Island</a></h3>
                                                                                                                <div class="rating-main d-flex align-items-center pb-2">
                                                                                                                    <div class="rating">
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                        <span class="fa fa-star checked"></span>
                                                                                                                    </div>
                                                                                                                    <span class="ms-2">(18)</span>
                                                                                                                </div>
                                                                                                                <p class=" border-b pb-2 mb-2">Duis aute irure dolor in reprehenderit in voluptate velit
                                                                                                                    esse cillum</p>
                                                                                                                <div class="entry-meta">
                                                                                                                    <div class="entry-author d-flex align-items-center">
                                                                                                                        <p class="mb-0"><span class="theme fw-bold fs-5"> $260.00</span> | Per person
                                                                                                                        </p>
                                                                                                                    </div>
                                                                                                                </div>

                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </section>
                                                                                    <!-- offer Packages Ends -->

                                                                                    <!-- our teams starts -->
                                                                                    <section class="our-team pb-6">
                                                                                        <div class="container">

                                                                                            <div class="section-title mb-6 w-75 mx-auto text-center">
                                                                                                <h4 class="mb-1 theme1">Tour Guides</h4>
                                                                                                <h2 class="mb-1">Meet Our <span class="theme">Excellent Guides</span></h2>
                                                                                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.
                                                                                                </p>
                                                                                            </div>
                                                                                            <div class="team-main">
                                                                                                <div class="row shop-slider">
                                                                                                    <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                                                                                                        <div class="team-list rounded">
                                                                                                            <div class="team-image">
                                                                                                                <img src="images/team/img1.jpg" alt="team">
                                                                                                            </div>
                                                                                                            <div class="team-content text-center p-3 bg-theme">
                                                                                                                <h4 class="mb-0 white">Salmon Thuir</h4>
                                                                                                                <p class="mb-0 white">Senior Agent</p>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>

                                                                                                    <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                                                                                                        <div class="team-list rounded">
                                                                                                            <div class="team-image">
                                                                                                                <img src="images/team/img2.jpg" alt="team">
                                                                                                            </div>
                                                                                                            <div class="team-content text-center p-3 bg-theme">
                                                                                                                <h4 class="mb-0 white">Horke Pels</h4>
                                                                                                                <p class="mb-0 white">Head Officer</p>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>

                                                                                                    <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                                                                                                        <div class="team-list rounded">
                                                                                                            <div class="team-image">
                                                                                                                <img src="images/team/img4.jpg" alt="team">
                                                                                                            </div>
                                                                                                            <div class="team-content text-center p-3 bg-theme">
                                                                                                                <h4 class="mb-0 white">Solden kalos</h4>
                                                                                                                <p class="mb-0 white">Supervisor</p>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>

                                                                                                    <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                                                                                                        <div class="team-list rounded">
                                                                                                            <div class="team-image">
                                                                                                                <img src="images/team/img3.jpg" alt="team">
                                                                                                            </div>
                                                                                                            <div class="team-content text-center p-3 bg-theme">
                                                                                                                <h4 class="mb-0 white">Nelson Bam</h4>
                                                                                                                <p class="mb-0 white">Quality Assurance</p>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>

                                                                                                    <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                                                                                                        <div class="team-list rounded">
                                                                                                            <div class="team-image">
                                                                                                                <img src="images/team/img4.jpg" alt="team">
                                                                                                            </div>
                                                                                                            <div class="team-content text-center bg-theme p-3">
                                                                                                                <h4 class="mb-0 white">Cacics Coold</h4>
                                                                                                                <p class="mb-0 white">Asst. Manager</p>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </section>
                                                                                    <!-- our teams Ends -->

                                                                                    <!-- testomonial start -->
                                                                                    <section class="testimonial pt-9" style="background-image:url(images/testimonial.png)">
                                                                                        <div class="container">
                                                                                            <div class="section-title mb-6 text-center w-75 mx-auto">
                                                                                                <h4 class="mb-1 theme1">Our Testimonails</h4>
                                                                                                <h2 class="mb-1">Good Reviews By <span class="theme">Clients</span></h2>
                                                                                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.
                                                                                                </p>
                                                                                            </div>
                                                                                            <div class="row align-items-center">
                                                                                                <div class="col-lg-5 pe-4">
                                                                                                    <div class="testimonial-image">
                                                                                                        <img src="images/travel2.png" alt="">
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="col-lg-7 ps-4">
                                                                                                    <div class="row review-slider">
                                                                                                        <div class="col-sm-4 item">
                                                                                                            <div class="testimonial-item1 rounded">
                                                                                                                <div class="author-info d-flex align-items-center mb-4">
                                                                                                                    <img src="images/testimonial/img1.jpg" alt="">
                                                                                                                        <div class="author-title ms-3">
                                                                                                                            <h5 class="m-0 theme">Jared Erondu</h5>
                                                                                                                            <span>Supervisor</span>
                                                                                                                        </div>
                                                                                                                </div>
                                                                                                                <div class="details">
                                                                                                                    <p class="m-0"><i class="fa fa-quote-left me-2 fs-1"></i>Lorem Ipsum is simply dummy
                                                                                                                        text of the printing andypesetting industry. Lorem ipsum a simple Lorem Ipsum
                                                                                                                        has been the industry's standard dummy hic et quidem. Dignissimos maxime velit
                                                                                                                        unde inventore quasi vero dolorem.</p>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                        <div class="col-sm-4 item">
                                                                                                            <div class="testimonial-item1 rounded">
                                                                                                                <div class="author-info d-flex align-items-center mb-4">
                                                                                                                    <img src="images/testimonial/img1.jpg" alt="">
                                                                                                                        <div class="author-title ms-3">
                                                                                                                            <h5 class="m-0 theme">Jared Erondu</h5>
                                                                                                                            <span>Supervisor</span>
                                                                                                                        </div>
                                                                                                                </div>
                                                                                                                <div class="details">
                                                                                                                    <p class="m-0"><i class="fa fa-quote-left me-2 fs-1"></i>Lorem Ipsum is simply dummy
                                                                                                                        text of the printing andypesetting industry. Lorem ipsum a simple Lorem Ipsum
                                                                                                                        has been the industry's standard dummy hic et quidem. Dignissimos maxime velit
                                                                                                                        unde inventore quasi vero dolorem.</p>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </section>
                                                                                    <!-- testimonial ends -->

                                                                                    <!-- partner starts -->
                                                                                    <div class="our-partner p-0">
                                                                                        <div class="container">
                                                                                            <div class="partners_inner">
                                                                                                <ul>
                                                                                                    <li><img src="images/cl-5.png" alt=""></li>
                                                                                                    <li><img src="images/cl-2.png" alt=""></li>
                                                                                                    <li><img src="images/cl-3.png" alt=""></li>
                                                                                                    <li><img src="images/cl-4.png" alt=""></li>
                                                                                                    <li><img src="images/cl-5.png" alt=""></li>
                                                                                                    <li><img src="images/cl-3.png" alt=""></li>
                                                                                                    <li><img src="images/cl-2.png" alt=""></li>
                                                                                                    <li><img src="images/cl-1.png" alt=""></li>
                                                                                                </ul>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <!-- partner ends -->

                                                                                    <!-- recent-articles starts -->
                                                                                    <section class="trending recent-articles pb-6">
                                                                                        <div class="container">
                                                                                            <div class="section-title mb-6 w-75 mx-auto text-center">
                                                                                                <h4 class="mb-1 theme1">Our Blogs Offers</h4>
                                                                                                <h2 class="mb-1">Recent <span class="theme">Articles & Posts</span></h2>
                                                                                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.
                                                                                                </p>
                                                                                            </div>
                                                                                            <div class="recent-articles-inner">
                                                                                                <div class="row">
                                                                                                    <div class="col-lg-4">
                                                                                                        <div class="trend-item box-shadow bg-white mb-4 rounded overflow-hidden">
                                                                                                            <div class="trend-image">
                                                                                                                <img src="images/trending/trending10.jpg" alt="image">
                                                                                                            </div>
                                                                                                            <div class="trend-content-main p-4 pb-2">
                                                                                                                <div class="trend-content">
                                                                                                                    <h5 class="theme mb-1">Technology</h5>
                                                                                                                    <h4><a href="detail-1.html">How a developer duo at Deutsche Bank keep remote
                                                                                                                            alive.</a></h4>
                                                                                                                    <p class="mb-3">
                                                                                                                        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
                                                                                                                    </p>
                                                                                                                    <div class="entry-meta d-flex align-items-center justify-content-between">
                                                                                                                        <div class="entry-author mb-2">
                                                                                                                            <img src="images/reviewer/2.jpg" alt="" class="rounded-circle me-1">
                                                                                                                                <span>Sollmond Nell</span>
                                                                                                                        </div>
                                                                                                                        <div class="entry-button d-flex align-items-centermb-2">
                                                                                                                            <a href="#" class="nir-btn">Read More</a>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>

                                                                                                    <div class="col-lg-4 col-md-6">
                                                                                                        <div class="trend-item box-shadow bg-white mb-4 rounded overflow-hidden">
                                                                                                            <div class="trend-image">
                                                                                                                <img src="images/trending/trending12.jpg" alt="image">
                                                                                                            </div>
                                                                                                            <div class="trend-content-main p-4 pb-2">
                                                                                                                <div class="trend-content">
                                                                                                                    <h5 class="theme mb-1">Inspiration</h5>
                                                                                                                    <h4><a href="detail-1.html">Inspire Runner with Autism Graces of Women's Running</a>
                                                                                                                    </h4>
                                                                                                                    <p class="mb-3">
                                                                                                                        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
                                                                                                                    </p>
                                                                                                                    <div class="entry-meta d-flex align-items-center justify-content-between">
                                                                                                                        <div class="entry-author mb-2">
                                                                                                                            <img src="images/reviewer/1.jpg" alt="" class="rounded-circle me-1">
                                                                                                                                <span>David Scott</span>
                                                                                                                        </div>
                                                                                                                        <div class="entry-button d-flex align-items-center mb-2">
                                                                                                                            <a href="#" class="nir-btn">Read More</a>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>

                                                                                                    <div class="col-lg-4 col-md-6">
                                                                                                        <div class="trend-item box-shadow bg-white mb-4 rounded overflow-hidden">
                                                                                                            <div class="trend-image">
                                                                                                                <img src="images/trending/trending13.jpg" alt="image">
                                                                                                            </div>
                                                                                                            <div class="trend-content-main p-4 pb-2">
                                                                                                                <div class="trend-content">
                                                                                                                    <h5 class="theme mb-1">Public</h5>
                                                                                                                    <h4><a href="detail-1.html">Services To Grow Your Business Sell Affiliate
                                                                                                                            Products</a></h4>
                                                                                                                    <p class="mb-3">
                                                                                                                        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
                                                                                                                    </p>
                                                                                                                    <div class="entry-meta d-flex align-items-center justify-content-between">
                                                                                                                        <div class="entry-author mb-2">
                                                                                                                            <img src="images/reviewer/3.jpg" alt="" class="rounded-circle me-1">
                                                                                                                                <span>John Bolden</span>
                                                                                                                        </div>
                                                                                                                        <div class="entry-button d-flex align-items-center mb-2">
                                                                                                                            <a href="#" class="nir-btn">Read More</a>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </section>
                                                                                    <!-- recent-articles ends -->

                                                                                    <!-- footer starts -->
                                                                                    <footer class="pt-20 pb-4" style="background-image: url(images/background_pattern.png);">
                                                                                        <div class="section-shape top-0" style="background-image: url(images/shape8.png);"></div>
                                                                                        <!-- Instagram starts -->
                                                                                        <div class="insta-main pb-10">
                                                                                            <div class="container">
                                                                                                <div class="insta-inner">
                                                                                                    <div class="follow-button">
                                                                                                        <h5 class="m-0 rounded"><i class="fab fa-instagram"></i> Follow on Instagram</h5>
                                                                                                    </div>
                                                                                                    <div class="row attract-slider">
                                                                                                        <div class="col-md-3 col-sm-6">
                                                                                                            <div class="insta-image rounded">
                                                                                                                <a href="gallery.html"><img src="images/insta/ins-3.jpg" alt="insta"></a>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                        <div class="col-md-3 col-sm-6">
                                                                                                            <div class="insta-image rounded">
                                                                                                                <a href="gallery.html"><img src="images/insta/ins-4.jpg" alt="insta"></a>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                        <div class="col-md-3 col-sm-6">
                                                                                                            <div class="insta-image rounded">
                                                                                                                <a href="gallery.html"><img src="images/insta/ins-5.jpg" alt="insta"></a>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                        <div class="col-md-3 col-sm-6">
                                                                                                            <div class="insta-image rounded">
                                                                                                                <a href="gallery.html"><img src="images/insta/ins-1.jpg" alt="insta"></a>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                        <div class="col-md-3 col-sm-6">
                                                                                                            <div class="insta-image rounded">
                                                                                                                <a href="gallery.html"><img src="images/insta/ins-7.jpg" alt="insta"></a>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                        <div class="col-md-3 col-sm-6">
                                                                                                            <div class="insta-image rounded">
                                                                                                                <a href="gallery.html"><img src="images/insta/ins-8.jpg" alt="insta"></a>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                        <div class="col-md-3 col-sm-6">
                                                                                                            <div class="insta-image rounded">
                                                                                                                <a href="gallery.html"><img src="images/insta/ins-2.jpg" alt="insta"></a>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                        <div class="col-md-3 col-sm-6">
                                                                                                            <div class="insta-image rounded">
                                                                                                                <a href="gallery.html"><img src="images/insta/ins-6.jpg" alt="insta"></a>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                        <div class="col-md-3 col-sm-6">
                                                                                                            <div class="insta-image rounded">
                                                                                                                <a href="gallery.html"><img src="images/insta/ins-9.jpg" alt="insta"></a>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                        <!-- Instagram ends -->
                                                                                        <div class="footer-upper pb-4">
                                                                                            <div class="container">
                                                                                                <div class="row">
                                                                                                    <div class="col-lg-4 col-md-6 col-sm-12 mb-4 pe-4">
                                                                                                        <div class="footer-about">
                                                                                                            <img src="images/logo-white.png" alt="">
                                                                                                                <p class="mt-3 mb-3 white">
                                                                                                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Odio suspendisse leo neque
                                                                                                                    iaculis molestie sagittis maecenas aenean eget molestie sagittis.
                                                                                                                </p>
                                                                                                                <ul>
                                                                                                                    <li class="white"><strong>PO Box:</strong> +47-252-254-2542</li>
                                                                                                                    <li class="white"><strong>Location:</strong> Collins Street, sydney, Australia</li>
                                                                                                                    <li class="white"><strong>Email:</strong> info@Travelin.com</li>
                                                                                                                    <li class="white"><strong>Website:</strong> www.Travelin.com</li>
                                                                                                                </ul>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                    <div class="col-lg-2 col-md-6 col-sm-12 mb-4">
                                                                                                        <div class="footer-links">
                                                                                                            <h3 class="white">Quick link</h3>
                                                                                                            <ul>
                                                                                                                <li><a href="about-us.html">About Us</a></li>
                                                                                                                <li><a href="about-us.html">Delivery Information</a></li>
                                                                                                                <li><a href="about-us.html">Privacy Policy</a></li>
                                                                                                                <li><a href="about-us.html">Terms &amp; Conditions</a></li>
                                                                                                                <li><a href="about-us.html">Customer Service</a></li>
                                                                                                                <li><a href="#about-us.html">Return Policy</a></li>
                                                                                                            </ul>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                    <div class="col-lg-2 col-md-6 col-sm-12 mb-4">
                                                                                                        <div class="footer-links">
                                                                                                            <h3 class="white">Categories</h3>
                                                                                                            <ul>
                                                                                                                <li><a href="about-us.html">Travel</a></li>
                                                                                                                <li><a href="about-us.html">Technology</a></li>
                                                                                                                <li><a href="about-us.html">Lifestyle</a></li>
                                                                                                                <li><a href="about-us.html">Destinations</a></li>
                                                                                                                <li><a href="about-us.html">Entertainment</a></li>
                                                                                                                <li><a href="about-us.html">Business</a></li>
                                                                                                            </ul>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                    <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
                                                                                                        <div class="footer-links">
                                                                                                            <h3 class="white">Newsletter</h3>
                                                                                                            <div class="newsletter-form ">
                                                                                                                <p class="mb-3">Jin our community of over 200,000 global readers who receives emails
                                                                                                                    filled with news, promotions, and other good stuff.</p>
                                                                                                                <form action="#" method="get" accept-charset="utf-8"
                                                                                                                      class="border-0 d-flex align-items-center">
                                                                                                                    <input type="text" placeholder="Email Address">
                                                                                                                        <button class="nir-btn ms-2">Subscribe</button>
                                                                                                                </form>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>

                                                                                        <div class="footer-payment">
                                                                                            <div class="container">
                                                                                                <div class="row footer-pay align-items-center justify-content-between text-lg-start text-center">
                                                                                                    <div class="col-lg-8 footer-payment-nav mb-4">
                                                                                                        <ul class="">
                                                                                                            <li class="me-2">We Support:</li>
                                                                                                            <li class="me-2"><i class="fab fa-cc-mastercard fs-4"></i></li>
                                                                                                            <li class="me-2"><i class="fab fa-cc-paypal fs-4"></i></li>
                                                                                                            <li class="me-2"><i class="fab fa-cc-stripe fs-4"></i></li>
                                                                                                            <li class="me-2"><i class="fab fa-cc-visa fs-4"></i></li>
                                                                                                            <li class="me-2"><i class="fab fa-cc-discover fs-4"></i></li>
                                                                                                        </ul>
                                                                                                    </div>
                                                                                                    <div class="col-lg-4 footer-payment-nav mb-4">
                                                                                                        <ul class="d-flex align-items-center">
                                                                                                            <li class="me-2 w-75">
                                                                                                                <select class="niceSelect rounded">
                                                                                                                    <option>English</option>
                                                                                                                    <option>Chinese</option>
                                                                                                                    <option>Russian</option>
                                                                                                                    <option>Japanese</option>
                                                                                                                    <option>Korean</option>
                                                                                                                </select>
                                                                                                            </li>
                                                                                                            <li class="w-25">
                                                                                                                <select class="niceSelect rounded">
                                                                                                                    <option>$ USD</option>
                                                                                                                    <option>$ AUD</option>
                                                                                                                    <option>$ YEN</option>
                                                                                                                    <option>$ IN</option>
                                                                                                                    <option>$ NP</option>
                                                                                                                </select>
                                                                                                            </li>
                                                                                                        </ul>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>

                                                                                        <div class="footer-copyright">
                                                                                            <div class="container">
                                                                                                <div class="copyright-inner rounded p-3 d-md-flex align-items-center justify-content-between">
                                                                                                    <div class="copyright-text">
                                                                                                        <p class="m-0 white">2022 Travelin. All rights reserved.</p>
                                                                                                    </div>
                                                                                                    <div class="social-links">
                                                                                                        <ul>
                                                                                                            <li><a href="#"><i class="fab fa-facebook" aria-hidden="true"></i></a></li>
                                                                                                            <li><a href="#"><i class="fab fa-twitter" aria-hidden="true"></i></a></li>
                                                                                                            <li><a href="#"><i class="fab fa-instagram" aria-hidden="true"></i></a></li>
                                                                                                            <li><a href="#"><i class="fab fa-linkedin" aria-hidden="true"></i></a></li>
                                                                                                        </ul>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div id="particles-js"></div>
                                                                                    </footer>
                                                                                    <!-- footer ends -->

                                                                                    <!-- Back to top start -->
                                                                                    <div id="back-to-top">
                                                                                        <a href="#"></a>
                                                                                    </div>
                                                                                    <!-- Back to top ends -->

                                                                                    <!-- search popup -->
                                                                                    <div id="search1">
                                                                                        <button type="button" class="close">×</button>
                                                                                        <form>
                                                                                            <input type="search" value="" placeholder="type keyword(s) here" />
                                                                                            <button type="submit" class="btn btn-primary">Search</button>
                                                                                        </form>
                                                                                    </div>

                                                                                    <!-- login registration modal -->
                                                                                    <div class="modal-wrapper-top">

                                                                                        <div class="modal fade log-reg" id="exampleModal" tabindex="-1" aria-hidden="true">
                                                                                            <div class="modal-dialog">
                                                                                                <div class="modal-content">
                                                                                                    <div class="modal-body">
                                                                                                        <div class="post-tabs">
                                                                                                            <!-- tab navs -->
                                                                                                            <ul class="nav nav-tabs nav-pills nav-fill" id="postsTab" role="tablist">
                                                                                                                <li class="nav-item" role="presentation">
                                                                                                                    <button aria-controls="login" aria-selected="false" class="nav-link active"
                                                                                                                            data-bs-target="#login" data-bs-toggle="tab" id="login-tab" role="tab"
                                                                                                                            type="button">Login</button>
                                                                                                                </li>
                                                                                                                <li class="nav-item" role="presentation">
                                                                                                                    <button aria-controls="register" aria-selected="true" class="nav-link"
                                                                                                                            data-bs-target="#register" data-bs-toggle="tab" id="register-tab" role="tab"
                                                                                                                            type="button">Đăng Kí</button>
                                                                                                                </li>
                                                                                                            </ul>
                                                                                                            <!-- tab contents -->
                                                                                                            <div class="tab-content blog-full" id="postsTabContent">
                                                                                                                <!-- popular posts -->
                                                                                                                <div aria-labelledby="login-tab" class="tab-pane fade active show" id="login"
                                                                                                                     role="tabpanel">
                                                                                                                    <div class="row">
                                                                                                                        <div class="col-lg-6">
                                                                                                                            <div class="blog-image rounded">
                                                                                                                                <a href="#"
                                                                                                                                   style="background-image: url(images/trending/trending5.jpg);"></a>
                                                                                                                            </div>
                                                                                                                        </div>
                                                                                                                        <div class="col-lg-6">
                                                                                                                            <h4 class="text-center border-b pb-2">Login</h4>
                                                                                                                            <div class="log-reg-button d-flex align-items-center justify-content-between">
                                                                                                                                <button type="submit" class="btn btn-fb">
                                                                                                                                    <i class="fab fa-facebook"></i> Login with Facebook
                                                                                                                                </button>
                                                                                                                                <button type="submit" class="btn btn-google">
                                                                                                                                    <i class="fab fa-google"></i> Login with Google
                                                                                                                                </button>
                                                                                                                            </div>
                                                                                                                            <hr class="log-reg-hr position-relative my-4 overflow-visible">
                                                                                                                                <form method="post" action="#" name="contactform" id="contactform">
                                                                                                                                    <div class="form-group mb-2">
                                                                                                                                        <input type="text" name="user_name" class="form-control" id="fname"
                                                                                                                                               placeholder="User Name or Email Address">
                                                                                                                                    </div>
                                                                                                                                    <div class="form-group mb-2">
                                                                                                                                        <input type="password" name="password_name" class="form-control"
                                                                                                                                               id="lpass" placeholder="Password">
                                                                                                                                    </div>
                                                                                                                                    <div class="form-group mb-2">
                                                                                                                                        <input type="checkbox" class="custom-control-input" id="exampleCheck">
                                                                                                                                            <label class="custom-control-label mb-0" for="exampleCheck1">Remember
                                                                                                                                                me</label>
                                                                                                                                            <a class="float-end" href="#">Lost your password?</a>
                                                                                                                                    </div>
                                                                                                                                    <div class="comment-btn mb-2 pb-2 text-center border-b">
                                                                                                                                        <input type="submit" class="nir-btn w-100" id="submit" value="Login">
                                                                                                                                    </div>
                                                                                                                                    <p class="text-center">Don't have an account? <a href="#"
                                                                                                                                                                                     class="theme">Register</a></p>
                                                                                                                                </form>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                                <!-- Recent posts -->
                                                                                                                <div aria-labelledby="register-tab" class="tab-pane fade" id="register" role="tabpanel">
                                                                                                                    <div class="row">
                                                                                                                        <div class="col-lg-6">
                                                                                                                            <div class="blog-image rounded">
                                                                                                                                <a href="#"
                                                                                                                                   style="background-image: url(images/trending/trending5.jpg);"></a>
                                                                                                                            </div>
                                                                                                                        </div>
                                                                                                                        <div class="col-lg-6">
                                                                                                                            <!-- comment <h4 class="text-center border-b pb-2">Đăng kí tài khoản</h4>-->
                                                                                                                            <!-- comment <div class="log-reg-button d-flex align-items-center justify-content-between">
                                                                                                                                <button type="submit" class="btn btn-fb">
                                                                                                                                    <i class="fab fa-facebook"></i> Login with Facebook
                                                                                                                                </button>
                                                                                                                                <button type="submit" class="btn btn-google">
                                                                                                                                    <i class="fab fa-google"></i> Login with Google
                                                                                                                                </button>
                                                                                                                            </div>
                                                                                                                            <hr class="log-reg-hr position-relative my-4 overflow-visible">-->
                                                                                                                            <form action="${pageContext.request.contextPath}/dang-ki" method="POST" id="dkiform" onsubmit="event.preventDefault(); validateAndSubmit();">
                                                                                                                                <div class="form-group mb-2 d-flex">
                                                                                                                                    <input type="text" name="lastname" id="lastname" class="form-control me-1" placeholder="Họ" style="width: 50%;">
                                                                                                                                        <input type="text" name="firstname" id="firstname" class="form-control ms-1" placeholder="Tên" style="width: 50%;">
                                                                                                                                            </div>

                                                                                                                                            <div class="form-group mb-2">
                                                                                                                                                <input type="text" name="username" id="username" class="form-control" placeholder="Tên đăng nhập">
                                                                                                                                            </div>

                                                                                                                                            <div class="form-group mb-2">
                                                                                                                                                <input type="password" name="password" id="password" class="form-control" placeholder="Mật khẩu">
                                                                                                                                            </div>

                                                                                                                                            <div class="form-group mb-2">
                                                                                                                                                <input type="password" name="password_confirm" id="password_confirm" class="form-control" placeholder="Nhập lại mật khẩu">
                                                                                                                                            </div>

                                                                                                                                            <div class="form-group mb-2">
                                                                                                                                                <input type="email" name="email" id="email" class="form-control" placeholder="Email">
                                                                                                                                            </div>

                                                                                                                                            <div class="form-group mb-2">
                                                                                                                                                <input type="text" name="phone" id="phone" class="form-control" placeholder="Số điện thoại">
                                                                                                                                            </div>

                                                                                                                                            <div class="form-group mb-2">
                                                                                                                                                <input type="date" name="dob" id="dob" class="form-control">
                                                                                                                                            </div>

                                                                                                                                            <div class="form-group mb-2">
                                                                                                                                                <select name="gender" id="gender" class="form-control">
                                                                                                                                                    <option value="">-- Chọn giới tính --</option>
                                                                                                                                                    <option value="Nam">Nam</option>
                                                                                                                                                    <option value="Nữ">Nữ</option>
                                                                                                                                                    <option value="Khác">Khác</option>
                                                                                                                                                </select>
                                                                                                                                            </div>

                                                                                                                                            <div class="form-group mb-2">
                                                                                                                                                <input type="text" name="address" id="address" class="form-control" placeholder="Địa chỉ">
                                                                                                                                            </div>

                                                                                                                                            <div class="form-check mb-3">
                                                                                                                                                <input class="form-check-input" type="checkbox" name="check" id="check">
                                                                                                                                                    <label class="form-check-label" for="check">Tôi đồng ý với điều khoản</label>
                                                                                                                                            </div>

                                                                                                                                            <div class="comment-btn mb-2 pb-2 text-center border-b">
                                                                                                                                                <input type="submit" class="nir-btn w-100" id="submit1" value="Đăng Kí">
                                                                                                                                            </div>

                                                                                                                                            <!-- ✅ Khu vực hiển thị thông báo phản hồi từ servlet -->
                                                                                                                                            <div id="message" class="text-center mb-2 text-danger"></div>

                                                                                                                                            <p class="text-center">Bạn đã có tài khoản? <a href="#" class="theme">Đăng nhập</a></p>

                                                                                                                                            </form>


                                                                                                                                            <div id="toast-container" style="position: fixed; top: 20px; right: 20px; z-index: 9999;"></div>



                                                                                                                                            <script src="js/validateRegister.js"></script>






                                                                                                                                            </div>
                                                                                                                                            </div>
                                                                                                                                            </div>
                                                                                                                                            </div>
                                                                                                                                            </div>
                                                                                                                                            </div>
                                                                                                                                            </div>
                                                                                                                                            </div>
                                                                                                                                            </div>
                                                                                                                                            </div>


                                                                                                                                            <!-- *Scripts* -->
                                                                                                                                            <script src="js/jquery-3.5.1.min.js"></script>
                                                                                                                                            <script src="js/bootstrap.min.js"></script>
                                                                                                                                            <script src="js/particles.js"></script>
                                                                                                                                            <script src="js/particlerun.js"></script>
                                                                                                                                            <script src="js/plugin.js"></script>
                                                                                                                                            <script src="js/main.js"></script>
                                                                                                                                            <script src="js/custom-swiper.js"></script>
                                                                                                                                            <script src="js/custom-nav.js"></script>

                                                                                                                                            </body>

                                                                                                                                            </html>
