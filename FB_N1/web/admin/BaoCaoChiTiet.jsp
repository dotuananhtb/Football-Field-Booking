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
                    <!-- Báo cáo chi tiết đơn đặt sân -->
                    <div class="row mt-3">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="header-title">📋 1. Báo cáo chi tiết đơn đặt sân</h4>
                                </div>
                                <div class="card-body">
                                    <form method="get" action="${pageContext.request.contextPath}/admin/bao-cao-chi-tiet" style="margin-bottom: 20px; display: flex; align-items: center; gap: 16px; flex-wrap: wrap;">
                                        <label for="detailFromDate">Từ ngày:</label>
                                        <input type="date" id="detailFromDate" name="detailFromDate" value="${param.detailFromDate}">
                                        <label for="detailToDate">Đến ngày:</label>
                                        <input type="date" id="detailToDate" name="detailToDate" value="${param.detailToDate}">
                                        <label for="detailFieldId">Sân:</label>
                                        <select id="detailFieldId" name="detailFieldId">
                                            <option value="">Tất cả</option>
                                            <c:forEach var="f" items="${fields}">
                                                <option value="${f.field_id}" <c:if test="${param.detailFieldId == f.field_id}">selected</c:if>>${f.field_name}</option>
                                            </c:forEach>
                                        </select>
                                        <label for="detailStatus">Trạng thái:</label>
                                        <select id="detailStatus" name="detailStatus">
                                            <option value="">Tất cả</option>
                                            <option value="1" <c:if test="${param.detailStatus == '1'}">selected</c:if>>Đã thanh toán</option>
                                            <option value="0" <c:if test="${param.detailStatus == '0'}">selected</c:if>>Chờ thanh toán</option>
                                            <option value="-1" <c:if test="${param.detailStatus == '-1'}">selected</c:if>>Đã hủy</option>
                                        </select>
                                        <label for="detailUser">Người dùng:</label>
                                        <input type="text" id="detailUser" name="detailUser" value="${param.detailUser}" placeholder="Tên hoặc mã đơn">
                                        <button type="submit">Lọc</button>
                                    </form>
                                    <table class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>STT</th>
                                                <th>Tên người đặt</th>
                                                <th>Sân</th>
                                                <th>Ngày giờ đặt</th>
                                                <th>Thời lượng (phút)</th>
                                                <th>Tổng tiền</th>
                                                <th>Trạng thái</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${bookingDetails}" varStatus="loop">
                                                <tr>
                                                    <td>${(page-1)*pageSize + loop.index + 1}</td>
                                                    <td>${item.customer_name}</td>
                                                    <td>${item.field_name}</td>
                                                    <td>${item.slot_date} ${item.start_time} - ${item.end_time}</td>
                                                    <td>${item.duration}</td>
                                                    <td>${item.total_amount}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${item.status_pay == 1}">Đã thanh toán</c:when>
                                                            <c:when test="${item.status_pay == 0}">Chờ thanh toán</c:when>
                                                            <c:when test="${item.status_pay == -1}">Đã hủy</c:when>
                                                            <c:otherwise>Khác</c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <!-- Phân trang -->
                                    <nav aria-label="Page navigation example">
                                        <ul class="pagination">
                                            <c:if test="${page > 1}">
                                                <li class="page-item">
                                                    <a class="page-link" href="?page=${page-1}&pageSize=${pageSize}
                                                        &detailFromDate=${param.detailFromDate}
                                                        &detailToDate=${param.detailToDate}
                                                        &detailFieldId=${param.detailFieldId}
                                                        &detailStatus=${param.detailStatus}
                                                        &detailUser=${param.detailUser}">Previous</a>
                                                </li>
                                            </c:if>
                                            <c:forEach var="i" begin="1" end="${totalPages}">
                                                <li class="page-item <c:if test='${i == page}'>active</c:if>'">
                                                    <a class="page-link" href="?page=${i}&pageSize=${pageSize}
                                                        &detailFromDate=${param.detailFromDate}
                                                        &detailToDate=${param.detailToDate}
                                                        &detailFieldId=${param.detailFieldId}
                                                        &detailStatus=${param.detailStatus}
                                                        &detailUser=${param.detailUser}">${i}</a>
                                                </li>
                                            </c:forEach>
                                            <c:if test="${page < totalPages}">
                                                <li class="page-item">
                                                    <a class="page-link" href="?page=${page+1}&pageSize=${pageSize}
                                                        &detailFromDate=${param.detailFromDate}
                                                        &detailToDate=${param.detailToDate}
                                                        &detailFieldId=${param.detailFieldId}
                                                        &detailStatus=${param.detailStatus}
                                                        &detailUser=${param.detailUser}">Next</a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Báo cáo thông tin người dùng -->
                    <div class="row mt-3">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="header-title">👤 2. Báo cáo thông tin người dùng</h4>
                                </div>
                                <div class="card-body">
                                    <table class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>STT</th>
                                                <th>Họ tên</th>
                                                <th>Email/SĐT</th>
                                                <th>Số lượt đặt</th>
                                                <th>Tổng chi tiêu</th>
                                                <th>Ngày đăng ký</th>
                                                <th>Trạng thái tài khoản</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="u" items="${userReportList}" varStatus="loop">
                                                <tr>
                                                    <td>${(userPage-1)*userPageSize + loop.index + 1}</td>
                                                    <td>${u.full_name}</td>
                                                    <td>${u.email}<br/>${u.phone}</td>
                                                    <td>${u.booking_count}</td>
                                                    <td>${u.total_spent}</td>
                                                    <td>${u.created_at}</td>
                                                    <td>${u.status_name}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <!-- Phân trang người dùng -->
                                    <nav aria-label="User page navigation">
                                        <ul class="pagination">
                                            <c:if test="${userPage > 1}">
                                                <li class="page-item">
                                                    <a class="page-link" href="?userPage=${userPage-1}&userPageSize=${userPageSize}">Previous</a>
                                                </li>
                                            </c:if>
                                            <c:forEach var="i" begin="1" end="${totalUserPages}">
                                                <li class="page-item <c:if test='${i == userPage}'>active</c:if>'">
                                                    <a class="page-link" href="?userPage=${i}&userPageSize=${userPageSize}">${i}</a>
                                                </li>
                                            </c:forEach>
                                            <c:if test="${userPage < totalUserPages}">
                                                <li class="page-item">
                                                    <a class="page-link" href="?userPage=${userPage+1}&userPageSize=${userPageSize}">Next</a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Báo cáo tình trạng sử dụng từng sân -->
                    <div class="row mt-3">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="header-title">⚽ 3. Báo cáo tình trạng sử dụng từng sân</h4>
                                </div>
                                <div class="card-body">
                                    <table class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>STT</th>
                                                <th>Mã sân</th>
                                                <th>Tên sân</th>
                                                <th>Loại sân</th>
                                                <th>Số lượt đặt</th>
                                                <th>Tổng doanh thu</th>
                                                <th>Trạng thái sân</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="f" items="${fieldUsageReportList}" varStatus="loop">
                                                <tr>
                                                    <td>${(fieldPage-1)*fieldPageSize + loop.index + 1}</td>
                                                    <td>${f.field_id}</td>
                                                    <td>${f.field_name}</td>
                                                    <td>${f.field_type_name}</td>
                                                    <td>${f.booking_count}</td>
                                                    <td>${f.total_revenue}</td>
                                                    <td>${f.status}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <!-- Phân trang sân -->
                                    <nav aria-label="Field page navigation">
                                        <ul class="pagination">
                                            <c:if test="${fieldPage > 1}">
                                                <li class="page-item">
                                                    <a class="page-link" href="?fieldPage=${fieldPage-1}&fieldPageSize=${fieldPageSize}">Previous</a>
                                                </li>
                                            </c:if>
                                            <c:forEach var="i" begin="1" end="${totalFieldPages}">
                                                <li class="page-item <c:if test='${i == fieldPage}'>active</c:if>'">
                                                    <a class="page-link" href="?fieldPage=${i}&fieldPageSize=${fieldPageSize}">${i}</a>
                                                </li>
                                            </c:forEach>
                                            <c:if test="${fieldPage < totalFieldPages}">
                                                <li class="page-item">
                                                    <a class="page-link" href="?fieldPage=${fieldPage+1}&fieldPageSize=${fieldPageSize}">Next</a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Báo cáo doanh thu chi tiết -->
                    <div class="row mt-3">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="header-title">💵 4. Báo cáo doanh thu chi tiết</h4>
                                    <div class="text-muted small">Mục đích: Theo dõi tiền thu được từ từng đơn, từ người dùng nào, theo thời gian</div>
                                </div>
                                <div class="card-body">
                                    <table class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>STT</th>
                                                <th>Mã giao dịch</th>
                                                <th>Người thanh toán</th>
                                                <th>Ngày giờ</th>
                                                <th>Số tiền</th>
                                                <th>Phương thức thanh toán</th>
                                                <th>Ghi chú</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${detailedPayments}" varStatus="loop">
                                                <tr>
                                                    <td>${(detailedPaymentsPage-1)*detailedPaymentsPageSize + loop.index + 1}</td>
                                                    <td>${item.transaction_code}</td>
                                                    <td>${item.payer_name}</td>
                                                    <td>${item.pay_time}</td>
                                                    <td>${item.transfer_amount}</td>
                                                    <td>${item.gateway}</td>
                                                    <td>${item.description}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <!-- Phân trang doanh thu chi tiết -->
                                    <nav aria-label="Detailed payments page navigation">
                                        <ul class="pagination">
                                            <c:if test="${detailedPaymentsPage > 1}">
                                                <li class="page-item">
                                                    <a class="page-link" href="?detailedPaymentsPage=${detailedPaymentsPage-1}&detailedPaymentsPageSize=${detailedPaymentsPageSize}">Previous</a>
                                                </li>
                                            </c:if>
                                            <c:forEach var="i" begin="1" end="${detailedPaymentsTotalPages}">
                                                <li class="page-item <c:if test='${i == detailedPaymentsPage}'>active</c:if>'">
                                                    <a class="page-link" href="?detailedPaymentsPage=${i}&detailedPaymentsPageSize=${detailedPaymentsPageSize}">${i}</a>
                                                </li>
                                            </c:forEach>
                                            <c:if test="${detailedPaymentsPage < detailedPaymentsTotalPages}">
                                                <li class="page-item">
                                                    <a class="page-link" href="?detailedPaymentsPage=${detailedPaymentsPage+1}&detailedPaymentsPageSize=${detailedPaymentsPageSize}">Next</a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Báo cáo đặt sân theo thời gian -->
                    <div class="row mt-3">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="header-title">📅 5. Báo cáo đặt sân theo thời gian</h4>
                                    <div class="text-muted small">Thống kê hoạt động trong từng mốc thời gian cụ thể (7 ngày gần nhất)</div>
                                </div>
                                <div class="card-body">
                                    <h5 class="mt-3">Tổng số đơn đặt theo từng ngày</h5>
                                    <table class="table table-bordered table-striped">
                                        <thead><tr><th>Ngày</th><th>Số đơn đặt</th></tr></thead>
                                        <tbody>
                                        <c:forEach var="item" items="${bookingCountByDay7}">
                                            <tr>
                                                <td>${item.day}</td>
                                                <td>${item.booking_count}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                    <h5 class="mt-4">Tổng doanh thu theo từng ngày</h5>
                                    <table class="table table-bordered table-striped">
                                        <thead><tr><th>Ngày</th><th>Doanh thu</th></tr></thead>
                                        <tbody>
                                        <c:forEach var="item" items="${revenueByDay7}">
                                            <tr>
                                                <td>${item.day}</td>
                                                <td>${item.revenue}</td>
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