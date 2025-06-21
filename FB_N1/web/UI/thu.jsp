<%-- 
    Document   : thu
    Created on : Jun 21, 2025, 3:38:33 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <base href="${pageContext.request.contextPath}/UI/">
        <title>Test</title></head>
    <body>
        <h2>List sản phẩm</h2>

        <!-- ✅ Bọc form -->
        <form method="get" action="${pageContext.request.contextPath}/Shop">
            <label for="search">Tìm theo tên:</label>
            <input type="text" name="keyword" id="search" />
            <button type="submit">Tìm kiếm</button>


            <!-- ✅ Hiển thị danh sách sản phẩm -->
            <c:if test="${not empty ListP}">
                <ul>
                    <c:forEach items="${ListP}" var="p">
                        <li>${p.productName} - ${p.cateProduct.cateName} - ${p.productPrice}</li>
                        </c:forEach>
                </ul>
            </c:if>
        </form>
    </body>
</html>
