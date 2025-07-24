<%-- 
    Document   : danhSachSan
    Created on : Jun 14, 2025, 12:19:19 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">

    <head>
        <base href="${pageContext.request.contextPath}/UI/">

            <meta charset="utf-8">
                <title>Danh sách sân - FootBall Star</title>

                <meta name="author" content="themesflat.com">
                    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

                        <link rel="stylesheet" href="app/css/app.css">
                            <link rel="stylesheet" href="app/css/jquery.fancybox.min.css">
                                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/flatpickr.min.css">

                                    <!-- Favicon and Touch Icons  -->
                                    <link rel="shortcut icon" href="assets/images/logoKoChu.png">

                                    <link rel="apple-touch-icon-precomposed" href="assets/images/logoKoChu.png">

                                            <style>

                                                .book-btn button {
                                                    background: linear-gradient(135deg, #28a745, #20c997);
                                                    color: white;
                                                    border: none;
                                                    padding: 8px 16px;
                                                    border-radius: 6px;
                                                    font-size: 12px;
                                                    font-weight: 600;
                                                    cursor: pointer;
                                                    transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                                                    white-space: nowrap;
                                                    min-width: auto;
                                                    position: relative;
                                                    overflow: hidden;
                                                    box-shadow: 0 4px 15px rgba(40, 167, 69, 0.2);
                                                }

                                                /* Hiệu ứng sóng khi hover */
                                                .book-btn button::before {
                                                    content: '';
                                                    position: absolute;
                                                    top: 50%;
                                                    left: 50%;
                                                    width: 0;
                                                    height: 0;
                                                    background: rgba(255, 255, 255, 0.3);
                                                    border-radius: 50%;
                                                    transform: translate(-50%, -50%);
                                                    transition: width 0.6s ease, height 0.6s ease;
                                                }

                                                .book-btn button:hover::before {
                                                    width: 300px;
                                                    height: 300px;
                                                }

                                                .book-btn button:hover {
                                                    background: linear-gradient(135deg, #218838, #1e7e34);
                                                    transform: translateY(-3px) scale(1.05);
                                                    box-shadow: 0 8px 25px rgba(40, 167, 69, 0.4);
                                                }

                                                .book-btn button:active {
                                                    transform: translateY(-1px) scale(1.02);
                                                    transition: all 0.1s ease;
                                                }
                                                .feature.maintenance {
                                                    background-color: #f59e0b !important;
                                                    color: white !important;
                                                    border-color: #d97706 !important;
                                                }

                                                .feature.broken {
                                                    background-color: #ef4444 !important;
                                                    color: white !important;
                                                    border-color: #dc2626 !important;
                                                }

                                                .slot-btn.active {
                                                    background-color: #FCD34D;
                                                    font-weight: bold;
                                                    border-color: #f59e0b;
                                                }
                                                .time-slots {
                                                    margin-bottom: 20px;
                                                }

                                                .slots-header {
                                                    display: flex;
                                                    justify-content: space-between;
                                                    align-items: center;
                                                    margin-bottom: 12px;
                                                    padding: 8px 0;
                                                    border-bottom: 1px solid #e9ecef;
                                                }

                                                .slots-title {
                                                    font-size: 16px;
                                                    font-weight: 600;
                                                    color: #333;
                                                }

                                                .toggle-btn {
                                                    background: none;
                                                    border: none;
                                                    color: #00d084;
                                                    font-size: 14px;
                                                    font-weight: 500;
                                                    cursor: pointer;
                                                    display: flex;
                                                    align-items: center;
                                                    gap: 4px;
                                                    padding: 4px 8px;
                                                    border-radius: 4px;
                                                    transition: background-color 0.2s ease;
                                                }

                                                .toggle-btn:hover {
                                                    background-color: #f0fff8;
                                                }

                                                .toggle-icon {
                                                    transition: transform 0.3s ease;
                                                }

                                                .toggle-icon.rotated {
                                                    transform: rotate(180deg);
                                                }
                                                .slots-container {
                                                    position: relative;
                                                    overflow: hidden;
                                                    transition: max-height 0.4s ease, opacity 0.3s ease;
                                                }

                                                .slots-container.collapsed {
                                                    max-height: 100px; /* Giảm chiều cao để hiển thị rõ hiệu ứng thu gọn */
                                                }

                                                .slots-container.expanded {
                                                    max-height: 1000px;
                                                }


                                                .slots-grid {
                                                    display: grid;
                                                    grid-template-columns: 1fr 1fr;
                                                    gap: 8px;
                                                    padding-bottom: 10px;
                                                }

                                                .show-more-indicator {
                                                    display: none;
                                                    text-align: center;
                                                    padding: 12px 8px 8px 8px;
                                                    background: linear-gradient(transparent 0%, rgba(248,249,250,0.8) 30%, rgba(248,249,250,0.95) 70%, #f8f9fa 100%);
                                                    margin-top: -30px;
                                                    position: relative;
                                                    z-index: 2;
                                                    border-radius: 0 0 8px 8px;
                                                }

                                                .show-more-indicator.visible {
                                                    display: block;
                                                }


                                                .show-more-text {
                                                    font-size: 12px;
                                                    color: #666;
                                                    font-style: italic;
                                                    font-weight: 500;
                                                }

                                                .slot-btn {
                                                    background: #f8f9fa;
                                                    border: 2px solid #e9ecef;
                                                    border-radius: 8px;
                                                    padding: 10px 12px;
                                                    font-size: 13px;
                                                    font-weight: 500;
                                                    color: #495057;
                                                    cursor: pointer;
                                                    transition: all 0.2s ease;
                                                    text-align: center;
                                                    position: relative;
                                                    min-height: 44px; /* Đảm bảo chiều cao tối thiểu */
                                                    display: flex;
                                                    align-items: center;
                                                    justify-content: center;
                                                }

                                                .slot-btn:hover {
                                                    border-color: #00d084;
                                                    background: #f0fff8;
                                                    color: #00d084;
                                                    transform: translateY(-1px);
                                                    box-shadow: 0 2px 4px rgba(0, 208, 132, 0.1);
                                                }

                                                .slot-btn.selected {
                                                    background: #00d084;
                                                    border-color: #00d084;
                                                    color: white;
                                                    box-shadow: 0 2px 8px rgba(0, 208, 132, 0.3);
                                                }

                                                .slot-btn.unavailable {
                                                    background: #f8f9fa;
                                                    border-color: #dee2e6;
                                                    color: #adb5bd;
                                                    cursor: not-allowed;
                                                    opacity: 0.6;
                                                }
                                                .slot-btn.booked {
                                                    background-color: #dc3545; /* đỏ */
                                                    color: white;
                                                    cursor: not-allowed;
                                                }
                                                .slot-btn.wait {
                                                    background-color: #dc3545; /* đỏ */
                                                    color: white;
                                                    cursor: not-allowed;
                                                }

                                                .slot-btn.expired {
                                                    background-color: #6c757d; /* xám */
                                                    color: white;
                                                    cursor: not-allowed;
                                                }
                                                .slot-btn.pending {
                                                    background-color: #dc3545; /* vàng */
                                                    color: white;
                                                    cursor: not-allowed;
                                                }

                                                .slot-btn.unavailable:hover {
                                                    transform: none;
                                                    border-color: #dee2e6;
                                                    background: #f8f9fa;
                                                    color: #adb5bd;
                                                    box-shadow: none;
                                                }

                                                .price-section {
                                                    display: flex;
                                                    justify-content: space-between;
                                                    align-items: center;
                                                    margin-top: 20px;
                                                    padding-top: 20px;
                                                    border-top: 1px solid #e9ecef;
                                                }

                                                .price-info {
                                                    flex: 1;
                                                }

                                                .price-label {
                                                    font-size: 14px;
                                                    color: #666;
                                                    margin-bottom: 4px;
                                                }

                                                .price-range {
                                                    display: flex;
                                                    align-items: center;
                                                    gap: 8px;
                                                }

                                                .price-from {
                                                    font-size: 18px;
                                                    font-weight: 700;
                                                    color: #00d084;
                                                    transition: all 0.3s ease;
                                                }

                                                .price-to {
                                                    font-size: 16px;
                                                    color: #666;
                                                    transition: opacity 0.3s ease;
                                                }

                                                /* Thêm animation khi thu gọn/mở rộng */
                                                @keyframes fadeIn {
                                                    from {
                                                        opacity: 0;
                                                    }
                                                    to {
                                                        opacity: 1;
                                                    }
                                                }

                                                @keyframes fadeOut {
                                                    from {
                                                        opacity: 1;
                                                    }
                                                    to {
                                                        opacity: 0;
                                                    }
                                                }

                                                .slots-container.expanding {
                                                    animation: fadeIn 0.3s ease;
                                                }

                                                .slots-container.collapsing {
                                                    animation: fadeOut 0.3s ease;
                                                }

                                                /* Responsive */
                                                @media (max-width: 768px) {
                                                    .slots-grid {
                                                        grid-template-columns: 1fr 1fr;
                                                        gap: 6px;
                                                    }

                                                    .slot-btn {
                                                        padding: 8px 10px;
                                                        font-size: 12px;
                                                        min-height: 40px;
                                                    }

                                                    .show-more-indicator {
                                                        margin-top: -25px;
                                                        padding: 10px 8px 6px 8px;
                                                    }
                                                }

                                                @media (max-width: 480px) {
                                                    .slots-grid {
                                                        grid-template-columns: 1fr;
                                                    }

                                                    .price-section {
                                                        flex-direction: column;
                                                        gap: 15px;
                                                        align-items: stretch;
                                                    }

                                                    .slots-container.collapsed {
                                                        max-height: 120px; /* Tăng chiều cao cho mobile */
                                                    }
                                                }
                                                .tf-pagination .pages-link {
                                                    display: inline-block;
                                                    width: 40px;
                                                    height: 40px;
                                                    line-height: 40px;
                                                    text-align: center;
                                                    border-radius: 50%;
                                                    background-color: white;
                                                    color: #0c1e35;
                                                    font-weight: 500;
                                                    border: 1px solid #ddd;
                                                    transition: all 0.3s ease;
                                                    margin: 0 4px;
                                                    cursor: pointer;
                                                    font-size: 16px;
                                                    padding: 0;
                                                }

                                                .tf-pagination .pages-link:hover,
                                                .tf-pagination .pages-link.active {
                                                    background-color: #4CAF50; /* màu xanh lá */
                                                    color: white;
                                                    border-color: #4CAF50;
                                                }
                                                .form-group.flex-five {
                                                    flex: 5;
                                                }
                                                .search-bar-group {
                                                    flex: 1;
                                                }
                                                .search-bar-group input {
                                                    width: 100%;
                                                    border: none;
                                                    outline: none;
                                                    font-size: 14px;
                                                    color: #212529;
                                                    font-weight: 500;
                                                    background: transparent;
                                                    padding: 0;
                                                }

                                                .search-bar-group input::placeholder {
                                                    color: #6c757d;
                                                    font-weight: 400;
                                                }

                                                .form-group-btn {
                                                    display: flex;
                                                    align-items: center;
                                                    gap: 10px;
                                                }
                                                .btn.btn-primary {
                                                    background-color: #4DA528 !important;
                                                    font-size: 18px;
                                                    font-weight: 500;
                                                    line-height: 18px;
                                                    border-radius: 33px;
                                                    padding: 20px 46px 20px 40px;
                                                    color: #FFFFFF !important;
                                                    border: none;
                                                    cursor: pointer;
                                                    display: inline-flex;
                                                    align-items: center;
                                                    justify-content: center;
                                                    gap: 8px;
                                                    white-space: nowrap;
                                                    text-decoration: none;
                                                }

                                                /* Hover hiệu ứng giống .btn-search nếu cần */
                                                .btn.btn-primary:hover {
                                                    background-color: #3c8e21 !important;
                                                }
                                                /* Cho Tablet: giảm số cột (ví dụ màn hình dưới 1024px) */
                                                @media (max-width: 1024px) {
                                                    .flex.wd-search {
                                                        /* Có thể chuyển sang 3 cột hoặc 2 cột tùy theo số trường bạn muốn hiển thị */
                                                        grid-template-columns: 1fr 1fr 1fr;
                                                        gap: 12px;
                                                    }

                                                    /* Đặt lại kích thước cho select khi không gian thu hẹp */
                                                    .wd-search .form-group .search-bar-group .nice-select {
                                                        min-width: unset;
                                                        max-width: unset;
                                                        width: 100%;
                                                    }
                                                }

                                                /* Cho Mobile: chuyển sang hiển thị dạng cột (mỗi ô nằm độc lập) */
                                                @media (max-width: 768px) {
                                                    .flex.wd-search {
                                                        display: flex;
                                                        flex-direction: column;
                                                        gap: 16px;
                                                    }

                                                    .wd-search .form-group {
                                                        width: 100%;
                                                    }

                                                    .wd-search .form-group .search-bar-group .nice-select,
                                                    .wd-search .form-group .search-bar-group input {
                                                        width: 100% !important;
                                                        min-width: unset;
                                                        max-width: unset;
                                                        box-sizing: border-box;
                                                    }

                                                    /* Nếu có nút search thì căn chỉnh cho chiếm trọn chiều ngang */
                                                    .wd-search .form-group .btn-search {
                                                        width: 100%;
                                                        text-align: center;
                                                    }
                                                }


                                            </style>
                                            </head>

                                            <body class="body header-fixed ">

                                                <div class="preload preload-container">
                                                    <svg class="pl" width="240" height="240" viewBox="0 0 240 240">
                                                        <circle class="pl__ring pl__ring--a" cx="120" cy="120" r="105" fill="none" stroke="#000" stroke-width="20"
                                                                stroke-dasharray="0 660" stroke-dashoffset="-330" stroke-linecap="round"></circle>
                                                        <circle class="pl__ring pl__ring--b" cx="120" cy="120" r="35" fill="none" stroke="#000" stroke-width="20"
                                                                stroke-dasharray="0 220" stroke-dashoffset="-110" stroke-linecap="round"></circle>
                                                        <circle class="pl__ring pl__ring--c" cx="85" cy="120" r="70" fill="none" stroke="#000" stroke-width="20"
                                                                stroke-dasharray="0 440" stroke-linecap="round"></circle>
                                                        <circle class="pl__ring pl__ring--d" cx="155" cy="120" r="70" fill="none" stroke="#000" stroke-width="20"
                                                                stroke-dasharray="0 440" stroke-linecap="round"></circle>
                                                    </svg>
                                                </div>
                                                <!-- /preload -->
                                                <div id="wrapper">
                                                    <div id="pagee" class="clearfix">
                                                        <jsp:include page="header.jsp" />
                                                        <!-- End Main Header -->
                                                        <main id="main">
                                                            <section class="breadcumb-section">
                                                                <div class="tf-container">
                                                                    <div class="row">
                                                                        <div class="col-lg-12 center z-index1">
                                                                            <h1 class="title">Danh Sách Sân</h1>
                                                                            <ul class="breadcumb-list flex-five">
                                                                                <li><a href="/FB_N1/home">Trang chủ</a></li>
                                                                                <li><span>Danh sách sân</span></li>
                                                                            </ul>
                                                                            <img class="bcrumb-ab" src="./assets/images/page/mask-bcrumb.png" alt="">
                                                                        </div>
                                                                    </div>

                                                                </div>
                                                            </section>
                                                            <!-- Widget Select Form -->
                                                            <form method="get" action="${pageContext.request.contextPath}/DanhSachSan">
                                                                <div class="mt--82 z-index3 relative">
                                                                    <div class="tf-container">
                                                                        <div class="row">
                                                                            <div class="col-lg-12">
                                                                                <div class="search-form-widget-slider relative">
                                                                                    <div class="flex wd-search">
                                                                                        <!-- Ô nhập tên sân -->
                                                                                        <div class="form-group flex-five">
                                                                                            <i class="icon-18"></i>
                                                                                            <div class="search-bar-group">
                                                                                                <label for="keyword">Tên sân</label>
                                                                                                <input type="text"
                                                                                                       id="keyword"
                                                                                                       name="keyword"
                                                                                                       placeholder="Nhập tên sân bạn muốn tìm..."
                                                                                                       value="${fn:escapeXml(param.keyword)}"
                                                                                                       class="form-control" />
                                                                                            </div>
                                                                                        </div>
                                                                                        <!-- Nút tìm kiếm -->
                                                                                        <div class="form-group flex-two">
                                                                                            <button type="submit" class="btn btn-primary">
                                                                                                <i class="icon-Vector5 me-2"></i> Tìm kiếm
                                                                                            </button>
                                                                                        </div>
                                                                                    </div>
                                                                                    <!-- /Thanh tìm kiếm -->
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <!-- Widget Select Form -->
                                                                <!-- Widget archieve tour -->
                                                                <section class="archieve-tour">
                                                                    <div class="tf-container">


                                                                        <div class="row">
                                                                            <div class="col-lg-4">
                                                                                <div class="sider-bar-tour-package" >
                                                                                    <div class="widget-filter mb-40">
                                                                                        <h6 class="title-tour">Lọc </h6>
                                                                                        <div class="group-select-wrap">
                                                                                            <fieldset class="group-select relative mb-22">
                                                                                                <i class="icon-Vector-8"></i>
                                                                                                <div class="search-bar-group relative">
                                                                                                    <label>Địa Điểm</label>
                                                                                                    <div class="nice-select" tabindex="0">
                                                                                                        <span class="current">
                                                                                                            <c:choose>
                                                                                                                <c:when test="${not empty param.zoneId}">
                                                                                                                    <c:forEach items="${listZ}" var="z">
                                                                                                                        <c:if test="${z.zoneId == param.zoneId}">
                                                                                                                            ${z.address}
                                                                                                                        </c:if>
                                                                                                                    </c:forEach>
                                                                                                                </c:when>
                                                                                                                <c:otherwise>Tất cả</c:otherwise>
                                                                                                            </c:choose>
                                                                                                        </span>
                                                                                                        <ul class="list">
                                                                                                            <li data-value="" class="option ${empty param.zoneId ? 'selected focus' : ''}">Tất cả</li>
                                                                                                                <c:forEach items="${listZ}" var="z">
                                                                                                                <li data-value="${z.zoneId}" class="option ${param.zoneId == z.zoneId ? 'selected focus' : ''}">
                                                                                                                    ${z.address}
                                                                                                                </li>
                                                                                                            </c:forEach>
                                                                                                        </ul>
                                                                                                    </div>
                                                                                                    <!-- Trường hidden để gửi zoneId -->
                                                                                                    <input type="hidden" name="zoneId" id="zoneIdInput" value="${param.zoneId}" />
                                                                                                </div>
                                                                                            </fieldset>
                                                                                            <fieldset class="group-select relative mb-22">
                                                                                                <i class="icon-15"></i>
                                                                                                <div class="search-bar-group relative">
                                                                                                    <label>Sân Bóng</label>
                                                                                                    <div class="nice-select" tabindex="0">
                                                                                                        <span class="current">
                                                                                                            <c:choose>
                                                                                                                <c:when test="${not empty param.typeId}">
                                                                                                                    <c:forEach var="t" items="${listT}">
                                                                                                                        <c:if test="${t.fieldTypeId == param.typeId}">
                                                                                                                            ${t.fieldTypeName}
                                                                                                                        </c:if>
                                                                                                                    </c:forEach>
                                                                                                                </c:when>
                                                                                                                <c:otherwise>Loại Sân</c:otherwise>
                                                                                                            </c:choose>
                                                                                                        </span>
                                                                                                        <ul class="list">
                                                                                                            <li data-value="" class="option ${empty param.typeId ? 'selected focus' : ''}">Tất cả</li>
                                                                                                                <c:forEach items="${listT}" var="t">
                                                                                                                <li data-value="${t.fieldTypeId}"
                                                                                                                    class="option ${param.typeId == t.fieldTypeId ? 'selected focus' : ''}">
                                                                                                                    ${t.fieldTypeName}
                                                                                                                </li>
                                                                                                            </c:forEach>
                                                                                                        </ul>
                                                                                                    </div>
                                                                                                    <!-- Trường ẩn để gửi giá trị chọn -->
                                                                                                    <input type="hidden" name="typeId" id="typeIdInput" value="${param.typeId}" />
                                                                                                </div>
                                                                                            </fieldset>
                                                                                            <fieldset class="group-select relative mb-22">
                                                                                                <i class="icon-time-left"></i>
                                                                                                <div class="search-bar-group relative">
                                                                                                    <label> Các loại ca </label>
                                                                                                    <div class="nice-select" tabindex="0">
                                                                                                        <span class="current">
                                                                                                            <c:choose>
                                                                                                                <c:when test="${param.time == 'morning'}">Ca sáng</c:when>
                                                                                                                <c:when test="${param.time == 'afternoon'}">Ca chiều</c:when>
                                                                                                                <c:when test="${param.time == 'evening'}">Ca tối</c:when>
                                                                                                                <c:otherwise>Ca nào</c:otherwise>
                                                                                                            </c:choose>
                                                                                                        </span>
                                                                                                        <ul class="list">
                                                                                                            <li data-value="" class="option ${empty param.time ? 'selected focus' : ''}">Tất cả</li>
                                                                                                            <li data-value="morning" class="option ${param.time == 'morning' ? 'selected focus' : ''}">Ca sáng</li>
                                                                                                            <li data-value="afternoon" class="option ${param.time == 'afternoon' ? 'selected focus' : ''}">Ca chiều</li>
                                                                                                            <li data-value="evening" class="option ${param.time == 'evening' ? 'selected focus' : ''}">Ca tối</li>
                                                                                                        </ul>
                                                                                                    </div>
                                                                                                    <!-- Trường hidden để submit lựa chọn -->
                                                                                                    <input type="hidden" name="time" id="timeInput" value="${param.time}" />
                                                                                                </div>
                                                                                            </fieldset>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-lg-8 listing-list-car-wrap">
                                                                                <div class="tf-my-listing mb-37">
                                                                                    <div class="row align-center">
                                                                                        <div class="col-sm-5">
                                                                                            <p class="showing">Hiện thị <span class="text-main">${showing}</span> / ${total} Tổng số sản phẩm
                                                                                            </p>
                                                                                        </div>
                                                                                        <div class="col-sm-7 group-bar-wrap flex-six">
                                                                                            <div class="listing-all-wrap">
                                                                                                <div class="flex-three">
                                                                                                    <fieldset>
                                                                                                        <div class="group-select-recently relative">
                                                                                                            <div class="nice-select" tabindex="0">
                                                                                                                <i class="icon-Vector6"></i>
                                                                                                                <span class="current">
                                                                                                                    <span class="current">
                                                                                                                        <c:choose>
                                                                                                                            <c:when test="${param.sortBy == 'name'}">Theo Tên Sân</c:when>
                                                                                                                            <c:when test="${param.sortBy == 'new'}">Sân mới</c:when>
                                                                                                                            <c:when test="${param.sortBy == 'recent'}">Mới cập nhật</c:when>
                                                                                                                            <c:otherwise>Sắp xếp</c:otherwise>
                                                                                                                        </c:choose>
                                                                                                                    </span>
                                                                                                                </span>
                                                                                                                <ul class="list">
                                                                                                                    <li data-value="" class="option ${empty param.sortBy ? 'selected focus' : ''}">Mặc định</li>
                                                                                                                    <li data-value="name" class="option ${param.sortBy == 'name' ? 'selected focus' : ''}">
                                                                                                                        Theo Tên Sân
                                                                                                                    </li>
                                                                                                                    <li data-value="new" class="option ${param.sortBy == 'new' ? 'selected focus' : ''}">
                                                                                                                        Sân mới
                                                                                                                    </li>
                                                                                                                    <li data-value="recent" class="option ${param.sortBy == 'recent' ? 'selected focus' : ''}">
                                                                                                                        Mới cập nhật
                                                                                                                    </li>
                                                                                                                </ul>
                                                                                                            </div>
                                                                                                            <input type="hidden" name="sortBy" id="sortByInput" value="${param.sortBy}" />
                                                                                                        </div>
                                                                                                    </fieldset>
                                                                                                    <div class="toolbar-list">
                                                                                                        <div class="form-group">
                                                                                                            <a class="btn-display-listing-grid active">
                                                                                                                <i class="icon-list"></i>
                                                                                                            </a>
                                                                                                        </div>
                                                                                                        <div class="form-group">
                                                                                                            <a class="btn-display-listing-list">
                                                                                                                <i class="icon-Group-1000001297"></i>
                                                                                                            </a>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="listing-list-car-grid mb-60">
                                                                                    <c:forEach items="${listF}" var="o">
                                                                                        <div class="tour-listing box-sd">
                                                                                            <a href="${pageContext.request.contextPath}/dat-san?field_id=${o.fieldId}" class="tour-listing-image">
                                                                                                <div class="badge-top flex-two">
                                                                                                    <span class="feature
                                                                                                          <c:choose>
                                                                                                              <c:when test="${o.status == 'Bảo trì'}">maintenance</c:when>
                                                                                                              <c:when test="${o.status == 'Hỏng'}">broken</c:when>
                                                                                                              <c:otherwise></c:otherwise>
                                                                                                          </c:choose>">${o.status}</span>
                                                                                                </div>
                                                                                                <img src="${o.image}" alt="Image Listing">
                                                                                            </a>
                                                                                            <div class="tour-listing-content">
                                                                                                <span class="map"><i class="icon-Vector4"></i>${o.zone.address}</span>
                                                                                                <h3 class="title-tour-list"><a href="${pageContext.request.contextPath}/dat-san?field_id=${o.fieldId}">${o.fieldName}</a>
                                                                                                </h3>
                                                                                                <div class="icon-box flex-three">
                                                                                                    <div class="icons flex-three">
                                                                                                        <i class="icon-time-left"></i>
                                                                                                        <span>Số ca: ${totalSlotMap[o.fieldId]}</span>
                                                                                                    </div>
                                                                                                    <div class="icons flex-three">
                                                                                                        <i class="icon-user"></i>
                                                                                                        <span>${o.typeOfField.fieldTypeName}</span>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="field-block" data-field-id="${o.fieldId}">
                                                                                                    <input type="date" class="slotDatePicker" data-field-id="${o.fieldId}" />
                                                                                                    <div class="time-slots">
                                                                                                        <div class="slots-header">
                                                                                                            <div class="slots-title">Khung giờ có sẵn</div>
                                                                                                            <button type="button" class="toggle-btn">
                                                                                                                <span id="toggleText">Thu gọn</span>
                                                                                                                <svg class="toggle-icon" id="toggleIcon" width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                                                                                                                    <path d="M7 14l5-5 5 5z"/>
                                                                                                                </svg>
                                                                                                            </button>

                                                                                                        </div>

                                                                                                        <div class="slots-container expanded" id="slotsContainer" data-field-id="${o.fieldId}">
                                                                                                            <div class="slots-grid">
                                                                                                                <c:forEach items="${o.slots}" var="s">
                                                                                                                    <button
                                                                                                                        type="button"
                                                                                                                        class="slot-btn"
                                                                                                                        data-field-id="${o.fieldId}"
                                                                                                                        data-price="${s.slotFieldPrice}"
                                                                                                                        data-start="${s.slotInfo.startTime}"
                                                                                                                        data-end="${s.slotInfo.endTime}"
                                                                                                                        data-slot-id="${s.slotFieldId}"
                                                                                                                        onclick="selectSlot(this)">
                                                                                                                        ${s.slotInfo.startTime} - ${s.slotInfo.endTime}
                                                                                                                    </button>
                                                                                                                </c:forEach>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                        <div class="show-more-indicator" id="showMoreIndicator">
                                                                                                            <div class="show-more-text">... và nhiều khung giờ khác</div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                    <div class="price-section">
                                                                                                        <div class="price-box flex-three">
                                                                                                            <div class="price-info">
                                                                                                                <div class="price-label" >Giá từ:</div>
                                                                                                                <div class="price-range">
                                                                                                                    <c:set var="prices" value="${priceMap[o.fieldId]}" />
                                                                                                                    <span class="price-from" data-original-min="${prices[0]}">
                                                                                                                        <fmt:formatNumber value="${prices[0]}" type="number" groupingUsed="true"/> ₫
                                                                                                                    </span>
                                                                                                                    <span class="price-to" data-original-max="${prices[1]}">
                                                                                                                        - <fmt:formatNumber value="${prices[1]}" type="number" groupingUsed="true"/> ₫
                                                                                                                    </span>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                        <div class="book-btn flex-three">
                                                                                                            <button type="button" onclick="bookField(event)">Đặt sân</button>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </c:forEach>
                                                                                </div>
                                                                                <div class="row">
                                                                                    <div class="col-md-12 ">
                                                                                        <ul class="tf-pagination flex-three">
                                                                                            <!-- Previous Button -->
                                                                                            <li>
                                                                                                <c:if test="${page > 1}">
                                                                                                    <button type="button" class="pages-link" onclick="goToPage(${page - 1})">
                                                                                                        <i class="icon-29"></i>
                                                                                                    </button>
                                                                                                </c:if>
                                                                                            </li>

                                                                                            <!-- Page Numbers -->
                                                                                            <c:forEach begin="1" end="${endP}" var="p">
                                                                                                <li>
                                                                                                    <button type="button" class="pages-link ${p == page ? 'active' : ''}" onclick="goToPage(${p})">
                                                                                                        ${p}
                                                                                                    </button>
                                                                                                </li>
                                                                                            </c:forEach>

                                                                                            <!-- Next Button -->
                                                                                            <li>
                                                                                                <c:if test="${page < endP}">
                                                                                                    <button type="button" class="pages-link" onclick="goToPage(${page + 1})">
                                                                                                        <i class="icon--1"></i>
                                                                                                    </button>
                                                                                                </c:if>
                                                                                            </li>
                                                                                        </ul>
                                                                                        <input type="hidden" name="index" id="pageIndexInput" value="${page}" />
                                                                                    </div>
                                                                                </div>

                                                                            </div>
                                                                        </div>

                                                                    </div>
                                                                </section>
                                                            </form>
                                                        </main>
                                                        <jsp:include page="footer.jsp" />
                                                        <!-- Bottom -->
                                                    </div>
                                                    <!-- /#page -->
                                                </div>
                                                <!-- CSS Flatpickr -->
                                                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

                                                    <!-- JS Flatpickr -->
                                                    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

                                                    <script src="app/js/DanhSachSan.js"></script>
                                                    <script src="app/js/jquery.min.js"></script>
                                                    <script src="app/js/jquery.nice-select.min.js"></script>
                                                    <script src="app/js/bootstrap.min.js"></script>
                                                    <script src="app/js/swiper-bundle.min.js"></script>
                                                    <script src="app/js/swiper.js"></script>
                                                    <script src="app/js/plugin.js"></script>
                                                    <script src="app/js/jquery.fancybox.js"></script>
                                                    <!--<script src="app/js/price-ranger.js"></script>-->
                                                    <script src="app/js/shortcodes.js"></script>
                                                    <script src="app/js/main.js"></script>
                                            </body>
                                            </html>
