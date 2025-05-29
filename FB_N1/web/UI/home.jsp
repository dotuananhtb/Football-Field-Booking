<%-- 
    Document   : home
    Created on : 26 thg 5, 2025, 23:20:54
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="vi">

    <head>

        <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
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
                </style>

                <title>BookField - Hệ Thống Đặt Sân Bóng Đá</title>
                <!-- Favicon -->
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

                                                <!-- Navigation Bar -->
                                                <div class="header_menu" id="header_menu">
                                                    <nav class="navbar navbar-default">
                                                        <div class="container">
                                                            <div class="navbar-flex d-flex align-items-center justify-content-between w-100 pb-3 pt-3">
                                                                <!-- Brand and toggle get grouped for better mobile display -->
                                                                <div class="navbar-header">
                                                                    <a class="navbar-brand" href="home.jsp">
                                                                        <img src="images/logo.png" alt="BookField Logo">
                                                                    </a>
                                                                </div>
                                                                <!-- Collect the nav links, forms, and other content for toggling -->
                                                                <div class="navbar-collapse1 d-flex align-items-center" id="bs-example-navbar-collapse-1">
                                                                    <ul class="nav navbar-nav" id="responsive-menu">
                                                                        <li class="dropdown submenu active">
                                                                            <a href="home.jsp" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Trang Chủ</a>
                                                                        </li>

                                                                        <li><a href="about.html">Giới Thiệu</a></li>


                                                                        <li class="submenu dropdown">
                                                                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Đặt Sân <i class="icon-arrow-down" aria-hidden="true"></i></a> 
                                                                            <ul class="dropdown-menu">
                                                                                <li class="submenu dropdown">
                                                                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Sân 5 Người<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                                                                    <ul class="dropdown-menu">
                                                                                        <li><a href="field-5-list.html">Sân 5 Quận 1</a></li>
                                                                                        <li><a href="field-5-list1.html">Sân 5 Quận 7</a></li>
                                                                                        <li><a href="field-5-list2.html">Sân 5 Tân Bình</a></li>
                                                                                    </ul>
                                                                                </li>
                                                                                <li class="submenu dropdown">
                                                                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Sân 7 Người<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                                                                    <ul class="dropdown-menu">
                                                                                        <li><a href="field-7-list.html">Sân 7 Quận 1</a></li>
                                                                                        <li><a href="field-7-list1.html">Sân 7 Quận 7</a></li>
                                                                                        <li><a href="field-7-list2.html">Sân 7 Tân Bình</a></li>
                                                                                    </ul>
                                                                                </li>
                                                                                <li class="submenu dropdown">
                                                                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Sân 11 Người<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                                                                    <ul class="dropdown-menu">
                                                                                        <li><a href="field-11-list.html">Sân 11 Quận 1</a></li>
                                                                                        <li><a href="field-11-list1.html">Sân 11 Quận 7</a></li>
                                                                                        <li><a href="field-11-list2.html">Sân 11 Tân Bình</a></li>
                                                                                    </ul>
                                                                                </li>
                                                                            </ul> 
                                                                        </li>
                                                                        <li class="submenu dropdown">
                                                                            <ul class="dropdown-menu">
                                                                                <li><a href="team.html">Huấn Luyện Viên</a></li>
                                                                                <li><a href="booking.html">Đặt Sân</a></li>
                                                                                <li><a href="confirmation.html">Xác Nhận</a></li>
                                                                                <li class="submenu dropdown">
                                                                                    <ul class="dropdown-menu">
                                                                                        <li><a href="services.html">Thuê Thiết Bị</a></li>
                                                                                        <li><a href="services-detail.html">Chi Tiết Dịch Vụ</a></li>
                                                                                    </ul>
                                                                                </li>
                                                                                <li class="submenu dropdown">
                                                                                    <a href="gallery.html" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Thư Viện<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                                                                    <ul class="dropdown-menu">
                                                                                        <li><a href="gallery.html">Hình Ảnh Sân</a></li>
                                                                                        <li><a href="gallery1.html">Video Sân</a></li>
                                                                                    </ul>
                                                                                </li>
                                                                                <li><a href="login.html">Đăng Nhập|Đăng Ký</a></li>
                                                                                <li><a href="contact.html">Liên Hệ</a></li>
                                                                                <li><a href="dashboard/dashboard.html">Quản Lý</a></li>
                                                                            </ul> 
                                                                        </li>
                                                                        <li class="submenu dropdown">
                                                                            <ul class="dropdown-menu">
                                                                                <li class="submenu dropdown">
                                                                                    <ul class="dropdown-menu">
                                                                                        <li><a href="post-grid-1.html">Tin Trong Nước</a></li>
                                                                                        <li><a href="post-grid-2.html">Tin Quốc Tế</a></li>
                                                                                        <li><a href="post-grid-3.html">Tin Địa Phương</a></li>
                                                                                    </ul>
                                                                                </li>
                                                                                <li class="submenu dropdown">
                                                                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Giải Đấu<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                                                                    <ul class="dropdown-menu">
                                                                                        <li><a href="post-list-1.html">Giải Nghiệp Dư</a></li>
                                                                                        <li><a href="post-list-2.html">Giải Chuyên Nghiệp</a></li>
                                                                                        <li><a href="post-list-3.html">Giải Thiếu Nhi</a></li>
                                                                                    </ul>
                                                                                </li>
                                                                            </ul>
                                                                        </li>
                                                                        <li class="search-main"><a href="#search1" class="mt_search"><i class="fa fa-search"></i></a></li>
                                                                    </ul>
                                                                </div><!-- /.navbar-collapse -->  
                                                                <div class="register-login d-flex align-items-center">
                                                                    <c:if test="${sessionScope.username != null}">
                                                                        <a href="${pageContext.request.contextPath}/logout"  class="me-3">
                                                                            <i class="icon-user"></i> Đăng Xuất

                                                                        </a>
                                                                    </c:if>
                                                                    <c:if test="${sessionScope.username == null}">
                                                                        <a href="#" data-bs-toggle="modal" data-bs-target="#exampleModal" class="me-3">
                                                                            <i class="icon-user"></i> Đăng Nhập/Đăng Ký
                                                                        </a>
                                                                    </c:if>
                                                                    <a href="#" class="nir-btn white">Đặt Sân Ngay</a>
                                                                    <c:if test="${sessionScope.username != null}">
                                                                        <c:set value="${sessionScope.userProfile}" var="u"></c:set>
                                                                        <a href="/FB_N1/UI/userProfile.jsp"  style="margin: 20px">
                                                                            <img src="${u.getAvatar()}" alt="User Profile" style="width: 30px; height: 30px; border-radius: 50%;">
                                                                        </a>

                                                                    </c:if>
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

                                                <!-- top Fields starts -->

                                                <!-- top Fields ends -->

                                                <!-- about-us starts -->
                                                <section class="about-us pt-0" style="background-image:url(images/bg/bg-trans.png);">
                                                    <div class="container">
                                                        <div class="about-image-box">

                                                        </div>
                                                    </div>
                                                    <div class="white-overlay"></div>
                                                </section>
                                                <!-- about-us ends -->

                                                <!-- Hot Deals Starts -->
                                                <section class="trending pb-0 pt-6" style="background-image: url(images/shape2.png);">
                                                    <div class="container">
                                                        <div class="section-title mb-6 w-75 mx-auto text-center">
                                                            <h4 class="mb-1 theme1">Ưu Đãi Hot</h4>
                                                            <h2 class="mb-1">Sân Bóng <span class="theme">Giá Rẻ</span></h2>
                                                            <p>Những sân bóng chất lượng cao với mức giá ưu đãi nhất. Đặt ngay để không bỏ lỡ cơ hội!
                                                            </p>
                                                        </div>
                                                        <div class="trend-box">
                                                            <div class="row">
                                                                <div class="col-lg-5 mb-4">
                                                                    <div class="trend-item1 rounded box-shadow mb-4">
                                                                        <div class="trend-image position-relative">
                                                                            <img src="images/trending/trendingb-2.jpg" alt="Sân bóng Quận 1" class="">
                                                                                <div class="trend-content1 p-4">
                                                                                    <h5 class="theme1 mb-1"><i class="flaticon-location-pin"></i> Quận 1</h5>
                                                                                    <h3 class="mb-1 white"><a href="field-grid.html" class="white">Sân Thể Thao Tân Định</a>
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
                                                                                            <p class="mb-0 white"><span class="theme1 fw-bold fs-5"> 180.000đ</span> |
                                                                                                Mỗi giờ</p>
                                                                                        </div>
                                                                                        <div class="entry-author">
                                                                                            <i class="icon-calendar white"></i>
                                                                                            <span class="fw-bold white"> Sân 5 người</span>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="overlay"></div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="trend-item1 rounded box-shadow mb-4">
                                                                        <div class="trend-image position-relative">
                                                                            <img src="images/trending/trending-large.jpg" alt="Sân bóng Quận 7" class="">
                                                                                <div class="trend-content1 p-4">
                                                                                    <h5 class="theme1 mb-1"><i class="flaticon-location-pin"></i> Quận 7</h5>
                                                                                    <h3 class="mb-1 white"><a href="field-grid.html" class="white">Sân Riverside</a>
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
                                                                                            <p class="mb-0 white"><span class="theme1 fw-bold fs-5"> 200.000đ</span> |
                                                                                                Mỗi giờ</p>
                                                                                        </div>
                                                                                        <div class="entry-author">
                                                                                            <i class="icon-calendar white"></i>
                                                                                            <span class="fw-bold white"> Sân 7 người</span>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="overlay"></div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="trend-item1 rounded box-shadow">
                                                                        <div class="trend-image position-relative">
                                                                            <img src="images/trending/trendingb-1.jpg" alt="Sân bóng Tân Bình" class="">
                                                                                <div class="trend-content1 p-4">
                                                                                    <h5 class="theme1 mb-1"><i class="flaticon-location-pin"></i> Tân Bình</h5>
                                                                                    <h3 class="mb-1 white"><a href="field-grid.html" class="white">Sân Green Park</a></h3>
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
                                                                                            <p class="mb-0 white"><span class="theme1 fw-bold fs-5"> 220.000đ</span> |
                                                                                                Mỗi giờ</p>
                                                                                        </div>
                                                                                        <div class="entry-author">
                                                                                            <i class="icon-calendar white"></i>
                                                                                            <span class="fw-bold white"> Sân 11 người</span>
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
                                                                                    <img src="images/trending/trending1.jpg" alt="Sân bóng Bình Thạnh" class="">
                                                                                        <div class="color-overlay"></div>
                                                                                </div>
                                                                                <div class="trend-content p-4 pt-5 position-relative bg-white">
                                                                                    <div class="trend-meta bg-theme white px-3 py-2 rounded">
                                                                                        <div class="entry-author">
                                                                                            <i class="icon-calendar"></i>
                                                                                            <span class="fw-bold"> Sân 5 người</span>
                                                                                        </div>
                                                                                    </div>
                                                                                    <h5 class="theme mb-1"><i class="flaticon-location-pin"></i> Bình Thạnh</h5>
                                                                                    <h3 class="mb-1"><a href="field-grid.html">Sân Landmark 81</a></h3>
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
                                                                                    <p class=" border-b pb-2 mb-2">Sân cỏ nhân tạo chất lượng cao, đèn chiếu sáng hiện đại</p>
                                                                                    <div class="entry-meta">
                                                                                        <div class="entry-author d-flex align-items-center">
                                                                                            <p class="mb-0"><span class="theme fw-bold fs-5"> 160.000đ</span> | Mỗi giờ</p>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-lg-6 col-md-6 mb-4">
                                                                            <div class="trend-item rounded box-shadow">
                                                                                <div class="trend-image position-relative">
                                                                                    <img src="images/trending/trending2.jpg" alt="Sân bóng Thủ Đức" class="">
                                                                                        <div class="color-overlay"></div>
                                                                                </div>
                                                                                <div class="trend-content p-4 pt-5 position-relative bg-white">
                                                                                    <div class="trend-meta bg-theme white px-3 py-2 rounded">
                                                                                        <div class="entry-author">
                                                                                            <i class="icon-calendar"></i>
                                                                                            <span class="fw-bold"> Sân 7 người</span>
                                                                                        </div>
                                                                                    </div>
                                                                                    <h5 class="theme mb-1"><i class="flaticon-location-pin"></i> Thủ Đức</h5>
                                                                                    <h3 class="mb-1"><a href="field-grid.html">Sân Mega Sport</a></h3>
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
                                                                                    <p class=" border-b pb-2 mb-2">Sân cỏ tự nhiên, phòng thay đồ rộng rãi, bãi đậu xe miễn phí</p>
                                                                                    <div class="entry-meta">
                                                                                        <div class="entry-author d-flex align-items-center">
                                                                                            <p class="mb-0"><span class="theme fw-bold fs-5"> 190.000đ</span> | Mỗi giờ</p>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-lg-6 col-md-6 mb-4">
                                                                            <div class="trend-item rounded box-shadow">
                                                                                <div class="trend-image position-relative">
                                                                                    <img src="images/trending/trending3.jpg" alt="Sân bóng Gò Vấp" class="">
                                                                                        <div class="color-overlay"></div>
                                                                                </div>
                                                                                <div class="trend-content p-4 pt-5 position-relative bg-white">
                                                                                    <div class="trend-meta bg-theme white px-3 py-2 rounded">
                                                                                        <div class="entry-author">
                                                                                            <i class="icon-calendar"></i>
                                                                                            <span class="fw-bold"> Sân 5 người</span>
                                                                                        </div>
                                                                                    </div>
                                                                                    <h5 class="theme mb-1"><i class="flaticon-location-pin"></i> Gò Vấp</h5>
                                                                                    <h3 class="mb-1"><a href="field-grid.html">Sân Thể Thao Gò Vấp</a></h3>
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
                                                                                    <p class=" border-b pb-2 mb-2">Sân cỏ nhân tạo mới, hệ thống âm thanh hiện đại</p>
                                                                                    <div class="entry-meta">
                                                                                        <div class="entry-author d-flex align-items-center">
                                                                                            <p class="mb-0"><span class="theme fw-bold fs-5"> 140.000đ</span> | Mỗi giờ</p>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-lg-6 col-md-6 mb-4">
                                                                            <div class="trend-item rounded box-shadow">
                                                                                <div class="trend-image position-relative">
                                                                                    <img src="images/trending/trending4.jpg" alt="Sân bóng Quận 12" class="">
                                                                                        <div class="color-overlay"></div>
                                                                                </div>
                                                                                <div class="trend-content p-4 pt-5 position-relative bg-white">
                                                                                    <div class="trend-meta bg-theme white px-3 py-2 rounded">
                                                                                        <div class="entry-author">
                                                                                            <i class="icon-calendar"></i>
                                                                                            <span class="fw-bold"> Sân 11 người</span>
                                                                                        </div>
                                                                                    </div>
                                                                                    <h5 class="theme mb-1"><i class="flaticon-location-pin"></i> Quận 12</h5>
                                                                                    <h3 class="mb-1"><a href="field-grid.html">Sân Tân Chánh Hiệp</a></h3>
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
                                                                                    <p class=" border-b pb-2 mb-2">Sân cỏ tự nhiên chuẩn FIFA, khán đài rộng rãi</p>
                                                                                    <div class="entry-meta">
                                                                                        <div class="entry-author d-flex align-items-center">
                                                                                            <p class="mb-0"><span class="theme fw-bold fs-5"> 300.000đ</span> | Mỗi giờ</p>
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
                                                <!-- Hot Deals Ends -->

                                                <!-- Discount action starts -->
                                                <section class="discount-action pt-6"
                                                         style="background-image:url(images/section-bg1.png); background-position:center;">
                                                    <div class="section-shape section-shape1 top-inherit bottom-0"
                                                         style="background-image: url(images/shape8.png);"></div>
                                                    <div class="container">
                                                        <div class="call-banner rounded pt-10 pb-14">
                                                            <div class="call-banner-inner w-75 mx-auto text-center px-5">
                                                                <div class="trend-content-main">
                                                                    <div class="trend-content mb-5 pb-2 px-5">
                                                                        <h5 class="mb-1 theme">Đam Mê Bóng Đá</h5>
                                                                        <h2><a href="detail-fullwidth.html">Khám Phá Niềm Đam Mê, <span class="theme1"> Chơi Bóng Mọi Lúc Mọi Nơi!</span></a></h2>
                                                                        <p>Hệ thống đặt sân bóng đá hàng đầu Việt Nam. Hơn 1000+ sân bóng chất lượng cao trên toàn quốc, phục vụ 24/7.</p>
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

                                                <!-- our teams starts -->
                                                <section class="our-team pb-6">
                                                    <div class="container">

                                                        <div class="section-title mb-6 w-75 mx-auto text-center">
                                                            <h4 class="mb-1 theme1">Đội Ngũ Chuyên Nghiệp</h4>
                                                            <h2 class="mb-1">Gặp Gỡ <span class="theme">Huấn Luyện Viên Xuất Sắc</span></h2>
                                                            <p>Đội ngũ huấn luyện viên giàu kinh nghiệm, tận tâm hướng dẫn và phát triển kỹ năng bóng đá cho bạn.
                                                            </p>
                                                        </div>
                                                        <div class="team-main">
                                                            <div class="row shop-slider">
                                                                <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                                                                    <div class="team-list rounded">
                                                                        <div class="team-image">
                                                                            <img src="images/team/img1.jpg" alt="Huấn luyện viên">
                                                                        </div>
                                                                        <div class="team-content text-center p-3 bg-theme">
                                                                            <h4 class="mb-0 white">Nguyễn Văn Minh</h4>
                                                                            <p class="mb-0 white">HLV Trưởng</p>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                                                                    <div class="team-list rounded">
                                                                        <div class="team-image">
                                                                            <img src="images/team/img2.jpg" alt="Huấn luyện viên">
                                                                        </div>
                                                                        <div class="team-content text-center p-3 bg-theme">
                                                                            <h4 class="mb-0 white">Trần Thành Đạt</h4>
                                                                            <p class="mb-0 white">HLV Thể Lực</p>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                                                                    <div class="team-list rounded">
                                                                        <div class="team-image">
                                                                            <img src="images/team/img4.jpg" alt="Huấn luyện viên">
                                                                        </div>
                                                                        <div class="team-content text-center p-3 bg-theme">
                                                                            <h4 class="mb-0 white">Lê Hoàng Nam</h4>
                                                                            <p class="mb-0 white">HLV Kỹ Thuật</p>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                                                                    <div class="team-list rounded">
                                                                        <div class="team-image">
                                                                            <img src="images/team/img3.jpg" alt="Huấn luyện viên">
                                                                        </div>
                                                                        <div class="team-content text-center p-3 bg-theme">
                                                                            <h4 class="mb-0 white">Phạm Quốc Tuấn</h4>
                                                                            <p class="mb-0 white">HLV Thủ Môn</p>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                                                                    <div class="team-list rounded">
                                                                        <div class="team-image">
                                                                            <img src="images/team/img4.jpg" alt="Huấn luyện viên">
                                                                        </div>
                                                                        <div class="team-content text-center bg-theme p-3">
                                                                            <h4 class="mb-0 white">Võ Minh Tâm</h4>
                                                                            <p class="mb-0 white">HLV Trẻ</p>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </section>
                                                <!-- our teams Ends -->

                                                <!-- partner starts -->

                                                <!-- partner ends -->

                                                <!-- recent-articles starts -->
                                                <section class="trending recent-articles pb-6">
                                                    <div class="container">
                                                        <div class="section-title mb-6 w-75 mx-auto text-center">
                                                            <h4 class="mb-1 theme1">Tin Tức Bóng Đá</h4>
                                                            <h2 class="mb-1">Bài Viết <span class="theme">Mới Nhất</span></h2>
                                                            <p>Cập nhật những tin tức mới nhất về bóng đá, kỹ thuật chơi bóng và các giải đấu hấp dẫn.
                                                            </p>
                                                        </div>
                                                        <div class="recent-articles-inner">
                                                            <div class="row">
                                                                <div class="col-lg-4">
                                                                    <div class="trend-item box-shadow bg-white mb-4 rounded overflow-hidden">
                                                                        <div class="trend-image">
                                                                            <img src="images/trending/trending10.jpg" alt="Tin tức bóng đá">
                                                                        </div>
                                                                        <div class="trend-content-main p-4 pb-2">
                                                                            <div class="trend-content">
                                                                                <h5 class="theme mb-1">Kỹ Thuật</h5>
                                                                                <h4><a href="detail-1.html">5 Bài Tập Cơ Bản Giúp Cải Thiện Kỹ Năng Chuyền Bóng</a></h4>
                                                                                <p class="mb-3">
                                                                                    Hướng dẫn chi tiết các bài tập giúp nâng cao kỹ năng chuyền bóng chính xác
                                                                                </p>
                                                                                <div class="entry-meta d-flex align-items-center justify-content-between">
                                                                                    <div class="entry-author mb-2">
                                                                                        <img src="images/reviewer/2.jpg" alt="" class="rounded-circle me-1">
                                                                                            <span>HLV Minh Tuấn</span>
                                                                                    </div>
                                                                                    <div class="entry-button d-flex align-items-centermb-2">
                                                                                        <a href="#" class="nir-btn">Đọc Thêm</a>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="col-lg-4 col-md-6">
                                                                    <div class="trend-item box-shadow bg-white mb-4 rounded overflow-hidden">
                                                                        <div class="trend-image">
                                                                            <img src="images/trending/trending12.jpg" alt="Tin tức bóng đá">
                                                                        </div>
                                                                        <div class="trend-content-main p-4 pb-2">
                                                                            <div class="trend-content">
                                                                                <h5 class="theme mb-1">Giải Đấu</h5>
                                                                                <h4><a href="detail-1.html">Giải Bóng Đá Nghiệp Dư TP.HCM Mùa Giải 2024</a>
                                                                                </h4>
                                                                                <p class="mb-3">
                                                                                    Thông tin chi tiết về giải đấu bóng đá nghiệp dư lớn nhất thành phố
                                                                                </p>
                                                                                <div class="entry-meta d-flex align-items-center justify-content-between">
                                                                                    <div class="entry-author mb-2">
                                                                                        <img src="images/reviewer/1.jpg" alt="" class="rounded-circle me-1">
                                                                                            <span>Ban Tổ Chức</span>
                                                                                    </div>
                                                                                    <div class="entry-button d-flex align-items-center mb-2">
                                                                                        <a href="#" class="nir-btn">Đọc Thêm</a>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="col-lg-4 col-md-6">
                                                                    <div class="trend-item box-shadow bg-white mb-4 rounded overflow-hidden">
                                                                        <div class="trend-image">
                                                                            <img src="images/trending/trending13.jpg" alt="Tin tức bóng đá">
                                                                        </div>
                                                                        <div class="trend-content-main p-4 pb-2">
                                                                            <div class="trend-content">
                                                                                <h5 class="theme mb-1">Sức Khỏe</h5>
                                                                                <h4><a href="detail-1.html">Chế Độ Dinh Dưỡng Cho Cầu Thủ Bóng Đá Nghiệp Dư</a></h4>
                                                                                <p class="mb-3">
                                                                                    Hướng dẫn chế độ ăn uống khoa học giúp nâng cao thể lực và sức bền
                                                                                </p>
                                                                                <div class="entry-meta d-flex align-items-center justify-content-between">
                                                                                    <div class="entry-author mb-2">
                                                                                        <img src="images/reviewer/3.jpg" alt="" class="rounded-circle me-1">
                                                                                            <span>BS Thể Thao</span>
                                                                                    </div>
                                                                                    <div class="entry-button d-flex align-items-center mb-2">
                                                                                        <a href="#" class="nir-btn">Đọc Thêm</a>
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

                                                    <!-- Instagram ends -->
                                                    <div class="footer-upper pb-4">
                                                        <div class="container">
                                                            <div class="row">
                                                                <div class="col-lg-4 col-md-6 col-sm-12 mb-4 pe-4">
                                                                    <div class="footer-about">
                                                                        <img src="images/logo-white.png" alt="BookField Logo">
                                                                            <p class="mt-3 mb-3 white">
                                                                                BookField - Hệ thống đặt sân bóng đá hàng đầu Việt Nam. Chúng tôi cung cấp dịch vụ đặt sân chất lượng cao, tiện lợi và nhanh chóng.
                                                                            </p>
                                                                            <ul>
                                                                                <li class="white"><strong>Hotline:</strong> 1900-1234</li>
                                                                                <li class="white"><strong>Địa chỉ:</strong> 123 Nguyễn Huệ, Q1, TP.HCM</li>
                                                                                <li class="white"><strong>Email:</strong> info@bookfield.vn</li>
                                                                                <li class="white"><strong>Website:</strong> www.bookfield.vn</li>
                                                                            </ul>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-2 col-md-6 col-sm-12 mb-4">
                                                                    <div class="footer-links">
                                                                        <h3 class="white">Liên Kết Nhanh</h3>
                                                                        <ul>
                                                                            <li><a href="about-us.html">Giới Thiệu</a></li>
                                                                            <li><a href="about-us.html">Hướng Dẫn Đặt Sân</a></li>
                                                                            <li><a href="about-us.html">Chính Sách Bảo Mật</a></li>
                                                                            <li><a href="about-us.html">Điều Khoản Sử Dụng</a></li>
                                                                            <li><a href="about-us.html">Hỗ Trợ Khách Hàng</a></li>
                                                                            <li><a href="#about-us.html">Chính Sách Hoàn Tiền</a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-2 col-md-6 col-sm-12 mb-4">
                                                                    <div class="footer-links">
                                                                        <h3 class="white">Loại Sân</h3>
                                                                        <ul>
                                                                            <li><a href="about-us.html">Sân 5 Người</a></li>
                                                                            <li><a href="about-us.html">Sân 7 Người</a></li>
                                                                            <li><a href="about-us.html">Sân 11 Người</a></li>
                                                                            <li><a href="about-us.html">Sân Futsal</a></li>
                                                                            <li><a href="about-us.html">Sân Cỏ Nhân Tạo</a></li>
                                                                            <li><a href="about-us.html">Sân Cỏ Tự Nhiên</a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
                                                                    <div class="footer-links">
                                                                        <h3 class="white">Đăng Ký Nhận Tin</h3>
                                                                        <div class="newsletter-form ">
                                                                            <p class="mb-3">Tham gia cộng đồng hơn 50,000 người chơi bóng đá để nhận thông tin về các ưu đãi và sự kiện mới nhất.</p>
                                                                            <form action="#" method="get" accept-charset="utf-8"
                                                                                  class="border-0 d-flex align-items-center">
                                                                                <input type="text" placeholder="Địa chỉ Email">
                                                                                    <button class="nir-btn ms-2">Đăng Ký</button>
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
                                                                        <li class="me-2">Chúng Tôi Hỗ Trợ:</li>
                                                                        <li class="me-2"><i class="fab fa-cc-mastercard fs-4"></i></li>
                                                                        <li class="me-2"><i class="fab fa-cc-paypal fs-4"></i></li>
                                                                        <li class="me-2"><i class="fab fa-cc-visa fs-4"></i></li>
                                                                        <li class="me-2">Momo</li>
                                                                        <li class="me-2">ZaloPay</li>
                                                                    </ul>
                                                                </div>
                                                                <div class="col-lg-4 footer-payment-nav mb-4">
                                                                    <ul class="d-flex align-items-center">
                                                                        <li class="me-2 w-75">
                                                                            <select class="niceSelect rounded">
                                                                                <option>Tiếng Việt</option>
                                                                                <option>English</option>
                                                                                <option>中文</option>
                                                                                <option>한국어</option>
                                                                            </select>
                                                                        </li>
                                                                        <li class="w-25">
                                                                            <select class="niceSelect rounded">
                                                                                <option>VNĐ</option>
                                                                                <option>USD</option>
                                                                                <option>EUR</option>
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
                                                                    <p class="m-0 white">2024 BookField. Tất cả quyền được bảo lưu.</p>
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
                                                        <input type="search" value="" placeholder="Tìm kiếm sân bóng..." />
                                                        <button type="submit" class="btn btn-primary">Tìm Kiếm</button>
                                                    </form>
                                                </div>

                                                <!-- login registration modal -->
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
                                                                                    type="button">Đăng Nhập</button>
                                                                        </li>
                                                                        <li class="nav-item" role="presentation">
                                                                            <button aria-controls="register" aria-selected="true" class="nav-link"
                                                                                    data-bs-target="#register" data-bs-toggle="tab" id="register-tab" role="tab"
                                                                                    type="button">Đăng Ký</button>
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
                                                                                    <h4 class="text-center border-b pb-2">Đăng Nhập</h4>

                                                                                    <hr class="log-reg-hr position-relative my-4 overflow-visible">
                                                                                        <form method="post" action="${pageContext.request.contextPath}/login" name="contactform" id="contactform" >
                                                                                            <div  class="form-group mb-2">
                                                                                                <input type="text" name="username" class="form-control" id="username"
                                                                                                       placeholder="Tên đăng nhập hoặc địa chỉ Email" autocomplete="off"  />
                                                                                            </div>
                                                                                            <div class="form-group mb-2">
                                                                                                <input type="password" name="password" class="form-control"
                                                                                                       id="password" placeholder="Mật khẩu"  >

                                                                                            </div>
                                                                                            <a class="fas fa-eye " href ="#" onclick="daoTT()" > Hiện thị mật khẩu</a>
                                                                                            <div id="loginError" class="text-danger mb-2" style="font-size: 14px;">
                                                                                                <c:if test="${not empty error}">
                                                                                                    <script>
                                                                                                        alert("${error}");
                                                                                                    </script>
                                                                                                </c:if>
                                                                                            </div>
                                                                                            <div class="form-group mb-2">

                                                                                               <input type="checkbox" name="remember" class="custom-control-input" id="rememberCheck">
                                                                                                     <label class="custom-control-label mb-0" for="rememberCheck">Nhớ Mật Khẩu</label>
                                                                                                    <a class="float-end" href="requestPassword.jsp">Quên mật khẩu?</a>

                                                                                            </div>
                                                                                            <div class="comment-btn mb-2 pb-2 text-center border-b">
                                                                                                <input type="submit" class="nir-btn w-100"  value="Đăng Nhập">


                                                                                            </div>
                                                                                            <p class="text-center">Bạn chưa có tài khoản? <a href="#" class="theme" onclick="event.preventDefault(); document.getElementById('register-tab').click();">Đăng Ký</a></p>
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
                                                                                           style="background-image: url(images/trending/anh_regis_1.jpg);"></a>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-lg-6">

                                                <script>
                                                    document.addEventListener("DOMContentLoaded", function () {
                                                        const exampleModal = document.getElementById("exampleModal");
                                                        const errorDiv = document.getElementById("loginError");
                                                        const usernameInput = document.getElementById("username");
                                                        const passwordInput = document.getElementById("password");
                                                        const  form = document.getElementById('contactform');
                                                        const params = new URLSearchParams(window.location.search);


                                                        // Tự động focus khi mở modal
                                                        exampleModal.addEventListener('shown.bs.modal', function () {
                                                            if (usernameInput)
                                                                usernameInput.focus();
                                                        });

                                                        // Khi đóng modal: xóa lỗi + xóa nội dung các input
                                                        exampleModal.addEventListener('hidden.bs.modal', function () {
                                                            if (errorDiv)
                                                                errorDiv.textContent = "";
                                                            if (usernameInput)
                                                                usernameInput.value = "";
                                                            if (passwordInput)
                                                                passwordInput.value = "";
                                                        });


                                                        // Hàm kiểm tra login

                                                        form.addEventListener("submit", function (event) {
                                                            const username = usernameInput.value.trim();
                                                            const password = passwordInput.value.trim();

                                                            if (!username || !password) {
                                                                errorDiv.textContent = "Vui lòng nhập tên đăng nhập và mật khẩu.";
                                                                event.preventDefault(); // 🚫 Ngăn form gửi đi nếu thiếu
                                                            } else {
                                                                errorDiv.textContent = "";
                                                                form.submit();

                                                            }
                                                        });


                                                        // Hàm ẩn/hiện mật khẩu
                                                        window.daoTT = function () {
                                                            let mk = document.getElementById("password");
                                                            mk.type = (mk.type === "password") ? "text" : "password";
                                                        };




                                                    });









                                                </script>


                                                                                    <form action="${pageContext.request.contextPath}/dang-ki" method="POST" id="dkiform" onsubmit="event.preventDefault(); validateAndSubmit();">

                                                                                        <!-- Họ và tên -->
                                                                                        <div class="form-group mb-2 d-flex">
                                                                                            <input type="text" name="lastname" id="lastname" class="form-control me-1" placeholder="Họ" style="width: 50%;" required>
                                                                                                <input type="text" name="firstname" id="firstname" class="form-control ms-1" placeholder="Tên" style="width: 50%;" required>
                                                                                                    </div>

                                                                                                    <!-- Tên đăng nhập -->
                                                                                                    <div class="form-group mb-2">
                                                                                                        <input type="text" name="username" id="username" class="form-control" placeholder="Tên đăng nhập" required>
                                                                                                    </div>

                                                                                                    <!-- Mật khẩu -->
                                                                                                    <div class="form-group mb-2">
                                                                                                        <input type="password" name="password" id="password" class="form-control" placeholder="Mật khẩu" required>
                                                                                                    </div>

                                                                                                    <!-- Nhập lại mật khẩu -->
                                                                                                    <div class="form-group mb-2">
                                                                                                        <input type="password" name="password_confirm" id="password_confirm" class="form-control" placeholder="Nhập lại mật khẩu" required>
                                                                                                    </div>

                                                                                                    <!-- Email -->
                                                                                                    <div class="form-group mb-2">
                                                                                                        <input type="email" name="email" id="email" class="form-control" placeholder="Email" required>
                                                                                                    </div>

                                                                                                    <!-- Số điện thoại -->
                                                                                                    <div class="form-group mb-2">
                                                                                                        <input type="text" name="phone" id="phone" class="form-control" placeholder="Số điện thoại" required>
                                                                                                    </div>

                                                                                                    <!-- Ngày sinh -->
                                                                                                    <div class="form-group mb-2">
                                                                                                        <input type="date" name="dob" id="dob" class="form-control" required>
                                                                                                    </div>

                                                                                                    <!-- Giới tính -->
                                                                                                    <div class="form-group mb-2">
                                                                                                        <select name="gender" id="gender" class="form-control" required>
                                                                                                            <option value="">-- Chọn giới tính --</option>
                                                                                                            <option value="Nam">Nam</option>
                                                                                                            <option value="Nữ">Nữ</option>
                                                                                                            <option value="Khác">Khác</option>
                                                                                                        </select>
                                                                                                    </div>

                                                                                                    <!-- Địa chỉ -->
                                                                                                    <div class="form-group mb-2">
                                                                                                        <input type="text" name="address" id="address" class="form-control" placeholder="Địa chỉ" required>
                                                                                                    </div>

                                                                                                    <!-- Đồng ý điều khoản -->
                                                                                                    <div class="form-check mb-3">
                                                                                                        <input class="form-check-input" type="checkbox" name="check" id="check" required>
                                                                                                            <label class="form-check-label" for="check">Tôi đồng ý với điều khoản</label>
                                                                                                    </div>

                                                                                                    <!-- Nút đăng ký -->
                                                                                                    <div class="comment-btn mb-2 pb-2 text-center border-b">
                                                                                                        <input type="submit" class="nir-btn w-100" id="submit1" value="Đăng Kí">
                                                                                                    </div>

                                                                                                    <!-- Thông báo từ servlet -->
                                                                                                    <div id="message" class="text-center mb-2 text-danger"></div>

                                                                                                    <!-- Đường dẫn đăng nhập -->
                                                                                                    <p class="text-center">Bạn đã có tài khoản? <a href="#" class="theme">Đăng nhập</a></p>
                                                                                                    </form>

                                                                                                    <!-- Toast hiển thị lỗi -->
                                                                                                    <div id="toast-container" style="position: fixed; top: 20px; right: 20px; z-index: 9999;"></div>

                                                                                                    <!-- Script kiểm tra form -->
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