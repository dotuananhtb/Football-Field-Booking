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

    // Lưu lại ghi chú vào selectedSlots
    $(".slot-note-input").off("input").on("input", function () {
        const index = $(this).data("index");
        if (index !== undefined) {
            selectedSlots[index].note = $(this).val();
        }
    });

    // Xử lý xoá slot
    $(".remove-slot-btn").off("click").on("click", function () {
        const rowIndex = $(this).closest("tr").data("index");
        if (rowIndex !== undefined) {
            restoreSlotAppearance(selectedSlots[rowIndex]);
            selectedSlots.splice(rowIndex, 1);
            renderSelectedTable(); // vẽ lại sau khi xoá
        }
    });

    const hasSlots = selectedSlots.length > 0;
    $("#selectedSlotsTable").toggle(hasSlots);
    $("#totalPrice").toggle(hasSlots).html('Tổng tiền: ' + total.toLocaleString('vi-VN') + '₫');
    $("#bookNowBtn").toggle(hasSlots);
    $("#offlineUserForm").toggle(hasSlots);
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

// ✅ Đã cập nhật để không dùng AJAX nữa
function openSlotInfoModal(slot) {
    $('#event-date').text(slot.slot_date || '---');
    $('#event-time').text(`${slot.start_time} - ${slot.end_time}`);
    $('#event-price').text(Number(slot.price).toLocaleString('vi-VN') + '₫');
    $('#event-status').text(getStatusText(slot.status));
    $('#event-field-name').text(slot.field_name || '---');
    $('#event-field-type').text(slot.field_type_name || '---');
    $('#ci-is-offline').text(slot.isOffline ? 'Online' : 'Offline');

    const user = slot.userInfo || {};
    $('#ci-name').text(user.name || '---');
    $('#ci-phone').text(user.phone || '---');
    $('#ci-email').text(user.email || '---');
    $('#ci-note').text(slot.note || '---');
    $('#ci-booking-id').text(slot.booking_id || '---');
    $('#ci-booking-details-id').text(slot.booking_details_id || '---');
    $('#ci-booking-date').text(slot.booking_date || '---');

    $('#modal-confirm-btn, #modal-pending-btn, #modal-cancel-btn').data('slotId', slot.slot_field_id);
    $('#modal-confirm-btn, #modal-pending-btn, #modal-cancel-btn').data('slotDate', slot.slot_date);

    $('#event-modal').modal('show');
}

function getStatusText(status) {
    switch (status) {
        case 0:
            return "Có thể đặt";
        case 1:
            return "Đã xác nhận";
        case 2:
            return "Chờ xử lý";
        case 3:
            return "Đã huỷ";
        default:
            return "---";
    }
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
