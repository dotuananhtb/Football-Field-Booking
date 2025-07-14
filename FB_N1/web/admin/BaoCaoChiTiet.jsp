<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Báo cáo chi tiết</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="head_only.jsp" />
    <link href="assets/css/app.min.css" rel="stylesheet" type="text/css" id="app-style" />
    <link href="assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <div class="wrapper">
        <jsp:include page="topbar.jsp"/>
        <jsp:include page="left_sidebar.jsp"/>
        <div class="content-page">
            <div class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12">
                            <div class="page-title-box">
                                <h4 class="page-title">Báo cáo chi tiết</h4>
                            </div>
                        </div>
                    </div>
                    <form method="get" action="${pageContext.request.contextPath}/admin/bao-cao-chi-tiet" style="margin-bottom: 20px;">
                        <label for="monthFilter">Chọn tháng:</label>
                        <input type="month" id="monthFilter" name="monthFilter" value="${param.monthFilter}">
                        <button type="submit">Lọc theo tháng</button>
                    </form>
                    <form method="get" action="${pageContext.request.contextPath}/admin/bao-cao-chi-tiet" style="margin-bottom: 20px; display: flex; align-items: center; gap: 16px; flex-wrap: wrap;">
                        <label for="fromDate">Từ ngày:</label>
                        <input type="date" id="fromDate" name="fromDate" value="${param.fromDate}">
                        <label for="toDate">Đến ngày:</label>
                        <input type="date" id="toDate" name="toDate" value="${param.toDate}">
                        <label for="payStatus">Trạng thái:</label>
                        <select id="payStatus" name="payStatus">
                            <option value="">Tất cả</option>
                            <option value="success" <c:if test="${param.payStatus == 'success'}">selected</c:if>>Đã thanh toán</option>
                            <option value="pending" <c:if test="${param.payStatus == 'pending'}">selected</c:if>>Chờ thanh toán</option>
                            <option value="failed" <c:if test="${param.payStatus == 'failed'}">selected</c:if>>Đã huỷ</option>
                        </select>
                        <button type="submit">Lọc</button>
                    </form>
                    <c:choose>
                        <c:when test="${not empty selectedMonthFilter}">
                            <div class="alert alert-info mt-2">
                                Doanh thu theo tháng <strong>${selectedMonthFilter}</strong>: <strong>${revenueByMonthFilter}</strong>
                            </div>
                        </c:when>
                        <c:when test="${not empty filteredRevenue}">
                            <div class="alert alert-info mt-2">
                                Doanh thu theo ngày: <strong>${filteredRevenue}</strong>
                            </div>
                        </c:when>
                    </c:choose>
                    <c:if test="${not empty selectedDate}">
                        <div class="alert alert-info mt-2">
                            Doanh thu ngày <strong>${selectedDate}</strong>: <strong>${revenueBySelectedDate}</strong>
                        </div>
                    </c:if>
                    <c:if test="${not empty selectedMonth}">
                        <div class="alert alert-info mt-2">
                            Doanh thu tháng <strong>${selectedMonth}</strong>: <strong>${revenueBySelectedMonth}</strong>
                        </div>
                    </c:if>
                    <c:if test="${empty selectedDate && empty selectedMonth}">
                        <!-- 1. Thống kê doanh thu top tháng/ngày -->
                        <div class="row mt-3">
                            <div class="col-lg-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h4 class="header-title">1. Thống kê doanh thu</h4>
                                    </div>
                                    <div class="card-body">
                                        <h5 class="mt-4">Top 5 tháng doanh thu cao nhất</h5>
                                        <table class="table table-bordered table-striped">
                                            <thead><tr><th>Tháng</th><th>Doanh thu</th></tr></thead>
                                            <tbody>
                                            <c:forEach var="item" items="${topRevenueMonths}">
                                                <tr>
                                                    <td>${item.month}</td>
                                                    <td>${item.revenue}</td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                        <h5 class="mt-4">Top 5 ngày doanh thu cao nhất</h5>
                                        <table class="table table-bordered table-striped">
                                            <thead><tr><th>Ngày</th><th>Doanh thu</th></tr></thead>
                                            <tbody>
                                            <c:forEach var="item" items="${topRevenueDays}">
                                                <tr>
                                                    <td>${item.date}</td>
                                                    <td>${item.revenue}</td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <!-- 2. Doanh thu theo từng sân -->
                    <div class="row mt-3">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="header-title">2. Doanh thu theo từng sân</h4>
                                </div>
                                <div class="card-body">
                                    <table class="table table-bordered table-striped">
                                        <thead><tr><th>Tên sân</th><th>Doanh thu</th></tr></thead>
                                        <tbody>
                                        <c:forEach var="item" items="${revenueByField}">
                                            <tr>
                                                <td>${item.field_name}</td>
                                                <td>${item.revenue}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 2. 10 booking gần nhất -->
                    <div class="row mt-3">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="header-title">3. 10 booking gần nhất</h4>
                                </div>
                                <div class="card-body">
                                    <table class="table table-bordered table-striped">
                                        <thead><tr><th>Tên user</th><th>Ngày đặt</th><th>Trạng thái</th><th>Số tiền</th></tr></thead>
                                        <tbody>
                                        <c:forEach var="b" items="${recentBookings}">
                                            <tr>
                                                <td>${b.customer_name}</td>
                                                <td>${b.booking_date}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${b.status_pay == 1}">Đã thanh toán</c:when>
                                                        <c:when test="${b.status_pay == 0}">Chờ thanh toán</c:when>
                                                        <c:when test="${b.status_pay == -1}">Đã hủy</c:when>
                                                        <c:otherwise>Khác</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>${b.total_amount}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 3. Thống kê booking theo từng sân -->
                    <div class="row mt-3">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="header-title">4. Thống kê booking theo từng sân</h4>
                                </div>
                                <div class="card-body">
                                    <table class="table table-bordered table-striped">
                                        <thead><tr><th>Tên sân</th><th>Số booking</th></tr></thead>
                                        <tbody>
                                        <c:forEach var="item" items="${bookingCountByField}">
                                            <tr>
                                                <td>${item.field_name}</td>
                                                <td>${item.booking_count}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 5. 10 user mới đăng ký gần đây -->
                    <div class="row mt-3">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="header-title">5. 10 user mới đăng ký gần đây</h4>
                                </div>
                                <div class="card-body">
                                    <table class="table table-bordered table-striped">
                                        <thead><tr><th>Tên user</th><th>Email</th><th>Ngày đăng ký</th></tr></thead>
                                        <tbody>
                                        <c:forEach var="user" items="${recentUsers}">
                                            <tr>
                                                <td>${user.userProfile.firstName} ${user.userProfile.lastName}</td>
                                                <td>${user.email}</td>
                                                <td>${user.createdAt}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="footer.jsp"/>
        </div>
    </div>
    <jsp:include page="themesetting.jsp" />
    <script src="assets/js/vendor.min.js"></script>
    <script src="assets/js/app.min.js"></script>
</body>
</html> 