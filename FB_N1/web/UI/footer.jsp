<%-- 
    Document   : footer
    Created on : May 30, 2025, 8:46:37 AM
    Author     : Đỗ Tuấn Anh
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<head>
    <!-- comment -->
    <base href="${pageContext.request.contextPath}/UI/">
    <!-- comment -->
</head>

<footer class="footer footer-style1">
    
    <div class="tf-container">
        <div class="footer-main">
            <c:set value="${requestScope.ct}" var="ct"></c:set>
            <div class="footer-logo">
                <div class="logo-footer">
                    <a href ="/FB_N1/home" ><img src="./assets/images/logo_dark__2_-removebg-preview.png"  alt="logo"></a>
                </div>
                <p class="des-footer"> Thông tin liên lạc
                </p>
                
                <ul class="footer-info">
                    <li class="flex-three">
                        <i class="icon-noun-mail-5780740-1"></i>
                        <p>nguyena7k58@gmail.com</p>
                    </li>
                    <li class="flex-three">
                        <i class="icon-Group-9"></i>
                        <p>0123456789</p>
                    </li>
                    <li class="flex-three">
                        <i class="icon-Layer-19"></i>
                        <p>ĐH FPT - Hòa Lạc - Hà Nội</p>
                    </li>
                </ul>
                    <br/>
<iframe src="https://www.google.com/maps/embed?pb=!1m16!1m12!1m3!1d238288.81639649623!2d105.59250864754692!3d21.06216523434805!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!2m1!1zxJHhuqFpIGjhu41jIGZwdA!5e0!3m2!1svi!2s!4v1749128102553!5m2!1svi!2s" width="300px" height="300px" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
            </div>
            <div class="footer-service">
                <h5 class="title">Quy định và chính sách</h5>

                <ul class="footer-menu">
                    <li>
                        <a href="about-us.html">Hướng dẫn sử dụng</a>
                    </li>
                    <li>
                        <a href="gallery.html">Quy chế Hoạt động ứng dụng</a>
                    </li>
                    <li>
                        <a href="team.html">Thông tin về thanh toán</a>
                    </li>
                    <li>
                        <a href="blog.html">Chính sách bảo mật thông tin cá nhân</a>
                    </li>
                    <li>
                        <a href="contact/">Thông tin chăm sóc khách hàng</a>
                    </li>
                </ul>

            </div>
            
            <div class="footer-gallery">
                <h5 class="title">Phòng trưng bày</h5>

                <div class="gallery-img">
                    <a href=".\assets\images\footer\san1.webp" data-fancybox="gallery">
                        <img src=".\assets\images\footer\san1.webp" alt="image gallery">
                    </a>
                    <a href=".\assets\images\footer\san2.jpg" data-fancybox="gallery">
                        <img src=".\assets\images\footer\san2.jpg" alt="image gallery">
                    </a>
                    <a href=".\assets\images\footer\san3.webp" data-fancybox="gallery">
                        <img src=".\assets\images\footer\san3.webp" alt="image gallery">
                    </a>
                    <a href=".\assets\images\footer\san4.webp" data-fancybox="gallery">
                        <img src=".\assets\images\footer\san4.webp" alt="image gallery">
                    </a>
                    <a href=".\assets\images\footer\san5.jpg" data-fancybox="gallery">
                        <img src=".\assets\images\footer\san5.jpg" alt="image gallery">
                    </a>
                    <a href=".\assets\images\footer\san6.jpg" data-fancybox="gallery">
                        <img src=".\assets\images\footer\san6.jpg" alt="image gallery">
                    </a>
                </div>

            </div>
            <div class="footer-service">
                <h5 class="title">Liên kết nhanh</h5>

                <ul class="footer-menu">
                    <li>
                        <a href="/FB_N1/home">Trang chủ</a>
                    </li>
                    <li>
                        <a href="/FB_N1/UI/lienHe.jsp">Dành cho đối tác</a>
                    </li>
                    <li>
                        <a href="/FB_N1/bai-dang">Tin tức
</a>
                    </li>
                    
                </ul>

            </div>
        </div>

        
    </div>
</footer>
