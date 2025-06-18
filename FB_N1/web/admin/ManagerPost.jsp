<%-- 
    Document   : ManagerPost
    Created on : 15 thg 6, 2025, 20:29:41
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>ADMIN - Quản lí Bài Viết</title>
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />

    <!-- App favicon -->
    <%@include file="head_only.jsp" %>
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
                                <h4 class="page-title">Quản lí bài viết</h4>
                            </div>
                        </div>
                    </div>
                    <!-- end page title -->

                    <div class="row g-4">
                        <div class="col-12">
                            <div class="mb-4">
                                <h4 class="fs-16">Quản lí bài viết</h4>
                                <p class="text-muted fs-14">
                                    
                                    
                                </p>

                                <table id="basic-datatable" class="table table-striped dt-responsive nowrap w-100">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Tiêu đề</th>
                                            <th>Nội dung</th>
                                            <th>Người đăng</th>
                                            <th>Ngày đăng</th>
                                            <th>Trạng thái</th>
                                            <th>Số bình luận</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>


                                    <tbody>
                                        <c:forEach var="post" items="${posts}">
                                            <tr>
                                                <td>${post.postId}</td>
                                                <td>${post.title}</td>
                                                <td>${post.contentPost}</td>
                                                <td>${post.account.username}</td>
                                                <td>${post.postDate}</td>
                                                <td>
                                                    <c:if test="${post.statusPost eq 'active'}">Hiện</c:if>
                                                    <c:if test="${post.statusPost eq 'deactive'}">Ẩn</c:if>
                                                </td>
                                                <td>${post.commentCount}</td>
                                                <td>
                                                    <form action="deletePost" method="post" style="display:inline;">
                                                        <input type="hidden" name="postId" value="${post.postId}" />
                                                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Xác nhận xoá?')">Xoá</button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                            </div> <!-- end card -->
                        </div><!-- end col-->
                    </div> <!-- end row-->


                    


                    


                   


                    


                    


                    


                    


                    


                    


                    
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
