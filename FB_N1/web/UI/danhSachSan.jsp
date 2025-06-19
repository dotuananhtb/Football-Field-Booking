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
                <title>FootballStar - Danh sách sân</title>

                <meta name="author" content="themesflat.com">
                    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

                        <link rel="stylesheet" href="app/css/app.css">
                            <link rel="stylesheet" href="app/css/jquery.fancybox.min.css">
                                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/flatpickr.min.css">

                                    <!-- Favicon and Touch Icons  -->
                                    <link rel="shortcut icon" href="assets/images/favico.png">
                                        <link rel="apple-touch-icon-precomposed" href="assets/images/favico.png">
                                            <style>
                                                .date-input {
                                                    width: 100%;
                                                    padding: 10px 15px;
                                                    border: 2px solid #e0e0e0;
                                                    border-radius: 6px;
                                                    font-size: 14px;
                                                    background-color: white;
                                                    transition: border-color 0.3s ease;
                                                }

                                                .date-input:focus {
                                                    outline: none;
                                                    border-color: #4CAF50;
                                                    box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
                                                }

                                                .date-input:hover {
                                                    border-color: #4CAF50;
                                                }

                                                /* Styling cho date picker */
                                                .date-input::-webkit-calendar-picker-indicator {
                                                    background-color: #4CAF50;
                                                    border-radius: 3px;
                                                    padding: 2px;
                                                    cursor: pointer;
                                                }

                                                .date-input::-webkit-calendar-picker-indicator:hover {
                                                    background-color: #45a049;
                                                }

                                                /* Alternative styling với Flatpickr */
                                                .flatpickr-input {
                                                    width: 100%;
                                                    padding: 10px 15px;
                                                    border: 2px solid #e0e0e0;
                                                    border-radius: 6px;
                                                    font-size: 14px;
                                                    background-color: white;
                                                    cursor: pointer;
                                                }

                                                .flatpickr-input:focus {
                                                    outline: none;
                                                    border-color: #4CAF50;
                                                    box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
                                                }

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
                                                .slot-btn {
                                                    margin: 4px;
                                                    padding: 6px 12px;
                                                    border: 1px solid #28a745;
                                                    border-radius: 6px;
                                                    background-color: #f0fff0;
                                                    cursor: pointer;
                                                    color: #83827F ;
                                                }

                                                .slot-btn.active {
                                                    background-color: #FCD34D; /* vàng nhẹ */
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
                                                    background-color: #dc3545 !important; /* đỏ */
                                                    color: white;
                                                    cursor: not-allowed;
                                                }

                                                .slot-btn.expired {
                                                    background-color: #6c757d !important; /* xám */
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
                                                            <div class="mt--82 z-index3 relative">
                                                                <div class="tf-container">
                                                                    <div class="row">
                                                                        <div class="col-lg-12">
                                                                            <div class="search-form-widget-slider relative">
                                                                                <form action="/" id="search-form-slider">
                                                                                    <div class="flex wd-search">
                                                                                        <div class="form-group flex">
                                                                                            <i class="icon-18"></i>
                                                                                            <div class="search-bar-group">
                                                                                                <label>Destination</label>
                                                                                                <div class="nice-select" tabindex="0">
                                                                                                    <span class="current">
                                                                                                        <c:choose>
                                                                                                            <c:when test="${not empty param.zid}">
                                                                                                                <c:forEach items="${listZ}" var="z">
                                                                                                                    <c:if test="${z.zoneId == param.zid}">
                                                                                                                        ${z.address}
                                                                                                                    </c:if>
                                                                                                                </c:forEach>
                                                                                                            </c:when>
                                                                                                            <c:otherwise>Vị trí</c:otherwise>
                                                                                                        </c:choose>
                                                                                                    </span>
                                                                                                    <ul class="list">
                                                                                                        <c:forEach items="${listZ}" var="z">
                                                                                                            <li data-value="${z.zoneId}" class="option">
                                                                                                                <a href="${pageContext.request.contextPath}/KhuVuc?zid=${z.zoneId}">
                                                                                                                    ${z.address}
                                                                                                                </a>
                                                                                                            </li>
                                                                                                        </c:forEach>
                                                                                                    </ul>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>

                                                                                        <div class="form-group flex">
                                                                                            <i class="icon-15"></i>
                                                                                            <div class="search-bar-group">
                                                                                                <label>Loại Sân</label>
                                                                                                <div class="nice-select" tabindex="0">
                                                                                                    <span class="current">Sân 7 người</span>
                                                                                                    <ul class="list">
                                                                                                        <li data-value="san5" class="option">Sân 5 người</li>
                                                                                                        <li data-value="san7" class="option selected">Sân 7 người
                                                                                                        </li>
                                                                                                        <li data-value="san11" class="option">Sân 11 người</li>
                                                                                                        <li data-value="futsal" class="option">Sân Futsal</li>
                                                                                                    </ul>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>

                                                                                        <div class="form-group flex">
                                                                                            <i class="icon-time-left"></i>
                                                                                            <div class="search-bar-group">
                                                                                                <label>Giờ Đặt</label>
                                                                                                <div class="nice-select" tabindex="0">
                                                                                                    <span class="current">7:00 - 9:00</span>
                                                                                                    <ul class="list">
                                                                                                        <li data-value="7-9" class="option selected">7:00 - 9:00
                                                                                                        </li>
                                                                                                        <li data-value="9-11" class="option">9:00 - 11:00</li>
                                                                                                        <li data-value="14-16" class="option">14:00 - 16:00</li>
                                                                                                        <li data-value="16-18" class="option">16:00 - 18:00</li>
                                                                                                        <li data-value="18-20" class="option">18:00 - 20:00</li>
                                                                                                        <li data-value="20-22" class="option">20:00 - 22:00</li>
                                                                                                    </ul>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>

                                                                                        <div class="form-group flex">
                                                                                            <i class="icon-Group-111"></i>
                                                                                            <div class="search-bar-group">
                                                                                                <label>Ngày Đặt</label>
                                                                                                <input type="text" class="flatpickr-input" id="bookingDateAdvanced"
                                                                                                       placeholder="Chọn ngày đặt" readonly>
                                                                                            </div>
                                                                                        </div>

                                                                                        <div class="form-group flex-two">

                                                                                            <a href="#" class="btn-search"><i class="icon-Vector5"></i>Search</a>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="wd-search-form">
                                                                                        <div class="input-group-grid">
                                                                                            <fieldset class="group-select relative ">
                                                                                                <label>tìm kiếm bằng giá</label>
                                                                                                <div class="widget widget-price ">
                                                                                                    <div id="slider-range"></div>
                                                                                                    <div class="slider-labels">
                                                                                                        <div>
                                                                                                            <input type="hidden" name="min-value" value="">
                                                                                                                <input type="hidden" name="max-value" value="">
                                                                                                                    </div>
                                                                                                                    <div class="caption flex-three">
                                                                                                                        <p class="price-range">Giá: </p>
                                                                                                                        <div class="number-range">
                                                                                                                            <span id="slider-range-value1"></span>
                                                                                                                            <span id="slider-range-value2"></span>
                                                                                                                        </div>
                                                                                                                    </div>

                                                                                                                    </div>
                                                                                                                    </div><!-- /.widget_price -->
                                                                                                                    </fieldset>
                                                                                                                    <fieldset class="group-select relative input-npd ">
                                                                                                                        <div class="search-bar-group relative">
                                                                                                                            <label>0</label>
                                                                                                                            <div class="nice-select" tabindex="0">
                                                                                                                                <span class="current">English</span>
                                                                                                                                <ul class="list">
                                                                                                                                    <li data-value="" class="option selected focus">Language
                                                                                                                                    </li>
                                                                                                                                    <li data-value="language1" class="option">Japan</li>
                                                                                                                                    <li data-value="language2" class="option">Vietnames</li>
                                                                                                                                    <li data-value="language3" class="option">Korea</li>
                                                                                                                                </ul>
                                                                                                                            </div>
                                                                                                                        </div>
                                                                                                                    </fieldset>
                                                                                                                    <fieldset class="group-select relative input-npd ">
                                                                                                                        <div class="search-bar-group relative">
                                                                                                                            <label>Any</label>
                                                                                                                            <div class="nice-select" tabindex="0">
                                                                                                                                <span class="current">Month</span>
                                                                                                                                <ul class="list">
                                                                                                                                    <li data-value="" class="option selected focus">Month
                                                                                                                                    </li>
                                                                                                                                    <li data-value="month1" class="option">1 Month</li>
                                                                                                                                    <li data-value="month2" class="option">2 Month</li>
                                                                                                                                    <li data-value="month3" class="option">3 Month</li>
                                                                                                                                </ul>
                                                                                                                            </div>
                                                                                                                        </div>
                                                                                                                    </fieldset>
                                                                                                                    <fieldset class="group-select relative input-npd">
                                                                                                                        <div class="search-bar-group relative">
                                                                                                                            <label>Any</label>
                                                                                                                            <div class="nice-select" tabindex="0">
                                                                                                                                <span class="current">Duration</span>
                                                                                                                                <ul class="list">
                                                                                                                                    <li data-value="" class="option selected focus">Duration
                                                                                                                                    </li>
                                                                                                                                    <li data-value="duration1" class="option">10-15 day</li>
                                                                                                                                    <li data-value="duration2" class="option">15-30 day</li>
                                                                                                                                    <li data-value="duration3" class="option">20-30 day</li>
                                                                                                                                </ul>
                                                                                                                            </div>
                                                                                                                        </div>
                                                                                                                    </fieldset>
                                                                                                                    <div class="group-check-box-wrap">
                                                                                                                        <div class="checkbox">
                                                                                                                            <input id="check4" type="checkbox" name="check" value="check">
                                                                                                                                <label for="check4">Accepts Credit Cards</label>
                                                                                                                        </div>
                                                                                                                        <div class="checkbox">
                                                                                                                            <input id="check5" type="checkbox" name="check" value="check">
                                                                                                                                <label for="check5">Car Parking</label>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                    <div class="group-check-box-wrap">
                                                                                                                        <div class="checkbox">
                                                                                                                            <input id="check6" type="checkbox" name="check" value="check">
                                                                                                                                <label for="check6">Free Coupons</label>
                                                                                                                        </div>
                                                                                                                        <div class="checkbox">
                                                                                                                            <input id="check7" type="checkbox" name="check" value="check">
                                                                                                                                <label for="check7">Laundry Service</label>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                    <div class="group-check-box-wrap">
                                                                                                                        <div class="checkbox">
                                                                                                                            <input id="check8" type="checkbox" name="check" value="check">
                                                                                                                                <label for="check8">Outdoor Seating</label>
                                                                                                                        </div>
                                                                                                                        <div class="checkbox">
                                                                                                                            <input id="check9" type="checkbox" name="check" value="check">
                                                                                                                                <label for="check9">Reservations</label>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                    <div class="group-check-box-wrap">
                                                                                                                        <div class="checkbox">
                                                                                                                            <input id="check10" type="checkbox" name="check" value="check">
                                                                                                                                <label for="check10">Restaurant</label>
                                                                                                                        </div>
                                                                                                                        <div class="checkbox">
                                                                                                                            <input id="check11" type="checkbox" name="check" value="check">
                                                                                                                                <label for="check11">Smoking Allowed</label>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                    </div>
                                                                                                                    </div>

                                                                                                                    </form>
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
                                                                                                                                    <form method="get" action="${pageContext.request.contextPath}/DanhSachSan" class="sider-bar-tour-package" >
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
                                                                                                                                                                <li data-value="" class="option ${empty param.typeId ? 'selected focus' : ''}">Lựa chọn</li>
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
                                                                                                                                                    <i class="icon-Group-111"></i>
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
                                                                                                                                                                <li data-value="" class="option ${empty param.time ? 'selected focus' : ''}">Lựa chọn</li>
                                                                                                                                                                <li data-value="morning" class="option ${param.time == 'morning' ? 'selected focus' : ''}">Ca sáng</li>
                                                                                                                                                                <li data-value="afternoon" class="option ${param.time == 'afternoon' ? 'selected focus' : ''}">Ca chiều</li>
                                                                                                                                                                <li data-value="evening" class="option ${param.time == 'evening' ? 'selected focus' : ''}">Ca tối</li>
                                                                                                                                                            </ul>
                                                                                                                                                        </div>
                                                                                                                                                        <!-- Trường hidden để submit lựa chọn -->
                                                                                                                                                        <input type="hidden" name="time" id="timeInput" value="${param.time}" />
                                                                                                                                                    </div>
                                                                                                                                                </fieldset>

<!--                                                                                                                                                <fieldset class="group-select relative mb-40">
                                                                                                                                                    <h6 class="title-tour">Tìm kiếm theo giá</h6>
                                                                                                                                                    <div class="widget widget-price ">
                                                                                                                                                        <div id="slider-range2"></div>
                                                                                                                                                        <div class="slider-labels">
                                                                                                                                                            <div>
                                                                                                                                                                <input type="hidden" name="min-value2" value="">
                                                                                                                                                                    <input type="hidden" name="max-value2" value="">
                                                                                                                                                                        </div>
                                                                                                                                                                        <div class="caption flex-three">
                                                                                                                                                                            <p class="price-range">Giá: </p>
                                                                                                                                                                            <div class="number-range">
                                                                                                                                                                                <span id="slider-range-value01">${param.minPrice}</span>
                                                                                                                                                                                <span id="slider-range-value02">${param.maxPrice}</span>

                                                                                                                                                                            </div>
                                                                                                                                                                            <input type="hidden" name="minPrice" id="minPriceInput" value="${param.minPrice}">
                                                                                                                                                                                <input type="hidden" name="maxPrice" id="maxPriceInput" value="${param.maxPrice}">

                                                                                                                                                                                    </div>
                                                                                                                                                                                    </div>
                                                                                                                                                                                    </div> /.widget_price 
                                                                                                                                                                                    </fieldset>-->
                                                                                                                                                                                    </div>
                                                                                                                                                                                    </div>
                                                                                                                                                                                    <!--                                                                                                                                                                        <div class="widget-filter mb-40">
                                                                                                                                                                                                <h6 class="title-tour">Search by Filter</h6>
                                                                                                                                                                                                <div class="group-check-box-wrap">
                                                                                                                                                                                                <div class="checkbox">
                                                                                                                                                                                                <input id="check" type="checkbox" name="check" value="check">
                                                                                                                                                                                                <label for="check">10+</label>
                                                                                                                                                                                                </div>
                                                                                                                                                                                                <div class="checkbox">
                                                                                                                                                                                                <input id="check1" type="checkbox" name="check" value="check">
                                                                                                                                                                                                <label for="check1">12+</label>
                                                                                                                                                                                                </div>
                                                                                                                                                                                                <div class="checkbox">
                                                                                                                                                                                                <input id="check2" type="checkbox" name="check" value="check">
                                                                                                                                                                                                <label for="check2">15+</label>
                                                                                                                                                                                                </div>
                                                                                                                                                                                                <div class="checkbox">
                                                                                                                                                                                                <input id="check3" type="checkbox" name="check" value="check">
                                                                                                                                                                                                <label for="check3">Adults</label>
                                                                                                                                                                                                </div>
                                                                                                                                                                                                </div>
                                                                                                                                                                                                </div>-->
                                                                                                                                                                                    <!--                                                                                                                                                                        <div class="widget-filter mb-40">
                                                                                                                                                                                                <h6 class="title-tour">Search by Filter</h6>
                                                                                                                                                                                                <div class="group-check-box-wrap">
                                                                                                                                                                                                <div class="checkbox">
                                                                                                                                                                                                <input id="check4-bar" type="checkbox" name="check" value="check">
                                                                                                                                                                                                <label for="check4-bar">Accepts Credit Cards</label>
                                                                                                                                                                                                </div>
                                                                                                                                                                                                <div class="checkbox">
                                                                                                                                                                                                <input id="check5-bar" type="checkbox" name="check" value="check">
                                                                                                                                                                                                <label for="check5-bar">Car Parking</label>
                                                                                                                                                                                                </div>
                                                                                                                                                                                                <div class="checkbox">
                                                                                                                                                                                                <input id="check6-bar" type="checkbox" name="check" value="check">
                                                                                                                                                                                                <label for="check6-bar">Free Coupons</label>
                                                                                                                                                                                                </div>
                                                                                                                                                                                                <div class="checkbox">
                                                                                                                                                                                                <input id="check7-bar" type="checkbox" name="check" value="check">
                                                                                                                                                                                                <label for="check7-bar">Laundry Service</label>
                                                                                                                                                                                                </div>
                                                                                                                                                                                                <div class="checkbox">
                                                                                                                                                                                                <input id="check8-bar" type="checkbox" name="check" value="check">
                                                                                                                                                                                                <label for="check8-bar">Outdoor Seating</label>
                                                                                                                                                                                                </div>
                                                                                                                                                                                                <div class="checkbox">
                                                                                                                                                                                                <input id="check9-bar" type="checkbox" name="check" value="check">
                                                                                                                                                                                                <label for="check9-bar">Reservations</label>
                                                                                                                                                                                                </div>
                                                                                                                                                                                                <div class="checkbox">
                                                                                                                                                                                                <input id="check10-bar" type="checkbox" name="check" value="check">
                                                                                                                                                                                                <label for="check10-bar">Restaurant</label>
                                                                                                                                                                                                </div>
                                                                                                                                                                                                <div class="checkbox">
                                                                                                                                                                                                <input id="check11-bar" type="checkbox" name="check" value="check">
                                                                                                                                                                                                <label for="check11-bar">Smoking Allowed</label>
                                                                                                                                                                                                </div>
                                                                                                                                                                                                </div>
                                                                                                                                                                                                </div>-->
                                                                                                                                                                                    </form>
                                                                                                                                                                                    </div>
                                                                                                                                                                                    <div class="col-lg-8 listing-list-car-wrap">
                                                                                                                                                                                        <form  action="${pageContext.request.contextPath}/DanhSachSan" class="tf-my-listing mb-37">
                                                                                                                                                                                            <input type="hidden" name="sortBy" id="sortByInput" value="${sortBy}">
                                                                                                                                                                                                <div class="row align-center">
                                                                                                                                                                                                    <div class="col-sm-5">
                                                                                                                                                                                                        <p class="showing">Showing <span class="text-main">${showing}</span> of ${total} Results
                                                                                                                                                                                                        </p>
                                                                                                                                                                                                    </div>
                                                                                                                                                                                                    <div class="col-sm-7 group-bar-wrap flex-six">
                                                                                                                                                                                                        <div class="listing-all-wrap">
                                                                                                                                                                                                        <div class="flex-three">
                                                                                                                                                                                                        <div class="group-select-recently">
                                                                                                                                                                                                        <div class="nice-select" tabindex="0">
                                                                                                                                                                                                        <i class="icon-Vector6"></i>
                                                                                                                                                                                                        <span class="current">
                                                                                                                                                                                                        <c:choose>                                                                                                                                                                                                        <c:when test="${sortBy == 'name'}">Name</c:when>
                                                                                                                                                                                                        <c:when test="${sortBy == 'new'}">Sân mới</c:when>
                                                                                                                                                                                                        <c:when test="${sortBy == 'recent'}">Mới cập nhật</c:when>
                                                                                                                                                                                                        <c:otherwise>Sort by</c:otherwise>
                                                                                                                                                                                                        </c:choose>
                                                                                                                                                                                                        </span>
                                                                                                                                                                                                        <ul class="list">                                                                                                                                                                                                        <li class="option ${sortBy == 'name' ? 'selected focus' : ''}">
                                                                                                                                                                                                        <a href="${pageContext.request.contextPath}/DanhSachSan?sortBy=name">Theo Tên Sân</a>
                                                                                                                                                                                                        </li>
                                                                                                                                                                                                        <li class="option ${sortBy == 'new' ? 'selected focus' : ''}">
                                                                                                                                                                                                        <a href="${pageContext.request.contextPath}/DanhSachSan?sortBy=new">Sân mới</a>
                                                                                                                                                                                                        </li>
                                                                                                                                                                                                        <li class="option ${sortBy == 'recent' ? 'selected focus' : ''}">
                                                                                                                                                                                                        <a href="${pageContext.request.contextPath}/DanhSachSan?sortBy=recent">Mới cập nhật</a>
                                                                                                                                                                                                        </li>
                                                                                                                                                                                                        </ul>
                                                                                                                                                                                                        </div>
                                                                                                                                                                                                        </div>
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
                                                                                                                                                                                        </form>
                                                                                                                                                                                        <div class="listing-list-car-grid mb-60">
                                                                                                                                                                                            <c:forEach items="${listF}" var="o">
                                                                                                                                                                                                <div class="tour-listing box-sd">
                                                                                                                                                                                                    <a href="tour-single.html" class="tour-listing-image">
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
                                                                                                                                                                                                        <h3 class="title-tour-list"><a href="tour-single.html">${o.fieldName}</a>
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
                                                                                                                                                                                                        <button type="button" class="toggle-btn" onclick="toggleSlots()">
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
                                                                                                                                                                                                        </div>



                                                                                                                                                                                                        <div class="price-section">
                                                                                                                                                                                                        <div class="price-box flex-three">
                                                                                                                                                                                                        <div class="price-info">
                                                                                                                                                                                                        <div class="price-label" id="priceLabel">Giá từ:</div>
                                                                                                                                                                                                        <div class="price-range">
                                                                                                                                                                                                        <c:set var="prices" value="${priceMap[o.fieldId]}" />
                                                                                                                                                                                                        <span class="price-from" id="priceDisplay" data-original-min="${prices[0]}">
                                                                                                                                                                                                        <fmt:formatNumber value="${prices[0]}" type="number" groupingUsed="true"/> ₫
                                                                                                                                                                                                        </span>
                                                                                                                                                                                                        <span class="price-to" id="originalPrice" data-original-max="${prices[1]}">
                                                                                                                                                                                                        - <fmt:formatNumber value="${prices[1]}" type="number" groupingUsed="true"/> ₫
                                                                                                                                                                                                        </span>
                                                                                                                                                                                                        </div>
                                                                                                                                                                                                        </div>
                                                                                                                                                                                                        </div>
                                                                                                                                                                                                        <div class="book-btn flex-three">
                                                                                                                                                                                                        <button type="button" onclick="bookField()">Đặt sân</button>
                                                                                                                                                                                                        </div>
                                                                                                                                                                                                        </div>
                                                                                                                                                                                                    </div>
                                                                                                                                                                                                </div>
                                                                                                                                                                                            </c:forEach>
                                                                                                                                                                                        </div>
                                                                                                                                                                                        <div class="row">
                                                                                                                                                                                            <div class="col-md-12 ">
                                                                                                                                                                                                <ul class="tf-pagination flex-three">
                                                                                                                                                                                                    <li>
                                                                                                                                                                                                        <c:if test="${page > 1}">
                                                                                                                                                                                                        <a class="pages-link" href="${pageContext.request.contextPath}/DanhSachSan?index=${page - 1}&sortBy=${sortBy}"><i class="icon-29"></i></a>
                                                                                                                                                                                                        </c:if>
                                                                                                                                                                                                    </li>
                                                                                                                                                                                                    <c:forEach begin="1" end="${endP}" var="p">
                                                                                                                                                                                                        <li>
                                                                                                                                                                                                        <a class="pages-link ${p == page ? 'active' : ''}"  href="${pageContext.request.contextPath}/DanhSachSan?index=${p}&sortBy=${sortBy}">${p}</a>
                                                                                                                                                                                                        </li>
                                                                                                                                                                                                    </c:forEach>
                                                                                                                                                                                                    <li>
                                                                                                                                                                                                        <c:if test="${page * 6 < total}">
                                                                                                                                                                                                        <a class="pages-link" href="${pageContext.request.contextPath}/DanhSachSan?index=${page + 1}&sortBy=${sortBy}"><i class=" icon--1"></i></a>
                                                                                                                                                                                                        </c:if>
                                                                                                                                                                                                    </li>
                                                                                                                                                                                                </ul>

                                                                                                                                                                                            </div>
                                                                                                                                                                                        </div>

                                                                                                                                                                                    </div>
                                                                                                                                                                                    </div>

                                                                                                                                                                                    </div>
                                                                                                                                                                                    </section>
                                                                                                                                                                                    <!-- Widget archieve tour -->

                                                                                                                                                                                    </main>

                                                                                                                                                                                    <jsp:include page="footer.jsp" />


                                                                                                                                                                                    <!-- Bottom -->
                                                                                                                                                                                    </div>
                                                                                                                                                                                    <!-- /#page -->
                                                                                                                                                                                    </div>

                                                                                                                                                                                    <!-- Modal Popup Bid -->

                                                                                                                                                                                    <a id="scroll-top" class="button-go"></a>

                                                                                                                                                                                    <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight">
                                                                                                                                                                                        <div class="offcanvas-header">
                                                                                                                                                                                            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                                                                                                                                                                                        </div>
                                                                                                                                                                                        <div class="offcanvas-body">
                                                                                                                                                                                            <div class="logo-canvas">
                                                                                                                                                                                                <img src="./assets/images/logo.png" alt="image">
                                                                                                                                                                                            </div>
                                                                                                                                                                                            <p class="des">The world’s first and largest digital market
                                                                                                                                                                                                for crypto collectibles and non-fungible
                                                                                                                                                                                            </p>
                                                                                                                                                                                            <ul class="canvas-info">
                                                                                                                                                                                                <li class="flex-three">
                                                                                                                                                                                                    <i class="icon-noun-mail-5780740-1"></i>
                                                                                                                                                                                                    <p>Info@webmail.com</p>
                                                                                                                                                                                                </li>
                                                                                                                                                                                                <li class="flex-three">
                                                                                                                                                                                                    <i class="icon-Group-9"></i>
                                                                                                                                                                                                    <p>684 555-0102 490</p>
                                                                                                                                                                                                </li>
                                                                                                                                                                                                <li class="flex-three">
                                                                                                                                                                                                    <i class="icon-Layer-19"></i>
                                                                                                                                                                                                    <p>6391 Elgin St. Celina, NYC 10299</p>
                                                                                                                                                                                                </li>
                                                                                                                                                                                            </ul>
                                                                                                                                                                                            <ul class="social flex-three">
                                                                                                                                                                                                <li>
                                                                                                                                                                                                    <a href="#">
                                                                                                                                                                                                        <i class="icon-icon-2"></i>
                                                                                                                                                                                                    </a>
                                                                                                                                                                                                </li>
                                                                                                                                                                                                <li>
                                                                                                                                                                                                    <a href="#">
                                                                                                                                                                                                        <i class="icon-x"></i>
                                                                                                                                                                                                    </a>
                                                                                                                                                                                                </li>
                                                                                                                                                                                                <li>
                                                                                                                                                                                                    <a href="#">
                                                                                                                                                                                                        <i class="icon-8"></i>
                                                                                                                                                                                                    </a>
                                                                                                                                                                                                </li>
                                                                                                                                                                                                <li>
                                                                                                                                                                                                    <a href="#">
                                                                                                                                                                                                        <i class="icon-6"></i>
                                                                                                                                                                                                    </a>
                                                                                                                                                                                                </li>
                                                                                                                                                                                            </ul>

                                                                                                                                                                                        </div>
                                                                                                                                                                                    </div>



                                                                                                                                                                                    <script>
                                                                                                                                                                                        document.querySelectorAll(".nice-select .option").forEach(function (option) {
                                                                                                                                                                                            option.addEventListener("click", function () {
                                                                                                                                                                                                const value = this.getAttribute("data-value");
                                                                                                                                                                                                const hiddenInput = this.closest("fieldset").querySelector("input[type='hidden']");
                                                                                                                                                                                                if (hiddenInput) {
                                                                                                                                                                                                    hiddenInput.value = value;
                                                                                                                                                                                                    this.closest("form").submit();
                                                                                                                                                                                                }
                                                                                                                                                                                            });
                                                                                                                                                                                        });

                                                                                                                                                                                        //tiền

                                                                                                                                                                                    </script>
                                                                                                                                                                                    <script>
                                                                                                                                                                                        document.querySelectorAll(".slotDatePicker").forEach(input => {
                                                                                                                                                                                            input.addEventListener("change", function () {
                                                                                                                                                                                                const selectedDate = this.value;
                                                                                                                                                                                                const fieldId = this.getAttribute("data-field-id");
                                                                                                                                                                                                const fieldBlock = this.closest(".field-block");

                                                                                                                                                                                                if (!fieldId || !fieldBlock) {
                                                                                                                                                                                                    console.log("❌ Thiếu fieldId hoặc fieldBlock");
                                                                                                                                                                                                    return;
                                                                                                                                                                                                }

                                                                                                                                                                                                const courtId = fieldId;

                                                                                                                                                                                                // ✅ Luôn reset UI khi date thay đổi (dù rỗng)
                                                                                                                                                                                                fieldBlock.querySelectorAll(".slot-btn").forEach(btn => {
                                                                                                                                                                                                    btn.classList.remove('booked', 'expired', 'pending', 'selected');
                                                                                                                                                                                                    btn.disabled = true;
                                                                                                                                                                                                    btn.removeAttribute('data-slot-date');
                                                                                                                                                                                                });

                                                                                                                                                                                                // ✅ Xoá slot chọn cũ
                                                                                                                                                                                                selectedSlots = selectedSlots.filter(slot => slot.courtId !== courtId);
                                                                                                                                                                                                selectedSlotPrices.delete(courtId);

                                                                                                                                                                                                // ❌ Nếu chưa có ngày thì không gọi API
                                                                                                                                                                                                if (!selectedDate) {
                                                                                                                                                                                                    console.log("📛 Input bị xoá ngày — đã reset slot UI, không gọi API");
                                                                                                                                                                                                    return;
                                                                                                                                                                                                }

                                                                                                                                                                                                console.log("📅 Đã chọn ngày:", selectedDate, "⛳ FieldId:", fieldId);

                                                                                                                                                                                                // Gán ngày vào slot để kiểm tra
                                                                                                                                                                                                fieldBlock.querySelectorAll(".slot-btn").forEach(btn => {
                                                                                                                                                                                                    btn.setAttribute("data-slot-date", selectedDate);
                                                                                                                                                                                                });

                                                                                                                                                                                                // Gọi API
                                                                                                                                                                                                $.ajax({
                                                                                                                                                                                                    url: '/FB_N1/checking-slots',
                                                                                                                                                                                                    method: 'GET',
                                                                                                                                                                                                    data: {
                                                                                                                                                                                                        fieldId: fieldId,
                                                                                                                                                                                                        start: selectedDate,
                                                                                                                                                                                                        end: selectedDate
                                                                                                                                                                                                    },
                                                                                                                                                                                                    dataType: 'json',
                                                                                                                                                                                                    success: function (bookedSlots) {
                                                                                                                                                                                                        console.log("✅ API trả về:", bookedSlots);
                                                                                                                                                                                                        updateSlotUI(bookedSlots, selectedDate, fieldBlock);
                                                                                                                                                                                                    },
                                                                                                                                                                                                    error: function (xhr, status, error) {
                                                                                                                                                                                                        console.error("❌ Lỗi API:", error);
                                                                                                                                                                                                    }
                                                                                                                                                                                                });
                                                                                                                                                                                            });
                                                                                                                                                                                        });


                                                                                                                                                                                    </script>


                                                                                                                                                                                    <script>
                                                                                                                                                                                        let selectedSlotPrices = new Map(); // Lưu giá đã chọn cho mỗi sân
                                                                                                                                                                                        let expandedStates = new Map(); // Lưu trạng thái mở/đóng của mỗi sân
                                                                                                                                                                                        let selectedSlots = [];


                                                                                                                                                                                        function selectSlot(button) {
                                                                                                                                                                                            if (button.disabled || button.classList.contains('booked') || button.classList.contains('expired')) {
                                                                                                                                                                                                console.warn("⛔ Slot không hợp lệ.");
                                                                                                                                                                                                return;
                                                                                                                                                                                            }

                                                                                                                                                                                            const courtContainer = button.closest('.time-slots');
                                                                                                                                                                                            const courtId = getCourtId(courtContainer);
                                                                                                                                                                                            const selectedDate = courtContainer.closest('.field-block')?.querySelector('.slotDatePicker')?.value;

                                                                                                                                                                                            const slotDate = button.getAttribute('data-slot-date');
                                                                                                                                                                                            const start = button.getAttribute('data-start');
                                                                                                                                                                                            const end = button.getAttribute('data-end');
                                                                                                                                                                                            const slotFieldId = button.getAttribute('data-slot-id');
                                                                                                                                                                                            const price = parseInt(button.getAttribute('data-price'));

                                                                                                                                                                                            // Ngăn người dùng chọn ca không thuộc ngày đang xem
                                                                                                                                                                                            if (slotDate !== selectedDate) {
                                                                                                                                                                                                console.warn("⚠️ Ca không thuộc ngày hiện tại.");
                                                                                                                                                                                                return;
                                                                                                                                                                                            }

                                                                                                                                                                                            // Không cho chọn nếu ngày nhỏ hơn ngày hiện tại
                                                                                                                                                                                            const now = new Date().toISOString().split('T')[0];
                                                                                                                                                                                            if (slotDate < now) {
                                                                                                                                                                                                console.warn("⚠️ Ca đã qua ngày.");
                                                                                                                                                                                                return;
                                                                                                                                                                                            }

                                                                                                                                                                                            //  Toggle chọn/bỏ chọn
                                                                                                                                                                                            if (button.classList.contains('selected')) {
                                                                                                                                                                                                button.classList.remove('selected');
                                                                                                                                                                                                selectedSlots = selectedSlots.filter(slot => slot.courtId !== courtId);
                                                                                                                                                                                                selectedSlotPrices.set(courtId, 0);
                                                                                                                                                                                                resetPriceDisplay(courtContainer);
                                                                                                                                                                                                return;
                                                                                                                                                                                            }

                                                                                                                                                                                            // Bỏ chọn slot khác của cùng sân
                                                                                                                                                                                            courtContainer.querySelectorAll('.slot-btn').forEach(btn => btn.classList.remove('selected'));

                                                                                                                                                                                            // Chọn slot mới
                                                                                                                                                                                            button.classList.add('selected');
                                                                                                                                                                                            selectedSlotPrices.set(courtId, price);
                                                                                                                                                                                            updatePriceDisplay(courtContainer, price);

                                                                                                                                                                                            selectedSlots = selectedSlots.filter(slot => slot.courtId !== courtId);
                                                                                                                                                                                            selectedSlots.push({
                                                                                                                                                                                                courtId,
                                                                                                                                                                                                slot_field_id: slotFieldId,
                                                                                                                                                                                                slot_date: slotDate,
                                                                                                                                                                                                start,
                                                                                                                                                                                                end,
                                                                                                                                                                                                price
                                                                                                                                                                                            });

                                                                                                                                                                                            console.log("📌 Slots đã chọn:", selectedSlots);
                                                                                                                                                                                        }


                                                                                                                                                                                        function bookField() {
                                                                                                                                                                                            if (selectedSlots.length === 0) {
                                                                                                                                                                                                alert("⚠️ Bạn chưa chọn ca nào để đặt.");
                                                                                                                                                                                                return;
                                                                                                                                                                                            }

                                                                                                                                                                                            const bookingDetailsList = selectedSlots.map(slot => ({
                                                                                                                                                                                                    bookingDetailsId: null,
                                                                                                                                                                                                    bookingId: null,
                                                                                                                                                                                                    slotFieldId: slot.slot_field_id,
                                                                                                                                                                                                    slotFieldPrice: slot.price,
                                                                                                                                                                                                    extraMinutes: 0,
                                                                                                                                                                                                    extraFee: 0,
                                                                                                                                                                                                    slotDate: slot.slot_date,
                                                                                                                                                                                                    note: null,
                                                                                                                                                                                                    statusCheckingId: 1
                                                                                                                                                                                                }));

                                                                                                                                                                                            $.ajax({
                                                                                                                                                                                                url: '/FB_N1/dat-san',
                                                                                                                                                                                                method: 'POST',
                                                                                                                                                                                                contentType: 'application/json',
                                                                                                                                                                                                data: JSON.stringify(bookingDetailsList),
                                                                                                                                                                                                success: function (response) {
                                                                                                                                                                                                    if (response && response.success) {
                                                                                                                                                                                                        alert("✅ Đặt sân thành công!");
                                                                                                                                                                                                        selectedSlots = [];
                                                                                                                                                                                                        selectedSlotPrices.clear();
                                                                                                                                                                                                        $('.slot-btn.selected').removeClass('selected');
                                                                                                                                                                                                    } else {
                                                                                                                                                                                                        alert("❌ Lỗi: " + (response.message || "Không rõ nguyên nhân"));
                                                                                                                                                                                                    }
                                                                                                                                                                                                },
                                                                                                                                                                                                error: function (xhr) {
                                                                                                                                                                                                    if (xhr.status === 401 || xhr.status === 302) {
                                                                                                                                                                                                        alert("⚠️ Bạn cần đăng nhập để đặt sân.");
                                                                                                                                                                                                        window.location.href = "/FB_N1/login";
                                                                                                                                                                                                    } else {
                                                                                                                                                                                                        alert("⚠️ Lỗi máy chủ: " + (xhr.responseText || "Không xác định"));
                                                                                                                                                                                                    }
                                                                                                                                                                                                }
                                                                                                                                                                                            });
                                                                                                                                                                                        }



                                                                                                                                                                                        function toggleSlots(event) {
                                                                                                                                                                                            const button = event.currentTarget; // ✅ chính là nút được click
                                                                                                                                                                                            const fieldBlock = button.closest(".field-block");

                                                                                                                                                                                            if (!fieldBlock)
                                                                                                                                                                                                return;

                                                                                                                                                                                            const fieldId = fieldBlock.getAttribute("data-field-id");
                                                                                                                                                                                            const container = fieldBlock.querySelector(".slots-container");
                                                                                                                                                                                            const toggleText = button.querySelector("span");
                                                                                                                                                                                            const toggleIcon = button.querySelector("svg");

                                                                                                                                                                                            const isExpanded = expandedStates.get(fieldId) === true;

                                                                                                                                                                                            if (isExpanded) {
                                                                                                                                                                                                container?.classList.remove("expanded");
                                                                                                                                                                                                container?.classList.add("collapsed");
                                                                                                                                                                                                toggleText.textContent = "Xem thêm";
                                                                                                                                                                                                toggleIcon.classList.add("rotated");
                                                                                                                                                                                                expandedStates.set(fieldId, false);
                                                                                                                                                                                            } else {
                                                                                                                                                                                                container?.classList.remove("collapsed");
                                                                                                                                                                                                container?.classList.add("expanded");
                                                                                                                                                                                                toggleText.textContent = "Thu gọn";
                                                                                                                                                                                                toggleIcon.classList.remove("rotated");
                                                                                                                                                                                                expandedStates.set(fieldId, true);
                                                                                                                                                                                            }
                                                                                                                                                                                        }





                                                                                                                                                                                        function updatePriceDisplay(courtContainer, price) {
                                                                                                                                                                                            // Tìm price section của sân này (có thể ở ngoài time-slots)
                                                                                                                                                                                            let priceSection = courtContainer.parentElement.querySelector('.price-section');
                                                                                                                                                                                            if (!priceSection) {
                                                                                                                                                                                                priceSection = courtContainer.querySelector('.price-section');
                                                                                                                                                                                            }

                                                                                                                                                                                            if (priceSection) {
                                                                                                                                                                                                const priceLabel = priceSection.querySelector('.price-label, [id*="priceLabel"]');
                                                                                                                                                                                                const priceDisplay = priceSection.querySelector('.price-from, [id*="priceDisplay"]');
                                                                                                                                                                                                const originalPrice = priceSection.querySelector('.price-to, [id*="originalPrice"]');

                                                                                                                                                                                                if (priceLabel)
                                                                                                                                                                                                    priceLabel.textContent = 'Giá đã chọn:';
                                                                                                                                                                                                if (priceDisplay)
                                                                                                                                                                                                    priceDisplay.textContent = formatPrice(price) + ' ₫';
                                                                                                                                                                                                if (originalPrice)
                                                                                                                                                                                                    originalPrice.style.display = 'none';
                                                                                                                                                                                            }
                                                                                                                                                                                        }

                                                                                                                                                                                        function resetPriceDisplay(courtContainer) {
                                                                                                                                                                                            let priceSection = courtContainer.parentElement.querySelector('.price-section');
                                                                                                                                                                                            if (!priceSection) {
                                                                                                                                                                                                priceSection = courtContainer.querySelector('.price-section');
                                                                                                                                                                                            }

                                                                                                                                                                                            if (priceSection) {
                                                                                                                                                                                                const priceLabel = priceSection.querySelector('.price-label, [id*="priceLabel"]');
                                                                                                                                                                                                const priceDisplay = priceSection.querySelector('.price-from, [id*="priceDisplay"]');
                                                                                                                                                                                                const originalPrice = priceSection.querySelector('.price-to, [id*="originalPrice"]');

                                                                                                                                                                                                if (priceDisplay) {
                                                                                                                                                                                                    const originalMin = priceDisplay.getAttribute('data-original-min');
                                                                                                                                                                                                    if (originalMin) {
                                                                                                                                                                                                        priceDisplay.textContent = formatPrice(parseInt(originalMin)) + ' ₫';
                                                                                                                                                                                                    }
                                                                                                                                                                                                }

                                                                                                                                                                                                if (originalPrice) {
                                                                                                                                                                                                    const originalMax = originalPrice.getAttribute('data-original-max');
                                                                                                                                                                                                    if (originalMax) {
                                                                                                                                                                                                        originalPrice.textContent = '- ' + formatPrice(parseInt(originalMax)) + ' ₫';
                                                                                                                                                                                                        originalPrice.style.display = 'inline';
                                                                                                                                                                                                    }
                                                                                                                                                                                                }
                                                                                                                                                                                            }
                                                                                                                                                                                        }


                                                                                                                                                                                        function formatPrice(price) {
                                                                                                                                                                                            return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
                                                                                                                                                                                        }

                                                                                                                                                                                        // Tạo ID duy nhất cho mỗi sân
                                                                                                                                                                                        function getCourtId(courtContainer) {
                                                                                                                                                                                            if (!courtContainer.dataset.courtId) {
                                                                                                                                                                                                // Tạo ID duy nhất dựa trên vị trí trong DOM
                                                                                                                                                                                                const allCourts = document.querySelectorAll('.time-slots');
                                                                                                                                                                                                const index = Array.from(allCourts).indexOf(courtContainer);
                                                                                                                                                                                                courtContainer.dataset.courtId = 'court_' + index;
                                                                                                                                                                                            }
                                                                                                                                                                                            return courtContainer.dataset.courtId;
                                                                                                                                                                                        }

                                                                                                                                                                                        // Simulate some unavailable slots
                                                                                                                                                                                        function updateSlotUI(bookedSlots, selectedDate, fieldBlock) {
                                                                                                                                                                                            if (!fieldBlock) {
                                                                                                                                                                                                console.error("❌ fieldBlock is undefined");
                                                                                                                                                                                                return;
                                                                                                                                                                                            }

                                                                                                                                                                                            const btns = fieldBlock.querySelectorAll('.slot-btn');

                                                                                                                                                                                            btns.forEach(btn => {
                                                                                                                                                                                                const start = btn.getAttribute('data-start'); // vd: "12:00"
                                                                                                                                                                                                const end = btn.getAttribute('data-end');
                                                                                                                                                                                                const slotId = btn.getAttribute('data-slot-id');

                                                                                                                                                                                                const matchedSlot = bookedSlots.find(slot => {
                                                                                                                                                                                                    const slotFieldId = slot.extendedProps?.slot_field_id;
                                                                                                                                                                                                    return String(slotFieldId) === String(slotId);
                                                                                                                                                                                                });

                                                                                                                                                                                                if (matchedSlot) {
                                                                                                                                                                                                    const status = matchedSlot.extendedProps?.status;

                                                                                                                                                                                                    if (status === "Booked") {
                                                                                                                                                                                                        btn.classList.add('booked');
                                                                                                                                                                                                        btn.disabled = true;
                                                                                                                                                                                                    } else if (status === "Đã qua") {
                                                                                                                                                                                                        btn.classList.add('expired');
                                                                                                                                                                                                        btn.disabled = true;
                                                                                                                                                                                                    } else if (status === "Pending") {
                                                                                                                                                                                                        // Có thể xử lý riêng nếu cần
                                                                                                                                                                                                        btn.classList.add('pending');
                                                                                                                                                                                                        btn.disabled = true;
                                                                                                                                                                                                    } else {
                                                                                                                                                                                                        btn.classList.remove('booked', 'expired');
                                                                                                                                                                                                        btn.disabled = false;
                                                                                                                                                                                                    }

                                                                                                                                                                                                    console.log("🔒 Slot đã bị đặt:", {slotId, start, end, status});
                                                                                                                                                                                                } else {
                                                                                                                                                                                                    // Không match thì vẫn là slot trống, nhưng kiểm tra thêm ngày có đã qua chưa
                                                                                                                                                                                                    const slotDateTime = new Date(`${selectedDate}T${start}`);
                                                                                                                                                                                                                    const now = new Date();

                                                                                                                                                                                                                    if (slotDateTime < now) {
                                                                                                                                                                                                                        btn.classList.add('expired');
                                                                                                                                                                                                                        btn.disabled = true;
                                                                                                                                                                                                                        console.log("⏰ Slot đã qua thời gian:", {slotId, start, end});
                                                                                                                                                                                                                    } else {
                                                                                                                                                                                                                        btn.classList.remove('booked', 'expired');
                                                                                                                                                                                                                        btn.disabled = false;
                                                                                                                                                                                                                        console.log("✅ Slot còn trống:", {slotId, start, end});
                                                                                                                                                                                                                    }
                                                                                                                                                                                                                }

                                                                                                                                                                                                            });
                                                                                                                                                                                                        }




                                                                                                                                                                                                        // Initialize
                                                                                                                                                                                                        document.addEventListener('DOMContentLoaded', function () {


                                                                                                                                                                                                            document.querySelectorAll('.time-slots').forEach(courtContainer => {
                                                                                                                                                                                                                const courtId = getCourtId(courtContainer);

                                                                                                                                                                                                                // ✅ Gán trạng thái ban đầu là "collapsed"
                                                                                                                                                                                                                expandedStates.set(courtId, false);

                                                                                                                                                                                                                // ✅ Cập nhật UI về trạng thái thu gọn đúng cách
                                                                                                                                                                                                                const container = courtContainer.querySelector('.slots-container, #slotsContainer');
                                                                                                                                                                                                                const toggleText = courtContainer.querySelector('#toggleText, [id*="toggleText"]');
                                                                                                                                                                                                                const toggleIcon = courtContainer.querySelector('#toggleIcon, [id*="toggleIcon"]');
                                                                                                                                                                                                                const showMoreIndicator = courtContainer.querySelector('#showMoreIndicator, [id*="showMoreIndicator"]');

                                                                                                                                                                                                                container?.classList.add('collapsed');
                                                                                                                                                                                                                container?.classList.remove('expanded');
                                                                                                                                                                                                                toggleText && (toggleText.textContent = 'Xem thêm');
                                                                                                                                                                                                                toggleIcon?.classList.add('rotated');
                                                                                                                                                                                                                showMoreIndicator?.classList.add('visible');
                                                                                                                                                                                                            });

                                                                                                                                                                                                            // ✅ Gắn sự kiện click sau khi đã xử lý trạng thái ban đầu
                                                                                                                                                                                                            document.querySelectorAll('.toggle-btn').forEach(btn => {
                                                                                                                                                                                                                btn.addEventListener('click', toggleSlots);
                                                                                                                                                                                                            });
                                                                                                                                                                                                        });

                                                                                                                                                                                                        // Utility functions
                                                                                                                                                                                                        function getAllSelectedSlots() {
                                                                                                                                                                                                            const result = {};
                                                                                                                                                                                                            document.querySelectorAll('.time-slots').forEach(courtContainer => {
                                                                                                                                                                                                                const courtId = getCourtId(courtContainer);
                                                                                                                                                                                                                const selectedButton = courtContainer.querySelector('.slot-btn.selected');
                                                                                                                                                                                                                const price = selectedSlotPrices.get(courtId) || 0;

                                                                                                                                                                                                                if (selectedButton && price > 0) {
                                                                                                                                                                                                                    result[courtId] = {
                                                                                                                                                                                                                        time: selectedButton.textContent.trim(),
                                                                                                                                                                                                                        price: price
                                                                                                                                                                                                                    };
                                                                                                                                                                                                                }
                                                                                                                                                                                                            });
                                                                                                                                                                                                            return result;
                                                                                                                                                                                                        }

                                                                                                                                                                                                        function getTotalPrice() {
                                                                                                                                                                                                            let total = 0;
                                                                                                                                                                                                            selectedSlotPrices.forEach(price => {
                                                                                                                                                                                                                total += price;
                                                                                                                                                                                                            });
                                                                                                                                                                                                            return total;
                                                                                                                                                                                                        }

                                                                                                                                                                                                        function resetAllSelections() {
                                                                                                                                                                                                            document.querySelectorAll('.time-slots').forEach(courtContainer => {
                                                                                                                                                                                                                const courtId = getCourtId(courtContainer);
                                                                                                                                                                                                                courtContainer.querySelectorAll('.slot-btn').forEach(btn => {
                                                                                                                                                                                                                    btn.classList.remove('selected');
                                                                                                                                                                                                                });
                                                                                                                                                                                                                selectedSlotPrices.set(courtId, 0);
                                                                                                                                                                                                                resetPriceDisplay(courtContainer);
                                                                                                                                                                                                            });
                                                                                                                                                                                                        }
                                                                                                                                                                                    </script>
                                                                                                                                                                                    <!-- Flatpickr JS -->
                                                                                                                                                                                    <script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/flatpickr.min.js"></script>
                                                                                                                                                                                    <!-- Flatpickr Vietnamese locale -->
                                                                                                                                                                                    <script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/l10n/vn.js"></script>
                                                                                                                                                                                    <script>
                                                                                                                                                                                                        // Initialize Flatpickr for date picker
                                                                                                                                                                                                        const datePicker = flatpickr("#bookingDateAdvanced", {
                                                                                                                                                                                                            locale: "vn",
                                                                                                                                                                                                            dateFormat: "d/m/Y",
                                                                                                                                                                                                            minDate: "today",
                                                                                                                                                                                                            defaultDate: new Date(),
                                                                                                                                                                                                            enableTime: false,
                                                                                                                                                                                                            clickOpens: true,
                                                                                                                                                                                                            allowInput: false,
                                                                                                                                                                                                            onChange: function (selectedDates, dateStr, instance) {
                                                                                                                                                                                                                console.log("Ngày được chọn:", dateStr);
                                                                                                                                                                                                            }
                                                                                                                                                                                                        });

                                                                                                                                                                                                        // Custom nice-select functionality
                                                                                                                                                                                                        document.querySelectorAll('.nice-select').forEach(select => {
                                                                                                                                                                                                            select.addEventListener('click', function (e) {
                                                                                                                                                                                                                e.stopPropagation();

                                                                                                                                                                                                                // Close all other selects
                                                                                                                                                                                                                document.querySelectorAll('.nice-select').forEach(otherSelect => {
                                                                                                                                                                                                                    if (otherSelect !== this) {
                                                                                                                                                                                                                        otherSelect.classList.remove('open');
                                                                                                                                                                                                                    }
                                                                                                                                                                                                                });

                                                                                                                                                                                                                // Toggle current select
                                                                                                                                                                                                                this.classList.toggle('open');
                                                                                                                                                                                                            });

                                                                                                                                                                                                            // Handle option selection
                                                                                                                                                                                                            select.querySelectorAll('.option').forEach(option => {
                                                                                                                                                                                                                option.addEventListener('click', function (e) {
                                                                                                                                                                                                                    e.stopPropagation();

                                                                                                                                                                                                                    const selectElement = this.closest('.nice-select');
                                                                                                                                                                                                                    const currentSpan = selectElement.querySelector('.current');
                                                                                                                                                                                                                    const hiddenInput = selectElement.parentElement.querySelector('input[type="hidden"]');

                                                                                                                                                                                                                    // Remove selected class from all options
                                                                                                                                                                                                                    selectElement.querySelectorAll('.option').forEach(opt => {
                                                                                                                                                                                                                        opt.classList.remove('selected');
                                                                                                                                                                                                                    });

                                                                                                                                                                                                                    // Add selected class to clicked option
                                                                                                                                                                                                                    this.classList.add('selected');

                                                                                                                                                                                                                    // Update current text and hidden input value
                                                                                                                                                                                                                    currentSpan.textContent = this.textContent;
                                                                                                                                                                                                                    if (hiddenInput) {
                                                                                                                                                                                                                        hiddenInput.value = this.getAttribute('data-value');
                                                                                                                                                                                                                    }

                                                                                                                                                                                                                    // Close dropdown
                                                                                                                                                                                                                    selectElement.classList.remove('open');
                                                                                                                                                                                                                });
                                                                                                                                                                                                            });
                                                                                                                                                                                                        });

                                                                                                                                                                                                        // Close dropdowns when clicking outside
                                                                                                                                                                                                        document.addEventListener('click', function () {
                                                                                                                                                                                                            document.querySelectorAll('.nice-select').forEach(select => {
                                                                                                                                                                                                                select.classList.remove('open');
                                                                                                                                                                                                            });
                                                                                                                                                                                                        });

                                                                                                                                                                                                        // Handle search button click
                                                                                                                                                                                                        document.querySelector('.btn-search').addEventListener('click', function (e) {
                                                                                                                                                                                                            e.preventDefault();

                                                                                                                                                                                                            // Validate required fields
                                                                                                                                                                                                            const bookingDate = document.getElementById('bookingDateAdvanced').value;
                                                                                                                                                                                                            if (!bookingDate) {
                                                                                                                                                                                                                alert('Vui lòng chọn ngày đặt sân!');
                                                                                                                                                                                                                return;
                                                                                                                                                                                                            }

                                                                                                                                                                                                            // Submit form to servlet
                                                                                                                                                                                                            document.getElementById('search-form-slider').submit();
                                                                                                                                                                                                        });

                                                                                                                                                                                                        // Handle form submission
                                                                                                                                                                                                        document.getElementById('search-form-slider').addEventListener('submit', function (e) {
                                                                                                                                                                                                            const bookingDate = document.getElementById('bookingDateAdvanced').value;
                                                                                                                                                                                                            if (!bookingDate) {
                                                                                                                                                                                                                e.preventDefault();
                                                                                                                                                                                                                alert('Vui lòng chọn ngày đặt sân!');
                                                                                                                                                                                                                return false;
                                                                                                                                                                                                            }
                                                                                                                                                                                                        });

                                                                                                                                                                                                        // Ensure date picker is clickable
                                                                                                                                                                                                        document.getElementById('bookingDateAdvanced').addEventListener('click', function () {
                                                                                                                                                                                                            if (this._flatpickr) {
                                                                                                                                                                                                                this._flatpickr.open();
                                                                                                                                                                                                            }
                                                                                                                                                                                                        }
                                                                                                                                                                                                        );
                                                                                                                                                                                    </script>
                                                                                                                                                                                    <!--sắp xếp-->

                                                                                                                                                                                    <script src="app/js/jquery.min.js"></script>
                                                                                                                                                                                    <script src="app/js/jquery.nice-select.min.js"></script>
                                                                                                                                                                                    <script src="app/js/bootstrap.min.js"></script>
                                                                                                                                                                                    <script src="app/js/swiper-bundle.min.js"></script>
                                                                                                                                                                                    <script src="app/js/swiper.js"></script>
                                                                                                                                                                                    <script src="app/js/plugin.js"></script>
                                                                                                                                                                                    <script src="app/js/jquery.fancybox.js"></script>
                                                                                                                                                                                    <script src="app/js/price-ranger.js"></script>
                                                                                                                                                                                    <script src="app/js/shortcodes.js"></script>
                                                                                                                                                                                    <script src="app/js/main.js"></script>

                                                                                                                                                                                    </body>

                                                                                                                                                                                    </html>
