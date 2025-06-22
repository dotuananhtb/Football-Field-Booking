function initCalendar() {
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
        eventDidMount: function (info) {
            const titleEl = info.el.querySelector('.fc-event-title');
            if (titleEl)
                titleEl.style.display = 'none';
        },
        events: fetchSlotEvents,
        eventClick: handleEventClick
    });
}

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

function handleEventClick(info) {
    const slot = info.event.extendedProps;
    if (slot.status === 0) {
        toggleSlotSelection(info);
        renderSelectedTable();
    } else if (slot.status === 1 || slot.status === 2) {
        openSlotInfoModal(slot); // Truyền toàn bộ dữ liệu slot
    }

}

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
function handleBookingSubmit() {
    if (selectedSlots.length === 0) {
        showToast("error", "⚠️ Bạn chưa chọn ca nào để đặt.");
        return;
    }

    const form = document.getElementById('offlineUserForm');
    const fullNameInput = document.getElementById('offlineFullName');
    const phoneInput = document.getElementById('offlinePhone');
    const emailInput = document.getElementById('offlineEmail');

    if (!form)
        return;

    // ✅ Nếu form không hợp lệ thì hiển thị từng lỗi
    if (!form.checkValidity()) {
        form.classList.add('was-validated');

        if (!fullNameInput.checkValidity()) {
            if (fullNameInput.validity.valueMissing) {
                showToast("error", "❌ Họ và tên không được để trống.");
            } else if (fullNameInput.validity.tooLong) {
                showToast("error", "❌ Họ và tên không được vượt quá 100 ký tự.");
            }
        }

        if (!phoneInput.checkValidity()) {
            if (phoneInput.validity.valueMissing) {
                showToast("error", "❌ Vui lòng nhập số điện thoại.");
            } else if (phoneInput.validity.patternMismatch || phoneInput.validity.tooLong) {
                showToast("error", "❌ Số điện thoại phải bắt đầu bằng 0 và đủ 10 chữ số.");
            }
        }

        if (emailInput.value && !emailInput.checkValidity()) {
            if (emailInput.validity.typeMismatch) {
                showToast("error", "❌ Email không đúng định dạng.");
            } else if (emailInput.validity.tooLong) {
                showToast("error", "❌ Email không được vượt quá 100 ký tự.");
            }
        }

        return;
    }

    // ✅ Thu thập dữ liệu
    const fullName = fullNameInput.value.trim();
    const phone = phoneInput.value.trim();
    const email = emailInput.value.trim();

    // ✅ Ghi chú từng slot
    $("#selectedSlotsTable tbody tr").each(function () {
        const noteInput = $(this).find(".slot-note-input");
        const i = noteInput.data("index");
        const noteVal = noteInput.val();
        if (i !== undefined && selectedSlots[i]) {
            selectedSlots[i].note = noteVal;
        }
    });

    const bookingDetailsList = selectedSlots.map(slot => ({
            bookingDetailsId: null,
            bookingId: null,
            slotFieldId: slot.slot_field_id,
            slotFieldPrice: slot.price,
            extraMinutes: 0,
            extraFee: 0,
            slotDate: slot.slot_date,
            note: `NV ${currentUsername} đặt sân offline: ${slot.note || ""}`,
            statusCheckingId: 1
        }));

    const dataToSend = {
        fullName: fullName,
        phone: phone,
        email: email || null,
        details: bookingDetailsList
    };

    // ✅ Gửi dữ liệu
    $.ajax({
        url: '/FB_N1/admin/dat-san-offline',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(dataToSend),
        success: function (response) {
            if (response && response.success) {
                showToast("success", response.message || "✅ Đặt sân thành công!");
                selectedSlots = [];
                calendar.refetchEvents();
                renderSelectedTable();
                fullNameInput.value = '';
                phoneInput.value = '';
                emailInput.value = '';
                form.classList.remove('was-validated');
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




function updateSlotStatus(slotId, slotDate, statusId) {
    $.ajax({
        url: '/FB_N1/admin/update-slot-status',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            slotFieldId: slotId,
            slotDate: slotDate,
            status: statusId
        }),
        success: function () {
            const msg =
                    statusId === 1 ? "✅ Đã xác nhận ca!" :
                    statusId === 2 ? "⌛ Đang chờ xử lý!" :
                    "🚫 Đã huỷ ca!";
            showToast("success", msg);
            $('#event-modal').modal('hide');
            calendar.refetchEvents();
        },
        error: function (xhr) {
            showToast("error", "❌ Lỗi cập nhật: " + (xhr.responseText || "Không xác định"));
        }
    });
}