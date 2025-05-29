<%-- 
    Document   : UserDetail
    Created on : May 29, 2025, 8:54:34 AM
    Author     : VAN NGUYEN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
   <html xmlns="http://www.w3.org/1999/xhtml" lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Hồ Sơ Cá Nhân - BookField</title>
    
    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="images/favicon.png">
    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <!--Custom CSS-->
    <link href="css/style.css" rel="stylesheet" type="text/css">
    <!--Plugin CSS-->
    <link href="css/plugin.css" rel="stylesheet" type="text/css">
    <!--Font Awesome-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css">
    <link rel="stylesheet" href="fonts/line-icons.css" type="text/css">

    <style>
        .profile-sidebar {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 0;
            overflow: hidden;
        }
        
        .profile-header {
            background: linear-gradient(135deg, #28a745, #20c997);
            padding: 30px 20px;
            text-align: center;
            color: white;
        }
        
        .profile-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            border: 4px solid white;
            margin-bottom: 15px;
        }
        
        .profile-nav {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .profile-nav li {
            border-bottom: 1px solid #f0f0f0;
        }
        
        .profile-nav li:last-child {
            border-bottom: none;
        }
        
        .profile-nav a {
            display: block;
            padding: 15px 20px;
            color: #333;
            text-decoration: none;
            transition: all 0.3s;
        }
        
        .profile-nav a:hover,
        .profile-nav a.active {
            background: #f8f9fa;
            color: #28a745;
            padding-left: 30px;
        }
        
        .profile-nav i {
            width: 20px;
            margin-right: 10px;
        }
        
        .profile-content {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 30px;
        }
        
        .stats-card {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            margin-bottom: 20px;
        }
        
        .stats-card.success {
            background: linear-gradient(135deg, #28a745, #20c997);
        }
        
        .stats-card.warning {
            background: linear-gradient(135deg, #ffc107, #e0a800);
        }
        
        .stats-card.info {
            background: linear-gradient(135deg, #17a2b8, #138496);
        }
        
        .booking-card {
            border: 1px solid #e9ecef;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            transition: all 0.3s;
        }
        
        .booking-card:hover {
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transform: translateY(-2px);
        }
        
        .status-badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }
        
        .status-confirmed {
            background: #d4edda;
            color: #155724;
        }
        
        .status-pending {
            background: #fff3cd;
            color: #856404;
        }
        
        .status-cancelled {
            background: #f8d7da;
            color: #721c24;
        }
        
        .favorite-field {
            border: 1px solid #e9ecef;
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 20px;
            transition: all 0.3s;
        }
        
        .favorite-field:hover {
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .field-image {
            height: 150px;
            background-size: cover;
            background-position: center;
            position: relative;
        }
        
        .field-content {
            padding: 15px;
        }
        
        .breadcrumb-main {
            background: #f8f9fa;
            padding: 20px 0;
            margin-bottom: 30px;
        }
    </style>
</head>
    <body>
        <div class="tab-content" id="personal-info">
                        <div class="profile-content">
                            <h3 class="mb-4">Thông Tin Cá Nhân</h3>
                            <c:set value="${sessionScope.userProfile}" var="u"></c:set>
                            <c:set value="${sessionScope.account}" var="a"></c:set>
                            <%--<c:out value="${sessionScope.acc}" default="Chưa có userProfile trong session" />--%>
                            <form action="${pageContext.request.contextPath}/updateUser" method="post" >
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <input type="hidden" value="${u.getAccountId()}" name="id">
                                        <label class="form-label"> Tên </label>
                                        <input type="text" class="form-control" value="${u.getFirstName()}" name="fname">
                                    </div>
                                     <div class="col-md-6 mb-3">
                                        <label class="form-label">Họ</label>
                                        <input type="text" class="form-control" value="${u.getLastName()}" name="lname" >
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">User Name</label>
                                        <input type="text" class="form-control" value="${a.getUsername()}" name="username" readonly>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Email</label>
                                        <input type="email" class="form-control" value="${a.getEmail()}" readonly >
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Số Điện Thoại</label>
                                        <input type="tel" class="form-control" value="${u.getPhone()}" name="phone">
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Ngày Sinh</label>
                                        <input type="date" class="form-control" value="${u.getDob()}" name="dob">
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Giới Tính</label>
                                        <input type="text" class="form-control" value="${u.getGender()}" name ="gender" readonly >
                                    </div>
                                    
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">Địa Chỉ</label>
                                    <input type="text" class="form-control" value="${u.getAddress()}" name="address">
                                </div>
                                
                                <input type="submit" value="Cập Nhật" class="btn btn-success"/>
                                
                                <h6>${mess}</h6>
                            </form>
                        </div>
                    </div>
    </body>
</html>
