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

<%
    String type = (String) session.getAttribute("toastType");
    String message = (String) session.getAttribute("toastMessage");
    if (type != null && message != null) {
%>
<script>
    const notyf = new Notyf({
        duration: 3000,
        dismissible: true,
        position: {x: 'right', y: 'top'}
    });

    <% if ("success".equals(type)) {%>
    notyf.success("<%= message%>");
    <% } else if ("error".equals(type)) {%>
    notyf.error("<%= message%>");
    <% } else {%>
    notyf.open({type: "<%= type%>", message: "<%= message%>"});
    <% } %>
</script>
<%
        session.removeAttribute("toastType");
        session.removeAttribute("toastMessage");
    }
%>
