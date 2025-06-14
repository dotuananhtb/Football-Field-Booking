<%-- 
    Document   : toast
    Created on : Jun 14, 2025, 10:46:54 PM
    Author     : Đỗ Tuấn Anh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${not empty sessionScope.toastMessage}">
    <div id="toast" class="toast ${sessionScope.toastType}">
        <span class="toast-icon">
            <c:choose>
                <c:when test="${sessionScope.toastType eq 'success'}">✔️</c:when>
                <c:when test="${sessionScope.toastType eq 'error'}">❌</c:when>
                <c:when test="${sessionScope.toastType eq 'warning'}">⚠️</c:when>
                <c:otherwise>ℹ️</c:otherwise>
            </c:choose>
        </span>
        <span class="toast-message">${sessionScope.toastMessage}</span>
    </div>

    <style>
        .toast {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 9999;
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 16px 20px;
            border-radius: 8px;
            color: white;
            font-weight: bold;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            min-width: 280px;
            opacity: 0;
            animation: fadeIn 0.5s forwards, fadeOut 0.5s ease 2.5s forwards;
        }

        .toast.success {
            background-color: #28a745;
        }

        .toast.error {
            background-color: #dc3545;
        }

        .toast.warning {
            background-color: #ffc107;
            color: #333;
        }

        .toast.info {
            background-color: #17a2b8;
        }

        .toast-icon {
            font-size: 1.4rem;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeOut {
            from {
                opacity: 1;
                transform: translateY(0);
            }
            to {
                opacity: 0;
                transform: translateY(20px);
            }
        }
    </style>

    <c:remove var="toastMessage" scope="session"/>
    <c:remove var="toastType" scope="session"/>
</c:if>
