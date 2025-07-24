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
        <title>Sửa chủ đề - FootBall Star</title>
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
        <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
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
                                    <h4 class="page-title">Sửa chủ đề</h4>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->


                        <div class="row g-4">

                            <div class="mb-4">
                                <h4 class="fs-16">Chọn chủ đề mà bạn muốn sửa</h4>


                                <div class="dropdown btn-group">
                                    <button class="btn btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false" id="animated-preview">
                                        Chọn chủ đề
                                    </button>
                                    <div class="dropdown-menu dropdown-menu-animated">
                                        <c:forEach items="${listEvent}" var="event">
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/sua-chu-de?eventId=${event.eventID}">${event.title_content}</a>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>

                            <div class="col-12">
                                <div class="mb-4">
                                    <form id="eventForm" action="${pageContext.request.contextPath}/admin/sua-chu-de?eventId=${event.eventID}&titleId=${event.title.titleID}" method="post" enctype="multipart/form-data">
                                        <input type="hidden" name="eventId" value="${requestScope.event.eventID}" />
                                        <input type="hidden" name="titleId" value="${requestScope.event.title.titleID}" />

                                        <div class="row g-4 align-items-stretch">
                                            <!-- Cột trái -->
                                            <div class="col-lg-4 d-flex flex-column">
                                                <div class="mb-3">
                                                    <label class="form-label">Tên chủ đề</label>
                                                    <input type="text" name="title_content" class="form-control" placeholder="Tên chủ đề" value="${requestScope.event.title_content}" required>
                                                </div>

                                                <div class="mb-3">
                                                    <label class="form-label">Mô tả 1</label>
                                                    <input type="text" name="content1" class="form-control" value="${requestScope.event.content1}" placeholder="Mô tả 1" required>
                                                </div>

                                                <div class="mb-3">
                                                    <label class="form-label">Mô tả 2</label>
                                                    <input type="text" name="content2" class="form-control" value="${requestScope.event.content2}" placeholder="Mô tả 2" required>
                                                </div>

                                                <div class="mb-3">
                                                    <label for="imageBig">Chọn ảnh To:</label>
                                                    <input type="file" name="image1" id="imageBig" accept="image/*" class="form-control">
                                                    <input type="hidden" name="oldImage1" value="${requestScope.event.image_video}">
                                                    <c:if test="${not empty requestScope.event.image_video}">
                                                        <div style="margin-top:10px;">
                                                            <strong>Ảnh hiện tại:</strong><br/>
                                                            <img src="${requestScope.event.image_video}" alt="Ảnh hiện tại" style="max-width: 100%; height: auto;" />
                                                        </div>
                                                    </c:if>
                                                </div>

                                                <div class="mb-3">
                                                    <label for="imageSmall">Chọn ảnh Nhỏ:</label>
                                                    <input type="file" name="image2" id="imageSmall" accept="image/*" class="form-control">
                                                    <input type="hidden" name="oldImage2" value="${requestScope.event.image2}">
                                                    <c:if test="${not empty requestScope.event.image2}">
                                                        <div style="margin-top:10px;">
                                                            <strong>Ảnh hiện tại:</strong><br/>
                                                            <img src="${requestScope.event.image2}" alt="Ảnh nhỏ hiện tại" style="max-width: 100%; height: auto;" />
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </div>

                                            <!-- Cột phải -->
                                            <div class="col-lg-8 d-flex flex-column">

                                                <label for="editor-title1" class="form-label">Nội dung bài đăng sự kiện</label>
                                                <div id="editor-title1" class="flex-grow-1" style="min-height: 250px; overflow-y: hidden;"></div>
                                                <input type="hidden" name="title1" id="title1">
                                                <div id="raw-title1" style="display:none;">${event.title.title1}</div>

                                                <!-- Nút submit đẩy xuống dưới cùng -->
                                                <div class="d-flex justify-content-center mt-3">
                                                    <input type="hidden" name="type" value="event">
                                                    <button type="submit" class="btn btn-sm btn-primary px-4" style="width: 33%;">Sửa Chủ Đề</button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <!-- end col -->
                        </div><!-- end row -->

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
            <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
            <!-- Datatables js -->

            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    const quill1 = new Quill('#editor-title1', {
                        theme: 'snow',
                        modules: {
                            toolbar: [
                                [{'font': []}, {'size': []}],
                                ['bold', 'italic', 'underline', 'strike'],
                                [{'color': []}, {'background': []}],
                                [{'script': 'sub'}, {'script': 'super'}],
                                [{'header': '1'}, {'header': '2'}, 'blockquote', 'code-block'],
                                [{'list': 'ordered'}, {'list': 'bullet'}, {'indent': '-1'}, {'indent': '+1'}],
                                [{'direction': 'rtl'}, {'align': []}],
                                ['link', 'image', 'video'],
                                ['clean']
                            ]
                        }
                    });

                    const editorEl = document.querySelector('#editor-title1 .ql-editor');

                    // Hàm resize chiều cao theo nội dung
                    function autoResize() {
                        editorEl.style.height = 'auto'; // reset
                        editorEl.style.height = (editorEl.scrollHeight) + "px";
                    }

                    // Resize ban đầu
                    autoResize();

                    // Resize khi nội dung thay đổi
                    quill1.on('text-change', function () {
                        autoResize();
                    });
                    var initialContent = document.getElementById("raw-title1").innerHTML;
                    quill1.clipboard.dangerouslyPasteHTML(initialContent);
                    // Gán dữ liệu về form
                    const form = document.getElementById('eventForm');
                    form.onsubmit = function () {
                        document.getElementById('title1').value = quill1.root.innerHTML;
                    };
                });
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
