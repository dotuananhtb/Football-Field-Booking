<%-- 
    Document   : head_only
    Created on : Jun 15, 2025, 3:54:57 PM
    Author     : Đỗ Tuấn Anh
--%>

<%@page import="model.UserProfile"%>
<%@page import="model.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- App favicon -->
<link rel="shortcut icon" href="assets/images/logo-sm.png">

<!-- Daterangepicker css -->
<link rel="stylesheet" href="assets/vendor/daterangepicker/daterangepicker.css">

<!-- Vector Map css -->
<link rel="stylesheet" href="assets/vendor/admin-resources/jquery.vectormap/jquery-jvectormap-1.2.2.css">

<!-- Theme Config Js -->
<script src="assets/js/config.js"></script>

<!-- App css -->
<link href="assets/css/app.min.css" rel="stylesheet" type="text/css" id="app-style" />

<!-- Icons css -->
<link href="assets/css/icons.min.css" rel="stylesheet" type="text/css" />


<!-- CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/notyf@3/notyf.min.css">

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/notyf@3/notyf.min.js"></script>

<jsp:include page="/UI/toast.jsp" />

<jsp:include page="/UI/sweetalert-include.jsp" />

<%
    Account account = (Account) session.getAttribute("account");
    UserProfile userProfile = (account != null) ? account.getUserProfile() : null;
%>

<script>
    window.accountId = <%= (account != null) ? account.getAccountId() : -1%>;
    window.roleId = <%= (userProfile != null) ? userProfile.getRoleId() : -1%>;
</script>

<script src="assets/js/admin-notify.js"></script>
<script>
    connectAdminSocket(accountId, roleId);
</script>