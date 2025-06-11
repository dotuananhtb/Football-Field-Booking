<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Lịch đặt sân</title>
        <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css' rel='stylesheet'/>
        <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js'></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <style>
            #calendar {
                max-width: 1100px;
                margin: 30px auto;
                padding: 10px;
                background: #f4f4f4;
                border-radius: 10px;
            }

            #fieldSelect {
                display: block;
                margin: 20px auto;
                font-size: 16px;
                padding: 8px 12px;
            }
        </style>
    </head>
    <body>

        <!-- Dropdown chọn sân -->
        <select id="fieldId">
            <option value="9">Sân 1</option>
            <option value="10">Sân 2</option>
        </select>


        <div id='calendar'></div>

        <script>
            let calendar; // khai báo ngoài để tái sử dụng

            document.addEventListener('DOMContentLoaded', function () {
                var calendarEl = document.getElementById('calendar');

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
                        const startDate = fetchInfo.startStr.substring(0, 10);
                        const endDate = fetchInfo.endStr.substring(0, 10);
                        const fieldId = $('#fieldId').val();

                        if (!fieldId) {
                            alert("Vui lòng chọn sân!");
                            return;
                        }

                        $.ajax({
                            url: '/FB_N1/checking-slots',
                            method: 'GET',
                            data: {
                                fieldId: fieldId,
                                start: startDate,
                                end: endDate
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
                    }
                });

                calendar.render();

                // ✅ Khi người dùng chọn sân khác → load lại sự kiện
                $('#fieldId').on('change', function () {
                    calendar.refetchEvents();
                });
            });
        </script>


    </body>
</html>