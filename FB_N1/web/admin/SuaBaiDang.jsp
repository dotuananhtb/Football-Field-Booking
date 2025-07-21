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
        <title>FootBallStar - Sửa chủ đề</title>
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
                                    
                                    <h4 class="page-title">Sửa bài đăng</h4>
                                    
                                </div>
                                
                            </div>
                            
                            
                        </div>
                        <!-- end page title -->


                        <div class="row g-4">
                            <div class="  d-flex flex-wrap gap-2 justify-content-end">

                                    <a type="button" href="/FB_N1/admin/quan-li-bai-dang" class="btn btn-info" >Quay lại</a>


                            </div>
                            

                            <div class="col-12">
                                <div class="mb-4">
                                    <form id="eventForm" action="${pageContext.request.contextPath}/admin/sua-bai-dang?blogId=${blog.blogId}" method="post" enctype="multipart/form-data">
                                        <input type="hidden" name="blogId" value="${requestScope.blog.blogId}" />
                                       

                                        <div class="row g-4 align-items-stretch">
                                            <!-- Cột trái -->
                                            <div class="col-lg-4 d-flex flex-column">
                                                <div class="mb-3">
                                                    <label class="form-label">Tiêu đề</label>
                                                    <input type="text" name="title" class="form-control" placeholder="Tiêu đề" value="${requestScope.blog.title}" required>
                                                </div>

                                                <div class="mb-3">
                                                    <label class="form-label">Slug</label>
                                                    <input type="text" name="slug" class="form-control" value="${requestScope.blog.slug}" placeholder="Slug" required>
                                                </div>

                                                <div class="mb-3">
                                                    <label class="form-label">Tóm tắt</label>
                                                    <input type="text" name="sum" class="form-control" value="${requestScope.blog.summary}" placeholder="Tóm tắt" required>
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label">Nhãn</label>
                                                    <input type="text" name="tag" class="form-control" value="${requestScope.blog.tags}" placeholder="Tóm tắt" required>
                                                </div>

                                                <div class="mb-3">
                                                    <label for="imageBig">Chọn ảnh :</label>
                                                    <input type="file" name="image1" id="imageBig" accept="image/*" class="form-control">
                                                    <input type="hidden" name="oldImage1" value="${requestScope.blog.thumbnailUrl}">
                                                    <c:if test="${not empty requestScope.blog.thumbnailUrl}">
                                                        <div style="margin-top:10px;">
                                                            <strong>Ảnh hiện tại:</strong><br/>
                                                            <img src="${requestScope.blog.thumbnailUrl}" alt="Ảnh hiện tại" style="max-width: 100%; height: auto;" />
                                                        </div>
                                                    </c:if>
                                                </div>

                                                
                                            </div>

                                            <!-- Cột phải -->
                                            <div class="col-lg-8 d-flex flex-column">

                                                <label for="editor-title1" class="form-label">Nội dung bài đăng </label>
                                                <div id="editor-title1" class="flex-grow-1" style="min-height: 250px; overflow-y: hidden;"></div>
                                                <input type="hidden" name="title1" id="title1">
                                                <div id="raw-title1" style="display:none;">${blog.content}</div>

                                                <!-- Nút submit đẩy xuống dưới cùng -->
                                                <div class="d-flex justify-content-center mt-3">
                                                    <input type="hidden" name="type" value="blog">
                                                    <button type="submit" class="btn btn-sm btn-primary px-4" style="width: 33%;">Xác Nhận</button>
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
                
                form.onsubmit = function () {
    const html = quill1.root.innerHTML;
    document.getElementById('title1').value = html;

    console.log("Tiêu đề:", document.querySelector('input[name=title]').value);
    console.log("Slug:", document.querySelector('input[name=slug]').value);
    console.log("Tóm tắt:", document.querySelector('input[name=sum]').value);
    console.log("Tag:", document.querySelector('input[name=tag]').value);
    console.log("Content:", html);
};
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
