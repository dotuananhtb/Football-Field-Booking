<%-- 
    Document   : toast
    Created on : Jun 14, 2025, 10:46:54 PM
    Author     : Đỗ Tuấn Anh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Notyf CDN -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/notyf@3/notyf.min.css">
<script src="https://cdn.jsdelivr.net/npm/notyf@3/notyf.min.js"></script>
<%-- <script src="./app/js/toast.js"></script>đường dẫn toast.js --%>
<script src="${pageContext.request.contextPath}/UI/app/js/toast.js"></script>


<%
    String type = (String) session.getAttribute("toastType");
    String message = (String) session.getAttribute("toastMessage");
    if (type != null && message != null) {
%>
<!-- Đợi DOM & toast.js load xong mới gọi -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        if (typeof showToast === 'function') {
            showToast("<%= type%>", "<%= message%>");
        } else {
            console.error("⚠️ showToast chưa được định nghĩa!");
        }
    });
</script>
<%
        session.removeAttribute("toastType");
        session.removeAttribute("toastMessage");
    }
%>
