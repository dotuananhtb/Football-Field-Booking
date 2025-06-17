<%-- 
    Document   : lichsuDatSan
    Created on : Jun 14, 2025, 1:16:42 PM
    Author     : Đỗ Tuấn Anh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">

    <head>

        <meta charset="utf-8">
            <base href="${pageContext.request.contextPath}/UI/">

                <title>Lịch sử đặt sân - FootBallStar</title>

                <meta name="author" content="themesflat.com">
                    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

                        <link rel="stylesheet" href="app/css/app.css">
                            <link rel="stylesheet" href="app/css/map.min.css">


                                <!-- comment -->
                                <link rel="shortcut icon" href="assets/images/logoKoChu.png">
                                    <link rel="apple-touch-icon-precomposed" href="assets/images/logoKoChu.png">
                                        </head>
                                        <style>
                                            /* ========== Container Tổng ========== */
                                            .my-booking-wrap {
                                                width: 100%;
                                                max-width: 1200px;
                                                margin: 0 auto;
                                                padding: 32px 16px;
                                                font-family: 'Segoe UI', sans-serif;
                                            }

                                            /* ========== Header ========== */
                                            .booking-table-header {
                                                display: flex;
                                                flex-wrap: nowrap;
                                                background-color: #0d1b2a;
                                                color: #fff;
                                                border-radius: 8px 8px 0 0;
                                                font-weight: 600;
                                                padding: 14px 20px;
                                                text-align: center;
                                                font-size: 15px;
                                                align-items: center;
                                            }

                                            .booking-table-header li {
                                                flex: 1;
                                                padding: 8px 0;
                                                display: flex;
                                                align-items: center;
                                                justify-content: center;
                                                min-height: 40px;
                                            }

                                            /* ========== Dòng dữ liệu booking ========== */
                                            .booking-table-row {
                                                background-color: #fff;
                                                margin-bottom: 12px;
                                                border-radius: 0 0 8px 8px;
                                                box-shadow: 0 2px 8px rgba(0,0,0,0.05);
                                                overflow: hidden;
                                                transition: box-shadow 0.2s;
                                            }

                                            .booking-table-row:hover {
                                                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                                            }

                                            /* Một dòng dữ liệu: dạng flex */
                                            .booking-table-row > li {
                                                display: flex;
                                                flex-wrap: nowrap;
                                                padding: 14px 20px;
                                                align-items: center;
                                                border-top: 1px solid #f0f0f0;
                                                text-align: center;
                                            }

                                            .booking-table-row > li > div {
                                                flex: 1;
                                                padding: 8px 0;
                                                display: flex;
                                                align-items: center;
                                                justify-content: center;
                                                min-height: 40px;
                                            }

                                            /* ========== Cell chung cho cả header + row ========== */
                                            .booking-table-cell {
                                                word-break: break-word;
                                                overflow-wrap: break-word;
                                                hyphens: auto;
                                            }

                                            /* STT */
                                            .booking-table-cell:nth-child(1),
                                            .booking-table-header li:nth-child(1) {
                                                text-align: center;
                                                justify-content: center;
                                            }

                                            /* Mã đơn đặt */
                                            .booking-table-cell:nth-child(2),
                                            .booking-table-header li:nth-child(2) {
                                                text-align: center;
                                                justify-content: center;
                                            }

                                            /* Thời gian đặt */
                                            .booking-table-cell:nth-child(3),
                                            .booking-table-header li:nth-child(3) {
                                                text-align: center;
                                                justify-content: center;
                                            }

                                            /* Giảm giá */
                                            .booking-table-cell:nth-child(4),
                                            .booking-table-header li:nth-child(4) {
                                                text-align: center;
                                                justify-content: center;
                                            }

                                            /* Tổng thanh toán */
                                            .booking-table-cell:nth-child(5),
                                            .booking-table-header li:nth-child(5) {
                                                text-align: center;
                                                justify-content: center;
                                            }

                                            /* Cột hành động: icon */
                                            .booking-table-cell:nth-child(6),
                                            .booking-table-header li:nth-child(6),
                                            .booking-table-cell.action-wrap {
                                                text-align: center;
                                                justify-content: center;
                                            }

                                            .booking-table-cell.action-wrap a i {
                                                font-size: 18px;
                                                color: #007bff;
                                                transition: transform 0.2s ease;
                                            }

                                            .booking-table-cell.action-wrap a:hover i {
                                                transform: scale(1.2);
                                            }

                                            /* ========== Text formatting ========== */
                                            .status {
                                                font-weight: 600;
                                                color: #2e7d32;
                                            }

                                            .date-gues {
                                                font-size: 14px;
                                                color: #333;
                                                margin: 0;
                                            }

                                            .booking-table-cell p {
                                                margin: 0;
                                                text-align: center;
                                            }

                                            .booking-table-cell p[style*="color: red"] {
                                                color: #d32f2f !important;
                                                font-weight: 700;
                                            }

                                            /* ========== Phân trang ========== */
                                            .tf-pagination {
                                                list-style: none;
                                                display: flex;
                                                justify-content: center;
                                                padding-left: 0;
                                                margin-top: 32px;
                                                gap: 10px;
                                            }

                                            .tf-pagination li a.pages-link {
                                                display: inline-block;
                                                padding: 8px 14px;
                                                background: #e3f2fd;
                                                border-radius: 6px;
                                                color: #333;
                                                font-weight: 500;
                                                text-decoration: none;
                                                transition: all 0.2s;
                                            }

                                            .tf-pagination li a.pages-link:hover {
                                                background-color: #90caf9;
                                            }

                                            .tf-pagination li.active a {
                                                background: #1565c0;
                                                color: white;
                                            }

                                            /* ========== Responsive ========== */
                                            @media (max-width: 768px) {
                                                .booking-table-header {
                                                    display: none; /* Ẩn header trên mobile */
                                                }

                                                .booking-table-row > li {
                                                    display: block; /* Chuyển về block layout */
                                                    text-align: left;
                                                }

                                                .booking-table-cell {
                                                    display: flex;
                                                    justify-content: space-between;
                                                    align-items: center;
                                                    padding: 12px 0;
                                                    border-bottom: 1px solid #f0f0f0;
                                                    text-align: left;
                                                }

                                                .booking-table-cell:last-child {
                                                    border-bottom: none;
                                                }

                                                /* Thêm label cho mobile */
                                                .booking-table-cell:nth-child(1)::before {
                                                    content: "STT: ";
                                                    font-weight: bold;
                                                }
                                                .booking-table-cell:nth-child(2)::before {
                                                    content: "Mã đơn: ";
                                                    font-weight: bold;
                                                }
                                                .booking-table-cell:nth-child(3)::before {
                                                    content: "Thời gian: ";
                                                    font-weight: bold;
                                                }
                                                .booking-table-cell:nth-child(4)::before {
                                                    content: "Giảm giá: ";
                                                    font-weight: bold;
                                                }
                                                .booking-table-cell:nth-child(5)::before {
                                                    content: "Tổng tiền: ";
                                                    font-weight: bold;
                                                }
                                                .booking-table-cell:nth-child(6)::before {
                                                    content: "Chi tiết: ";
                                                    font-weight: bold;
                                                }

                                                .booking-table-cell.action-wrap {
                                                    justify-content: flex-start;
                                                }
                                            }

                                            /* Đảm bảo bảng full width */
                                            .my-booking-wrap {
                                                display: flex;
                                                flex-direction: column;
                                            }

                                            .booking-table-header,
                                            .booking-table-row > li {
                                                width: 100%;
                                            }

                                            @media (max-width: 1024px) {
                                                .booking-table-header li,
                                                .booking-table-row > li > div {
                                                    font-size: 14px;
                                                }
                                            }/* ========== Container Tổng ========== */
                                            .my-booking-wrap {
                                                width: 100%;
                                                max-width: 1200px;
                                                margin: 0 auto;
                                                padding: 32px 16px;
                                                font-family: 'Segoe UI', sans-serif;
                                                display: flex;
                                                flex-direction: column;
                                            }

                                            /* ========== Header ========== */
                                            .booking-table-header {
                                                display: flex;
                                                flex-wrap: nowrap;
                                                background-color: #0d1b2a;
                                                color: #fff;
                                                border-radius: 8px 8px 0 0;
                                                font-weight: 600;
                                                padding: 14px 20px;
                                                text-align: center;
                                                font-size: 15px;
                                                align-items: center;
                                            }

                                            .booking-table-header li {
                                                flex: 1;
                                                padding: 8px 0;
                                                display: flex;
                                                align-items: center;
                                                justify-content: center;
                                                min-height: 40px;
                                            }

                                            /* ========== Dòng dữ liệu booking ========== */
                                            .booking-table-row {
                                                background-color: #fff;
                                                margin-bottom: 12px;
                                                border-radius: 0 0 8px 8px;
                                                box-shadow: 0 2px 8px rgba(0,0,0,0.05);
                                                overflow: hidden;
                                                transition: box-shadow 0.2s;
                                            }

                                            .booking-table-row:hover {
                                                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                                            }

                                            /* Một dòng dữ liệu: dạng flex */
                                            .booking-table-row > li {
                                                display: flex;
                                                flex-wrap: nowrap;
                                                padding: 14px 20px;
                                                align-items: center;
                                                border-top: 1px solid #f0f0f0;
                                                text-align: center;
                                            }

                                            .booking-table-row > li > div {
                                                flex: 1;
                                                padding: 8px 0;
                                                display: flex;
                                                align-items: center;
                                                justify-content: center;
                                                min-height: 40px;
                                            }

                                            /* ========== Cell chung cho cả header + row ========== */
                                            .booking-table-cell {
                                                word-break: break-word;
                                                overflow-wrap: break-word;
                                                hyphens: auto;
                                            }

                                            /* STT */
                                            .booking-table-cell:nth-child(1),
                                            .booking-table-header li:nth-child(1) {
                                                text-align: center;
                                                justify-content: center;
                                            }

                                            /* Mã đơn đặt */
                                            .booking-table-cell:nth-child(2),
                                            .booking-table-header li:nth-child(2) {
                                                text-align: center;
                                                justify-content: center;
                                            }

                                            /* Thời gian đặt */
                                            .booking-table-cell:nth-child(3),
                                            .booking-table-header li:nth-child(3) {
                                                text-align: center;
                                                justify-content: center;
                                            }

                                            /* Giảm giá */
                                            .booking-table-cell:nth-child(4),
                                            .booking-table-header li:nth-child(4) {
                                                text-align: center;
                                                justify-content: center;
                                            }

                                            /* Tổng thanh toán */
                                            .booking-table-cell:nth-child(5),
                                            .booking-table-header li:nth-child(5) {
                                                text-align: center;
                                                justify-content: center;
                                            }

                                            /* Cột hành động: icon */
                                            .booking-table-cell:nth-child(6),
                                            .booking-table-header li:nth-child(6),
                                            .booking-table-cell.action-wrap {
                                                text-align: center;
                                                justify-content: center;
                                            }

                                            .booking-table-cell.action-wrap a i {
                                                font-size: 18px;
                                                color: #007bff;
                                                transition: transform 0.2s ease;
                                            }

                                            .booking-table-cell.action-wrap a:hover i {
                                                transform: scale(1.2);
                                            }

                                            /* ========== Text formatting ========== */
                                            .status {
                                                font-weight: 600;
                                                color: #2e7d32;
                                            }

                                            .date-gues {
                                                font-size: 14px;
                                                color: #333;
                                                margin: 0;
                                            }

                                            .booking-table-cell p {
                                                margin: 0;
                                                text-align: center;
                                            }

                                            .booking-table-cell p[style*="color: red"] {
                                                color: #d32f2f !important;
                                                font-weight: 700;
                                            }

                                            /* ========== Phân trang ========== */
                                            .tf-pagination {
                                                list-style: none;
                                                display: flex;
                                                justify-content: center;
                                                align-items: center;
                                                padding-left: 0;
                                                margin: 32px auto 0;
                                                gap: 8px;
                                                max-width: 90%; /* Slightly shorter than the table */
                                                flex-wrap: nowrap; /* Ensure single line */
                                            }

                                            .tf-pagination li a.pages-link {
                                                display: inline-block;
                                                padding: 6px 12px; /* Slightly reduced padding for compactness */
                                                background: #e3f2fd;
                                                border-radius: 6px;
                                                color: #333;
                                                font-weight: 500;
                                                text-decoration: none;
                                                transition: all 0.2s;
                                                font-size: 14px; /* Smaller font for better fit */
                                                white-space: nowrap; /* Prevent text wrapping */
                                            }

                                            .tf-pagination li a.pages-link:hover {
                                                background-color: #90caf9;
                                            }

                                            .tf-pagination li.active a {
                                                background: #1565c0;
                                                color: white;
                                            }

                                            /* Styling for Next/Previous buttons */
                                            .tf-pagination li a.pages-link.prev,
                                            .tf-pagination li a.pages-link.next {
                                                padding: 6px 10px;
                                                font-size: 14px;
                                            }

                                            /* ========== Responsive ========== */
                                            @media (max-width: 768px) {
                                                .booking-table-header {
                                                    display: none; /* Ẩn header trên mobile */
                                                }

                                                .booking-table-row > li {
                                                    display: block; /* Chuyển về block layout */
                                                    text-align: left;
                                                }

                                                .booking-table-cell {
                                                    display: flex;
                                                    justify-content: space-between;
                                                    align-items: center;
                                                    padding: 12px 0;
                                                    border-bottom: 1px solid #f0f0f0;
                                                    text-align: left;
                                                }

                                                .booking-table-cell:last-child {
                                                    border-bottom: none;
                                                }

                                                /* Thêm label cho mobile */
                                                .booking-table-cell:nth-child(1)::before {
                                                    content: "STT: ";
                                                    font-weight: bold;
                                                }
                                                .booking-table-cell:nth-child(2)::before {
                                                    content: "Mã đơn: ";
                                                    font-weight: bold;
                                                }
                                                .booking-table-cell:nth-child(3)::before {
                                                    content: "Thời gian: ";
                                                    font-weight: bold;
                                                }
                                                .booking-table-cell:nth-child(4)::before {
                                                    content: "Giảm giá: ";
                                                    font-weight: bold;
                                                }
                                                .booking-table-cell:nth-child(5)::before {
                                                    content: "Tổng tiền: ";
                                                    font-weight: bold;
                                                }
                                                .booking-table-cell:nth-child(6)::before {
                                                    content: "Chi tiết: ";
                                                    font-weight: bold;
                                                }

                                                .booking-table-cell.action-wrap {
                                                    justify-content: flex-start;
                                                }

                                                /* Adjust pagination for mobile */
                                                .tf-pagination {
                                                    max-width: 100%; /* Full width on mobile */
                                                    gap: 6px;
                                                    overflow-x: auto; /* Allow horizontal scroll if needed */
                                                    padding: 0 10px;
                                                }

                                                .tf-pagination li a.pages-link {
                                                    padding: 5px 10px;
                                                    font-size: 13px;
                                                }
                                            }

                                            /* Đảm bảo bảng full width */
                                            .booking-table-header,
                                            .booking-table-row > li {
                                                width: 100%;
                                            }

                                            @media (max-width: 1024px) {
                                                .booking-table-header li,
                                                .booking-table-row > li > div {
                                                    font-size: 14px;
                                                }

                                                .tf-pagination {
                                                    max-width: 95%; /* Slightly wider but still shorter than table */
                                                    gap: 6px;
                                                }
                                            }
                                        </style>
                                        <body class="body header-fixed">

                                            <jsp:include page="header_dashboard.jsp" />
                                            <!-- End Main Header -->
                                            <main id="main">
                                                <section class="profile-dashboard">
                                                    <div class="inner-header mb-40">
                                                        <h3 class="title">Lịch sử đặt sân của bạn</h3>
                                                        <p class="des">Dưới đây là danh sách các lần bạn đặt sân</p>
                                                    </div>
                                                    <div class="my-booking-wrap">
                                                        <!-- Header -->
                                                        <ul class="booking-table-header">
                                                            <li class="booking-table-cell"><p>STT</p></li>
                                                            <li class="booking-table-cell"><p>Mã đơn đặt (BookingID)</p></li>
                                                            <li class="booking-table-cell"><p>Thời gian đặt</p></li>
                                                            <li class="booking-table-cell"><p>Giảm giá (nếu có)</p></li>
                                                            <li class="booking-table-cell"><p>Tổng thanh toán</p></li>
                                                            <li class="booking-table-cell"><p>Xem chi tiết</p></li>
                                                        </ul>

                                                        <!-- Danh sách Booking -->
                                                        <c:forEach var="booking" items="${bookingList}" varStatus="loop">
                                                            <ul class="booking-table-row mb-60">
                                                                <li class="flex-three">
                                                                    <!-- STT -->
                                                                    <div class="booking-table-cell flex-three">
                                                                        <p class="date-gues">
                                                                            <c:out value="${(currentPage - 1) * itemsPerPage + loop.index + 1}" />
                                                                        </p>
                                                                    </div>

                                                                    <!-- Mã đơn đặt -->
                                                                    <div class="booking-table-cell">
                                                                        <p class="date-gues">ID: #${booking.bookingId}</p>
                                                                    </div>

                                                                    <!-- Thời gian đặt -->
                                                                    <div class="booking-table-cell">
                                                                        <p class="date-gues">${booking.bookingDate}</p>
                                                                    </div>

                                                                    <!-- Giảm giá -->
                                                                    <div class="booking-table-cell">
                                                                        <p class="status">
                                                                            <c:choose>
                                                                                <c:when test="${saleMap[booking.bookingId] > 0}">
                                                                                    ${saleMap[booking.bookingId]}%
                                                                                </c:when>
                                                                                <c:otherwise>Không có</c:otherwise>
                                                                            </c:choose>
                                                                        </p>
                                                                    </div>

                                                                    <!-- Tổng thanh toán -->
                                                                    <div class="booking-table-cell">
                                                                        <p style="font-weight: bold; color: red;">${booking.totalAmount} vnđ</p>
                                                                    </div>

                                                                    <!-- Xem chi tiết -->
                                                                    <div class="booking-table-cell action-wrap">
                                                                        <div class="action flex-five">
                                                                            <a href="/FB_N1/chi-tiet-dat-san?bookingId=${booking.bookingId}">
                                                                                <i class="icon-Vector-21"></i>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </li>
                                                            </ul>
                                                        </c:forEach>

                                                        <!-- Nếu không có booking -->
                                                        <c:if test="${empty bookingList}">
                                                            <p>Không có đơn đặt sân nào.</p>
                                                        </c:if>

                                                        <!-- Phân trang -->
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <ul class="tf-pagination flex-five">
                                                                    <c:if test="${currentPage > 1}">
                                                                        <li>
                                                                            <a class="pages-link" href="../lich-su-dat-san?page=${currentPage - 1}">
                                                                                <i class="icon-29"></i>
                                                                            </a>
                                                                        </li>
                                                                    </c:if>
                                                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                                                        <li class="pages-item ${i == currentPage ? 'active' : ''}" aria-current="${i == currentPage ? 'page' : ''}">
                                                                            <a class="pages-link" href="../lich-su-dat-san?page=${i}">${i}</a>
                                                                        </li>
                                                                    </c:forEach>
                                                                    <c:if test="${currentPage < totalPages}">
                                                                        <li>
                                                                            <a class="pages-link" href="../lich-su-dat-san?page=${currentPage + 1}">
                                                                                <i class="icon--1"></i>
                                                                            </a>
                                                                        </li>
                                                                    </c:if>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </section>

                                            </main>



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