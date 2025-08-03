let socket;

document.querySelectorAll(".nice-select .option").forEach(function (option) {
    option.addEventListener("click", function () {
        const value = this.getAttribute("data-value");
        const hiddenInput = this.closest("fieldset").querySelector("input[type='hidden']");
        if (hiddenInput) {
            hiddenInput.value = value;
            this.closest("form").submit();
        }
    });
});
function goToPage(pageNumber) {
    const pageInput = document.getElementById("pageIndexInput");
    if (pageInput) {
        pageInput.value = pageNumber;
        pageInput.form.submit();
    }
}

// lấy dữ liệu json
document.querySelectorAll(".slotDatePicker").forEach(input => {
    input.addEventListener("change", function () {
        const selectedDate = this.value;
        const fieldId = this.getAttribute("data-field-id");
        const fieldBlock = this.closest(".field-block");

        if (!fieldId || !fieldBlock) {
            console.log("❌ Thiếu fieldId hoặc fieldBlock");
            return;
        }

        const courtId = fieldId;

        // ✅ Luôn reset UI khi date thay đổi (dù rỗng)
        fieldBlock.querySelectorAll(".slot-btn").forEach(btn => {
            btn.classList.remove('booked', 'expired','wait' ,'pending', 'selected');
            btn.disabled = true;
            btn.removeAttribute('data-slot-date');
        });

        // ✅ Xoá slot chọn cũ
        selectedSlots = selectedSlots.filter(slot => slot.courtId !== courtId);
        selectedSlotPrices.delete(courtId);

        // ❌ Nếu chưa có ngày thì không gọi API
        if (!selectedDate) {
            console.log("📛 Input bị xoá ngày — đã reset slot UI, không gọi API");
            return;
        }

        console.log("📅 Đã chọn ngày:", selectedDate, "⛳ FieldId:", fieldId);

        // Gán ngày vào slot để kiểm tra
        fieldBlock.querySelectorAll(".slot-btn").forEach(btn => {
            btn.setAttribute("data-slot-date", selectedDate);
        });

        // Gọi API
        $.ajax({
            url: '/FB_N1/checking-slots',
            method: 'GET',
            data: {
                fieldId: fieldId,
                start: selectedDate,
                end: selectedDate
            },
            dataType: 'json',
            success: function (bookedSlots) {
                console.log("✅ API trả về:", bookedSlots);
                updateSlotUI(bookedSlots, selectedDate, fieldBlock);
            },
            error: function (xhr, status, error) {
                console.error("❌ Lỗi API:", error);
            }
        });
    });
});
// đặt sân
let selectedSlotPrices = new Map(); // Lưu giá đã chọn cho mỗi sân
let expandedStates = new Map(); // Lưu trạng thái mở/đóng của mỗi sân
let selectedSlots = [];

function selectSlot(button) {
    if (button.disabled || button.classList.contains('booked') || button.classList.contains('expired')) {
        console.warn("⛔ Slot không hợp lệ.");
        return;
    }

    const courtContainer = button.closest('.time-slots');
    const courtId = getCourtId(courtContainer);
    const selectedDate = courtContainer.closest('.field-block')?.querySelector('.slotDatePicker')?.value;

    const slotDate = button.getAttribute('data-slot-date');
    const start = button.getAttribute('data-start');
    const end = button.getAttribute('data-end');
    const slotFieldId = button.getAttribute('data-slot-id');
    const price = parseInt(button.getAttribute('data-price'));

    // Ngăn người dùng chọn ca không thuộc ngày đang xem
    if (slotDate !== selectedDate) {
//                                                                                                                                
        showToast("error", "Ca không thuộc ngày hiện tại.");

        return;
    }

    // Không cho chọn nếu ngày nhỏ hơn ngày hiện tại
    const now = new Date().toISOString().split('T')[0];
    if (slotDate < now) {
//                                                                                                                                
        showToast("error", "ca đã qua ngày");
        return;
    }

    //  Toggle chọn/bỏ chọn
    if (button.classList.contains('selected')) {
        button.classList.remove('selected');
        selectedSlots = selectedSlots.filter(slot => slot.courtId !== courtId);
        selectedSlotPrices.set(courtId, 0);
        resetPriceDisplay(button);
        return;
    }

    // Bỏ chọn slot khác của cùng sân
    courtContainer.querySelectorAll('.slot-btn').forEach(btn => btn.classList.remove('selected'));

    // Chọn slot mới
    button.classList.add('selected');
    selectedSlotPrices.set(courtId, price);
    updatePriceDisplay(button, price);

    selectedSlots = selectedSlots.filter(slot => slot.courtId !== courtId);
    selectedSlots.push({
        courtId,
        slot_field_id: slotFieldId,
        slot_date: slotDate,
        start,
        end,
        price
    });

    console.log("📌 Slots đã chọn:", selectedSlots);
}


function bookField(event) {
    const button = event.currentTarget;
    const fieldBlock = button.closest('.field-block');
    const courtId = getCourtId(fieldBlock.querySelector('.time-slots'));

    // Lọc các slot đúng với sân hiện tại
    const bookingDetailsList = selectedSlots
            .filter(slot => slot.courtId === courtId)
            .map(slot => ({
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

    if (bookingDetailsList.length === 0) {
        showToast("error", "Bạn chưa chọn ca nào để đặt cho sân này.");
        return;
    }

    $.ajax({
        url: '/FB_N1/dat-san',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(bookingDetailsList),
        success: function (response) {
            console.log("✅ Server response:", response);

            if (response && response.success) {
                showToast("success", "Vui lòng thanh toán để đặt sân!");

                const bookingCode = response.bookingCode;
                console.log("bookingCode nhận được:", bookingCode);

                if (bookingCode) {
                    setTimeout(() => {
                        console.log("⏩ Đang chuyển trang đến:", `/FB_N1/thanh-toan?code=${encodeURIComponent(bookingCode)}`);
                        window.location.href = `/FB_N1/thanh-toan?code=${encodeURIComponent(bookingCode)}`;
                    }, 1000);
                } else {
                    console.warn("️ Không có bookingCode từ response!");
                }
                // Xoá slot đã đặt của sân đó
                selectedSlots = selectedSlots.filter(slot => slot.courtId !== courtId);
                selectedSlotPrices.delete(courtId);

                fieldBlock.querySelectorAll('.slot-btn.selected').forEach(btn => btn.classList.remove('selected'));
                resetPriceDisplay(fieldBlock.querySelector('.slot-btn'));
            } else {
                alert("❌ Lỗi: " + (response.message || "Không rõ nguyên nhân"));
            }
        },
        error: function (xhr) {
            console.error("❌ AJAX Error:", xhr.status, xhr.responseText);
            if (xhr.status === 401 || xhr.status === 302) {
                showToast("error", "Bạn cần đăng nhập để đặt sân.");
                window.location.href = "/FB_N1/login";
            } else {
                alert("⚠️ Lỗi máy chủ: " + (xhr.responseText || "Không xác định"));
            }
        }
    });
}





function toggleSlots(event) {
    const button = event.currentTarget; // ✅ chính là nút được click
    const fieldBlock = button.closest(".field-block");

    if (!fieldBlock)
        return;

    const fieldId = fieldBlock.getAttribute("data-field-id");
    const container = fieldBlock.querySelector(".slots-container");
    const toggleText = button.querySelector("span");
    const toggleIcon = button.querySelector("svg");

    const isExpanded = expandedStates.get(fieldId) === true;

    if (isExpanded) {
        container?.classList.remove("expanded");
        container?.classList.add("collapsed");
        toggleText.textContent = "Xem thêm";
        toggleIcon.classList.add("rotated");
        expandedStates.set(fieldId, false);
    } else {
        container?.classList.remove("collapsed");
        container?.classList.add("expanded");
        toggleText.textContent = "Thu gọn";
        toggleIcon.classList.remove("rotated");
        expandedStates.set(fieldId, true);
    }
}



function updatePriceDisplay(button, price) {
    // Tìm .field-block chứa button được click
    const fieldBlock = button.closest('.field-block');
    if (!fieldBlock) {
        console.warn(" Không tìm thấy field-block để cập nhật giá");
        return;
    }

    // Tìm .price-section bên trong sân
    const priceSection = fieldBlock.querySelector('.price-section');
    if (!priceSection) {
        console.warn(" Không tìm thấy price-section trong field-block");
        return;
    }

    const priceLabel = priceSection.querySelector('.price-label');
    const priceDisplay = priceSection.querySelector('.price-from');
    const originalPrice = priceSection.querySelector('.price-to');

    if (priceLabel)
        priceLabel.textContent = 'Giá đã chọn:';

    if (priceDisplay)
        priceDisplay.textContent = formatPrice(price) + ' ₫';

    if (originalPrice)
        originalPrice.style.display = 'none';
}

function resetPriceDisplay(button) {
    const fieldBlock = button.closest('.field-block');
    if (!fieldBlock) {
        console.warn(" Không tìm thấy field-block để reset giá");
        return;
    }

    const priceSection = fieldBlock.querySelector('.price-section');
    if (!priceSection) {
        console.warn(" Không tìm thấy price-section trong field-block");
        return;
    }

    const priceLabel = priceSection.querySelector('.price-label');
    const priceDisplay = priceSection.querySelector('.price-from');
    const originalPrice = priceSection.querySelector('.price-to');

    if (priceLabel)
        priceLabel.textContent = 'Giá từ:';

    if (button) {
        const originalMin = priceDisplay.getAttribute('data-original-min');
        if (originalMin) {
            priceDisplay.textContent = formatPrice(parseInt(originalMin)) + ' ₫';
        }
    }

    if (originalPrice) {
        const originalMax = originalPrice.getAttribute('data-original-max');
        if (originalMax) {
            originalPrice.textContent = '- ' + formatPrice(parseInt(originalMax)) + ' ₫';
            originalPrice.style.display = 'inline';
        }
    }
}



function formatPrice(price) {
    return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
}

// Tạo ID duy nhất cho mỗi sân    
function getCourtId(courtContainer) {
    if (!courtContainer.dataset.courtId) {
        // Tạo ID duy nhất dựa trên vị trí trong DOM
        const allCourts = document.querySelectorAll('.time-slots');
        const index = Array.from(allCourts).indexOf(courtContainer);
        courtContainer.dataset.courtId = 'court_' + index;
    }
    return courtContainer.dataset.courtId;
}

// Simulate some unavailable slots
function updateSlotUI(bookedSlots, selectedDate, fieldBlock) {
    if (!fieldBlock) {
        console.error("fieldBlock is undefined");
        return;
    }

    const btns = fieldBlock.querySelectorAll('.slot-btn');

    btns.forEach(btn => {
        const start = btn.getAttribute('data-start');
        const end = btn.getAttribute('data-end');
        const slotId = btn.getAttribute('data-slot-id');

        const matchedSlot = bookedSlots.find(slot => {
            const slotFieldId = slot.extendedProps?.slot_field_id;
            return String(slotFieldId) === String(slotId);
        });

        if (matchedSlot) {
            const status = matchedSlot.extendedProps?.status;

            btn.classList.remove('booked', 'expired', 'wait', 'pending', 'selected');
            btn.disabled = false;

            if (status === "Booked") {
                btn.classList.add('booked');
                btn.disabled = true;
            } else if (status === "Đã qua") {
                btn.classList.add('expired');
                btn.disabled = true;
            } else if (status === "Wait") {
                btn.classList.add('wait');
                btn.disabled = true;
            } else if (status === "Pending") {
                btn.classList.add('pending');
                btn.disabled = true;
            }
        } else {
            // Nếu không match, kiểm tra ngày giờ slot đã qua chưa
            const slotDateTime = new Date(`${selectedDate}T${start}`);
            const now = new Date();

            btn.classList.remove('booked', 'expired', 'wait', 'pending', 'selected');
            btn.disabled = false;

            if (slotDateTime < now) {
                btn.classList.add('expired');
                btn.disabled = true;
            }
        }
    });
}

// Hàm kết nối WebSocket để nhận cập nhật realtime slot
function connectSlotWebSocket() {
    if (socket && socket.readyState === WebSocket.OPEN) {
        socket.close();
    }

    socket = new WebSocket(`ws://${location.host}/FB_N1/ws/slot-updates`);

    socket.onopen = () => console.log("✅ WebSocket for slots connected");

    socket.onmessage = (event) => {
        const msg = JSON.parse(event.data);
        if (msg.type === "slotUpdate") {
            console.log("Nhận cập nhật slot từ server", msg);

            // Tự động gọi lại API cập nhật slot mới cho tất cả sân có chọn ngày
            document.querySelectorAll(".slotDatePicker").forEach(input => {
                const selectedDate = input.value;
                const fieldId = input.getAttribute("data-field-id");
                const fieldBlock = input.closest(".field-block");
                if (!fieldBlock || !fieldId || !selectedDate) return;

                $.ajax({
                    url: '/FB_N1/checking-slots',
                    method: 'GET',
                    data: {
                        fieldId: fieldId,
                        start: selectedDate,
                        end: selectedDate
                    },
                    dataType: 'json',
                    success: function (bookedSlots) {
                        updateSlotUI(bookedSlots, selectedDate, fieldBlock);
                    }
                });
            });
        }
    };

    socket.onclose = () => console.log("⚠️ WebSocket for slots disconnected");
    socket.onerror = e => console.error("❌ WebSocket error", e);
}




// Initialize
document.addEventListener('DOMContentLoaded', function () {


    document.querySelectorAll('.time-slots').forEach(courtContainer => {
        const courtId = getCourtId(courtContainer);

        // ✅ Gán trạng thái ban đầu là "collapsed"
        expandedStates.set(courtId, false);

        // ✅ Cập nhật UI về trạng thái thu gọn đúng cách
        const container = courtContainer.querySelector('.slots-container, #slotsContainer');
        const toggleText = courtContainer.querySelector('#toggleText, [id*="toggleText"]');
        const toggleIcon = courtContainer.querySelector('#toggleIcon, [id*="toggleIcon"]');
        const showMoreIndicator = courtContainer.querySelector('#showMoreIndicator, [id*="showMoreIndicator"]');

        container?.classList.add('collapsed');
        container?.classList.remove('expanded');
        toggleText && (toggleText.textContent = 'Xem thêm');
        toggleIcon?.classList.add('rotated');
        showMoreIndicator?.classList.add('visible');
    });

    // ✅ Gắn sự kiện click sau khi đã xử lý trạng thái ban đầu
    document.querySelectorAll('.toggle-btn').forEach(btn => {
        btn.addEventListener('click', toggleSlots);
    });

});

// Utility functions
function getAllSelectedSlots() {
    const result = {};
    document.querySelectorAll('.time-slots').forEach(courtContainer => {
        const courtId = getCourtId(courtContainer);
        const selectedButton = courtContainer.querySelector('.slot-btn.selected');
        const price = selectedSlotPrices.get(courtId) || 0;

        if (selectedButton && price > 0) {
            result[courtId] = {
                time: selectedButton.textContent.trim(),
                price: price
            };
        }
    });
    return result;
}

function getTotalPrice() {
    return Array.from(selectedSlotPrices.values()).reduce((sum, price) => sum + price, 0);
}

function resetAllSelections() {
    document.querySelectorAll('.time-slots').forEach(courtContainer => {
        const courtId = getCourtId(courtContainer);
        courtContainer.querySelectorAll('.slot-btn').forEach(btn => {
            btn.classList.remove('selected');
        });
        selectedSlotPrices.set(courtId, 0);
        resetPriceDisplay();
    });
}
// tìm kiếm
// Initialize Flatpickr for date picker
const datePicker = flatpickr("#bookingDateAdvanced", {
    locale: "vn",
    dateFormat: "d/m/Y",
    minDate: "today",
    defaultDate: new Date(),
    enableTime: false,
    clickOpens: true,
    allowInput: false,
    onChange: function (selectedDates, dateStr, instance) {
        console.log("Ngày được chọn:", dateStr);
    }
});

// Custom nice-select functionality
document.querySelectorAll('.nice-select').forEach(select => {
    select.addEventListener('click', function (e) {
        e.stopPropagation();

        // Close all other selects
        document.querySelectorAll('.nice-select').forEach(otherSelect => {
            if (otherSelect !== this) {
                otherSelect.classList.remove('open');
            }
        });

        // Toggle current select
        this.classList.toggle('open');
    });

    // Handle option selection
    select.querySelectorAll('.option').forEach(option => {
        option.addEventListener('click', function (e) {
            e.stopPropagation();

            const selectElement = this.closest('.nice-select');
            const currentSpan = selectElement.querySelector('.current');
            const hiddenInput = selectElement.parentElement.querySelector('input[type="hidden"]');

            // Remove selected class from all options
            selectElement.querySelectorAll('.option').forEach(opt => {
                opt.classList.remove('selected');
            });

            // Add selected class to clicked option
            this.classList.add('selected');

            // Update current text and hidden input value
            currentSpan.textContent = this.textContent;
            if (hiddenInput) {
                hiddenInput.value = this.getAttribute('data-value');
            }

            // Close dropdown
            selectElement.classList.remove('open');
        });
    });
});

// Close dropdowns when clicking outside
document.addEventListener('click', function () {
    document.querySelectorAll('.nice-select').forEach(select => {
        select.classList.remove('open');
    });
});

// Handle search button click
document.querySelector('.btn-search').addEventListener('click', function (e) {
    e.preventDefault();

    // Validate required fields
    const bookingDate = document.getElementById('bookingDateAdvanced').value;
    if (!bookingDate) {
        alert('Vui lòng chọn ngày đặt sân!');
        return;
    }

    // Submit form to servlet
    document.getElementById('search-form-slider').submit();
});

// Handle form submission
document.getElementById('search-form-slider').addEventListener('submit', function (e) {
    const bookingDate = document.getElementById('bookingDateAdvanced').value;
    if (!bookingDate) {
        e.preventDefault();
        alert('Vui lòng chọn ngày đặt sân!');
        return false;
    }
});

// Ensure date picker is clickable
document.getElementById('bookingDateAdvanced').addEventListener('click', function () {
    if (this._flatpickr) {
        this._flatpickr.open();
    }
}
);

document.querySelectorAll('.btn-book').forEach(btn => {
    btn.addEventListener('click', bookField);
});




