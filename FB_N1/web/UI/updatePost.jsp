<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
<head>
    <base href="${pageContext.request.contextPath}/UI/">
    <meta charset="utf-8">
    <title>Cập nhật bài viết</title>
    <meta name="author" content="themesflat.com">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="app/css/app.css">
    <link rel="stylesheet" href="app/css/map.min.css">
    <!-- Favicon and Touch Icons  -->
    <link rel="shortcut icon" href="assets/images/favico.png">
    <link rel="apple-touch-icon-precomposed" href="assets/images/favico.png">
</head>
<body class="body header-fixed ">
    <div class="preload preload-container">
        <svg class="pl" width="240" height="240" viewBox="0 0 240 240">
            <circle class="pl__ring pl__ring--a" cx="120" cy="120" r="105" fill="none" stroke="#000" stroke-width="20" stroke-dasharray="0 660" stroke-dashoffset="-330" stroke-linecap="round"></circle>
            <circle class="pl__ring pl__ring--b" cx="120" cy="120" r="35" fill="none" stroke="#000" stroke-width="20" stroke-dasharray="0 220" stroke-dashoffset="-110" stroke-linecap="round"></circle>
            <circle class="pl__ring pl__ring--c" cx="85" cy="120" r="70" fill="none" stroke="#000" stroke-width="20" stroke-dasharray="0 440" stroke-linecap="round"></circle>
            <circle class="pl__ring pl__ring--d" cx="155" cy="120" r="70" fill="none" stroke="#000" stroke-width="20" stroke-dasharray="0 440" stroke-linecap="round"></circle>
        </svg>
    </div>
    <div id="wrapper">
        <div id="pagee" class="clearfix">
            <div class="sidebar-dashboard">
                <div class="db-logo">
                    <a href="index.html"><img src="assets/images/favico.png" alt="Logo"><span>Vitour</span></a>
                </div>
                <div class="db-menu">
                    <ul>
                        <li><a href="dashboard.html"><i class="icon-Vector-9"></i><span>Dashboard</span></a></li>
                        <li><a href="my-booking.html"><i class="icon-Layer-2"></i><span>My Booking</span></a></li>
                        <li><a href="my-listing.html"><i class="icon-Group-81"></i><span>My Listing</span></a></li>
                        <li class="active"><a href="add-tour.html"><i class="icon-Group-91"></i><span>Add Tour</span></a></li>
                        <li><a href="my-favorite.html"><i class="icon-Vector-10"></i><span>My Favorites</span></a></li>
                        <li><a href="my-profile.html"><i class="icon-profile-user-1"></i><span>My Profile</span></a></li>
                        <li><a href="login.html"><i class="icon-turn-off-1"></i><span>Logout</span></a></li>
                    </ul>
                </div>
            </div>
            <div class="has-dashboard">
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
                                                    <div class="navbar-collapse collapse clearfix" id="navbarSupportedContent">
                                                        <ul class="navigation clearfix">
                                                            <li class="dropdown2"><a href="#">Home</a>
                                                                <ul>
                                                                    <li><a href="index.html">Home Page 01</a></li>
                                                                    <li><a href="home2.html">Home Page 02</a></li>
                                                                    <li><a href="home3.html">Home Page 03</a></li>
                                                                    <li><a href="home4.html">Home Page 04</a></li>
                                                                    <li><a href="home5.html">Home Page 05</a></li>
                                                                </ul>
                                                            </li>
                                                            <li class="dropdown2"><a href="#">Tour</a>
                                                                <ul>
                                                                    <li><a href="archieve-tour.html">Archieve tour</a></li>
                                                                    <li><a href="tour-package-v2.html">Tour left sidebar</a></li>
                                                                    <li><a href="tour-package-v4.html">Tour package </a></li>
                                                                    <li><a href="tour-single.html">Tour Single </a></li>
                                                                </ul>
                                                            </li>
                                                            <li class="dropdown2"><a href="#">Destination</a>
                                                                <ul>
                                                                    <li><a href="tour-destination-v1.html">Destination V1</a></li>
                                                                    <li><a href="tour-destination-v2.html">Destination V2</a></li>
                                                                    <li><a href="tour-destination-v3.html">Destination V3</a></li>
                                                                    <li><a href="single-destination.html">Destination Single</a></li>
                                                                </ul>
                                                            </li>
                                                            <li class="dropdown2 "><a href="#">Blog</a>
                                                                <ul>
                                                                    <li><a href="blog.html">Blog</a></li>
                                                                    <li><a href="blog-details.html">Blog Detail</a></li>
                                                                </ul>
                                                            </li>
                                                            <li class="dropdown2"><a href="#">Pages</a>
                                                                <ul>
                                                                    <li><a href="about-us.html">About Us</a></li>
                                                                    <li><a href="team.html">Team member</a></li>
                                                                    <li><a href="gallery.html">Gallery</a></li>
                                                                    <li><a href="terms-condition.html">Terms & Condition</a></li>
                                                                    <li><a href="help-center.html">Help center</a></li>
                                                                </ul>
                                                            </li>
                                                            <li class="dropdown2 current"><a href="#">Dashboard</a>
                                                                <ul>
                                                                    <li><a href="dashboard.html">Dashboard </a></li>
                                                                    <li><a href="my-booking.html">My booking</a></li>
                                                                    <li><a href="my-listing.html">My Listing</a></li>
                                                                    <li class="current"><a href="add-tour.html">Add Tour</a></li>
                                                                    <li><a href="my-favorite.html">My Favorites</a></li>
                                                                    <li><a href="my-profile.html">My profile</a></li>
                                                                </ul>
                                                            </li>
                                                            <li><a href="contact-us.html">Contact</a></li>
                                                        </ul>
                                                    </div>
                                                </nav>
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
                                </div>
                            </div>
                        </nav>
                    </div>
                    <!-- End Mobile Menu -->
                </header>
                <!-- End Main Header -->
                <main id="main">
                    <section class="profile-dashboard">
                        <div class="inner-header mb-40">
                            <h3 class="title">Cập nhật bài viết</h3>
                            <p class="des">Bạn có thể chỉnh sửa thông tin bài viết tại đây</p>
                        </div>
                        <form action="${pageContext.request.contextPath}/updatePost" method="post" class="form-add-tour">
                            <input type="hidden" name="postId" value="${post.postId}" />
                            <div class="widget-dash-board pr-256 mb-75">
                                <h4 class="title-add-tour mb-30">1. Thông tin bài viết</h4>
                                <div class="input-wrap mb-45">
                                    <label>Tiêu đề <span style="color:red">*</span></label>
                                    <input type="text" name="title" required placeholder="Nhập tiêu đề bài viết" value="${post.title}">
                                </div>
                                <div class="input-wrap mb-45">
                                    <label>Ghi chú/Nội dung thêm</label>
                                    <textarea name="userContent" rows="4" placeholder="Nhập ghi chú hoặc yêu cầu đặc biệt...">${post.contentPost}</textarea>
                                </div>
                                <div style="text-align:center;">
                                    <button type="submit" class="button-add">Cập nhật</button>
                                </div>
                            </div>
                        </form>
                    </section>
                </main>
                <footer class="footer footer-dashboard">
                    <div class="tf-container full">
                        <div class="row">
                            <div class="col-lg-6">
                                <p class="text-white">Made with ❤️ by Themesflat. - Powered by Theme</p>
                            </div>
                            <div class="col-lg-6">
                                <ul class="menu-footer flex-six">
                                    <li><a href="#">Privacy & Policy</a></li>
                                    <li><a href="#">Licensing</a></li>
                                    <li><a href="#">Instruction</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </footer>
                <!-- Bottom -->
            </div>
        </div>
        <!-- /#page -->
    </div>
    <!-- Modal Popup Bid -->
    <a id="scroll-top" class="button-go"></a>
    <!-- Modal search-->
    <div class="modal search-mobie fade" id="exampleModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                <div class="modal-body">
                    <form action="/" class="search-form-mobie">
                        <div class="search">
                            <i class="icon-circle2017"></i>
                            <input type="search" placeholder="Search Travel" class="search-input" autocomplete="off">
                            <button type="button">Search</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight">
        <div class="offcanvas-header">
            <h5 class="offcanvas-title" id="offcanvasRightLabel">Offcanvas right</h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>
        <div class="offcanvas-body">...</div>
    </div>
    <!-- Javascript -->
    <script src="app/js/jquery.min.js"></script>
    <script src="app/js/jquery.nice-select.min.js"></script>
    <script src="app/js/bootstrap.min.js"></script>
    <script src="app/js/tinymce/tinymce.min.js"></script>
    <script src="app/js/tinymce/tinymce-custom.js"></script>
    <script src="app/js/swiper-bundle.min.js"></script>
    <script src="app/js/swiper.js"></script>
    <script src="app/js/plugin.js"></script>
    <script src="app/js/map.min.js"></script>
    <script src="app/js/map.js"></script>
    <script src="app/js/shortcodes.js"></script>
    <script src="app/js/main.js"></script>
</body>
</html> 