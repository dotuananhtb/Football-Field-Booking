<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <jsp:include page="head_only.jsp" />
        <title>Quản lý Loại Sân</title>

    </head>
    <body>

        <h2>Quản lý Loại Sân</h2>

        <!-- FORM THÊM hoặc CẬP NHẬT -->
        <form method="post" action="${pageContext.request.contextPath}/admin/Admin_LoaiSan">
            <input type="hidden" name="action" value="${type != null ? 'update' : 'add'}" />
            <c:if test="${type != null}">
                <input type="hidden" name="field_type_id" value="${type.fieldTypeId}" />
            </c:if>
            <input type="text" name="field_type_name" value="${type != null ? type.fieldTypeName : ''}" placeholder="Nhập tên loại sân" required />
            <button type="submit">${type != null ? 'Cập nhật' : 'Thêm'}</button>
            <c:if test="${type != null}">
                <a href="${pageContext.request.contextPath}/admin/Admin_LoaiSan">Hủy</a>
            </c:if>
        </form>

        <br/>

        <!-- DANH SÁCH LOẠI SÂN -->
        <table border="1" cellpadding="5" cellspacing="0">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên Loại Sân</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="t" items="${types}">
                    <tr>
                        <td>${t.fieldTypeId}</td>
                        <td>${t.fieldTypeName}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/Admin_LoaiSan?editId=${t.fieldTypeId}">Sửa</a> |
                            <form method="post" action="${pageContext.request.contextPath}/admin/Admin_LoaiSan" style="display:inline;">
                                <input type="hidden" name="action" value="delete" />
                                <input type="hidden" name="field_type_id" value="${t.fieldTypeId}" />
                                <button type="submit" onclick="return confirm('Xác nhận xoá?')">Xoá</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <%@include file="footer.jsp" %>
    </body>
</html>
