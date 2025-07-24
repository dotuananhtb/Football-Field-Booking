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
        <title>Quản Lý Đặt Sân - FootBall Star</title>
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


        /* Áp dụng màu chữ trắng nếu có bg-dark */
        .fc-event.bg-dark,
        .fc-event.bg-dark .fc-event-time,
        .fc-event.bg-dark .fc-event-title,
        .fc-timegrid-event.bg-dark,
        .fc-timegrid-event.bg-dark .fc-event-title,
        .fc-timegrid-event.bg-dark .fc-event-time {
            color: #fff !important;
        }

        /* Áp dụng màu chữ đen nếu có text-dark */
        .fc-event.text-dark,
        .fc-event.text-dark .fc-event-title,
        .fc-event.text-dark .fc-event-time,
        .fc-timegrid-event.text-dark,
        .fc-timegrid-event.text-dark .fc-event-title,
        .fc-timegrid-event.text-dark .fc-event-time {
            color: #212529 !important;
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
            width: 100%;
            max-width: 400px;
            margin: 20px auto;
            padding: 10px 16px;
            font-size: 1rem;
            font-weight: 500;
            color: #495057;
            background-color: #fff;
            border: 1px solid #ced4da;
            border-radius: 0.5rem;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        #fieldSelect:focus {
            border-color: #198754; /* Bootstrap's success color */
            box-shadow: 0 0 0 0.2rem rgba(25, 135, 84, 0.25);
            outline: none;
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

    <style>
        .payment-status-select {
            display: block;
            width: 100%;
            max-width: 300px;
            margin: 10px auto;
            padding: 8px 12px;
            font-size: 1rem;
            font-weight: 500;
            color: #495057;
            background-color: #fff;
            border: 1px solid #ced4da;
            border-radius: 0.5rem;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .payment-status-select:focus {
            border-color: #0d6efd; /* Bootstrap primary */
            box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
            outline: none;
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
                                    <h4 class="page-title">Quản Lý Đặt Sân</h4>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <div class="row">
                            <div class="col-12">

                                <div class="container-fluid px-4">
                                    <div class="card shadow-sm border-0">
                                        <div class="card-body">

                                            <!-- 🔹 Chọn sân -->
                                            <div class="mb-3">
                                                <label for="fieldSelect" class="form-label fw-bold">Chọn sân</label>
                                                <select id="fieldSelect" class="form-select">
                                                    <option value="">-- Chọn sân --</option>
                                                    <%
                                                        FieldDAO fieldDAO = new FieldDAO();
                                                        List<Field> fields = fieldDAO.getAllFields();
                                                        for (Field field : fields) {
                                                    %>
                                                    <option value="<%= field.getFieldId()%>"><%= field.getFieldName()%></option>
                                                    <% }%>
                                                </select>
                                            </div>


                                            <!-- 🔹 Lịch -->
                                            <div id="calendar-wrapper" class="card shadow-sm p-3 mb-4">
                                                <div class="calendar-fixed-header mb-3">
                                                    <div class="fc-toolbar"></div>
                                                    <div class="fc-col-header"></div>
                                                </div>
                                                <div class="calendar-scrollable-body">
                                                    <div id="calendar"></div>
                                                </div>
                                            </div>

                                            <!-- Chú thích trạng thái cho người sử dụng -->
                                            <style>#legend-bar {
                                                    max-width: 1100px;
                                                    margin: 0 auto 10px;
                                                }
                                                #legend-bar .badge {
                                                    font-size: 0.9rem;
                                                    padding: 0.5em 0.75em;
                                                }
                                            </style>
                                            <div class="container mt-3" id="legend-bar">
                                                <h6><i class="bi bi-info-circle-fill text-primary"></i> Chú thích trạng thái màu của các ca trên lịch:</h6>
                                                <div class="d-flex flex-wrap gap-2">
                                                    <span class="badge bg-success">Có thể đặt</span>
                                                    <span class="badge bg-warning">Yêu cầu huỷ</span>
                                                    <span class="badge bg-danger">Đã đặt</span>                                                
                                                    <span class="badge bg-danger bg-opacity-25 text-dark">Ca cũ đã đặt</span>
                                                    <span class="badge bg-warning bg-opacity-25 text-dark">Ca cũ chưa được xử lí huỷ</span>
                                                    <span class="badge bg-primary bg-opacity-25 text-dark border border-primary">Chờ thanh toán</span>
                                                    <span class="badge bg-light text-dark border">Ca cũ chưa đặt</span>
                                                    <span class="badge bg-info">Đang chọn</span>

                                                </div>
                                            </div>
                                            <!-- comment -->

                                            <!-- 🔹 Thông tin khách hàng offline -->
                                            <form id="offlineUserForm" class="needs-validation card shadow-sm p-4 mb-4 border-0" style="display: none;" novalidate>
                                                <h5 class="mb-4 text-primary fw-bold">Thông tin khách hàng offline</h5>
                                                <div class="row g-3">
                                                    <!-- Họ tên -->
                                                    <div class="col-md-4">
                                                        <label for="offlineFullName" class="form-label">Họ và tên <span class="text-danger">*</span></label>
                                                        <input type="text" id="offlineFullName" name="offlineFullName" class="form-control" placeholder="Nhập họ tên khách hàng"
                                                               required minlength="2" maxlength="50"
                                                               pattern="^[a-zA-ZÀ-ỹ\s]+$"
                                                               title="Chỉ chứa chữ cái và khoảng trắng. Tối đa 50 ký tự.">
                                                        <div class="invalid-feedback">
                                                            Họ và tên từ 2–50 ký tự, chỉ chứa chữ cái và khoảng trắng.
                                                        </div>
                                                    </div>

                                                    <!-- Số điện thoại -->
                                                    <div class="col-md-4">
                                                        <label for="offlinePhone" class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                                                        <input type="tel" id="offlinePhone" name="offlinePhone" class="form-control" placeholder="Nhập số điện thoại"
                                                               required pattern="^0[0-9]{9}$" maxlength="10"
                                                               title="Phải có đúng 10 chữ số và bắt đầu bằng số 0.">
                                                        <div class="invalid-feedback">
                                                            Số điện thoại phải gồm 10 chữ số và bắt đầu bằng số 0.
                                                        </div>
                                                    </div>

                                                    <!-- Email -->
                                                    <div class="col-md-4">
                                                        <label for="offlineEmail" class="form-label">Email (tuỳ chọn)</label>
                                                        <input type="email" id="offlineEmail" name="offlineEmail" class="form-control" placeholder="Email khách hàng (nếu có)"
                                                               maxlength="100"
                                                               title="Nhập đúng định dạng email và không vượt quá 100 ký tự.">
                                                        <div class="invalid-feedback">
                                                            Email không đúng định dạng hoặc quá 100 ký tự.
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>

                                            <!-- 🔹 Bảng ca đã chọn -->
                                            <div class="table-responsive mb-3">
                                                <table id="selectedSlotsTable" class="table table-bordered table-hover align-middle text-center shadow-sm" style="display: none;">
                                                    <thead class="table-light">
                                                        <tr>
                                                            <th>Ngày</th>
                                                            <th>Khung giờ</th>
                                                            <th>Giá</th>
                                                            <th>Ghi chú</th>
                                                            <th>Hành động</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody></tbody>
                                                </table>
                                            </div>

                                            <!-- 🔹 Tổng tiền -->
                                            <div id="totalPrice" class="fw-bold fs-5 text-end text-success mb-3" style="display: none;">
                                                Tổng tiền: 0₫
                                            </div>

                                            <!-- 🔹 Trạng thái thanh toán -->
                                            <div id="statusPayGroup" class="mb-3" style="display: none;">
                                                <label for="statusPayInput" class="form-label fw-bold text-primary">
                                                    <i class="bi bi-cash-coin me-1"></i> Hình thức thanh toán
                                                </label>
                                                <select id="statusPayInput" class="form-select shadow-sm rounded">
                                                    <option value="2">Thanh toán tại quầy</option>
                                                    <option value="0">Chuyển khoản QR</option>
                                                </select>
                                            </div>

                                            <!-- 🔹 Nút đặt sân -->
                                            <div class="text-center">
                                                <button id="bookNowBtn" class="btn btn-success btn-lg w-100" style="display: none;">
                                                    <i class="bi bi-check-circle-fill me-2"></i>Đặt sân
                                                </button>
                                            </div>


                                        </div> <!-- end card-body -->
                                    </div> <!-- end card -->
                                </div>



                                <!-- Admin Modal -->

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
                                                <!-- 🔹 Thông tin ca sân -->
                                                <h6 class="text-primary fw-bold mb-3">
                                                    <i class="bi bi-info-circle"></i> Thông tin ca sân
                                                </h6>
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

                                                <hr class="my-4" />

                                                <!-- 🔹 Thông tin người đặt -->
                                                <h6 class="text-primary fw-bold mb-3">
                                                    <i class="bi bi-person-circle"></i> Thông tin người đặt
                                                </h6>
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
                                                    <div class="col-md-6"><strong>Hình thức đặt:</strong> <span id="ci-is-offline">---</span></div>
                                                </div>

                                            </div>

                                            <!-- 🔹 Nút cập nhật trạng thái -->
                                            <div class="modal-footer bg-light border-top d-flex justify-content-between">
                                                <div>

                                                    <!-- ✅ Các nút xử lý đặt trong footer modal -->
                                                    <button id="modal-confirm-btn" class="btn btn-success d-none">
                                                        <i class="bi bi-check-circle-fill me-1"></i> Xác nhận ca
                                                    </button>

                                                    <button id="modal-pending-btn" class="btn btn-warning text-dark d-none">
                                                        <i class="bi bi-clock-history me-1"></i> Chuyển về chờ xử lý
                                                    </button>

                                                    <button id="modal-cancel-btn" class="btn btn-danger d-none">
                                                        <i class="bi bi-x-circle-fill me-1"></i> Huỷ ca
                                                    </button>

                                                    <button id="modal-confirm-cancel-btn" class="btn btn-danger d-none">
                                                        <i class="bi bi-trash3-fill me-1"></i> Xác nhận huỷ ca
                                                    </button>

                                                    <button id="modal-cancel-request-btn" class="btn btn-secondary d-none">
                                                        <i class="bi bi-arrow-counterclockwise me-1"></i> Huỷ bỏ yêu cầu huỷ
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

