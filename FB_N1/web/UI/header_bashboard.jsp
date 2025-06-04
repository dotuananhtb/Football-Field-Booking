<%-- 
    Document   : header_bashboard
    Created on : 31 thg 5, 2025, 15:41:09
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <!-- comment -->
    <base href="${pageContext.request.contextPath}/UI/">
    <!-- comment -->
</head>
                <header class="main-header flex">
                    <div id="header">

                        <div class="header-dashboard">
                            <div class="tf-container full">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="inner-container flex justify-space align-center">
                                              
                                            <div class="header-search flex-three">
                                                <div class="icon-bars">
                                                    <i class="icon-Vector3"></i>
                                                </div>
                                                <form action="/" class="search-dashboard">
                                                    <i class="icon-Vector5"></i>
                                                    <input type="search" placeholder="Search tours">
                                                </form>

                                            </div>
                                            <div class="nav-outer flex align-center">
                                                <nav class="main-menu show navbar-expand-md">
                                                    <div class="navbar-collapse collapse clearfix"
                                                        id="navbarSupportedContent">
                                                        <ul class="navigation clearfix">
                                                            <li class="dropdown">
                                                                <a href="/FB_N1/home">Trang chủ</a>
                                                                <ul>
                                                                    <li><a href="index.html">Home Page 01</a></li>
                                                                    <li><a href="home2.html">Home Page 02</a></li>
                                                                    <li><a href="home3.html">Home Page 03</a></li>
                                                                    <li><a href="home4.html">Home Page 04</a></li>
                                                                    <li><a href="home5.html">Home Page 05</a></li>
                                                                </ul>
                                                            </li>
                                                            
<!--                                                            <li class="dropdown"><a href="#">Destination</a>
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
                                                            </li>-->
<!--                                                            <li class="dropdown2 "><a href="#">Blog</a>
                                                                <ul>
                                                                    <li><a href="blog.html">Blog</a></li>
                                                                    <li><a href="blog-details.html">Blog Detail</a></li>
                                                                </ul>
                                                            </li>-->

<!--                                                            <li class="dropdown2"><a href="#">Pages</a>
                                                                <ul>
                                                                    <li><a href="about-us.html">About Us</a></li>
                                                                    <li><a href="team.html">Team member</a></li>
                                                                    <li><a href="gallery.html">Gallery</a></li>
                                                                    <li><a href="terms-condition.html">Terms &
                                                                            Condition</a></li>
                                                                    <li><a href="help-center.html">Help center</a></li>
                                                                </ul>
                                                            </li>-->
                                                            <li class="dropdown2 current"><a href="#">Bảng điều khiển</a>
                                                                <ul>
                                                                    <li><a href="dashboard.html">Bảng điều khiển</a></li>
                                                                    <li><a href="my-booking.html">Đặt lịch</a></li>
                                                                    
                                                                    <li><a href="my-favorite.html">Yêu thích</a></li>
                                                                    <li class="current"><a href="/FB_N1/userProfile">Hồ sơ</a></li>
                                                                </ul>
                                                            </li>
                                                            <li><a href="contact-us.html">liên hệ</a></li>
                                                        </ul>
                                                    </div>
                                                </nav>
                                                 <!--Main Menu End-->
                                            </div>
                                            <div class="header-account flex align-center">
                                                <div class="dropdown notification">
                                                    <a class="icon-notification" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                        <i class="icon-notification-1"></i>
                                                    </a>
                                                    <ul class="dropdown-menu">
                                                      <li>
                                                        <div class="message-item  flex-three">
                                                            <div class="image">
                                                                <i class="icon-26"></i>
                                                            </div>
                                                            <div>
                                                                <div class="body-title">Discount available</div>
                                                                <div class="text-tiny">Morbi sapien massa, ultricies at rhoncus at, ullamcorper nec diam</div>
                                                            </div>
                                                        </div>
                                                      </li>
                                                      <li>
                                                        <div class="message-item  flex-three">
                                                            <div class="image">
                                                                <i class="icon-26"></i>
                                                            </div>
                                                            <div>
                                                                <div class="body-title">Discount available</div>
                                                                <div class="text-tiny">Morbi sapien massa, ultricies at rhoncus at, ullamcorper nec diam</div>
                                                            </div>
                                                        </div>
                                                      </li>
                                                      <li>
                                                        <div class="message-item  flex-three">
                                                            <div class="image">
                                                                <i class="icon-26"></i>
                                                            </div>
                                                            <div>
                                                                <div class="body-title">Discount available</div>
                                                                <div class="text-tiny">Morbi sapien massa, ultricies at rhoncus at, ullamcorper nec diam</div>
                                                            </div>
                                                        </div>
                                                      </li>
                                                      
                                                    </ul>
                                                </div> 
                                                <div class="dropdown account">
                                                    <a type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                        <img src="./assets/images/page/avata.jpg" alt="image">
                                                    </a>
                                                    <ul class="dropdown-menu">
                                                      <li><a  href="#">Account</a></li>
                                                      <li><a  href="#">Setting</a></li>
                                                      <li><a  href="#">Support</a></li>
                                                      <li><a  href="login.html">Logout</a></li>
                                                    </ul>
                                                </div> 
                                                <div class="mobile-nav-toggler mobile-button">
                                                    <i class="icon-bar"></i>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="close-btn"><span class="icon flaticon-cancel-1"></span></div>
                    <div class="mobile-menu">
                        <div class="menu-backdrop"></div>
                        <nav class="menu-box">
                            <div class="nav-logo"><a href="index.html">
                                    <img src="assets/images/logo2.png" alt=""></a></div>
                            <div class="bottom-canvas">
                                <div class="menu-outer">
                                </div>
                            </div>
                        </nav>
                    </div>


                </header>
                 
