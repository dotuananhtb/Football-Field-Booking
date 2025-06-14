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

                                        <body class="body header-fixed">

                                            <jsp:include page="header_dashboard.jsp" />
                                            <!-- End Main Header -->
                                            <main id="main">
                                                <section class="profile-dashboard">
                                                    <div class="inner-header mb-40">
                                                        <h3 class="title">Lịch sử đặt sân của bạn</h3>
                                                        <p class="des">Dưới đây là danh sách các lần bạn đặt sân</p>
                                                    </div>
                                                    <div class="my-booking-wrap ">
                                                        <ul class="booking-table-title flex-three">
                                                            <li>
                                                                <p>Mã đơn đặt (BookingID)</p>
                                                            </li>
                                                            <li>
                                                                <p>Thời gian đặt</p>
                                                            </li>
                                                            <li>
                                                                <p>Giảm giá(nếu có)</p>
                                                            </li>
                                                            <li>
                                                                <p>Tổng thanh toán</p>
                                                            </li>

                                                            <li>
                                                                <p>Xem chi tiết</p>
                                                            </li>
                                                        </ul>
                                                        <!-- Danh sách Booking -->
                                                        <c:forEach var="booking" items="${bookingList}">
                                                            <ul class="booking-table-content mb-60">
                                                                <li class="flex-three">
                                                                    <!-- Mã đơn đặt -->
                                                                    <div class="booking-list flex-three">
                                                                        <p class="date-gues">ID: #${booking.bookingId}</p>
                                                                    </div>

                                                                    <!-- Thời gian đặt -->
                                                                    <div class="booking-list-table">
                                                                        <p class="date-gues">${booking.bookingDate}</p>
                                                                    </div>

                                                                    <!-- Giảm giá -->
                                                                    <div class="booking-list-table">
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
                                                                    <div class="booking-list-table">
                                                                        <p class="date-gues">${booking.totalAmount} vnđ</p>
                                                                    </div>

                                                                    <!-- Hành động -->
                                                                    <div class="flex-five action-wrap">
                                                                        <div class="action flex-five">
                                                                            <i class="icon-Vector-4"></i> <!-- Ví dụ icon xem -->
                                                                        </div>

                                                                        <!--<div class="action flex-five">-->
                                                                        <!--<i class="icon-Vector-17"></i>  -->
                                                                        <!--</div>-->

                                                                    </div>
                                                                </li>
                                                            </ul>
                                                        </c:forEach>


                                                        <!-- Nếu không có booking -->
                                                        <c:if test="${empty bookingList}">
                                                            <p>Không có đơn đặt sân nào.</p>
                                                        </c:if>
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <ul class="tf-pagination flex-five">

                                                                    <!-- Nút Previous -->
                                                                    <c:if test="${currentPage > 1}">
                                                                        <li>
                                                                            <a class="pages-link" href="../lich-su-dat-san?page=${currentPage - 1}">
                                                                                <i class="icon-29"></i>
                                                                            </a>
                                                                        </li>
                                                                    </c:if>

                                                                    <!-- Các số trang -->
                                                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                                                        <li class="pages-item ${i == currentPage ? 'active' : ''}" aria-current="${i == currentPage ? 'page' : ''}">
                                                                            <a class="pages-link" href="../lich-su-dat-san?page=${i}">${i}</a>
                                                                        </li>
                                                                    </c:forEach>

                                                                    <!-- Nút Next -->
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