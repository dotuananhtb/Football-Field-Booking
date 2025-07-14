<%-- 
    Document   : ThongKe
    Created on : 14 thg 7, 2025, 14:08:35
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Thống kê tổng quát</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />

        <!-- App favicon -->
        <jsp:include page="head_only.jsp" />

        <!-- Daterangepicker css -->
        <link rel="stylesheet" href="assets/vendor/daterangepicker/daterangepicker.css">

        <!-- Vector Map css -->
        <link rel="stylesheet" href="assets/vendor/admin-resources/jquery.vectormap/jquery-jvectormap-1.2.2.css">

        <!-- Theme Config Js -->
        <script src="assets/js/config.js"></script>

        <!-- App css -->
        <link href="assets/css/app.min.css" rel="stylesheet" type="text/css" id="app-style" />

        <!-- Icons css -->
        <link href="assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    </head>

    <body>
        <!-- Begin page -->
        <div class="wrapper">
            <jsp:include page="topbar.jsp"/>
            <jsp:include page="left_sidebar.jsp"/>

            <!-- ============================================================== -->
            <!-- Start Page Content here -->
            <!-- ============================================================== -->

            <div class="content-page">
                <div class="content">

                    <!-- Start Content-->
                    <div class="container-fluid">

                        <div class="row">
                            <div class="col-12">
                                <div class="bg-flower">
                                    <img src="assets/images/flowers/img-3.png">
                                </div>

                                <div class="bg-flower-2">
                                    <img src="assets/images/flowers/img-1.png">
                                </div>

                                <div class="page-title-box">                                    
                                    <div class="page-title-right">
                                        
                                    </div>
                                    <h4 class="page-title">Thống kê tổng quát</h4>
                                </div>
                            </div>
                        </div>

                        <!-- Nhóm 1: Hệ thống & phân loại -->
                        <div class="row mt-3">
                            <div class="col-sm-6 col-xxl-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <h5 class="text-muted fw-normal mt-0 text-truncate" title="Tổng số khu vực">Khu vực</h5>
                                                <h3 class="my-1 py-1">${totalZones}</h3>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-end">
                                                    <i class="ri-map-pin-line fs-2 text-info"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-xxl-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <h5 class="text-muted fw-normal mt-0 text-truncate" title="Tổng số loại sân">Loại sân</h5>
                                                <h3 class="my-1 py-1">${totalFieldTypes}</h3>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-end">
                                                    <i class="ri-football-fill fs-2 text-success"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-xxl-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <h5 class="text-muted fw-normal mt-0 text-truncate" title="Tổng số sân bóng">Sân bóng</h5>
                                                <h3 class="my-1 py-1">${totalFields}</h3>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-end">
                                                    <i class="ri-football-line fs-2 text-success"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-xxl-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <h5 class="text-muted fw-normal mt-0 text-truncate" title="Tổng số loại sản phẩm">Loại sản phẩm</h5>
                                                <h3 class="my-1 py-1">${totalProductCategories}</h3>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-end">
                                                    <i class="ri-price-tag-3-line fs-2 text-primary"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Nhóm 2: Sản phẩm & nội dung -->
                        <div class="row mt-3">
                            <div class="col-sm-6 col-xxl-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <h5 class="text-muted fw-normal mt-0 text-truncate" title="Tổng số sản phẩm">Sản phẩm</h5>
                                                <h3 class="my-1 py-1">${totalProducts}</h3>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-end">
                                                    <i class="ri-shopping-bag-3-line fs-2 text-primary"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-xxl-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <h5 class="text-muted fw-normal mt-0 text-truncate" title="Tổng số bài viết/blog">Bài viết</h5>
                                                <h3 class="my-1 py-1">${totalPosts}</h3>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-end">
                                                    <i class="ri-article-line fs-2 text-info"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-xxl-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <h5 class="text-muted fw-normal mt-0 text-truncate" title="Tổng số slider/banner">Slider/Banner</h5>
                                                <h3 class="my-1 py-1">${totalSliders}</h3>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-end">
                                                    <i class="ri-slideshow-2-line fs-2 text-warning"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Nhóm 3: Người dùng & tài khoản -->
                        <div class="row mt-3">
                            <div class="col-sm-6 col-xxl-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <h5 class="text-muted fw-normal mt-0 " title="Tài khoản người dùng">Tài khoản người dùng</h5>
                                                <h3 class="my-1 py-1">${totalUsers}</h3>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-end">
                                                    <div id="user-chart" data-colors="#6da09c"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-xxl-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <h5 class="text-muted fw-normal mt-0 text-truncate" title="Tổng số nhân viên/admin">Admin</h5>
                                                <h3 class="my-1 py-1">${totalStaff + totalAdmin}</h3>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-end">
                                                    <div id="staff-chart" data-colors="#87bf8a"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-xxl-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <h5 class="text-muted fw-normal mt-0 text-truncate" title="Tài khoản bị khóa">Tài khoản bị khóa</h5>
                                                <h3 class="my-1 py-1">${lockedAccounts}</h3>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-end">
                                                    <i class="ri-lock-line fs-2 text-danger"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Nhóm 4: Booking & doanh thu -->
                        <div class="row mt-3">
                            <div class="col-sm-6 col-xxl-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <h5 class="text-muted fw-normal mt-0 text-truncate" title="Tổng số booking">Tổng booking</h5>
                                                <h3 class="my-1 py-1">${totalBookings}</h3>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-end">
                                                    <div id="booking-chart" data-colors="#e7607b"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-xxl-3">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="text-muted fw-normal mt-0 text-truncate" title="Booking mới">Booking mới</h5>
                                        <ul class="list-unstyled mb-0">
                                            <li>Hôm nay: <b>${newBookingToday}</b></li>
                                            <li>Tuần này: <b>${newBookingWeek}</b></li>
                                            <li>Tháng này: <b>${newBookingMonth}</b></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-xxl-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <h5 class="text-muted fw-normal mt-0 " title="Booking đã hoàn thành">Booking hoàn thành</h5>
                                                <h3 class="my-1 py-1">${totalCompletedBookings}</h3>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-end">
                                                    <i class="ri-check-double-line fs-2 text-success"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-xxl-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <h5 class="text-muted fw-normal mt-0 " title="Booking đang chờ xử lý">Booking  xử lý</h5>
                                                <h3 class="my-1 py-1">${totalPendingBookings}</h3>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-end">
                                                    <i class="ri-time-line fs-2 text-warning"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-xxl-3 mt-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <h5 class="text-muted fw-normal mt-0 text-truncate" title="Booking đã hủy">Booking đã hủy</h5>
                                                <h3 class="my-1 py-1">${cancelledBookings}</h3>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-end">
                                                    <i class="ri-close-circle-line fs-2 text-warning"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-xxl-3 mt-3">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="text-muted fw-normal mt-0 text-truncate" title="Tỷ lệ booking thành công/hủy">Tỷ lệ thành công/hủy</h5>
                                        <ul class="list-unstyled mb-0">
                                            <li>Thành công: <b>${bookingSuccessRate}%</b></li>
                                            <li>Hủy: <b>${bookingCancelRate}%</b></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Bảng doanh thu -->
                        <div class="row mt-4">
                            <div class="col-lg-6">
                                <div class="card">
                                    <div class="card-header">
                                        <h4 class="header-title">Bảng Thống Kê Doanh Thu</h4>
                                    </div>
                                    <div class="card-body">
                                        <table class="table table-bordered table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Khoảng thời gian</th>
                                                    <th>Tổng doanh thu</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>1 tháng gần nhất</td>
                                                    <td>${revenue1Month}</td>
                                                </tr>
                                                <tr>
                                                    <td>3 tháng gần nhất</td>
                                                    <td>${revenue3Month}</td>
                                                </tr>
                                                <tr>
                                                    <td>6 tháng gần nhất</td>
                                                    <td>${revenue6Month}</td>
                                                </tr>
                                                <tr>
                                                    <td><b>Tổng doanh thu toàn hệ thống</b></td>
                                                    <td><b>${totalRevenue}</b></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end row -->

                        
                        <!-- end row -->

                        
                        <!-- end row -->

                    </div>
                    <!-- container -->

                </div>
                <!-- content -->

                <!-- Footer Start -->
                <jsp:include page="footer.jsp"/>
                <!-- end Footer -->
            </div>

            <!-- ============================================================== -->
            <!-- End Page content -->
            <!-- ============================================================== -->

        </div>
        <!-- END wrapper -->

        <!-- Theme Settings -->
        <jsp:include page="themesetting.jsp" />

        <!-- Vendor js -->
        <script src="assets/js/vendor.min.js"></script>

        <!-- Daterangepicker js -->
        <script src="assets/vendor/daterangepicker/moment.min.js"></script>
        <script src="assets/vendor/daterangepicker/daterangepicker.js"></script>
        
        <!-- Apex Charts js -->
        <script src="assets/vendor/apexcharts/apexcharts.min.js"></script>

        <!-- Vector Map js -->
        <script src="assets/vendor/admin-resources/jquery.vectormap/jquery-jvectormap-1.2.2.min.js"></script>
        <script src="assets/vendor/admin-resources/jquery.vectormap/maps/jquery-jvectormap-world-mill-en.js"></script>

        <!-- Dashboard App js -->
        <script src="assets/js/pages/demo.dashboard.js"></script>

        <!-- App js -->
        <script src="assets/js/app.min.js"></script>
    </body>
</html> 
