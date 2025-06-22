<%-- 
    Document   : newjsp
    Created on : Jun 15, 2025, 5:28:51 PM
    Author     : Đỗ Tuấn Anh
--%>

<%@page import="model.UserProfile"%>
<%@page import="model.Field"%>
<%@page import="java.util.List"%>
<%@page import="dao.FieldDAO"%>
<%@ page import="model.Account" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>FootBallStar - Quản lý đặt sân</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta
            content="A fully featured admin theme which can be used to build CRM, CMS, etc."
            name="description"
            />
        <meta content="Coderthemes" name="author" />
        <link href="assets/vendor/fullcalendar/main.min.css" rel="stylesheet">

        <!-- Them_1 sau App favicon -->
        <!-- App favicon -->
        <%@include file="head_only.jsp" %>
        <!-- End_Them_1 sau "App favicon" -->


    </head>



    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
        }
        /* Đảm bảo mọi bg-dark có chữ trắng */
        .fc-event.bg-dark,
        .fc-event.bg-dark .fc-event-time,
        .fc-event.bg-dark .fc-event-title {
            color: #fff !important;
        }

        /* Đảm bảo chỉ text-dark mới có chữ đen */
        .fc-event.text-dark {
            color: #212529 !important;
        }

        .fc-event.text-dark .fc-event-time,
        .fc-event.text-dark .fc-event-title {
            color: inherit !important;
        }



        #calendar-wrapper {
            position: relative;
            width: 100%;
            max-width: 1100px;
            margin: 0 auto;
            height:600px;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            display: flex;
            flex-direction: column;
        }

        /* Phần cố định chứa toolbar và col-header */
        .calendar-fixed-header {
            position: sticky;
            top: 0;
            background: white;
            z-index: 1000;
            border-bottom: 1px solid #ddd;
        }

        /* Scroll được phần nội dung bên dưới */
        .calendar-scrollable-body {
            flex: 1;
            overflow: auto;
            position: relative;
        }

        /* Lịch có thể cuộn ngang nếu nhiều cột */
        #calendar {
            min-width: 600px;
            padding: 10px;
        }


        #fieldSelect {
            display: block;
            margin: 20px auto;
            font-size: 16px;
            padding: 8px 12px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }



        .fc-event:hover {
            cursor: pointer;
            opacity: 0.85;
        }

        button#bookNowBtn {
            display: none; /* Ẩn ban đầu */
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button#bookNowBtn:hover {
            background-color: #218838;
        }

        #selectedSlotsTable {
            max-width: 1100px;
            margin: 20px auto;
            border-collapse: collapse;
            width: 100%;
        }

        #selectedSlotsTable th, #selectedSlotsTable td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }

        #selectedSlotsTable th {
            background-color: #f2f2f2;
        }

        #totalPrice {
            text-align: right;
            max-width: 1100px;
            margin: 10px auto;
            font-weight: bold;
            font-size: 18px;
        }
    </style>


    <body>

        <!-- Begin page -->
        <div class="wrapper">
            <!-- Them_2 sau "Topbar Start" -->
            <!-- ========== Topbar Start ========== -->
            <jsp:include page="topbar.jsp" />
            <!-- ========== Topbar End ========== -->
            <!-- End_Them_2 sau "Topbar End" -->
            <!-- Them_3 sau "Topbar Left Sidebar Start" -->
            <!-- ========== Left Sidebar Start ========== -->
            <jsp:include page="left_sidebar.jsp" />
            <!-- ========== Left Sidebar End ========== -->
            <!-- End_Them_3 sau "Topbar Left Sidebar Start" -->

            <!-- ============================================================== -->
            <!-- Start Page Content here -->
            <!-- ============================================================== -->

            <% Account acc = (Account) session.getAttribute("account");%>
            <script>
                const currentUsername = '<%= acc != null ? acc.getUsername() : "unknown"%>';
                const currentFullName = '<%= acc != null ? acc.getUserProfile().getFirstName() + " " + acc.getUserProfile().getLastName() : "unknown"%>';
            </script>


            <div class="content-page">
                <div class="content">

                    <!-- Start Content-->
                    <div class="container-fluid">

                        <!-- start page title -->
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
                                        <p>Dưới đây là lịch cho từng sân</p>
                                    </div>
                                    <h4 class="page-title">Quản lý đặt sân</h4>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <div class="row">
                            <div class="col-12">

                                <div class="card">
                                    <div class="card-body">
                                        <!-- comment -->
                                        <select id="fieldSelect">
                                            <option value="">-- Chọn sân --</option>
                                            <%
                                                FieldDAO fieldDAO = new FieldDAO();
                                                List<Field> fields = fieldDAO.getAllFields();
                                                for (Field field : fields) {
                                            %>
                                            <option value="<%= field.getFieldId()%>"><%= field.getFieldName()%></option>
                                            <% }%>
                                        </select>

                                        <div id="calendar-wrapper">
                                            <div class="calendar-fixed-header">
                                                <div class="fc-toolbar"></div>
                                                <div class="fc-col-header"></div>
                                            </div>

                                            <div class="calendar-scrollable-body">
                                                <div id="calendar"></div>
                                            </div>
                                        </div>

                                        <table id="selectedSlotsTable" class="table" style="display:none;">
                                            <thead>
                                                <tr>
                                                    <th>Ngày</th>
                                                    <th>Khung giờ</th>
                                                    <th>Giá</th>
                                                    <th>Ghi chú(SDT khách)</th>
                                                    <th>Hành động</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                        <div id="totalPrice" style="display:none; margin-top: 10px;">Tổng tiền: 0₫</div>

                                        <div style="text-align: center; margin-top: 20px;">
                                            <button id="bookNowBtn">Đặt sân</button>
                                        </div>
                                        <!--                                        <script src="assets/js/calendarBooking.js"></script>-->


                                        <!-- comment -->
                                    </div> <!-- end card body-->
                                </div> <!-- end card -->

                                <!-- Admin Modal -->
                                <!-- Modal Thông Tin Ca Sân -->
                                <!-- Modal xem chi tiết ca sân -->
                                <!-- Modal hiển thị tất cả thông tin slot + người đặt -->
                                <!-- Modal xem chi tiết slot -->
                                <div class="modal fade" id="event-modal" tabindex="-1" aria-hidden="true">
                                    <div class="modal-dialog modal-lg modal-dialog-centered">
                                        <div class="modal-content shadow rounded-3">
                                            <div class="modal-header bg-success text-white rounded-top">
                                                <h5 class="modal-title">
                                                    <i class="bi bi-calendar-event"></i> Chi tiết ca sân
                                                </h5>
                                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                            </div>

                                            <div class="modal-body p-4">
                                                <!-- Thông tin ca sân -->
                                                <h6 class="text-primary fw-bold mb-3"><i class="bi bi-info-circle"></i> Thông tin ca sân</h6>
                                                <div class="row mb-3">
                                                    <div class="col-md-6"><i class="bi bi-calendar"></i> <strong>Ngày đá:</strong> <span id="event-date">---</span></div>
                                                    <div class="col-md-6"><i class="bi bi-clock"></i> <strong>Khung giờ:</strong> <span id="event-time">---</span></div>
                                                </div>
                                                <div class="row mb-3">
                                                    <div class="col-md-6"><i class="bi bi-geo-alt"></i> <strong>Tên sân:</strong> <span id="event-field-name">---</span></div>
                                                    <div class="col-md-6"><i class="bi bi-grid-3x3"></i> <strong>Loại sân:</strong> <span id="event-field-type">---</span></div>
                                                </div>
                                                <div class="row mb-3">
                                                    <div class="col-md-6"><i class="bi bi-cash-coin"></i> <strong>Giá ca:</strong> <span id="event-price">---</span></div>
                                                    <div class="col-md-6"><i class="bi bi-hourglass-split"></i> <strong>Trạng thái:</strong> <span id="event-status">---</span></div>
                                                </div>

                                                <hr class="my-4">

                                                <!-- Thông tin người đặt -->
                                                <h6 class="text-primary fw-bold mb-3"><i class="bi bi-person-circle"></i> Thông tin người đặt</h6>
                                                <div class="row mb-3">
                                                    <div class="col-md-6"><strong>Họ tên:</strong> <span id="ci-name">---</span></div>
                                                    <div class="col-md-6"><strong>SĐT:</strong> <span id="ci-phone">---</span></div>
                                                </div>
                                                <div class="row mb-3">
                                                    <div class="col-md-6"><strong>Email:</strong> <span id="ci-email">---</span></div>
                                                    <div class="col-md-6"><strong>Ghi chú:</strong> <span id="ci-note">---</span></div>
                                                </div>
                                                <div class="row mb-3">
                                                    <div class="col-md-6"><strong>ID Booking:</strong> <span id="ci-booking-id">---</span></div>
                                                    <div class="col-md-6"><strong>ID Booking Detail:</strong> <span id="ci-booking-details-id">---</span></div>
                                                </div>
                                                <div class="row mb-2">
                                                    <div class="col-md-6"><strong>Ngày đặt:</strong> <span id="ci-booking-date">---</span></div>
                                                </div>
                                            </div>

                                            <!-- Nút cập nhật trạng thái -->
                                            <div class="modal-footer bg-light border-top d-flex justify-content-between">
                                                <div>
                                                    <button id="modal-confirm-btn" class="btn btn-success">
                                                        <i class="bi bi-check-circle"></i> Xác nhận
                                                    </button>
                                                    <button id="modal-pending-btn" class="btn btn-warning">
                                                        <i class="bi bi-hourglass-split"></i> Đang chờ
                                                    </button>
                                                    <button id="modal-cancel-btn" class="btn btn-danger">
                                                        <i class="bi bi-x-circle"></i> Huỷ
                                                    </button>
                                                </div>
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                                    <i class="bi bi-x-lg"></i> Đóng
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>






                                <!-- end modal-->
                            </div>
                            <!-- end col-12 -->
                        </div> <!-- end row -->

                    </div> <!-- container -->

                </div> <!-- content -->

                <!-- Footer Start -->
                <%@include file="footer.jsp" %>
                <!-- end Footer -->

            </div>


            <!-- ============================================================== -->
            <!-- End Page content -->
            <!-- ============================================================== -->
        </div>
        <!-- END wrapper -->

        <!-- Theme Settings -->
        <!-- Theme Settings -->
        <%@include file="themesetting.jsp" %>
        <!-- xoa den tan truoc the </body> -->
        <!-- Vendor js -->
        <script src="assets/js/vendor.min.js"></script>

        <!-- Fullcalendar js -->
        <script src="assets/vendor/fullcalendar/main.min.js"></script>

        <!-- Calendar App Demo js -->
        <script src="assets/js/calendar-logic.js"></script>
        <script src="assets/js/calendar-ui.js"></script>


        <!-- App js -->
        <script src="assets/js/app.min.js"></script>

    </body>



</html>

