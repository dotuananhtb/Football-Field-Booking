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
                                <div class="modal fade" id="event-modal" tabindex="-1">
                                    <div class="modal-dialog modal-dialog-centered modal-lg">
                                        <div class="modal-content">
                                            <form class="needs-validation" id="form-event" novalidate>
                                                <div class="modal-header bg-success text-white">
                                                    <h5 class="modal-title">
                                                        <i class="bi bi-calendar-check me-2"></i>Thông tin ca sân
                                                    </h5>
                                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>

                                                <div class="modal-body px-4 py-3">
                                                    <div class="row g-3">
                                                        <div class="col-md-6">
                                                            <label class="form-label fw-semibold">Ngày</label>
                                                            <input class="form-control" type="text" id="event-date" disabled />
                                                        </div>
                                                        <div class="col-md-6">
                                                            <label class="form-label fw-semibold">Khung giờ</label>
                                                            <input class="form-control" type="text" id="event-time" disabled />
                                                        </div>
                                                        <div class="col-md-6">
                                                            <label class="form-label fw-semibold">Tên sân</label>
                                                            <input class="form-control" type="text" id="event-field-name" disabled />
                                                        </div>
                                                        <div class="col-md-6">
                                                            <label class="form-label fw-semibold">Loại sân</label>
                                                            <input class="form-control" type="text" id="event-field-type" disabled />
                                                        </div>
                                                        <div class="col-md-6">
                                                            <label class="form-label fw-semibold">Giá</label>
                                                            <input class="form-control" type="text" id="event-price" disabled />
                                                        </div>
                                                        <div class="col-md-6">
                                                            <label class="form-label fw-semibold">Trạng thái</label>
                                                            <input class="form-control" type="text" id="event-status" disabled />
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="modal-footer px-4 pb-3 pt-0">
                                                    <div class="container-fluid">
                                                        <div class="row g-2">
                                                            <div class="col-md-6 col-lg-3">
                                                                <button type="button" class="btn btn-info w-100" id="btn-show-customer">
                                                                    <i class="bi bi-person-circle me-1"></i> Người đặt
                                                                </button>
                                                            </div>
                                                            <div class="col-md-6 col-lg-3">
                                                                <button type="button" class="btn btn-secondary w-100" id="btn-cancel-slot">
                                                                    <i class="bi bi-x-circle me-1"></i> Huỷ ca
                                                                </button>
                                                            </div>
                                                            <div class="col-md-6 col-lg-3">
                                                                <button type="button" class="btn btn-warning w-100" id="btn-pending-slot">
                                                                    <i class="bi bi-hourglass-split me-1"></i> Đang xử lí
                                                                </button>
                                                            </div>
                                                            <div class="col-md-6 col-lg-3">
                                                                <button type="button" class="btn btn-danger w-100" id="btn-confirm-slot">
                                                                    <i class="bi bi-check2-circle me-1"></i> Xác nhận
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                                <!-- Modal Thông Tin Người Đặt -->
                                <div class="modal fade" id="customer-info-modal" tabindex="-1" aria-labelledby="customerInfoModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header py-3 px-4">
                                                <h5 class="modal-title" id="customerInfoModalLabel">
                                                    <i class="bi bi-person-circle me-2"></i>Thông tin người đặt
                                                </h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                            </div>
                                            <div class="modal-body px-4 pb-4 pt-0">
                                                <ul class="list-group list-group-flush">
                                                    <li class="list-group-item"><strong>Ngày đặt:</strong> <span id="ci-booking-date">---</span></li>
                                                    <li class="list-group-item"><strong>Mã Booking:</strong> <span id="ci-booking-id">---</span></li>
                                                    <li class="list-group-item"><strong>Mã Chi Tiết:</strong> <span id="ci-booking-details-id">---</span></li>
                                                    <li class="list-group-item"><strong>Họ tên:</strong> <span id="ci-name">---</span></li>
                                                    <li class="list-group-item"><strong>Số điện thoại:</strong> <span id="ci-phone">---</span></li>
                                                    <li class="list-group-item"><strong>Email:</strong> <span id="ci-email">---</span></li>
                                                    <li class="list-group-item"><strong>Ghi chú:</strong> <span id="ci-note">---</span></li>
                                                </ul>
                                            </div>
                                            <div class="modal-footer px-4 py-3">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
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

