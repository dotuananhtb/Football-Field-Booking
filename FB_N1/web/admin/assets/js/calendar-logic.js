//calendar-ui.js
// 🔹 1. AJAX lấy ca từ server
function fetchSlotEvents(fetchInfo, successCallback, failureCallback) {
    const fieldId = $('#fieldSelect').val();
    if (!fieldId)
        return successCallback([]);

    $.ajax({
        url: '/FB_N1/checking-slots2',
        method: 'GET',
        data: {
            fieldId: fieldId,
            start: fetchInfo.startStr.substring(0, 10),
            end: fetchInfo.endStr.substring(0, 10)
        },
        dataType: 'json',
        success: successCallback,
        error: (_, __, error) => failureCallback(error)
    });
}

// 🔹 2. Xử lý khi click event trên lịch
function handleEventClick(info) {
    const slot = info.event.extendedProps;

    if (slot.status === 0) {
        toggleSlotSelection(info);
        renderSelectedTable();
    } else if (slot.status === 1 || slot.status === 2) {
        openStatusModal(info.event);
    }
}

// 🔹 3. Toggle chọn/bỏ ca
function toggleSlotSelection(info) {
    const slot = info.event.extendedProps;

    const existsIndex = selectedSlots.findIndex(s =>
        String(s.slot_field_id) === String(slot.slot_field_id) &&
                s.slot_date === slot.slot_date &&
                s.start === info.event.startStr &&
                s.end === info.event.endStr
    );

    if (existsIndex > -1) {
        selectedSlots.splice(existsIndex, 1);
        info.event.setProp('classNames', ['bg-success', 'text-white']);
    } else {
        selectedSlots.push({
            slot_field_id: slot.slot_field_id,
            slot_date: slot.slot_date,
            start: info.event.startStr,
            end: info.event.endStr,
            price: parseFloat(slot.price),
            title: info.event.title
        });
        info.event.setProp('classNames', ['bg-info', 'text-white']);
    }
}

// 🔹 4. Gửi yêu cầu đặt sân
function handleBookingSubmit() {
    if (selectedSlots.length === 0) {
        showToast("error", "⚠️ Bạn chưa chọn ca nào để đặt.");
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
        url: '/FB_N1/admin/dat-san',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(bookingDetailsList),
        success: function (response) {
            if (response && response.success) {
                showToast("success", response.message || "✅ Đặt sân thành công!");
                selectedSlots = [];
                calendar.refetchEvents();
                renderSelectedTable();
            } else {
                showToast("error", response.message || "❌ Không rõ nguyên nhân!");
            }
        },
        error: function (xhr) {
            if (xhr.status === 401 || xhr.status === 302) {
                showToast("error", "⚠️ Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.");
                setTimeout(() => window.location.href = "/FB_N1/login", 3000);
            } else {
                const msg = xhr.responseText || "❌ Lỗi máy chủ không xác định.";
                showToast("error", msg);
            }
        }
    });
}

// 🔹 5. Cập nhật trạng thái ca (Admin)
// 🔹 5. Cập nhật trạng thái ca (Admin)
function updateSlotStatus(slotId, slotDate, statusId) {
    $.ajax({
        url: '/FB_N1/admin/update-slot-status',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            slotFieldId: slotId,
            slotDate: slotDate,
            status: statusId  // số nguyên
        }),
        success: function (res) {
            const msg =
                    statusId === 1 ? "✅ Đã xác nhận ca!"
                    : statusId === 2 ? "⌛ Đang chờ xử lý!"
                    : "🚫 Đã huỷ ca!";
            showToast("success", msg);
            $('#event-modal').modal('hide');
            calendar.refetchEvents();
        },
        error: function (xhr) {
            showToast("error", "❌ Lỗi cập nhật: " + (xhr.responseText || "Không xác định"));
        }
    });
}

