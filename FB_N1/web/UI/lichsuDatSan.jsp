<%-- 
    Document   : lichsuDatSan
    Created on : Jun 14, 2025, 1:16:42 PM
    Author     : Đỗ Tuấn Anh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

                                <!-- Favicon and Touch Icons  -->
                                <link rel="shortcut icon" href="assets/images/favico.png">
                                    <link rel="apple-touch-icon-precomposed" href="assets/images/favico.png">

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
                                                        <ul class="booking-table-content mb-60">
                                                            <li class="flex-three">
                                                                <div class="booking-list flex-three">
                                                                    <p class="id">ID: #6</p>                                                                                                    
                                                                </div>

                                                                <div class="booking-list-table">
                                                                    <p class="date-gues">2025-06-14 10:56:51</p>
                                                                </div>
                                                                <div class="booking-list-table">
                                                                    <p class="status">Approved</p>
                                                                </div>
                                                                <div class="booking-list-table">
                                                                    <p class="price">360000.00 vnđ</p>
                                                                </div>

                                                                <div class="flex-five action-wrap">
                                                                    <div class="action flex-five">
                                                                        <i class="icon-Vector-16"></i>
                                                                    </div>
                                                                    <div class="action flex-five">
                                                                        <i class="icon-Vector-17"></i>
                                                                    </div>
                                                                </div>
                                                            </li>


                                                        </ul>
                                                        <div class="row">
                                                            <div class="col-md-12 ">
                                                                <ul class="tf-pagination flex-five">
                                                                    <li>
                                                                        <a class="pages-link" href="#"> <i class="icon-29"></i></a>
                                                                    </li>
                                                                    <li>
                                                                        <a class="pages-link" href="#">1</a>
                                                                    </li>
                                                                    <li class="pages-item active" aria-current="page">
                                                                        <a class="pages-link" href="#">2</a>
                                                                    </li>
                                                                    <li><a class="pages-link" href="#">3</a></li>
                                                                    <li>
                                                                        <a class="pages-link" href="#"><i class=" icon--1"></i></a>
                                                                    </li>
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