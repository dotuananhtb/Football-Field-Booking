

<%@page import="model.Field"%>
<%@page import="java.util.List"%>
<%@page import="dao.FieldDAO"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Lịch đặt sân</title>
        <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css' rel='stylesheet'/>
        <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js'></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="assets/js/calendarBooking.js"></script>  

        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f9f9f9;
            }

            #calendar-wrapper {
                position: relative;
                width: 100%;
                max-width: 1100px;
                margin: 0 auto;
                height:600px;
                background: #ffffff;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                display: flex;
                flex-direction: column;
            }

            /* Phần cố định chứa toolbar và col-header */
            .calendar-fixed-header {
                position: sticky;
                top: 0;
                background: white;
                z-index: 1000;
                border-bottom: 1px solid #ddd;
            }

            /* Scroll được phần nội dung bên dưới */
            .calendar-scrollable-body {
                flex: 1;
                overflow: auto;
                position: relative;
            }

            /* Lịch có thể cuộn ngang nếu nhiều cột */
            #calendar {
                min-width: 600px;
                padding: 10px;
            }


            #fieldSelect {
                display: block;
                margin: 20px auto;
                font-size: 16px;
                padding: 8px 12px;
                border-radius: 6px;
                border: 1px solid #ccc;
            }

         

            .fc-event:hover {
                cursor: pointer;
                opacity: 0.85;
            }

            button#bookNowBtn {
                display: none; /* Ẩn ban đầu */
                padding: 10px 20px;
                background-color: #28a745;
                color: white;
                font-size: 16px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            button#bookNowBtn:hover {
                background-color: #218838;
            }

            #selectedSlotsTable {
                max-width: 1100px;
                margin: 20px auto;
                border-collapse: collapse;
                width: 100%;
            }

            #selectedSlotsTable th, #selectedSlotsTable td {
                padding: 10px;
                text-align: left;
                border: 1px solid #ddd;
            }

            #selectedSlotsTable th {
                background-color: #f2f2f2;
            }

            #totalPrice {
                text-align: right;
                max-width: 1100px;
                margin: 10px auto;
                font-weight: bold;
                font-size: 18px;
            }
        </style>
    </head>
    <body>

        <select id="fieldSelect">
            <option value="">-- Chọn sân --</option>
            <%
                FieldDAO fieldDAO = new FieldDAO();
                List<Field> fields = fieldDAO.getAllFields();
                for (Field field : fields) {
            %>
            <option value="<%= field.getFieldId()%>"><%= field.getFieldName()%></option>
            <% }%>
        </select>

        <div id="calendar-wrapper">
            <div class="calendar-fixed-header">
                <div class="fc-toolbar"></div>
                <div class="fc-col-header"></div>
            </div>

            <div class="calendar-scrollable-body">
                <div id="calendar"></div>
            </div>
        </div>

        <table id="selectedSlotsTable" class="table" style="display:none;">
            <thead>
                <tr>
                    <th>Ngày</th>
                    <th>Khung giờ</th>
                    <th>Giá</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
        <div id="totalPrice" style="display:none; margin-top: 10px;">Tổng tiền: 0₫</div>

        <div style="text-align: center; margin-top: 20px;">
            <button id="bookNowBtn">Đặt sân</button>
        </div>

    </body>
</html>
