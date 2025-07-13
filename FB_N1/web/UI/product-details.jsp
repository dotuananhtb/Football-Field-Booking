<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <base href="${pageContext.request.contextPath}/UI/">
    <meta charset="UTF-8">
    <title>Chi tiết sản phẩm</title>
    <link rel="stylesheet" href="app/css/app.css">
    <style>
        .product-details-main {
            max-width: 900px;
            margin: 80px auto 40px auto; /* tăng margin-top để cách xa header */
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 16px rgba(0,0,0,0.08);
            padding: 32px 24px;
        }
        .product-header {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 64px; /* tăng khoảng cách giữa ảnh và tên */
            margin-bottom: 32px;
            justify-content: flex-start;
        }
        .product-header-img {
            flex: 1 1 350px;
            min-width: 220px;
            max-width: 400px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .product-header-img img {
            width: 100%;
            border-radius: 16px;
            object-fit: cover;
            box-shadow: 0 2px 8px rgba(0,0,0,0.07);
            max-height: 260px;
        }
        .product-header-info {
            flex: 2 1 300px;
            display: flex;
            align-items: center;
            justify-content: flex-start;
            height: 100%;
            min-width: 200px;
        }
        .product-title {
            font-size: 2.8rem;
            font-weight: bold;
            color: #0c1e35;
            margin-bottom: 0;
            margin-left: 0;
            line-height: 1.2;
        }
        .product-variant-list {
            width: 100%;
            border-collapse: collapse;
            margin-top: 12px;
        }
        .product-variant-list th, .product-variant-list td {
            padding: 10px 12px;
            border-bottom: 1px solid #e8ecef;
            text-align: left;
        }
        .product-variant-list th {
            background: #f8fafc;
            color: #4CAF50;
        }
        .product-variant-list tr:last-child td {
            border-bottom: none;
        }
        .product-moreinfo {
            margin-top: 18px;
            font-style: italic;
            color: #666;
        }
        @media (max-width: 900px) {
            .product-header {
                gap: 24px;
            }
        }
        @media (max-width: 768px) {
            .product-header {
                flex-direction: column;
                gap: 16px;
                align-items: stretch;
            }
            .product-header-info {
                justify-content: center;
                align-items: flex-start;
                margin-top: 12px;
            }
            .product-title {
                font-size: 2rem;
                text-align: center;
                width: 100%;
            }
            .product-details-main {
                padding: 16px 4px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <!-- Breadcrumb section giống shop.jsp -->
    <section class="breadcumb-section">
        <div class="tf-container">
            <div class="row">
                <div class="col-lg-12 center z-index1">
                    <h1 class="title">Cửa hàng</h1>
                    <ul class="breadcumb-list flex-five">
                        <li><a href="/FB_N1/home">Trang chủ</a></li>
                        <li><span>Danh sách sản phẩm</span></li>
                        <li><span>›</span></li>
                        <li><span>Chi tiết sản phẩm</span></li>
                    </ul>
                    <img class="bcrumb-ab" src="assets/images/page/mask-bcrumb.png" alt="">
                </div>
            </div>
        </div>
    </section>
    <!-- Search bar section giống shop.jsp -->
    <form method="get" action="${pageContext.request.contextPath}/Shop">
        <div class="mt--82 z-index3 relative">
            <div class="tf-container">
                <div class="row">
                    <div class="col-lg-12">
                        
                    </div>
                </div>
            </div>
        </div>
    </form>
    <!-- Product details main content -->
    <div class="product-details-main">
        <div class="product-header">
            <div class="product-header-img">
                <img src="${product.productImage}" alt="${product.productName}" onerror="this.src='assets/images/slide/img-1.jpg'">
            </div>
            <div class="product-header-info">
                <div class="product-title">${product.productName}</div>
            </div>
        </div>
        <h3>Biến Thể Sản Phẩm</h3>
        <table class="product-variant-list">
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Màu sắc</th>
                    <th>Kích thước</th>
                    <th>Chất liệu</th>
                    <th>Trọng lượng</th>
                    <th>Xuất xứ</th>
                    <th>Bảo hành</th>
                    <th>Thông tin thêm</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="detail" items="${productDetails}" varStatus="loop">
                    <tr>
                        <td>${loop.index + 1}</td>
                        <td>${detail.color}</td>
                        <td>${detail.size}</td>
                        <td>${detail.material}</td>
                        <td>${detail.weight}</td>
                        <td>${detail.origin}</td>
                        <td>${detail.warranty}</td>
                        <td>${detail.moreInfo}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>
