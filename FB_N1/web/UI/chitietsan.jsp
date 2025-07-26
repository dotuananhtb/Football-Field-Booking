<%@page import="model.UserProfile"%>
<%@page import="model.Account"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">

    <head>
        <meta charset="utf-8">
            <base href="${pageContext.request.contextPath}/UI/">
                <title>Danh sách chi tiết sân - FootBall Star</title>

                <meta name="author" content="themesflat.com">
                    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

                        <link rel="stylesheet" href="app/css/app.css">
                            <link rel="stylesheet" href="app/css/map.min.css">
                                <link rel="stylesheet" href="app/css/jquery.fancybox.min.css">

                                    <!-- Favicon and Touch Icons  -->
                                    <link rel="shortcut icon" href="assets/images/logoKoChu.png">

                                    <link rel="apple-touch-icon-precomposed" href="assets/images/logoKoChu.png">


                                            <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css' rel='stylesheet' />
                                            <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js'></script>
                                            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

                                            <% Account account = (Account) session.getAttribute("account");
                                                UserProfile userProfile = (account != null)
                                                        ? account.getUserProfile() : null;%>

                                            <script>
                                                window.accountId = <%= (account != null) ? account.getAccountId() : -1%>;
                                                window.roleId = <%= (userProfile != null) ? userProfile.getRoleId() : -1%>;
                                            </script>
                                            <script src="app/js/calendarBooking.js"></script>
                                            <style>
                                                /* Tổng thể lịch */
                                                #calendar {
                                                    width: 100%;
                                                    max-height: 600px;
                                                    overflow-y: auto;
                                                    background: #fff;
                                                    border-radius: 10px;
                                                    border: 1px solid #ddd;
                                                    padding: 10px;
                                                    box-shadow: 0 0 8px rgba(0, 0, 0, 0.05);
                                                }

                                                /* Ô ngày */
                                                .fc .fc-daygrid-day {
                                                    min-height: 80px; /* cao hơn 1 chút để cân đối */
                                                    padding: 4px;
                                                    border: 1px solid #eee;
                                                    vertical-align: top;
                                                }

                                                /* Số ngày */
                                                .fc .fc-daygrid-day-number {
                                                    font-size: 13px;
                                                    font-weight: 600;
                                                    color: #333;
                                                    padding: 2px 4px;
                                                }

                                                /* Sự kiện */
                                                .fc-event {   /* Cho phép xuống dòng */
                                                    text-overflow: unset !important;    /* Không cắt text */
                                                    overflow: visible !important;       /* Hiển thị toàn bộ */
                                                    display: block !important;          /* Mỗi event là 1 dòng */
                                                    font-size: 13px;
                                                    padding: 2px 4px;
                                                    margin: 2px 0;
                                                    border-radius: 5px;
                                                    background-color: #e6f5f0;
                                                    color: #1a7f5a;
                                                }

                                                /* Tiêu đề sự kiện */
                                                .fc-event-title {
                                                    white-space: normal !important;
                                                    font-weight: 500;
                                                    font-size: 11px;
                                                    overflow: hidden;
                                                    text-overflow: ellipsis;
                                                    white-space: nowrap;
                                                }

                                                /* Tooltip khi hover sự kiện (nếu có) */
                                                .fc-event:hover {
                                                    background-color: #cceee0;
                                                    cursor: pointer;
                                                }

                                                .booking-form {
                                                    background-color: #f9f9f9;
                                                    padding: 20px 25px;
                                                    border-radius: 10px;
                                                    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
                                                }

                                                .booking-form h5.form-title {
                                                    font-size: 20px;
                                                    font-weight: 600;
                                                    margin-bottom: 15px;
                                                    color: #333;
                                                }

                                                #selectedSlotsTable {
                                                    background-color: #fff;
                                                    border-collapse: collapse;
                                                    width: 100%;
                                                    border-radius: 8px;
                                                    overflow: hidden;
                                                    margin-bottom: 15px;
                                                }

                                                #selectedSlotsTable th,
                                                #selectedSlotsTable td {
                                                    text-align: center;
                                                    padding: 10px;
                                                    font-size: 14px;
                                                    border: 1px solid #e0e0e0;
                                                }

                                                #selectedSlotsTable th {
                                                    background-color: #f1f1f1;
                                                    font-weight: bold;
                                                }

                                                #selectedSlotsTable .btn-danger {
                                                    padding: 5px 12px;
                                                    font-size: 13px;
                                                    border-radius: 5px;
                                                }

                                                #totalPrice {
                                                    font-size: 16px;
                                                    text-align: right;
                                                    color: #2d2d2d;
                                                }

                                                #bookNowBtn {
                                                    background-color: #63ba7b;
                                                    color: #fff;
                                                    font-weight: 600;
                                                    padding: 10px;
                                                    font-size: 16px;
                                                    border: none;
                                                    border-radius: 8px;
                                                    transition: background-color 0.3s ease;
                                                }

                                                #bookNowBtn:hover {
                                                    background-color: #4ea467;
                                                }
                                                @media (max-width: 768px) {
                                                    /* Giao diện lịch gọn hơn */
                                                    #calendar {
                                                        padding: 10px;
                                                        font-size: 12px;
                                                    }

                                                    .fc .fc-toolbar-title {
                                                        font-size: 16px;
                                                        text-align: center;
                                                    }

                                                    .fc .fc-toolbar.fc-header-toolbar {
                                                        flex-wrap: wrap;
                                                        justify-content: center;
                                                        gap: 10px;
                                                    }


                                                    .fc .fc-daygrid-day-number {
                                                        font-size: 12px;
                                                        padding: 2px 5px;
                                                    }

                                                    /* Các slot trong ngày hiển thị gọn */
                                                    .fc-event {
                                                        font-size: 10px;
                                                        padding: 2px 4px;
                                                        border-radius: 5px;
                                                        margin: 1px 0;
                                                        white-space: nowrap;
                                                        overflow: hidden;
                                                        text-overflow: ellipsis;
                                                        background-color: #e2f7f0;
                                                        color: #146c43;
                                                    }
                                                }
                                                @media (max-width: 768px) {
                                                    #selectedSlotsTable th,
                                                    #selectedSlotsTable td {
                                                        font-size: 12px;
                                                        padding: 6px 8px;
                                                        white-space: nowrap;
                                                    }

                                                    #selectedSlotsTable {
                                                        font-size: 12px;
                                                        overflow-x: auto;
                                                        display: block;
                                                    }

                                                    #totalPrice {
                                                        font-size: 14px;
                                                        text-align: center;
                                                    }

                                                    #bookNowBtn {
                                                        font-size: 14px;
                                                        padding: 8px;
                                                    }
                                                }
                                                .feature {
                                                    background-color: #09cc53 !important;
                                                }

                                            </style>
                                            </head>

                                            <body class="body header-fixed ">

                                                <div class="preload preload-container">
                                                    <svg class="pl" width="240" height="240" viewBox="0 0 240 240">
                                                        <circle class="pl__ring pl__ring--a" cx="120" cy="120" r="105" fill="none" stroke="#000" stroke-width="20"
                                                                stroke-dasharray="0 660" stroke-dashoffset="-330" stroke-linecap="round"></circle>
                                                        <circle class="pl__ring pl__ring--b" cx="120" cy="120" r="35" fill="none" stroke="#000" stroke-width="20"
                                                                stroke-dasharray="0 220" stroke-dashoffset="-110" stroke-linecap="round"></circle>
                                                        <circle class="pl__ring pl__ring--c" cx="85" cy="120" r="70" fill="none" stroke="#000" stroke-width="20"
                                                                stroke-dasharray="0 440" stroke-linecap="round"></circle>
                                                        <circle class="pl__ring pl__ring--d" cx="155" cy="120" r="70" fill="none" stroke="#000" stroke-width="20"
                                                                stroke-dasharray="0 440" stroke-linecap="round"></circle>
                                                    </svg>
                                                </div>

                                                <!-- /preload -->

                                                <div id="wrapper">
                                                    <div id="pagee" class="clearfix">

                                                        <!-- Main Header -->
                                                        <jsp:include page="header.jsp" />
                                                        <!-- End Main Header -->
                                                        <main id="main">

                                                            <section class="breadcumb-section">
                                                                <div class="tf-container">
                                                                    <div class="row">
                                                                        <div class="col-lg-12 center z-index1">
                                                                            <h1 class="title">Danh Sách chi tiết Sân</h1>
                                                                            <ul class="breadcumb-list flex-five">
                                                                                <li><a href="/FB_N1/home">Trang chủ</a></li>
                                                                                <li><a href="/FB_N1/Danh-Sach-San">Danh sách sân</a></li>
                                                                                <li><span>Danh sách chi tiết sân</span></li>
                                                                            </ul>
                                                                            <img class="bcrumb-ab" src="./assets/images/page/mask-bcrumb.png" alt="">
                                                                        </div>
                                                                    </div>

                                                                </div>
                                                            </section>
                                                            <section class="tour-single">
                                                                <div class="container mt-5">
                                                                    <div class="row">
                                                                        <div class="col-lg-12">
                                                                            <ul class="nav nav-fill tab-tour-single" id="pills-tab" role="tablist">
                                                                                <li class="nav-item" role="presentation">
                                                                                    <button class="nav-link active" id="pills-information-tab" data-bs-toggle="pill"
                                                                                            data-bs-target="#pills-information" type="button" role="tab"
                                                                                            aria-controls="pills-information" aria-selected="true"><i
                                                                                            class="icon-Vector-51"></i> Thông tin sân bóng</button>
                                                                                </li>
<!--                                                                                <li class="nav-item" role="presentation">
                                                                                    <button class="nav-link" id="pills-shot-gallery-tab" data-bs-toggle="pill"
                                                                                            data-bs-target="#pills-shot-gallery" type="button" role="tab"
                                                                                            aria-controls="pills-shot-gallery" aria-selected="false"><i
                                                                                            class="icon-image-gallery-1"></i> Ảnh sân bóng</button>
                                                                                </li>-->
                                                                                <li class="nav-item" role="presentation">
                                                                                    <button class="nav-link" id="pills-booking-tab" data-bs-toggle="pill"
                                                                                            data-bs-target="#pills-booking" type="button" role="tab"
                                                                                            aria-controls="pills-booking" aria-selected="false"><i
                                                                                            class="icon-map-1"></i> Đặt sân Bóng </button>
                                                                                </li>
                                                                            </ul>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row pd-main">
                                                                        <div class="col-lg-12">
                                                                            <div class="tab-content" id="pills-tabContent">
                                                                                <div class="tab-pane fade show active" id="pills-information" role="tabpanel"
                                                                                     aria-labelledby="pills-information-tab" tabindex="0">
                                                                                    <div class="row mb-50">
                                                                                        <div class="col-lg-12">
                                                                                            <div class="inner-heading-wrap flex-two">
                                                                                                <div class="inner-heading">
                                                                                                    <span class="feature">${field.status}</span>
                                                                                                    <h2 class="title">${field.fieldName}</h2>
                                                                                                    <ul class="flex-three list-wrap-heading">
                                                                                                        <li class="flex-three">
                                                                                                            <i class="icon-time-left"></i>
                                                                                                            <span> Số ca: ${totalSlots}</span>
                                                                                                        </li>
                                                                                                        <li class="flex-three">
                                                                                                            <i class="icon-user"></i>
                                                                                                            <span>Loại sân: ${field.typeOfField.fieldTypeName}</span>
                                                                                                        </li>
                                                                                                        <li class="flex-three">
                                                                                                            <i class="icon-18"></i>
                                                                                                            <span>Địa diểm: ${field.zone.address}</span>
                                                                                                        </li>
                                                                                                        <li class="flex-three">
                                                                                                            <i class="icon-Layer-19"></i>
                                                                                                            <span>Khu vực: ${field.zone.zone_name}</span>
                                                                                                        </li>
                                                                                                    </ul>

                                                                                                </div>
                                                                                                <div class="inner-price">
                                                                                                    <p class="price-sale text-main">
                                                                                                        <c:choose>
                                                                                                            <c:when test="${minPrice == 0}">
                                                                                                                đ
                                                                                                            </c:when>
                                                                                                            <c:otherwise>
                                                                                                                <fmt:formatNumber value="${minPrice}" pattern="#,###" /> đ
                                                                                                            </c:otherwise>
                                                                                                        </c:choose>
                                                                                                        -
                                                                                                        <c:choose>
                                                                                                            <c:when test="${maxPrice == 0}">
                                                                                                                đ
                                                                                                            </c:when>
                                                                                                            <c:otherwise>
                                                                                                                <fmt:formatNumber value="${maxPrice}" pattern="#,###" /> đ
                                                                                                            </c:otherwise>
                                                                                                        </c:choose>
                                                                                                    </p>
                                                                                                </div>

                                                                                            </div>

                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="row mb-40 image-gallery-single">
                                                                                        <div class="col-12 col-sm-8">
                                                                                            <img src="${field.image}" alt="Image Listing">
                                                                                        </div>
                                                                                        <div class="col-12 col-sm-4">
                                                                                            <div class="side-bar-right">
                                                                                                <div class="sidebar-widget">
                                                                                                    <h6 class="block-heading">Đặt sân bóng với sự tự tin</h6>
                                                                                                    <ul class="category-confidence">
                                                                                                        <li class="flex-three">
                                                                                                            <i class="icon-customer-service-1"></i>
                                                                                                            <span>Hỗ trợ đặt sân 24/7</span>
                                                                                                        </li>
                                                                                                        <li class="flex-three">
                                                                                                            <i class="icon-Vector-6"></i>
                                                                                                            <span>Đảm bảo giá tốt nhất, không rắc rối</span>
                                                                                                        </li>
                                                                                                        <li class="flex-three">
                                                                                                            <i class="icon-insurance-1"></i>
                                                                                                            <span>Đặt sân an toàn, bảo đảm, uy tín</span>
                                                                                                        </li>
                                                                                                        <li class="flex-three">
                                                                                                            <i class="icon-price-tag-1-1"></i>
                                                                                                            <span>Sân bóng đạt tiêu chuẩn</span>
                                                                                                        </li>
                                                                                                    </ul>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="row">
                                                                                        <div class="col-lg-8">
                                                                                            <div class="information-content-tour">
                                                                                                <div class="description-wrap mb-40">
                                                                                                    <span class="description">Description:</span>
                                                                                                    <p class="des">${field.description}</p>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>

                                                                                </div>
<!--                                                                                <div class="tab-pane fade" id="pills-shot-gallery" role="tabpanel"
                                                                                     aria-labelledby="pills-shot-gallery-tab" tabindex="0">
                                                                                    <div class="row">
                                                                                        <div class="col-lg-8">
                                                                                            <div class="gallery-content-tour">
                                                                                                <div class="image-gallery1 image">
                                                                                                    <img src="./assets/images/gallery/gallery.jpg" alt="image"
                                                                                                         class="item1">
                                                                                                </div>

                                                                                                <div class="image-gallery2 image">
                                                                                                    <img src="./assets/images/gallery/gallery2.jpg" alt="image"
                                                                                                         class="item2">
                                                                                                </div>

                                                                                                <div class="image-gallery3 image">
                                                                                                    <img src="./assets/images/gallery/gallery3.jpg" alt="image"
                                                                                                         class="item1">
                                                                                                </div>


                                                                                            </div>

                                                                                        </div>
                                                                                        <div class="col-lg-4">
                                                                                            <div class="side-bar-right">
                                                                                                <div class="sidebar-widget">
                                                                                                    <h6 class="block-heading">Đặt sân bóng với sự tự tin</h6>
                                                                                                    <ul class="category-confidence">
                                                                                                        <li class="flex-three">
                                                                                                            <i class="icon-customer-service-1"></i>
                                                                                                            <span>Hỗ trợ đặt sân 24/7</span>
                                                                                                        </li>
                                                                                                        <li class="flex-three">
                                                                                                            <i class="icon-Vector-6"></i>
                                                                                                            <span>Đảm bảo giá tốt nhất, không rắc rối</span>
                                                                                                        </li>
                                                                                                        <li class="flex-three">
                                                                                                            <i class="icon-insurance-1"></i>
                                                                                                            <span>Đặt sân an toàn, bảo đảm, uy tín</span>
                                                                                                        </li>
                                                                                                        <li class="flex-three">
                                                                                                            <i class="icon-price-tag-1-1"></i>
                                                                                                            <span>Sân bóng đạt tiêu chuẩn</span>
                                                                                                        </li>
                                                                                                    </ul>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>

                                                                                </div>-->
                                                                                <div class="tab-pane fade" id="pills-booking" role="tabpanel" aria-labelledby="pills-booking-tab">
                                                                                    <div class="row">
                                                                                        <!-- Cột trái: Lịch -->
                                                                                        <div class="col-lg-8">
                                                                                            <input type="hidden" id="fieldSelect" value="${field.fieldId}" />
                                                                                            <h4 class="form-title text-center mb-4">
                                                                                                <i class="fas fa-calendar-alt"></i> Lịch đặt sân: ${field.fieldName}
                                                                                            </h4>
                                                                                            <div id="calendar-wrapper"
                                                                                                 style="background: #fff; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); padding: 20px;">
                                                                                                <div id="calendar"></div>
                                                                                            </div>
                                                                                        </div>

                                                                                        <!-- Cột phải: Form -->
                                                                                        <div class="col-lg-4">
                                                                                            <div class="booking-form">
                                                                                                <h5 class="form-title mb-3">Đặt sân</h5>
                                                                                                <div class="table-responsive">
                                                                                                    <table id="selectedSlotsTable" class="table table-bordered mb-3"
                                                                                                           style="display:none;">
                                                                                                        <thead>
                                                                                                            <tr>
                                                                                                                <th>Ngày</th>
                                                                                                                <th>Khung giờ</th>
                                                                                                                <th>Giá</th>
                                                                                                                <th>Xóa</th>
                                                                                                            </tr>
                                                                                                        </thead>
                                                                                                        <tbody></tbody>
                                                                                                    </table>
                                                                                                </div>
                                                                                                <div id="totalPrice" class="text-end fw-bold mb-3"
                                                                                                     style="display:none;">
                                                                                                    Tổng tiền: <span id="totalPriceValue">0₫</span>
                                                                                                </div>

                                                                                                <button id="bookNowBtn" class="btn btn-success w-100">
                                                                                                    <i class="fas fa-calendar-check"></i> Đặt sân ngay
                                                                                                </button>
                                                                                            </div>
                                                                                            <div class="side-bar-right">
                                                                                                <div class="sidebar-widget">
                                                                                                    <h6 class="block-heading">Đặt sân bóng với sự tự tin</h6>
                                                                                                    <ul class="category-confidence">
                                                                                                        <li class="flex-three">
                                                                                                            <i class="icon-customer-service-1"></i>
                                                                                                            <span>Hỗ trợ đặt sân 24/7</span>
                                                                                                        </li>
                                                                                                        <li class="flex-three">
                                                                                                            <i class="icon-Vector-6"></i>
                                                                                                            <span>Đảm bảo giá tốt nhất, không rắc rối</span>
                                                                                                        </li>
                                                                                                        <li class="flex-three">
                                                                                                            <i class="icon-insurance-1"></i>
                                                                                                            <span>Đặt sân an toàn, bảo đảm, uy tín</span>
                                                                                                        </li>
                                                                                                        <li class="flex-three">
                                                                                                            <i class="icon-price-tag-1-1"></i>
                                                                                                            <span>Sân bóng đạt tiêu chuẩn</span>
                                                                                                        </li>
                                                                                                    </ul>
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
                                                        </main>
                                                        <jsp:include page="footer.jsp" />
                                                        <!-- Bottom -->
                                                    </div>
                                                    <!-- /#page -->
                                                </div>

                                                <!-- Modal Popup Bid -->

                                                <a id="scroll-top" class="button-go"></a>

                                                <script src="app/js/jquery.min.js"></script>
                                                <script src="app/js/jquery.nice-select.min.js"></script>
                                                <script src="app/js/bootstrap.min.js"></script>

                                                <script src="app/js/swiper-bundle.min.js"></script>
                                                <script src="app/js/swiper.js"></script>
                                                <script src="app/js/plugin.js"></script>
                                                <script src="app/js/jquery.fancybox.js"></script>
                                                <script src="app/js/map.min.js"></script>
                                                <script src="app/js/map.js"></script>
                                                <script src="app/js/shortcodes.js"></script>
                                                <script src="app/js/main.js"></script>
                                                <script>
                                                document.querySelector('button[data-bs-target="#pills-booking"]')
                                                        .addEventListener('shown.bs.tab', function () {
                                                            console.log('Tab shown');
                                                            calendar.render();
                                                        });
                                                </script>

                                            </body>

                                            </html>
