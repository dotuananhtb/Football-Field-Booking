let calendar;
let selectedSlots = [];
let socket = null;

// 🔹 Kết nối WebSocket
function connectWebSocket(fieldId) {
    if (socket && socket.readyState === WebSocket.OPEN) {
        socket.close();
    }

    const url = `ws://${location.host}/FB_N1/ws/app?accountId=${accountId}&roleId=${roleId}&fieldId=${fieldId}`;
    socket = new WebSocket(url);

    socket.onopen = () => console.log("✅ WebSocket connected");
    socket.onmessage = (event) => {
        const msg = JSON.parse(event.data);
        if (msg.type === "refreshCalendar") {
            calendar.refetchEvents();
        }
    };
    socket.onclose = () => console.warn("⚠️ WebSocket disconnected");
    socket.onerror = (e) => console.error("❌ WebSocket error", e);
}

document.addEventListener('DOMContentLoaded', function () {
    initCalendar();
    calendar.render();
    bindUIEvents();

    const fieldId = $('#fieldSelect').val();
    if (fieldId) {
        connectWebSocket(fieldId);
    }
});

// 🔹 Hiển thị bảng slot đã chọn
function renderSelectedTable() {
    const tbody = $("#selectedSlotsTable tbody");
    tbody.empty();
    let total = 0;

    selectedSlots.forEach((slot, index) => {
        const price = parseFloat(slot.price) || 0;
        total += price;

        tbody.append(`
            <tr data-index="${index}">
                <td>${slot.slot_date}</td>
                <td>${slot.title}</td>
                <td>${price.toLocaleString('vi-VN')}₫</td>
                <td>
                    <input type="text" class="form-control slot-note-input" data-index="${index}" 
                        placeholder="Nhập ghi chú..." value="${slot.note || ''}">
                </td>
                <td>
                    <button class="remove-slot-btn btn btn-sm btn-danger">Xoá</button>
                </td>
            </tr>
        `);
    });

    $(".remove-slot-btn").off("click").on("click", function () {
        const rowIndex = $(this).closest("tr").data("index");
        if (rowIndex !== undefined) {
            restoreSlotAppearance(selectedSlots[rowIndex]);
            selectedSlots.splice(rowIndex, 1);
            renderSelectedTable();
        }
    });

    $("#selectedSlotsTable").toggle(selectedSlots.length > 0);
    $("#totalPrice").toggle(selectedSlots.length > 0)
        .html('Tổng tiền: ' + total.toLocaleString('vi-VN') + '₫');
    $("#bookNowBtn").toggle(selectedSlots.length > 0);
}

// 🔹 Khôi phục giao diện ca
function restoreSlotAppearance(removedSlot) {
    calendar.getEvents().forEach(event => {
        const props = event.extendedProps;
        if (
            String(props.slot_field_id) === String(removedSlot.slot_field_id) &&
            props.slot_date === removedSlot.slot_date &&
            event.startStr === removedSlot.start &&
            event.endStr === removedSlot.end
        ) {
            event.setProp('classNames', ['bg-success', 'text-white']);
        }
    });
}

// 🔹 Mở modal chi tiết (gọi API check-slot-info)
function openSlotInfoModal(slotFieldId, slotDate) {
    $.ajax({
        url: '/FB_N1/check-slot-info',
        method: 'GET',
        data: { slotFieldId, slotDate },
        success: function (data) {
            if (data) {
                $('#event-date').text(data.slotDate || '---');
                $('#event-time').text(`${data.startTime} - ${data.endTime}`);
                $('#event-price').text(Number(data.slotFieldPrice).toLocaleString('vi-VN') + '₫');
                $('#event-status').text(data.slotStatus || '---');
                $('#event-field-name').text(data.fieldName || '---');
                $('#event-field-type').text(data.fieldTypeName || '---');

                $('#ci-name').text(data.customerName || '---');
                $('#ci-phone').text(data.phone || '---');
                $('#ci-email').text(data.email || '---');
                $('#ci-note').text(data.note || '---');
                $('#ci-booking-id').text(data.bookingId || '---');
                $('#ci-booking-details-id').text(data.bookingDetailsId || '---');
                $('#ci-booking-date').text(data.bookingDate || '---');

                $('#event-modal').modal('show');
            }
        },
        error: function () {
            showToast("error", "❌ Không thể tải dữ liệu chi tiết.");
        }
    });
}


// 🔹 Xử lý sự kiện UI
function bindUIEvents() {
    $('#fieldSelect').on('change', function () {
        const newFieldId = $(this).val();
        connectWebSocket(newFieldId);
        calendar.refetchEvents();
        renderSelectedTable();
    });

    $('#bookNowBtn').on('click', handleBookingSubmit);

    $('#btn-show-customer').on('click', function () {
        $('#customer-info-modal').modal('show');
    });

    $('#modal-confirm-btn, #btn-confirm-slot').on('click', function () {
        updateSlotStatus($(this).data('slotId'), $(this).data('slotDate'), 1);
    });

    $('#modal-pending-btn, #btn-pending-slot').on('click', function () {
        updateSlotStatus($(this).data('slotId'), $(this).data('slotDate'), 2);
    });

    $('#modal-cancel-btn, #btn-cancel-slot').on('click', function () {
        updateSlotStatus($(this).data('slotId'), $(this).data('slotDate'), 3);
    });
}
