<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Quản lý giá cả của sân - FootBall Star</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />


        <!-- Theme Config Js -->
        <script src="assets/js/config.js"></script>

        <!-- App css -->
        <link href="assets/css/app.min.css" rel="stylesheet" type="text/css" id="app-style" />

        <!-- Icons css -->
        <link href="assets/css/icons.min.css" rel="stylesheet" type="text/css" />
        <%@include file="head_only.jsp" %>
    </head>

    <style>
        .grid-checkbox {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 10px;
        }

        .slot-item {
            display: flex;
            align-items: center;
            padding: 10px 14px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: #f8f9fa;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            user-select: none;
        }

        .slot-item:hover {
            background-color: #e2f0ff;
            box-shadow: 0 0 6px rgba(0, 123, 255, 0.3);
            transform: scale(1.01);
        }

        .slot-item input[type="checkbox"] {
            margin-right: 8px;
            transform: scale(1.2);
            cursor: pointer;
        }

        .slot-item input[type="checkbox"]:checked+span {
            color: #0d6efd;
            font-weight: bold;
        }

        .slot-item input[type="checkbox"]:checked~* {
            background-color: #d0ebff;
        }
    </style>



    <body>
        <!-- Begin page -->
        <div class="wrapper">
            <!-- ========== Topbar Start ========== -->
            <jsp:include page="topbar.jsp" />

            <!-- ========== Topbar End ========== -->

            <!-- ========== Left Sidebar Start ========== -->
            <jsp:include page="left_sidebar.jsp" />
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
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Quản lý Sân</a>
                                            </li>
                                            <li class="breadcrumb-item active">Quản lý giá cả</li>
                                        </ol>
                                    </div>
                                    <h4 class="page-title">Quản Lý giá cả</h4>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->
                        <div class="row g-4">
                            <div class="card p-4 mb-5">
                                <h4 class="mb-4"> Cập nhật giá cho nhiều khung giờ</h4>
                                <!-- Chọn sân -->
                                <form method="get"
                                      action="${pageContext.request.contextPath}/admin/quan-ly-gia-tung-ca">
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label"><strong>Chọn sân:</strong></label>
                                            <select name="field_id" class="form-select"
                                                    onchange="this.form.submit()" required>
                                                <option value="">-- Chọn sân --</option>
                                                <c:forEach var="f" items="${fields}">
                                                    <option value="${f.fieldId}" ${f.fieldId==selectedFieldId
                                                                     ? 'selected' : '' }>${f.fieldName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </form>

                                <form method="post"
                                      action="${pageContext.request.contextPath}/admin/quan-ly-gia-tung-ca" class="mt-4">
                                    <input type="hidden" name="action" value="save_bulk_price" />
                                    <input type="hidden" name="field_id" value="${selectedFieldId}" />
                                    <input type="hidden" name="submitType" id="submitType" value="insert" />

                                    <div class="row g-3">
                                        <!-- Danh sách khung giờ -->
                                        <div class="col-md-12">
                                            <label class="form-label"><strong>Chọn các khung giờ:</strong></label>
                                            <div class="grid-checkbox">
                                                <c:forEach var="s" items="${slots}">
                                                    <c:set var="isExisting"
                                                           value="${existingSlotIds.contains(s.slotId)}" />
                                                    <label class="slot-item"
                                                           style="${isExisting ? 'color: green;' : ''}"
                                                           title="${isExisting ? 'Đã có giá' : 'Chưa có giá'}">
                                                        <input type="checkbox" name="slot_ids" value="${s.slotId}"
                                                               ${submitType=='insert' && isExisting ? 'disabled' : '' }
                                                               ${submitType=='update' && !isExisting ? 'disabled' : ''
                                                               } />
                                                        <span>${s.startTime} - ${s.endTime} ${isExisting ? "(đã có
                                                                giá)" : ""}</span>
                                                    </label>
                                                </c:forEach>
                                            </div>
                                        </div>

                                        <!-- Nhập giá -->
                                        <div class="col-md-4">
                                            <label class="form-label"><strong>Nhập giá (VNĐ):</strong></label>
                                            <input type="number" name="slot_field_price" class="form-control"
                                                   step="1000" required />
                                        </div>

                                        <!-- Nút submit -->
                                        <div class="col-md-12 mt-3">
                                            <button type="submit"
                                                    onclick="document.getElementById('submitType').value = 'insert'"
                                                    class="btn btn-success me-2">
                                                Thêm giá mới
                                            </button>
                                            <button type="submit"
                                                    onclick="document.getElementById('submitType').value = 'update'"
                                                    class="btn btn-primary">
                                                Cập nhật giá
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>


                            <!-- Danh sách Slot theo loại sân -->
                            <h3 class="mb-4">Danh sách giá của các sân</h3>
                            <c:forEach var="f" items="${fields}">
                                <c:if test="${selectedFieldId == -1 || f.fieldId == selectedFieldId}">
                                    <div class="col-xl-6">
                                        <div class="card p-4 shadow-sm">
                                            <h4 class="mb-3">⚽ ${f.fieldName}</h4>

                                            <!-- Ảnh sân -->
                                            <c:if test="${not empty f.image}">
                                                <div class="text-center mb-3">
                                                    <img src="${f.image}"
                                                         alt="Ảnh sân" class="img-fluid rounded-4 border"
                                                         style="height: 300px; width: 100%; object-fit: cover;" />
                                                </div>
                                            </c:if>

                                            <div class="table-responsive">
                                                <table
                                                    class="table table-bordered table-hover text-center align-middle">
                                                    <thead>
                                                        <tr>
                                                            <th>Khung giờ</th>
                                                            <th>Giá</th>
                                                            <th>Hành động</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="p" items="${slotPrices}">
                                                            <c:if test="${p.field.fieldId == f.fieldId}">
                                                                <tr>
                                                                    <td>${p.slotInfo.startTime} - ${p.slotInfo.endTime}
                                                                    </td>
                                                                    <td class="text-success fw-bold"><strong>${p.slotFieldPrice}</strong> ₫</td>
                                                                    <td>
                                                                        <form method="post"
                                                                              action="${pageContext.request.contextPath}/admin/quan-ly-gia-tung-ca"
                                                                              onsubmit="return confirm('Bạn có chắc chắn muốn xoá?')"
                                                                              style="display: inline;">
                                                                            <input type="hidden" name="action"
                                                                                   value="delete_price" />
                                                                            <input type="hidden" name="slot_field_id"
                                                                                   value="${p.slotFieldId}" />
                                                                            <button type="submit"
                                                                                    class="btn btn-sm btn-outline-danger"
                                                                                    title="Xoá">
                                                                                <i class="ri-delete-bin-2-line"></i>
                                                                            </button>
                                                                        </form>
                                                                    </td>
                                                                </tr>
                                                            </c:if>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <c:set var="hasPrice" value="false" />
                                            <c:forEach var="p" items="${slotPrices}">
                                                <c:if test="${p.field.fieldId == f.fieldId}">
                                                    <c:set var="hasPrice" value="true" />
                                                </c:if>
                                            </c:forEach>

                                            <c:if test="${not hasPrice}">
                                                <div class="alert alert-warning mt-3 mb-0">
                                                    Chưa có giá nào được thiết lập cho sân này.
                                                </div>
                                            </c:if>

                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                        <!-- end row-->

                    </div> <!-- container -->

                </div> <!-- content -->
                <%@include file="footer.jsp" %>

            </div>

            <!-- ============================================================== -->
            <!-- End Page content -->
            <!-- ============================================================== -->

        </div>
        <!-- END wrapper -->

        <%@include file="themesetting.jsp" %>

        <!-- Vendor js -->
        <script src="assets/js/vendor.min.js"></script>
        <!-- App js -->
        <script src="assets/js/app.min.js"></script>
    </body>

</html>