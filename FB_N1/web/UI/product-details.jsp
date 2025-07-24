<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <base href="${pageContext.request.contextPath}/UI/">
    <meta charset="UTF-8">
    <title>Chi tiết sản phẩm</title>
    <link rel="stylesheet" href="app/css/app.css">
    <link rel="shortcut icon" href="assets/images/logoKoChu.png">
    <style>
        .product-details-container {
            display: flex;
            gap: 48px;
            background: #f5f8ff;
            padding: 40px;
            border-radius: 20px;
            max-width: 1100px;
            margin: 60px auto 40px auto;
            box-shadow: 0 2px 16px rgba(0,0,0,0.08);
        }
        .product-image {
            flex: 1 1 400px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
        }
        .product-image img {
            width: 400px;
            max-width: 100%;
            border-radius: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.07);
            object-fit: cover;
        }
        .image-note {
            margin-top: 10px;
            color: #888;
            font-size: 1rem;
        }
        .product-info {
            flex: 1 1 400px;
            display: flex;
            flex-direction: column;
            gap: 18px;
        }
        .product-title {
            font-size: 2.2rem;
            font-weight: bold;
            color: #0c1e35;
            margin-bottom: 0;
        }
        .product-price {
            font-size: 2rem;
            color: #e53935;
            font-weight: bold;
            margin-bottom: 8px;
        }
        .product-color, .product-size, .product-quantity {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 8px;
        }
        .color-btn, .size-btn {
            border: 1px solid #6c7ae0;
            background: #fff;
            color: #6c7ae0;
            border-radius: 10px;
            padding: 8px 20px;
            margin-right: 8px;
            cursor: pointer;
            font-size: 1rem;
            transition: background 0.2s, color 0.2s;
        }
        .color-btn.active, .size-btn.active {
            background: linear-gradient(90deg, #6c7ae0, #8f6ed5);
            color: #fff;
        }
        .product-quantity button {
            width: 36px;
            height: 36px;
            border-radius: 8px;
            border: 1px solid #6c7ae0;
            background: #fff;
            color: #6c7ae0;
            font-size: 1.2rem;
            cursor: pointer;
        }
        .product-quantity input {
            width: 48px;
            text-align: center;
            font-size: 1.1rem;
            border: 1px solid #ccc;
            border-radius: 8px;
            margin: 0 6px;
        }
        .product-description {
            margin-top: 10px;
            color: #444;
            font-size: 1.1rem;
        }
        @media (max-width: 900px) {
            .product-details-container {
                flex-direction: column;
                gap: 24px;
                padding: 20px;
            }
            .product-image img {
                width: 100%;
                max-width: 350px;
            }
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp" />
<section class="breadcumb-section">
    <div class="tf-container">
        <div class="row">
            <div class="col-lg-12 center z-index1">
                <h1 class="title">Cửa hàng</h1>
                <ul class="breadcumb-list flex-five">
                    <li><a href="/FB_N1/home">Trang chủ</a></li>
                    <li><span>Chi tiết sản phẩm</span></li>
                </ul>
                <img class="bcrumb-ab" src="assets/images/page/mask-bcrumb.png" alt="">
            </div>
        </div>
    </div>
</section>
<div class="product-details-container">
    <div class="product-image">
        <img src="${product.productImage}" alt="${product.productName}" onerror="this.src='assets/images/slide/img-1.jpg'">
    </div>
    <div class="product-info">
        <div class="product-title">${product.productName}</div>
        <div class="product-price">
            <c:choose>
                <c:when test="${product.productPrice > 0}">
                    <c:out value="${product.productPrice}"/> đ
                </c:when>
                <c:otherwise>
                    <span>Liên hệ</span>
                </c:otherwise>
            </c:choose>
        </div>
        <c:if test="${not empty productDetails}">
            <c:set var="colors" value="" />
            <c:set var="sizes" value="" />
            <c:set var="materials" value="" />
            <c:set var="weights" value="" />
            <c:set var="origins" value="" />
            <c:set var="warranties" value="" />
            <c:set var="moreInfos" value="" />
            <c:forEach var="detail" items="${productDetails}">
                <c:if test="${not empty detail.color and not fn:contains(colors, detail.color)}">
                    <c:set var="colors" value="${colors}${detail.color}, " />
                </c:if>
                <c:if test="${not empty detail.size and not fn:contains(sizes, detail.size)}">
                    <c:set var="sizes" value="${sizes}${detail.size}, " />
                </c:if>
                <c:if test="${not empty detail.material and not fn:contains(materials, detail.material)}">
                    <c:set var="materials" value="${materials}${detail.material}, " />
                </c:if>
                <c:if test="${not empty detail.weight and not fn:contains(weights, detail.weight)}">
                    <c:set var="weights" value="${weights}${detail.weight}, " />
                </c:if>
                <c:if test="${not empty detail.origin and not fn:contains(origins, detail.origin)}">
                    <c:set var="origins" value="${origins}${detail.origin}, " />
                </c:if>
                <c:if test="${not empty detail.warranty and not fn:contains(warranties, detail.warranty)}">
                    <c:set var="warranties" value="${warranties}${detail.warranty}, " />
                </c:if>
                <c:if test="${not empty detail.moreInfo and not fn:contains(moreInfos, detail.moreInfo)}">
                    <c:set var="moreInfos" value="${moreInfos}${detail.moreInfo}, " />
                </c:if>
            </c:forEach>
            <div class="product-attributes-list" style="display: flex; flex-wrap: wrap; gap: 16px 24px; margin-bottom: 16px;">
                <div style="min-width: 160px;"><strong>Màu sắc:</strong> ${fn:substring(colors, 0, fn:length(colors)-2)}</div>
                <div style="min-width: 120px;"><strong>Size:</strong> ${fn:substring(sizes, 0, fn:length(sizes)-2)}</div>
                <div style="min-width: 160px;"><strong>Chất liệu:</strong> 
                    <c:choose>
                        <c:when test="${fn:contains(materials, ', ')}">
                            ${fn:substring(materials, 0, fn:indexOf(materials, ', '))}
                        </c:when>
                        <c:otherwise>
                            ${materials}
                        </c:otherwise>
                    </c:choose>
                </div>
                <div style="min-width: 160px;"><strong>Trọng lượng:</strong> 
                    <c:choose>
                        <c:when test="${fn:contains(weights, ', ')}">
                            ${fn:substring(weights, 0, fn:indexOf(weights, ', '))}
                        </c:when>
                        <c:otherwise>
                            ${weights}
                        </c:otherwise>
                    </c:choose>
                </div>
                <div style="min-width: 120px;"><strong>Xuất xứ:</strong> 
                    <c:choose>
                        <c:when test="${fn:contains(origins, ', ')}">
                            ${fn:substring(origins, 0, fn:indexOf(origins, ', '))}
                        </c:when>
                        <c:otherwise>
                            ${origins}
                        </c:otherwise>
                    </c:choose>
                </div>
                <div style="min-width: 140px;"><strong>Bảo hành:</strong> 
                    <c:choose>
                        <c:when test="${fn:contains(warranties, ', ')}">
                            ${fn:substring(warranties, 0, fn:indexOf(warranties, ', '))}
                        </c:when>
                        <c:otherwise>
                            ${warranties}
                        </c:otherwise>
                    </c:choose>
                </div>
                <div style="min-width: 120px;"><strong>Khác:</strong> 
                    <c:choose>
                        <c:when test="${fn:contains(moreInfos, ', ')}">
                            ${fn:substring(moreInfos, 0, fn:indexOf(moreInfos, ', '))}
                        </c:when>
                        <c:otherwise>
                            ${moreInfos}
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:if>
        <!-- Bỏ phần số lượng -->
        <div class="product-description" style="margin-top: 12px;">
            <span>Mô tả:</span>
            <p>${product.productDescription}</p>
        </div>
    </div>
</div>
<script>
function selectColor(btn) {
    document.querySelectorAll('.color-btn').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
}
function selectSize(btn) {
    document.querySelectorAll('.size-btn').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
}
function changeQuantity(delta) {
    var input = document.getElementById('quantity');
    var val = parseInt(input.value) + delta;
    if(val < 1) val = 1;
    input.value = val;
}
</script>
<jsp:include page="footer.jsp" />
</body>
</html>
