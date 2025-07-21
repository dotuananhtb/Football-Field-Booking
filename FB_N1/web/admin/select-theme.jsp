<%-- 
    Document   : manage-user
    Created on : Jun 16, 2025, 10:44:10 AM
    Author     : VAN NGUYEN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>FootBallStar - Chọn chủ đề</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico">

        <!-- Datatables css -->
        <link href="assets/vendor/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendor/datatables.net-responsive-bs5/css/responsive.bootstrap5.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendor/datatables.net-fixedcolumns-bs5/css/fixedColumns.bootstrap5.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendor/datatables.net-fixedheader-bs5/css/fixedHeader.bootstrap5.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendor/datatables.net-buttons-bs5/css/buttons.bootstrap5.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendor/datatables.net-select-bs5/css/select.bootstrap5.min.css" rel="stylesheet" type="text/css" />

        <!-- Theme Config Js -->
        <script src="assets/js/config.js"></script>

        <!-- App css -->
        <link href="assets/css/app.min.css" rel="stylesheet" type="text/css" id="app-style" />

        <!-- Icons css -->
        <link href="assets/css/icons.min.css" rel="stylesheet" type="text/css" />

        <!-- App favicon -->
        <%@include file="head_only.jsp" %>


        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body, html {
                height: 100%;
            }

            .container {
                display: flex;
                height: 100vh;
                font-family: Arial;
            }

            .left {
                width: 25%;
                padding: 20px;
                background: #f4f4f4;
                border-right: 1px solid #ccc;
            }

            .right {
                flex-grow: 1;
            }

            iframe {
                width: 100%;
                height: 100%;
                border: none;
            }

            button {
                display: block;
                margin-bottom: 15px;
                width: 100%;
                padding: 10px;
                font-size: 16px;
            }
        </style>

    </head>

    <body>
        <!-- Begin page -->
        <div class="wrapper">


            <!-- ========== Topbar Start ========== -->
            <jsp:include page="topbar.jsp"/>

            <!-- ========== Topbar End ========== -->

            <!-- ========== Left Sidebar Start ========== -->
            <jsp:include page="left_sidebar.jsp"/>
            <!-- ========== Left Sidebar End ========== -->

            <!-- ============================================================== -->
            <!-- Start Page Content here -->
            <!-- ============================================================== -->

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

                                    </div>
                                    <h4 class="page-title">Thay đổi chủ đề</h4>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->
                        <div class="row">

                            <div class="col-6 left">
                                <div class="mb-4">
                                    <h4 class="fs-16">Chọn chủ đề mà bạn muốn:</h4>
                                    <p></p>

                                    <div class="list-group">
                                        <c:forEach items="${listE}" var="event">
                                            <a href="javascript:void(0);" 
                                               onclick="previewEvent(${event.eventID})" 
                                               class="list-group-item list-group-item-action">
                                                ${event.title_content}
                                            </a>
                                        </c:forEach>

                                    </div>
                                </div> <!-- end card-->
                            </div>
                            <div class="col-6 right">
                                <iframe id="previewFrame" src="/FB_N1/home?eventId=${listE[0].eventID}"
                                        style="width: 100%; height: 600px; border: 1px solid #ccc; border-radius: 8px;"></iframe>

                            </div>

                        </div> <!-- container -->

                    </div> <!-- content -->
                    <%@include file="footer.jsp" %>
                    <!-- Footer Start -->

                    <!-- end Footer -->

                </div>

                <!-- ============================================================== -->
                <!-- End Page content -->
                <!-- ============================================================== -->

            </div>
            <!-- END wrapper -->

            <!-- Theme Settings -->
            <%@include file="themesetting.jsp" %>

            <!-- Vendor js -->
            <script src="assets/js/vendor.min.js"></script>

            <!-- Datatables js -->

            <script>
                                                   function previewEvent(eventId) {
                                                       // Lưu chủ đề mới qua fetch/POST
                                                       fetch('/FB_N1/admin/luu-chu-de', {
                                                           method: 'POST',
                                                           headers: {
                                                               'Content-Type': 'application/x-www-form-urlencoded'
                                                           },
                                                           body: 'eventId=' + eventId
                                                       }).then(() => {
                                                           // Sau khi lưu, load thử giao diện mới
                                                           document.getElementById("previewFrame").src = "/FB_N1/home?eventId=" + eventId;
                                                       });
                                                   }
            </script>
            <script src="assets/vendor/datatables.net/js/jquery.dataTables.min.js"></script>
            <script src="assets/vendor/datatables.net-bs5/js/dataTables.bootstrap5.min.js"></script>
            <script src="assets/vendor/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
            <script src="assets/vendor/datatables.net-responsive-bs5/js/responsive.bootstrap5.min.js"></script>
            <script src="assets/vendor/datatables.net-fixedcolumns-bs5/js/fixedColumns.bootstrap5.min.js"></script>
            <script src="assets/vendor/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
            <script src="assets/vendor/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
            <script src="assets/vendor/datatables.net-buttons-bs5/js/buttons.bootstrap5.min.js"></script>
            <script src="assets/vendor/datatables.net-buttons/js/buttons.html5.min.js"></script>
            <script src="assets/vendor/datatables.net-buttons/js/buttons.flash.min.js"></script>
            <script src="assets/vendor/datatables.net-buttons/js/buttons.print.min.js"></script>
            <script src="assets/vendor/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
            <script src="assets/vendor/datatables.net-select/js/dataTables.select.min.js"></script>


            <script src="assets/js/pages/demo.datatable-init.js"></script>


            <script src="assets/js/app.min.js"></script>

    </body>

</html>
