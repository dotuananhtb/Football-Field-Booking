<%-- 
    Document   : ThongKe
    Created on : 14 thg 7, 2025, 14:08:35
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="com.google.gson.Gson" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String revenueDataJson = new Gson().toJson(request.getAttribute("revenueByMonth"));
    String monthLabelsJson = new Gson().toJson(request.getAttribute("monthLabels"));
    String weekDayLabelsJson = new Gson().toJson(request.getAttribute("weekDayLabels"));
    String weekDayRevenueJson = new Gson().toJson(request.getAttribute("weekDayRevenue"));
    String fieldLabelsJson = new Gson().toJson(request.getAttribute("fieldLabels"));
    String fieldRevenueJson = new Gson().toJson(request.getAttribute("fieldRevenue"));
    String typeOfFieldLabelsJson = new Gson().toJson(request.getAttribute("typeOfFieldLabels"));
    String typeOfFieldCountsJson = new Gson().toJson(request.getAttribute("typeOfFieldCounts"));
    String bookingHourLabelsJson = new Gson().toJson(request.getAttribute("bookingHourLabels"));
    String bookingHourCountsJson = new Gson().toJson(request.getAttribute("bookingHourCounts"));
%>
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
                            <!-- Tổng số bài viết của user thường (roleId = 3) -->
                            <div class="col-sm-6 col-xxl-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <h5 class="text-muted fw-normal mt-0 text-truncate" title="Tổng số bài viết/blog">Bài viết </h5>
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
                            <div class="col-sm-6 col-xxl-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <h5 class="text-muted fw-normal mt-0 text-truncate" title="Tổng số blog">Blog</h5>
                                                <h3 class="my-1 py-1">${totalBlogs}</h3>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-end">
                                                    <i class="ri-book-2-line fs-2 text-primary"></i>
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
                                                <h5 class="text-muted fw-normal mt-0" title="Tài khoản người dùng">Tài khoản người dùng</h5>
                                                <h3 class="my-1 py-1">${totalUsers}</h3>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-end">
                                                    <i class="ri-user-line fs-2 text-success"></i>
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
                                                <h5 class="text-muted fw-normal mt-0 text-truncate" title="Tổng số nhân viên">Nhân viên</h5>
                                                <h3 class="my-1 py-1">${totalStaff}</h3>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-end">
                                                    <i class="ri-user-settings-line fs-2 text-info"></i>
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
                                                <h5 class="text-muted fw-normal mt-0 text-truncate" title="Tổng số admin">Admin</h5>
                                                <h3 class="my-1 py-1">${totalAdmin}</h3>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-end">
                                                    <i class="ri-shield-user-line fs-2 text-primary"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Nhóm 4: Booking & doanh thu -->
                        <!-- ĐÃ XÓA: Các box thống kê booking ở đây -->
                        <!-- Bảng thống kê tổng quát doanh thu hệ thống (di chuyển lên đầu) -->
                        <div class="row mt-4">
                            <div class="col-lg-6">
                                <div class="card">
                                    <div class="card-header">
                                        <h4 class="header-title">Thống kê tổng quát doanh thu hệ thống</h4>
                                    </div>
                                    <div class="card-body">
                                        <!-- Form chọn khoảng thời gian hoặc tháng/năm -->
                                        <form method="get" class="row g-2 mb-3">
                                            <div class="col-12 col-md-6">
                                                <label>Chọn khoảng ngày:</label>
                                                <input type="date" name="fromDate" value="${param.fromDate}" class="form-control" />
                                                <input type="date" name="toDate" value="${param.toDate}" class="form-control mt-1" />
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <label class="fw-bold mb-1">Chọn khoảng tháng trong năm:</label>
                                                <div class="row g-2 align-items-end">
                                                    <div class="col-4">
                                                        <label class="form-label mb-0">Từ tháng</label>
                                                        <select name="fromMonth" class="form-select">
                                                            <option value="">--</option>
                                                            <c:forEach var="m" begin="1" end="12">
                                                                <option value="${m}" <c:if test="${param.fromMonth == (m + '')}">selected</c:if>>${m}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                    <div class="col-4">
                                                        <label class="form-label mb-0">Đến tháng</label>
                                                        <select name="toMonth" class="form-select">
                                                            <option value="">--</option>
                                                            <c:forEach var="m" begin="1" end="12">
                                                                <option value="${m}" <c:if test="${param.toMonth == (m + '')}">selected</c:if>>${m}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                    <div class="col-4">
                                                        <label class="form-label mb-0">Năm</label>
                                                        <input type="number" name="yearRange" min="2000" max="2100" value="${param.yearRange}" class="form-control" placeholder="Năm" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-2 d-flex align-items-end">
                                                <button type="submit" class="btn btn-primary w-100">Xem thống kê</button>
                                            </div>
                                        </form>
                                        <c:choose>
                                            <c:when test="${not empty revenueCustom}">
                                                <table class="table table-bordered table-striped">
                                                    <thead>
                                                        <tr>
                                                            <th>Khoảng thời gian</th>
                                                            <th>Tổng doanh thu</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${not empty param.fromMonth and not empty param.toMonth and not empty param.yearRange}">
                                                                        Tháng ${param.fromMonth}-${param.toMonth}/${param.yearRange}
                                                                    </c:when>
                                                                    <c:when test="${not empty param.fromDate and not empty param.toDate}">
                                                                        ${param.fromDate} đến ${param.toDate}
                                                                    </c:when>
                                                                    <c:when test="${not empty param.month and not empty param.year}">
                                                                        Tháng ${param.month}/${param.year}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        Tuỳ chọn
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td><b>${revenueCustom}</b></td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </c:when>
                                            <c:otherwise>
                                                <h5 class="mb-3">Bảng Thống Kê Tổng Quát Doanh Thu Hệ Thống</h5>
                                                <table class="table table-bordered table-striped">
                                                    <thead>
                                                        <tr>
                                                            <th>Chỉ số</th>
                                                            <th>Giá trị</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td><b>Tổng doanh thu năm nay</b></td>
                                                            <td><b>${totalRevenueYear}</b></td>
                                                        </tr>
                                                        <tr>
                                                            <td><b>Tổng doanh thu toàn hệ thống</b></td>
                                                            <td><b>${totalRevenue}</b></td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Biểu đồ doanh thu các tháng (1 hàng) -->
                        <div class="row mt-3">
                            <div class="col-12 mb-3">
                                <div class="card">
                                    <div class="card-header">
                                        <h4 class="header-title">Biểu đồ doanh thu các tháng</h4>
                                    </div>
                                    <div class="card-body">
                                        <div id="revenue-month-chart" class="apex-charts" style="min-height: 350px;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Biểu đồ doanh thu 7 ngày gần nhất (1 hàng) -->
                        <div class="row mt-3">
                            <div class="col-12 mb-3">
                                <div class="card">
                                    <div class="card-header">
                                        <h4 class="header-title">Biểu đồ doanh thu 7 ngày gần nhất</h4>
                                    </div>
                                    <div class="card-body">
                                        <div id="revenue-week-chart" class="apex-charts" style="min-height: 350px;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Biểu đồ doanh thu theo sân (1 hàng) -->
                        <div class="row mt-3">
                            <div class="col-12 mb-3">
                                <div class="card">
                                    <div class="card-header">
                                        <h4 class="header-title">Biểu đồ doanh thu theo sân</h4>
                                    </div>
                                    <div class="card-body">
                                        <div id="revenue-field-chart" class="apex-charts" style="min-height: 350px;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Biểu đồ tỷ lệ loại sân được đặt (pie chart) -->
                        <div class="row mt-3">
                            <div class="col-12 mb-3">
                                <div class="card">
                                    <div class="card-header">
                                        <h4 class="header-title">Biểu đồ tỷ lệ loại sân được đặt</h4>
                                    </div>
                                    <div class="card-body">
                                        <div id="type-of-field-pie-chart" class="apex-charts" style="min-height: 350px;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Biểu đồ khung giờ đặt sân phổ biến (column chart) -->
                        <div class="row mt-3">
                            <div class="col-12 mb-3">
                                <div class="card">
                                    <div class="card-header">
                                        <h4 class="header-title">Biểu đồ khung giờ đặt sân phổ biến</h4>
                                    </div>
                                    <div class="card-body">
                                        <div id="popular-booking-hour-chart" class="apex-charts" style="min-height: 350px;"></div>
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
        <!-- ApexCharts JS -->
        <script src="assets/vendor/apexcharts/apexcharts.min.js"></script>
        <script>
            var revenueData = <%= revenueDataJson %>;
            var monthLabels = <%= monthLabelsJson %>;
            var weekDayLabels = <%= weekDayLabelsJson %>;
            var weekDayRevenue = <%= weekDayRevenueJson %>;
            var fieldLabels = <%= fieldLabelsJson %>;
            var fieldRevenue = <%= fieldRevenueJson %>;
            var typeOfFieldLabels = <%= typeOfFieldLabelsJson %>;
            var typeOfFieldCounts = <%= typeOfFieldCountsJson %>;
            var bookingHourLabels = <%= bookingHourLabelsJson %>;
            var bookingHourCounts = <%= bookingHourCountsJson %>;
            document.addEventListener("DOMContentLoaded", function() {
                // Biểu đồ doanh thu các tháng
                var options = {
                    chart: {
                        type: 'bar',
                        height: 350,
                        toolbar: { show: false }
                    },
                    series: [{
                        name: 'Doanh thu',
                        data: revenueData
                    }],
                    xaxis: { categories: monthLabels },
                    colors: ['#47ad77'],
                    dataLabels: { enabled: true },
                    title: { text: 'So sánh doanh thu các tháng', align: 'center' }
                };
                var chart = new ApexCharts(document.querySelector("#revenue-month-chart"), options);
                chart.render();

                // Biểu đồ doanh thu 7 ngày gần nhất
                var weekOptions = {
                    chart: {
                        type: 'line',
                        height: 350,
                        toolbar: { show: false }
                    },
                    series: [{
                        name: 'Doanh thu',
                        data: weekDayRevenue
                    }],
                    xaxis: { categories: weekDayLabels },
                    colors: ['#e7607b'],
                    dataLabels: { enabled: true },
                    title: { text: 'Doanh thu 7 ngày gần nhất', align: 'center' }
                };
                var weekChart = new ApexCharts(document.querySelector("#revenue-week-chart"), weekOptions);
                weekChart.render();

                // Biểu đồ doanh thu theo sân
                var fieldOptions = {
                    chart: {
                        type: 'bar',
                        height: 350,
                        toolbar: { show: false }
                    },
                    series: [{
                        name: 'Doanh thu',
                        data: fieldRevenue
                    }],
                    xaxis: { categories: fieldLabels },
                    colors: ['#008ffb'],
                    dataLabels: { enabled: true },
                    title: { text: 'Doanh thu theo sân', align: 'center' }
                };
                var fieldChart = new ApexCharts(document.querySelector("#revenue-field-chart"), fieldOptions);
                fieldChart.render();

                // Biểu đồ tỷ lệ loại sân được đặt (pie chart)
                var typePieOptions = {
                    chart: {
                        type: 'pie',
                        height: 350,
                        toolbar: { show: false }
                    },
                    series: typeOfFieldCounts,
                    labels: typeOfFieldLabels,
                    title: { text: 'Tỷ lệ loại sân được đặt', align: 'center' },
                    dataLabels: { enabled: true },
                    legend: { position: 'bottom' }
                };
                var typePieChart = new ApexCharts(document.querySelector("#type-of-field-pie-chart"), typePieOptions);
                typePieChart.render();

                // Biểu đồ khung giờ đặt sân phổ biến (column chart)
                var hourOptions = {
                    chart: {
                        type: 'bar',
                        height: 350,
                        toolbar: { show: false }
                    },
                    series: [{
                        name: 'Số lượt đặt',
                        data: bookingHourCounts
                    }],
                    xaxis: { categories: bookingHourLabels, title: { text: 'Khung giờ bắt đầu' } },
                    colors: ['#feb019'],
                    dataLabels: { enabled: true },
                    title: { text: 'Khung giờ đặt sân phổ biến', align: 'center' }
                };
                var hourChart = new ApexCharts(document.querySelector("#popular-booking-hour-chart"), hourOptions);
                hourChart.render();
            });
        </script>
    </body>
</html> 
