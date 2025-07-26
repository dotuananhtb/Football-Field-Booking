<%-- 
    Document   : ManagerProduct
    Created on : 15 thg 6, 2025, 20:29:41
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Quản lý Sản phẩm - FootBall Star </title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />

        <!-- App favicon -->
        <jsp:include page="head_only.jsp" />

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
        
        <!-- Toastr CSS -->
        <link href="assets/vendor/jquery-toast-plugin/jquery.toast.min.css" rel="stylesheet" type="text/css" />
    </head>

    <body>
        <!-- Toast Notifications -->
        <c:if test="${sessionScope.successToast != null}">
            <script>
                document.addEventListener('DOMContentLoaded', function() {
                    toastr.success('${sessionScope.successToast}');
                });
            </script>
            <c:remove var="successToast" scope="session"/>
        </c:if>
        <c:if test="${sessionScope.errorToast != null}">
            <script>
                document.addEventListener('DOMContentLoaded', function() {
                    toastr.error('${sessionScope.errorToast}');
                });
            </script>
            <c:remove var="errorToast" scope="session"/>
        </c:if>
        
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
                                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addProductModal">
                                            <i class="ri-add-line"></i> Thêm Sản phẩm Mới
                                        </button>
                                        <button type="button" class="btn btn-success ms-2" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                                            <i class="ri-add-line"></i> Thêm Loại Sản phẩm
                                        </button>
                                    </div>
                                    <h4 class="page-title">Quản lý Sản phẩm</h4>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <!-- Search and Filter Section -->
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <form action="${pageContext.request.contextPath}/admin/quan-ly-san-pham" method="GET" class="d-flex">
    <input type="hidden" name="action" value="filter">

    <!-- Dropdown chọn danh mục -->
    <select name="categoryId" class="form-select me-2">
        <option value="">Tất cả danh mục</option>
        <c:forEach var="category" items="${categories}">
            <option value="${category.productCateId}" 
                ${selectedCategory eq category.productCateId ? 'selected' : ''}>
                ${category.cateName}
            </option>
        </c:forEach>
    </select>

    <!-- Nhập giá từ -->
    <input type="number" name="minPrice" class="form-control me-2" placeholder="Giá từ" value="${param.minPrice}">

    <!-- Nhập giá đến -->
    <input type="number" name="maxPrice" class="form-control me-2" placeholder="Đến" value="${param.maxPrice}">

    <!-- Nút lọc -->
    <button type="submit" class="btn btn-outline-secondary me-2">Lọc</button>

    <!-- Nút đặt lại: chuyển về trang mặc định không có filter -->
    <a href="${pageContext.request.contextPath}/admin/quan-ly-san-pham" class="btn btn-outline-danger">Đặt lại</a>
</form>

                            </div>
                        </div>

                        <div class="row g-4">
                            <div class="col-12">
                                <div class="mb-4">
                                    <h4 class="fs-16">Danh sách Sản phẩm</h4>
                                    <p class="text-muted fs-14">Quản lý thông tin các sản phẩm trong hệ thống</p>
                                    <table id="scroll-horizontal-datatable" class="table table-striped w-100 nowrap">
                                        <thead>
                                            <tr>
                                                <th>STT</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Danh mục</th>
                                                <th>Giá</th>
                                                <th>Mô tả</th>
                                                <th>Trạng thái</th>
                                                <th>Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="product" items="${products}" varStatus="status">
                                                <tr>
                                                    <td>${status.index + 1}</td>
                                                    <td>${product.productName}</td>
                                                    <td>${product.cateProduct.cateName}</td>
                                                    <td>${product.productPrice}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${fn:length(product.productDescription) > 50}">
                                                                ${fn:substring(product.productDescription, 0, 50)}...
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${product.productDescription}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <span class="badge ${product.productStatus eq 'active' ? 'bg-success' : 'bg-danger'}">
                                                            ${product.productStatus eq 'active' ? 'Còn hàng' : 'Hết hàng'}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <button type="button" class="btn btn-sm btn-outline-primary edit-product-btn"
                                                                    data-product-id="${product.productId}"
                                                                    data-product-name="${product.productName}"
                                                                    data-category-id="${product.productCateId}"
                                                                    data-product-price="${product.productPrice}"
                                                                    data-product-image="${product.productImage}"
                                                                    data-product-description="${product.productDescription}"
                                                                    data-product-status="${product.productStatus}"
                                                                    data-product-details='${product.productDetailsListJson}'>
                                                                <i class="ri-edit-line"></i>
                                                            </button>
                                                            <form action="${pageContext.request.contextPath}/admin/quan-ly-san-pham" method="POST" style="display:inline;">
                                                                <input type="hidden" name="action" value="toggleStatus">
                                                                <input type="hidden" name="productId" value="${product.productId}">
                                                                <input type="hidden" name="currentStatus" value="${product.productStatus}">
                                                                <button type="submit" class="btn btn-sm btn-outline-warning" onclick="return confirm('Xác nhận thay đổi trạng thái?')">
                                                                    <i class="ri-toggle-line"></i>
                                                                </button>
                                                            </form>
                                                            <form action="${pageContext.request.contextPath}/admin/quan-ly-san-pham" method="POST" style="display:inline;">
                                                                <input type="hidden" name="action" value="delete">
                                                                <input type="hidden" name="productId" value="${product.productId}">
                                                                <button type="submit" class="btn btn-sm btn-outline-danger" onclick="return confirm('Xác nhận xóa sản phẩm?')">
                                                                    <i class="ri-delete-bin-line"></i>
                                                                </button>
                                                            </form>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div> <!-- end card -->
                            </div><!-- end col-->
                        </div> <!-- end row-->

                        <!-- Danh sách loại sản phẩm -->
                        <div class="row mt-4">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h5 class="card-title mb-0">Danh sách Loại Sản phẩm</h5>
                                    </div>
                                    <div class="card-body">
                                        <table id="category-datatable" class="table table-striped w-100 nowrap">
                                            <thead>
                                                <tr>
                                                    <th>STT</th>
                                                    <th>Tên loại</th>
                                                    <th>Hành động</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="cate" items="${categories}" varStatus="status">
                                                    <tr>
                                                        <td>${status.index + 1}</td>
                                                        <td>${cate.cateName}</td>
                                                        <td>
                                                            <button type="button" class="btn btn-sm btn-outline-primary edit-cate-btn"
                                                                    data-cate-id="${cate.productCateId}"
                                                                    data-cate-name="${cate.cateName}">
                                                                <i class="ri-edit-line"></i> Sửa
                                                            </button>
                                                            <form action="${pageContext.request.contextPath}/admin/quan-ly-san-pham" method="POST" style="display:inline;">
                                                                <input type="hidden" name="action" value="deleteCategory">
                                                                <input type="hidden" name="categoryId" value="${cate.productCateId}">
                                                                <button type="submit" class="btn btn-sm btn-outline-danger" onclick="return confirm('Xác nhận xoá loại sản phẩm?')">
                                                                    <i class="ri-delete-bin-line"></i> Xoá
                                                                </button>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
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

        <!-- Add Product Modal -->
        <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addProductModalLabel">Thêm Sản phẩm Mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/admin/quan-ly-san-pham" method="POST" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="add">
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="productName" class="form-label">Tên Sản phẩm *</label>
                                        <input type="text" class="form-control" id="productName" name="productName" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="categoryId" class="form-label">Danh mục *</label>
                                        <select class="form-select" id="categoryId" name="categoryId" required>
                                            <option value="">Chọn danh mục</option>
                                            <c:forEach var="category" items="${categories}">
                                                <option value="${category.productCateId}">${category.cateName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="productPrice" class="form-label">Giá *</label>
                                        <input type="number" step="0.01" class="form-control" id="productPrice" name="productPrice" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="productImageFile" class="form-label">Ảnh sản phẩm</label>
                                        <input type="file" class="form-control" id="productImageFile" name="productImageFile" accept="image/*" onchange="previewProductImage(event, 'addProductImagePreview')">
                                        <img id="addProductImagePreview" src="#" alt="Preview" style="max-width: 200px; display: none; margin-top: 5px;"/>
                                    </div>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="productDescription" class="form-label">Mô tả</label>
                                <textarea class="form-control" id="productDescription" name="productDescription" rows="3"></textarea>
                            </div>
                            <hr>
                            <h5>Chi tiết sản phẩm</h5>
                            <div class="row mb-2">
                                <div class="col-md-6 mb-2">
                                    <label for="addColors" class="form-label">Màu sắc <span style="color:red">*</span> <small>(nhiều giá trị, cách nhau bởi dấu phẩy)</small></label>
                                    <input type="text" class="form-control" id="addColors" name="colors" placeholder="Ví dụ: Đỏ, Đen" required>
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label for="addSizes" class="form-label">Size <span style="color:red">*</span> <small>(nhiều giá trị, cách nhau bởi dấu phẩy)</small></label>
                                    <input type="text" class="form-control" id="addSizes" name="sizes" placeholder="Ví dụ: 41, 42" required>
                                </div>
                                <div class="col-md-4 mb-2">
                                    <label for="addMaterial" class="form-label">Chất liệu</label>
                                    <input type="text" class="form-control" id="addMaterial" name="material" placeholder="Chỉ nhập 1 giá trị">
                                </div>
                                <div class="col-md-4 mb-2">
                                    <label for="addWeight" class="form-label">Trọng lượng</label>
                                    <input type="number" step="0.01" class="form-control" id="addWeight" name="weight" placeholder="Chỉ nhập 1 giá trị">
                                </div>
                                <div class="col-md-4 mb-2">
                                    <label for="addOrigin" class="form-label">Xuất xứ</label>
                                    <input type="text" class="form-control" id="addOrigin" name="origin" placeholder="Chỉ nhập 1 giá trị">
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label for="addWarranty" class="form-label">Bảo hành</label>
                                    <input type="text" class="form-control" id="addWarranty" name="warranty" placeholder="Chỉ nhập 1 giá trị">
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label for="addMoreInfo" class="form-label">Khác</label>
                                    <input type="text" class="form-control" id="addMoreInfo" name="moreInfo" placeholder="Chỉ nhập 1 giá trị">
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-primary">Thêm Sản phẩm</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Edit Product Modal -->
        <div class="modal fade" id="editProductModal" tabindex="-1" aria-labelledby="editProductModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editProductModalLabel">Chỉnh sửa Sản phẩm</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/admin/quan-ly-san-pham" method="POST" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="productId" id="editProductId">
                        <input type="hidden" id="editProductImage" name="oldProductImage" value="">
                        <input type="hidden" id="editProductStatusHidden" name="productStatus" value="">
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="editProductName" class="form-label">Tên Sản phẩm *</label>
                                        <input type="text" class="form-control" id="editProductName" name="productName" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="editCategoryId" class="form-label">Danh mục *</label>
                                        <select class="form-select" id="editCategoryId" name="categoryId" required>
                                            <option value="">Chọn danh mục</option>
                                            <c:forEach var="category" items="${categories}">
                                                <option value="${category.productCateId}">${category.cateName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="editProductPrice" class="form-label">Giá *</label>
                                        <input type="number" step="0.01" class="form-control" id="editProductPrice" name="productPrice" required>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="editProductImageFile" class="form-label">Ảnh sản phẩm</label>
                                        <input type="file" class="form-control" id="editProductImageFile" name="productImageFile" accept="image/*" onchange="previewProductImage(event, 'editProductImagePreview')">
                                        <img id="editProductImagePreview" src="#" alt="Preview" style="max-width: 200px; display: none; margin-top: 5px;"/>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="editProductStatus" class="form-label">Trạng thái</label>
                                        <select class="form-select" id="editProductStatus" name="productStatus">
                                            <option value="active">Còn hàng</option>
                                            <option value="inactive">Hết hàng</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="editProductDescription" class="form-label">Mô tả</label>
                                <textarea class="form-control" id="editProductDescription" name="productDescription" rows="3"></textarea>
                            </div>
                            <hr>
                            <h5>Chi tiết sản phẩm</h5>
                            <div class="row mb-2">
                                <div class="col-md-6 mb-2">
                                    <label for="editColors" class="form-label">Màu sắc <span style="color:red">*</span> <small>(nhiều giá trị, cách nhau bởi dấu phẩy)</small></label>
                                    <input type="text" class="form-control" id="editColors" name="color[]" placeholder="Ví dụ: Đỏ, Đen" required>
                                    <input type="hidden" id="editProductDetailsId" name="productDetailsId[]" value="">
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label for="editSizes" class="form-label">Size <span style="color:red">*</span> <small>(nhiều giá trị, cách nhau bởi dấu phẩy)</small></label>
                                    <input type="text" class="form-control" id="editSizes" name="size[]" placeholder="Ví dụ: 41, 42" required>
                                </div>
                                <div class="col-md-4 mb-2">
                                    <label for="editMaterial" class="form-label">Chất liệu</label>
                                    <input type="text" class="form-control" id="editMaterial" name="material[]" placeholder="Chỉ nhập 1 giá trị">
                                </div>
                                <div class="col-md-4 mb-2">
                                    <label for="editWeight" class="form-label">Trọng lượng</label>
                                    <input type="number" step="0.01" class="form-control" id="editWeight" name="weight[]" placeholder="Chỉ nhập 1 giá trị">
                                </div>
                                <div class="col-md-4 mb-2">
                                    <label for="editOrigin" class="form-label">Xuất xứ</label>
                                    <input type="text" class="form-control" id="editOrigin" name="origin[]" placeholder="Chỉ nhập 1 giá trị">
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label for="editWarranty" class="form-label">Bảo hành</label>
                                    <input type="text" class="form-control" id="editWarranty" name="warranty[]" placeholder="Chỉ nhập 1 giá trị">
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label for="editMoreInfo" class="form-label">Khác</label>
                                    <input type="text" class="form-control" id="editMoreInfo" name="moreInfo[]" placeholder="Chỉ nhập 1 giá trị">
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-primary">Cập nhật</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Add Category Modal -->
        <div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addCategoryModalLabel">Thêm Loại Sản phẩm Mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/admin/quan-ly-san-pham" method="POST">
                        <input type="hidden" name="action" value="addCategory">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="categoryName" class="form-label">Tên Loại Sản phẩm *</label>
                                <input type="text" class="form-control" id="categoryName" name="categoryName" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-success">Thêm Loại</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Edit Category Modal -->
        <div class="modal fade" id="editCategoryModal" tabindex="-1" aria-labelledby="editCategoryModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editCategoryModalLabel">Chỉnh sửa Loại Sản phẩm</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/admin/quan-ly-san-pham" method="POST">
                        <input type="hidden" name="action" value="editCategory">
                        <input type="hidden" name="categoryId" id="editCateId">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="editCateName" class="form-label">Tên Loại Sản phẩm *</label>
                                <input type="text" class="form-control" id="editCateName" name="categoryName" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-primary">Cập nhật</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

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

        <!-- Datatable Demo Aapp js -->
        <script src="assets/js/jsBang.js"></script>

        <!-- App js -->
        <script src="assets/js/app.min.js"></script>
        
        <!-- Toastr JS -->
        <script src="assets/vendor/jquery-toast-plugin/jquery.toast.min.js"></script>

        <script>
            // Xử lý sự kiện click cho nút edit
            document.addEventListener('DOMContentLoaded', function() {
                document.querySelectorAll('.edit-product-btn').forEach(function(btn) {
                    btn.addEventListener('click', function() {
                        const productId = this.getAttribute('data-product-id');
                        const productName = this.getAttribute('data-product-name');
                        const categoryId = this.getAttribute('data-category-id');
                        const productPrice = this.getAttribute('data-product-price');
                        const productImage = this.getAttribute('data-product-image');
                        const productDescription = this.getAttribute('data-product-description');
                        const productStatus = this.getAttribute('data-product-status');
                        const productDetailsJson = this.getAttribute('data-product-details');
                        
                        editProduct(productId, productName, categoryId, productPrice, productImage, productDescription, productStatus, productDetailsJson);
                    });
                });
            });

            function editProduct(productId, productName, categoryId, productPrice, productImage, productDescription, productStatus, productDetailsJson) {
                document.getElementById('editProductId').value = productId;
                document.getElementById('editProductName').value = productName || '';
                document.getElementById('editCategoryId').value = categoryId || '';
                document.getElementById('editProductPrice').value = productPrice || '';
                document.getElementById('editProductImage').value = productImage || '';
                document.getElementById('editProductDescription').value = productDescription || '';
                document.getElementById('editProductStatus').value = productStatus || 'active';
                document.getElementById('editProductStatusHidden').value = productStatus || 'active';
                
                // Xử lý ProductDetails
                try {
                    const details = JSON.parse(productDetailsJson || '[]');
                    if (details.length > 0) {
                        const detail = details[0]; // Lấy chi tiết đầu tiên
                        document.getElementById('editColors').value = detail.color || '';
                        document.getElementById('editSizes').value = detail.size || '';
                        document.getElementById('editMaterial').value = detail.material || '';
                        document.getElementById('editWeight').value = detail.weight || '';
                        document.getElementById('editOrigin').value = detail.origin || '';
                        document.getElementById('editWarranty').value = detail.warranty || '';
                        document.getElementById('editMoreInfo').value = detail.moreInfo || '';
                        document.getElementById('editProductDetailsId').value = detail.productDetailsId || '';
                    } else {
                        // Reset các trường nếu không có dữ liệu
                        document.getElementById('editColors').value = '';
                        document.getElementById('editSizes').value = '';
                        document.getElementById('editMaterial').value = '';
                        document.getElementById('editWeight').value = '';
                        document.getElementById('editOrigin').value = '';
                        document.getElementById('editWarranty').value = '';
                        document.getElementById('editMoreInfo').value = '';
                        document.getElementById('editProductDetailsId').value = '';
                    }
                } catch (e) {
                    console.error('Lỗi parse JSON:', e);
                    // Reset các trường nếu có lỗi
                    document.getElementById('editColors').value = '';
                    document.getElementById('editSizes').value = '';
                    document.getElementById('editMaterial').value = '';
                    document.getElementById('editWeight').value = '';
                    document.getElementById('editOrigin').value = '';
                    document.getElementById('editWarranty').value = '';
                    document.getElementById('editMoreInfo').value = '';
                    document.getElementById('editProductDetailsId').value = '';
                }
                
                new bootstrap.Modal(document.getElementById('editProductModal')).show();
            }

            // Xử lý nút sửa loại sản phẩm
            document.addEventListener('DOMContentLoaded', function() {
                document.querySelectorAll('.edit-cate-btn').forEach(function(btn) {
                    btn.addEventListener('click', function() {
                        const cateId = this.getAttribute('data-cate-id');
                        const cateName = this.getAttribute('data-cate-name');
                        document.getElementById('editCateId').value = cateId;
                        document.getElementById('editCateName').value = cateName;
                        new bootstrap.Modal(document.getElementById('editCategoryModal')).show();
                    });
                });
                
                // Xử lý thay đổi trạng thái sản phẩm trong modal edit
                document.getElementById('editProductStatus').addEventListener('change', function() {
                    document.getElementById('editProductStatusHidden').value = this.value;
                });
            });
        </script>
        <script>
$(function() {
    // Destroy instance nếu đã có
    if ($.fn.DataTable.isDataTable('#scroll-horizontal-datatable')) {
        $('#scroll-horizontal-datatable').DataTable().destroy();
    }
    var table = $('#scroll-horizontal-datatable').DataTable({
        responsive: true,
        fixedHeader: true,
        pageLength: 10,
        lengthMenu: [5, 10, 20, 50, 100],
        language: {
            paginate: { previous: 'Trước', next: 'Sau' },
            info: 'Hiển thị _START_ đến _END_ của _TOTAL_ sản phẩm',
            infoEmpty: 'Không có dữ liệu',
            lengthMenu: 'Hiển thị _MENU_ sản phẩm',
            search: 'Tìm kiếm:',
            zeroRecords: 'Không tìm thấy kết quả phù hợp',
            infoFiltered: '(lọc từ _MAX_ sản phẩm)',
            loadingRecords: 'Đang tải...',
            processing: 'Đang xử lý...'
        }
    });

    // Gắn lại sự kiện mỗi lần vẽ lại bảng (phân trang, lọc, search)
    $('#scroll-horizontal-datatable').on('draw.dt', function() {
        // bindDetailBtn(); // Xóa hàm này
    });
    // Gắn sự kiện lần đầu
    // bindDetailBtn(); // Xóa hàm này

    // function bindDetailBtn() { // Xóa hàm này
    //     $('#scroll-horizontal-datatable tbody').off('click', '.dt-details-btn').on('click', '.dt-details-btn', function () { // Xóa hàm này
    //         var tr = $(this).closest('tr'); // Xóa hàm này
    //         var row = table.row(tr); // Xóa hàm này
    //         var idx = $(this).data('product-index'); // Xóa hàm này
    //         var detailsHtml = $('#details-content-' + idx).html(); // Xóa hàm này
    //         if (row.child.isShown()) { // Xóa hàm này
    //             row.child.hide(); // Xóa hàm này
    //             tr.removeClass('shown'); // Xóa hàm này
    //         } else { // Xóa hàm này
    //             row.child(detailsHtml).show(); // Xóa hàm này
    //             tr.addClass('shown'); // Xóa hàm này
    //         } // Xóa hàm này
    //     }); // Xóa hàm này
    // } // Xóa hàm này
});
</script>
<script>
$(document).ready(function() {
    if ($.fn.DataTable.isDataTable('#category-datatable')) {
        $('#category-datatable').DataTable().destroy();
    }
    $('#category-datatable').DataTable({
        responsive: true,
        fixedHeader: true,
        pageLength: 10,
        lengthMenu: [5, 10, 20, 50, 100],
        language: {
            paginate: {
                previous: 'Trước',
                next: 'Sau'
            },
            info: 'Hiển thị _START_ đến _END_ của _TOTAL_ loại sản phẩm',
            infoEmpty: 'Không có dữ liệu',
            lengthMenu: 'Hiển thị _MENU_ loại sản phẩm',
            search: 'Tìm kiếm:',
            zeroRecords: 'Không tìm thấy kết quả phù hợp',
            infoFiltered: '(lọc từ _MAX_ loại sản phẩm)',
            loadingRecords: 'Đang tải...',
            processing: 'Đang xử lý...'
        }
    });
});
</script>
<%-- Toast notification --%>
<c:if test="${not empty sessionScope.toastMessage}">
    <script>
        toastr['${sessionScope.toastType eq null ? "success" : sessionScope.toastType}']("${sessionScope.toastMessage}");
    </script>
    <c:remove var="toastMessage" scope="session"/>
    <c:remove var="toastType" scope="session"/>
</c:if>
   
    </body>

</html>
