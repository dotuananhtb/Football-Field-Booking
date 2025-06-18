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
        <title>Datatables | Powerx - Bootstrap 5 Admin & Dashboard Template</title>
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
                                    <h4 class="page-title">Quản lí người dùng</h4>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <div class="row g-4">
                            <div class="d-flex flex-wrap gap-2">

                                <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#bs-example-modal-lg">Tạo Mới</button>


                            </div>

                            <div class="col-12">
                                <div class="mb-4">



                                    <table id="row-callback-datatable" class="table table-striped dt-responsive nowrap w-100">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Họ và Tên</th>
                                                <th>Tên đăng nhập</th>
                                                <th>Giới tính</th>
                                                <th>Ngày sinh</th>
                                                <th>Địa chỉ</th>
                                                <th>Email</th>
                                                <th>Số điện thoại</th>
                                                <th>Trạng thái</th>                                                
                                                <th></th>
                                            </tr>
                                        </thead>


                                        <tbody>
                                            <c:forEach var="user" items="${listUser}">
                                                <tr>
                                                    <td>${user.accountId} </td>
                                                    <td>${user.userProfile.firstName}  ${user.userProfile.lastName }</td>
                                                    <td>${user.username}</td>
                                                    <td>${user.userProfile.gender}</td>
                                                    <td>${user.userProfile.dob}</td>
                                                    <td>${user.userProfile.address}</td>
                                                    <td>${user.email}</td>
                                                    <td>${user.userProfile.phone}</td>

                                                    <td>
                                                        <div class="btn-group mb-2">
                                                            <c:if test="${user.statusId  == 1}">
                                                                <button type="button" class="btn btn-success dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                    Hoạt Động</button></c:if>
                                                                <c:if test="${user.statusId  == 2}">
                                                                <button type="button" class="btn btn-warning dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                    Chờ xác minh</button></c:if>
                                                                <c:if test="${user.statusId  == 3}">
                                                                <button type="button" class="btn btn-danger dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                    Bị khóa</button></c:if>
                                                                <div class="dropdown-menu">
                                                                <c:forEach items="${listStatus}" var="status">
                                                                    <form action="${pageContext.request.contextPath}/admin/quan-li-tai-khoan" method="post" style="margin: 0;">
                                                                        <input type="hidden" name="sId" value="${status.statusId}" />
                                                                        <input type="hidden" name="aId" value="${user.accountId}" />
                                                                        <button type="submit" class="dropdown-item" style="border: none; background: none; padding: 8px 16px; width: 100%; text-align: left;">
                                                                            ${status.statusName}
                                                                        </button>
                                                                    </form>
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <input type="hidden" name="accId" value="${user.accountId}">
                                                        <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#bs-example-modal-lg-2">Cập nhật</button>
                                                        
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

                                </div> <!-- end card -->
                            </div><!-- end col-->
                        </div>
                        
                          <div class="modal fade" id="bs-example-modal-lg-2" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4 class="modal-title" id="myLargeModalLabel">Cập Nhật Thông Tin Người Dùng</h4>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="row g-4">
                                            <div class="col-12">
                                                <div class="mb-4">



                                                    <form action="${pageContext.request.contextPath}/admin/updateUserAdmin" method="post">
                                                        
                                                        <div class="row g-2">
                                                            <div class="mb-3 col-md-6">
                                                                <label for="inputEmai6" class="form-label">Tên Đăng Nhập</label>
                                                                <input type="text" name="username" class="form-control" id="inputEmail6" value="${acc.username}">
                                                            </div>
                                                            <div class="mb-3 col-md-6">
                                                                <label for="inputPassword5" class="form-label">Mật Khẩu</label>
                                                                <input type="password" name ="password" class="form-control" id="inputPassword5" placeholder="Mật Khẩu">
                                                            </div>
                                                        </div>
                                                        <div class="row g-2">
                                                            <div class="mb-3 col-md-6">
                                                                <label for="inputEmail4" class="form-label">Họ</label>
                                                                <input type="text" name ="firstname" class="form-control" id="inputEmail4" value="${acc.userProfile.firstName}">
                                                            </div>
                                                            <div class="mb-3 col-md-6">
                                                                <label for="inputPassword4" class="form-label">Tên</label>
                                                                <input type="text" name ="lastname" class="form-control" id="inputPassword4" value="${acc.userProfile.lastName}">
                                                            </div>
                                                            
                                                        </div>

                                                        <div class="mb-3">
                                                            <label for="inputAddress" class="form-label">Địa Chỉ</label>
                                                            <input type="text" name ="address" class="form-control" id="inputAddress" value="${acc.userProfile.address}">
                                                        </div>

                                                        <div class="mb-3">
                                                            <label for="inputEmail5" class="form-label">Email</label>
                                                            <input type="email" name ="email" class="form-control" id="inputEmail5" value="${acc.email}">
                                                        </div>

                                                        <div class="row g-2">
                                                            <div class="mb-3 col-md-6">
                                                                <label for="inputCity" class="form-label">Số Điện Thoại</label>
                                                                <input type="number" name ="phone" class="form-control" value="${acc.userProfile.phone}" id="inputCity">
                                                            </div>
                                                            <div class="mb-3 col-md-4">
                                                                <label for="inputState"  class="form-label">Giới Tính</label>
                                                                <select id="inputState" name ="gender" value="${acc.userProfile.gender}" class="form-select">
                                                                    <option>Giới Tính </option>
                                                                    <option value="Nam">Nam</option>
                                                                    <option value="Nữ">Nữ</option>
                                                                    <option value="Khác">Khác</option>
                                                                </select>
                                                            </div>
                                                            <div class="mb-3 col-md-2">
                                                                <label for="example-date" class="form-label">Ngày Sinh</label>
                                                                <input class="form-control" name ="dob" value="${acc.userProfile.dob}" id="example-date" type="date" name="date">
                                                            </div>
                                                        </div>



                                                        <button type="submit" class="btn btn-primary">Cập Nhật </button>
                                                    </form>

                                                </div> <!-- end card-->
                                            </div> <!-- end col -->
                                        </div>
                                    </div>
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal-dialog -->
                        </div>
                        
                        

                        <div class="modal fade" id="bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4 class="modal-title" id="myLargeModalLabel">Tạo Mới Người Dùng</h4>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="row g-4">
                                            <div class="col-12">
                                                <div class="mb-4">



                                                    <form action="${pageContext.request.contextPath}/admin/addUser" method="post">
                                                        <div class="row g-2">
                                                            <div class="mb-3 col-md-6">
                                                                <label for="inputEmai6" class="form-label">Tên Đăng Nhập</label>
                                                                <input type="text" name="username" class="form-control" id="inputEmail6" placeholder="Tên Đăng Nhập">
                                                            </div>
                                                            <div class="mb-3 col-md-6">
                                                                <label for="inputPassword5" class="form-label">Mật Khẩu</label>
                                                                <input type="password" name ="password" class="form-control" id="inputPassword5" placeholder="Mật Khẩu">
                                                            </div>
                                                        </div>
                                                        <div class="row g-2">
                                                            <div class="mb-3 col-md-6">
                                                                <label for="inputEmail4" class="form-label">Họ</label>
                                                                <input type="text" name ="firstname" class="form-control" id="inputEmail4" placeholder="Họ">
                                                            </div>
                                                            <div class="mb-3 col-md-6">
                                                                <label for="inputPassword4" class="form-label">Tên</label>
                                                                <input type="text" name ="lastname" class="form-control" id="inputPassword4" placeholder="Tên">
                                                            </div>
                                                        </div>

                                                        <div class="mb-3">
                                                            <label for="inputAddress" class="form-label">Địa Chỉ</label>
                                                            <input type="text" name ="address" class="form-control" id="inputAddress" placeholder="Địa Chỉ">
                                                        </div>

                                                        <div class="mb-3">
                                                            <label for="inputEmail5" class="form-label">Email</label>
                                                            <input type="email" name ="email" class="form-control" id="inputEmail5" placeholder="Email">
                                                        </div>

                                                        <div class="row g-2">
                                                            <div class="mb-3 col-md-6">
                                                                <label for="inputCity" class="form-label">Số Điện Thoại</label>
                                                                <input type="number" name ="phone" class="form-control" id="inputCity">
                                                            </div>
                                                            <div class="mb-3 col-md-4">
                                                                <label for="inputState"  class="form-label">Giới Tính</label>
                                                                <select id="inputState" name ="gender" class="form-select">
                                                                    <option>Giới Tính </option>
                                                                    <option value="Nam">Nam</option>
                                                                    <option value="Nữ">Nữ</option>
                                                                    <option value="Khác">Khác</option>
                                                                </select>
                                                            </div>
                                                            <div class="mb-3 col-md-2">
                                                                <label for="example-date" class="form-label">Ngày Sinh</label>
                                                                <input class="form-control" name ="dob" id="example-date" type="date" name="date">
                                                            </div>
                                                        </div>



                                                        <button type="submit" class="btn btn-primary">Tạo Người Dùng</button>
                                                    </form>

                                                </div> <!-- end card-->
                                            </div> <!-- end col -->
                                        </div>
                                    </div>
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal-dialog -->
                        </div><!-- /.modal -->
































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
