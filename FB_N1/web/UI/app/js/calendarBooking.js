let calendar;
let selectedSlots = [];
let socket_user = null;

function connectWebSocket(fieldId) {
    if (socket_user && socket_user.readyState === WebSocket.OPEN) {
        socket_user.close(); // đóng socket_user cũ nếu có
    }

    const url = `ws://${location.host}/FB_N1/ws/app?accountId=${accountId}&roleId=${roleId}&fieldId=${fieldId}`;
    socket_user = new WebSocket(url);

    socket_user.onopen = () => {
        console.log("✅ WebSocket connected");
    };

    socket_user.onmessage = (event) => {
        const msg = JSON.parse(event.data);
        if (msg.type === "refreshCalendar") {
            calendar.refetchEvents();
        }
    };

    socket_user.onclose = () => {
        console.warn("⚠️ WebSocket disconnected");
    };

    socket_user.onerror = (e) => {
        console.error("❌ WebSocket error", e);
    };
}

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
                    info.event.setProp('classNames', []);
                } else {
                    const newSlot = {
                        slot_field_id: slot.slot_field_id,
                        slot_date: slot.slot_date,
                        start: info.event.startStr,
                        end: info.event.endStr,
                        price: parseFloat(slot.price),
                        title: info.event.title
                    };
                    selectedSlots.push(newSlot);
                    info.event.setProp('classNames', ['selected-slot']);
                }

                renderSelectedTable();
            }
        }
    });

    calendar.render();
    const initialFieldId = $('#fieldSelect').val();
    if (initialFieldId) {
        connectWebSocket(initialFieldId);
    }

    $('#fieldSelect').on('change', function () {
        const newFieldId = $(this).val();
        connectWebSocket(newFieldId);
        calendar.refetchEvents();
        renderSelectedTable();
    });


    $('#bookNowBtn').on('click', function () {
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
                    calendar.refetchEvents();
                    renderSelectedTable();
                } else {
                    alert("❌ Lỗi: " + (response.message || "Không rõ nguyên nhân"));
                }
            },
            error: function (xhr, status, error) {
                if (xhr.status === 401 || xhr.status === 302) {
                    alert("⚠️ Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.");
                    window.location.href = "/FB_N1/login";
                } else {
                    alert("⚠️ Lỗi máy chủ: " + (xhr.responseText || "Không xác định"));
                }
            }
        });
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

    $(".remove-slot-btn").off("click").on("click", function () {
        const rowIndex = $(this).closest("tr").data("index");

        if (rowIndex !== undefined) {
            const removedSlot = selectedSlots[rowIndex];

            calendar.getEvents().forEach(event => {
                const props = event.extendedProps;
                if (
                        String(props.slot_field_id) === String(removedSlot.slot_field_id) &&
                        props.slot_date === removedSlot.slot_date &&
                        event.startStr === removedSlot.start &&
                        event.endStr === removedSlot.end
                        ) {
                    event.setProp('classNames', []);
                }
            });

            selectedSlots.splice(rowIndex, 1);
            renderSelectedTable();
        }
    });

    if (selectedSlots.length > 0) {
        $("#selectedSlotsTable").show();
        $("#totalPrice").show().html('Tổng tiền: ' + total.toLocaleString('vi-VN') + '₫');
        $("#bookNowBtn").show();
    } else {
        $("#selectedSlotsTable").hide();
        $("#totalPrice").hide();
        $("#bookNowBtn").hide();
    }
}
