<%-- 
    Document   : lichsuChiTiet
    Created on : Jun 14, 2025, 5:34:08 PM
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
                                            <jsp:include page="toast.jsp" />
                                            <jsp:include page="sweetalert-include.jsp" />
                                            <jsp:include page="header_dashboard.jsp" />
                                            <!-- End Main Header -->
                                            <main id="main">
                                                <section class="profile-dashboard">
                                                    <div class="inner-header mb-40">
                                                        <h3 class="title">Lịch sử chi tiết của Mã đặt sân(BookingID): #${bookingId}</h3>
                                                        <p class="des">Dưới đây là danh sách chi tiết của mã đơn #${bookingId}</p>
                                                    </div>
                                                    <div class="my-booking-wrap ">
                                                        <ul class="booking-table-title flex-three">
                                                            <li>
                                                                <p>Ca sân</p>
                                                            </li>
                                                            <li>
                                                                <p>Ngày đặt</p>
                                                            </li>
                                                            <li>
                                                                <p>Thêm giờ</p>
                                                            </li>
                                                            <li>
                                                                <p>Trạng thái</p>
                                                            </li>
                                                            <li>
                                                                <p>Thành tiền</p>
                                                            </li>
                                                            <li>
                                                                <p>Ghi chú</p>
                                                            </li>
                                                            <li>
                                                                <p>Hành động</p>
                                                            </li>
                                                        </ul>

                                                        <c:forEach var="item" items="${details}">
                                                            <ul class="booking-table-content mb-60">
                                                                <li class="flex-three">
                                                                    <div class="booking-list flex-three">
                                                                        <div class="image">
                                                                            <img src="${item.imageUrl}" alt="Ảnh sân ${item.fieldName}">
                                                                        </div>
                                                                        <div class="content">
                                                                            <p class="id">BookingDetailsID: #${item.bookingDetailsId}</p>
                                                                            <h6 class="title-booking"><a href="#">${item.fieldName}</a></h6>
                                                                            <p style="font-weight: bold; background-color: #003147; color: white; padding: 10px; border-radius: 5px; text-align: center;">
                                                                                ${item.startTime} - ${item.endTime}
                                                                            </p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="booking-list-table">
                                                                        <p class="date-gues">${item.slotDate}</p>
                                                                    </div>
                                                                    <div class="booking-list-table">
                                                                        <div class="content">
                                                                            <h6 class="title-booking"><a href="#">${item.extraMinutes} phút</a></h6>
                                                                            <p class="price">${item.extraFee} vnđ</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="booking-list-table">
                                                                        <p class="status"
                                                                           style="font-weight: bold;
                                                                           background-color: ${item.statusId == 1 ? '#28a745' : (item.statusId == 2 ? '#ffc107' : (item.statusId == 3 ? '#6c757d' : 'transparent'))};
                                                                           color: white;
                                                                           padding: 6px 12px;
                                                                           border-radius: 5px;
                                                                           text-align: center;">
                                                                            ${item.statusName}
                                                                        </p>
                                                                    </div>

                                                                    <div class="booking-list-table">
                                                                        <p style="font-weight: bold; color: red;">${item.totalPrice} vnđ
                                                                        </p>
                                                                    </div>
                                                                    <div class="booking-list-table">
                                                                        <p class="date-gues">${item.note}</p>
                                                                    </div>
                                                                    <div class="flex-five action-wrap">


                                                                        <!-- Nút icon Hủy (nếu statusId == 1 nghĩa là 'Đã đặt') -->
                                                                        <div class="flex-five action-wrap">
                                                                            <c:if test="${item.statusId == 1}">
                                                                                <form id="cancel-form-${item.bookingDetailsId}" action="../huy-dat-san" method="post" style="display:none;">
                                                                                    <input type="hidden" name="bookingDetailsId" value="${item.bookingDetailsId}" />
                                                                                    <input type="hidden" name="bookingId" value="${bookingId}" />
                                                                                    <input type="hidden" name="page" value="${currentPage}" />

                                                                                </form>


                                                                                <div class="action flex-five">
                                                                                    <i class="icon-Vector-17" style="color:red; cursor:pointer;" title="Hủy ca"
                                                                                       onclick="showConfirmDialog('Bạn có chắc muốn hủy ca này?', function () {
                                                                                                       document.getElementById('cancel-form-${item.bookingDetailsId}').submit();
                                                                                                   })">
                                                                                    </i>

                                                                                </div>
                                                                            </div>

                                                                        </c:if>
                                                                </li>
                                                            </ul>

                                                        </c:forEach>

                                                        <c:if test="${empty details}">
                                                            <p>Không có ca nào được đặt của Mã đặt sân(BookingID): #${bookingId}</p>
                                                        </c:if>

                                                        <c:if test="${totalPages > 1}">
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <ul class="tf-pagination flex-five">

                                                                        <!-- Nút Previous -->
                                                                        <c:if test="${currentPage > 1}">
                                                                            <li>
                                                                                <a class="pages-link" href="../chi-tiet-dat-san?bookingId=${bookingId}&page=${currentPage - 1}">
                                                                                    <i class="icon-29"></i>
                                                                                </a>
                                                                            </li>
                                                                        </c:if>

                                                                        <!-- Các số trang -->
                                                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                                                            <li class="pages-item ${i == currentPage ? 'active' : ''}" aria-current="${i == currentPage ? 'page' : ''}">
                                                                                <a class="pages-link" href="../chi-tiet-dat-san?bookingId=${bookingId}&page=${i}">${i}</a>
                                                                            </li>
                                                                        </c:forEach>

                                                                        <!-- Nút Next -->
                                                                        <c:if test="${currentPage < totalPages}">
                                                                            <li>
                                                                                <a class="pages-link" href="../chi-tiet-dat-san?bookingId=${bookingId}&page=${currentPage + 1}">
                                                                                    <i class="icon--1"></i>
                                                                                </a>
                                                                            </li>
                                                                        </c:if>

                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </c:if>
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
