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

        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f9f9f9;
            }

            #calendar {
                max-width: 1100px;
                margin: 30px auto;
                padding: 10px;
                background: #ffffff;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }

            #fieldSelect {
                display: block;
                margin: 20px auto;
                font-size: 16px;
                padding: 8px 12px;
                border-radius: 6px;
                border: 1px solid #ccc;
            }

            .selected-slot {
                background-color: #14539a !important;
                border: 2px solid #339af0 !important;
                color: #ffffff !important;
                box-shadow: 0 0 15px 2px rgba(51, 154, 240, 0.8);
                transform: scale(1.03);
                transition: all 0.3s ease;
                font-weight: bold;
            }

            .fc-event:hover {
                cursor: pointer;
                opacity: 0.85;
            }

            button#bookNowBtn {
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

        <!-- Dropdown chọn sân -->
        <label for="fieldSelect">Chọn sân:</label>
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

        <!-- Lịch đặt -->
        <div id="calendar"></div>

        <!-- Bảng ca đã chọn -->
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

        <script>
            let calendar;
            let selectedSlots = [];

            document.addEventListener('DOMContentLoaded', function () {
                const calendarEl = document.getElementById('calendar');

                calendar = new FullCalendar.Calendar(calendarEl, {
                    initialView: 'dayGridMonth',
                    headerToolbar: {
                        left: 'prev,next today',
                        center: 'title',
                        right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
                    },
                    views: {
                        dayGridMonth: {buttonText: 'Tháng'},
                        timeGridWeek: {buttonText: 'Tuần'},
                        timeGridDay: {buttonText: 'Ngày'},
                        listWeek: {buttonText: 'Danh sách'}
                    },
                    locale: 'vi',
                    height: 'auto',

                    events: function (fetchInfo, successCallback, failureCallback) {
                        const fieldId = $('#fieldSelect').val();
                        if (!fieldId) {
                            successCallback([]);
                            return;
                        }

                        $.ajax({
                            url: '/FB_N1/checking-slots',
                            method: 'GET',
                            data: {
                                fieldId: fieldId,
                                start: fetchInfo.startStr.substring(0, 10),
                                end: fetchInfo.endStr.substring(0, 10)
                            },
                            dataType: 'json',
                            success: function (events) {
                                successCallback(events);
                            },
                            error: function (xhr, status, error) {
                                console.error("Lỗi khi lấy dữ liệu:", error);
                                failureCallback(error);
                            }
                        });
                    },

                    eventClick: function (info) {
                        const slot = info.event.extendedProps;

                        if (slot.status === "Available") {
                            const existsIndex = selectedSlots.findIndex(s =>
                                String(s.slot_field_id) === String(slot.slot_field_id) &&
                                        s.slot_date === slot.slot_date &&
                                        s.start === info.event.startStr &&
                                        s.end === info.event.endStr
                            );

                            if (existsIndex > -1) {
                                selectedSlots.splice(existsIndex, 1);
                                $(info.el).removeClass("selected-slot");
                            } else {
                                selectedSlots.push({
                                    slot_field_id: slot.slot_field_id,
                                    slot_date: slot.slot_date,
                                    start: info.event.startStr,
                                    end: info.event.endStr,
                                    price: parseFloat(slot.price),
                                    title: info.event.title
                                });
                                $(info.el).addClass("selected-slot");
                            }

                            renderSelectedTable();
                        }
                    }
                });

                calendar.render();

                // 🔧 Không reset selectedSlots khi đổi sân nữa
                $('#fieldSelect').on('change', function () {
                    calendar.refetchEvents();         // chỉ reload lịch sân
                    renderSelectedTable();            // vẽ lại bảng (slot các sân vẫn giữ)
                });

                $('#bookNowBtn').on('click', function () {
                    if (selectedSlots.length === 0) {
                        alert("Bạn chưa chọn ca nào để đặt.");
                        return;
                    }

                    // Gửi dữ liệu (đã bỏ comment nếu bạn muốn bật lại AJAX)
                    /*
                     $.ajax({
                     url: "/FB_N1/book",
                     method: "POST",
                     contentType: "application/json",
                     data: JSON.stringify(selectedSlots),
                     success: function (response) {
                     alert("Đặt sân thành công!");
                     selectedSlots = [];
                     renderSelectedTable();
                     calendar.refetchEvents();
                     },
                     error: function () {
                     alert("Có lỗi xảy ra khi đặt sân.");
                     }
                     });
                     */
                });
            });

            function renderSelectedTable() {
                const tbody = $("#selectedSlotsTable tbody");
                tbody.empty();

                let total = 0;

                selectedSlots.forEach((slot, index) => {
                    const slotDate = slot.slot_date || '';
                    const timeRange = slot.title || '';
                    const price = typeof slot.price === 'number' ? slot.price : parseFloat(slot.price) || 0;
                    const priceFormatted = price.toLocaleString('vi-VN') + '₫';

                    const rowHTML =
                            '<tr data-index="' + index + '">' +
                            '<td>' + slotDate + '</td>' +
                            '<td>' + timeRange + '</td>' +
                            '<td>' + priceFormatted + '</td>' +
                            '<td><button class="remove-slot-btn btn btn-sm btn-danger">Xoá</button></td>' +
                            '</tr>';

                    tbody.append(rowHTML);
                    total += price;
                });

                // Gán sự kiện xoá slot
                $(".remove-slot-btn").on("click", function () {
                    const rowIndex = $(this).closest("tr").data("index");
                    if (rowIndex !== undefined) {
                        selectedSlots.splice(rowIndex, 1);
                        renderSelectedTable(); // vẽ lại bảng sau khi xoá
                    }
                });

                if (selectedSlots.length > 0) {
                    $("#selectedSlotsTable").show();
                    $("#totalPrice").show().html('Tổng tiền: ' + total.toLocaleString('vi-VN') + '₫');
                } else {
                    $("#selectedSlotsTable").hide();
                    $("#totalPrice").hide();
                }
            }
        </script>



    </body>
</html>
