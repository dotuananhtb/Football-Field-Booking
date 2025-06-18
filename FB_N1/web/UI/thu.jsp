<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Sân Bóng</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            background-color: #f5f5f5;
        }
        
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        h1 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #34495e;
        }
        
        input[type="date"] {
            width: 200px;
            padding: 10px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }
        
        .slots-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
            gap: 15px;
            margin: 20px 0;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
            min-height: 100px;
        }
        
        .slot-btn {
            padding: 15px 10px;
            border: 2px solid #27ae60;
            background-color: white;
            color: #27ae60;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            font-size: 14px;
        }
        
        .slot-btn:hover:not(:disabled) {
            background-color: #27ae60;
            color: white;
            transform: translateY(-2px);
        }
        
        .slot-btn.selected {
            background-color: #2980b9;
            color: white;
            border-color: #2980b9;
        }
        
        .slot-btn:disabled {
            background-color: #bdc3c7 !important;
            color: #7f8c8d !important;
            border-color: #bdc3c7 !important;
            cursor: not-allowed;
            transform: none;
        }
        
        .book-btn {
            width: 100%;
            padding: 15px;
            background-color: #e74c3c;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 20px;
        }
        
        .book-btn:hover:not(:disabled) {
            background-color: #c0392b;
        }
        
        .book-btn:disabled {
            background-color: #bdc3c7;
            cursor: not-allowed;
        }
        
        .loading {
            text-align: center;
            padding: 20px;
            color: #7f8c8d;
        }
        
        .empty-slots {
            text-align: center;
            padding: 40px 20px;
            color: #7f8c8d;
            font-style: italic;
        }
        
        .error-message {
            color: #e74c3c;
            background-color: #fdf2f2;
            padding: 10px;
            border-radius: 5px;
            margin: 10px 0;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏈 Đặt Sân Bóng Đá</h1>
        
        <!-- Hidden field chứa fieldId được truyền từ server -->
        <input type="hidden" id="field-id" value="1" />
        
        <!-- Debug info -->
        <div style="background: #f0f0f0; padding: 10px; margin: 10px 0; font-size: 12px;">
            <strong>Debug Info:</strong><br>
            URL Param fieldId: ${param.fieldId}<br>
            Request Attr fieldId: ${requestScope.fieldId}<br>
            Current URL: <script>document.write(window.location.href);</script>
        </div>

        <!-- Chọn ngày để kiểm tra slot -->
        <div class="form-group">
            <label for="slot-date">📅 Chọn ngày:</label>
            <input type="date" id="slot-date" />
        </div>

        <!-- Khu vực hiển thị các slot -->
        <div class="slots-grid" id="slots-grid">
            <div class="empty-slots">Vui lòng chọn ngày để xem các ca có sẵn</div>
        </div>

        <!-- Nút đặt sân -->
        <button class="book-btn" id="book-btn" onclick="bookField()">⚽ Đặt Sân</button>
    </div>

    <script src="app/js/jquery.min.js"></script>
    <script>
        // Đảm bảo DOM đã load xong
        $(document).ready(function() {
            console.log("DOM ready!");
            
            // Lấy elements sau khi DOM ready
            const fieldIdElement = document.getElementById("field-id");
            const slotsGrid = document.getElementById('slots-grid');
            const datePicker = document.getElementById('slot-date');
            const bookBtn = document.getElementById('book-btn');
            let selectedSlots = [];

            // Debug: Kiểm tra elements
            console.log("fieldId element:", fieldIdElement);
            console.log("datePicker element:", datePicker);
            
            // Lấy fieldId value
            const fieldId = fieldIdElement ? fieldIdElement.value : '1';
            console.log("fieldId value:", fieldId);

            // Set minimum date to today
            const today = new Date();
            const todayString = today.getFullYear() + '-' + 
                String(today.getMonth() + 1).padStart(2, '0') + '-' + 
                String(today.getDate()).padStart(2, '0');
            
            console.log("Today string:", todayString);
            
            if (datePicker) {
                datePicker.setAttribute('min', todayString);
                datePicker.value = todayString; // Set default to today
            }

            function formatDateToYMD(date) {
                if (!date) {
                    console.log("formatDateToYMD: date is empty");
                    return '';
                }
                
                // Nếu date đã là string định dạng YYYY-MM-DD thì trả về luôn
                if (typeof date === 'string' && /^\d{4}-\d{2}-\d{2}$/.test(date)) {
                    console.log("formatDateToYMD: date already formatted:", date);
                    return date;
                }
                
                const d = new Date(date);
                if (isNaN(d.getTime())) {
                    console.log("formatDateToYMD: invalid date:", date);
                    return '';
                }
                
                const year = d.getFullYear();
                const month = String(d.getMonth() + 1).padStart(2, '0');
                const day = String(d.getDate()).padStart(2, '0');
                const result = `${year}-${month}-${day}`;
                console.log("formatDateToYMD result:", result);
                return result;
            }

            function showError(message) {
                slotsGrid.innerHTML = `
                    <div class="error-message">
                        ❌ ${message}
                        <br><br>
                        <button onclick="retryLastRequest()" style="padding: 5px 10px; background: #007bff; color: white; border: none; border-radius: 3px; cursor: pointer;">
                            🔄 Thử lại
                        </button>
                    </div>
                `;
            }

            // Lưu thông tin request cuối để retry
            let lastRequestInfo = null;
            
            function retryLastRequest() {
                if (lastRequestInfo) {
                    console.log("🔄 Retrying last request...");
                    loadSlots(lastRequestInfo.date);
                }
            }

            function showLoading() {
                slotsGrid.innerHTML = '<div class="loading">🔄 Đang tải các ca...</div>';
            }

            function loadSlots(selectedDate) {
                console.log("=== LOAD SLOTS DEBUG ===");
                console.log("fieldId:", fieldId);
                console.log("selectedDate:", selectedDate);
                console.log("fieldId type:", typeof fieldId);
                console.log("selectedDate type:", typeof selectedDate);
                
                // Lưu thông tin để retry
                lastRequestInfo = { date: selectedDate };
                
                // Force set fieldId if empty
                let actualFieldId = fieldId;
                if (!actualFieldId || actualFieldId === '' || actualFieldId === 'undefined' || actualFieldId === 'null') {
                    actualFieldId = '1'; // Default fallback
                    console.warn("Using fallback fieldId:", actualFieldId);
                }
                
                if (!selectedDate || selectedDate === '') {
                    console.error("selectedDate is invalid:", selectedDate);
                    showError("Vui lòng chọn ngày hợp lệ.");
                    return;
                }

                // Show loading state
                showLoading();

                const formattedDate = formatDateToYMD(selectedDate);
                console.log("formattedDate:", formattedDate);
                
                if (!formattedDate) {
                    showError("Định dạng ngày không hợp lệ.");
                    return;
                }

                // Construct URL - thử nhiều cách khác nhau
                const baseUrl = window.location.origin + '/FB_N1';
                const url = `${baseUrl}/checking-slots?fieldId=${actualFieldId}&start=${formattedDate}&end=${formattedDate}`;
                
                console.log("🌐 URL Info:");
                console.log("- Origin:", window.location.origin); 
                console.log("- Full URL:", window.location.href);
                console.log("- Pathname:", window.location.pathname);
                console.log("- Final Request URL:", url);

                // Sử dụng AJAX với error handling chi tiết hơn
                $.ajax({
                    url: url,
                    method: 'GET',
                    dataType: 'json',
                    timeout: 10000, // 10 seconds timeout
                    beforeSend: function(xhr) {
                        console.log("Sending request to:", url);
                    },
                    success: function(data) {
                        console.log("✅ Response received:", data);
                        
                        try {
                            const slots = Array.isArray(data) ? data : (data ? [data] : []);
                            renderSlots(slots);
                        } catch (error) {
                            console.error("❌ Error processing slots data:", error);
                            showError("Lỗi xử lý dữ liệu từ server: " + error.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        
                        let errorMessage = "Không thể tải dữ liệu. ";
                        
                        // Xử lý các loại lỗi cụ thể
                        switch(xhr.status) {
                            case 0:
                                errorMessage += "Không thể kết nối đến server. Kiểm tra server có chạy không?";
                                break;
                            case 404:
                                errorMessage += "Không tìm thấy endpoint. Kiểm tra URL: " + url;
                                break;
                            case 500:
                                errorMessage += "Lỗi server. Chi tiết: " + (xhr.responseText || "Không có thông tin");
                                break;
                            case 403:
                                errorMessage += "Không có quyền truy cập.";
                                break;
                            case 400:
                                errorMessage += "Yêu cầu không hợp lệ. Chi tiết: " + (xhr.responseText || "Không có thông tin");
                                break;
                            default:
                                errorMessage += `Mã lỗi: ${xhr.status} - ${xhr.statusText}`;
                                if (xhr.responseText) {
                                    errorMessage += ". Chi tiết: " + xhr.responseText;
                                }
                        }
                        
                        // Hiển thị lỗi chi tiết trong console
                        console.log("🔍 Debugging Info:");
                        console.log("- Request URL:", url);
                        console.log("- Server Response:", xhr.responseText);
                        console.log("- Ready State:", xhr.readyState);
                        console.log("- All Response Headers:", xhr.getAllResponseHeaders());
                        
                        showError(errorMessage);
                        
                        // Suggest solutions
                        if (xhr.status === 404) {
                            console.log("💡 Possible solutions:");
                            console.log("1. Check if CheckingSlotsServlet is mapped to /checking-slots");
                            console.log("2. Check if server is running on port 9999");
                            console.log("3. Check web.xml or servlet annotations");
                        }
                    }
                });
            }

            function renderSlots(slots) {
                slotsGrid.innerHTML = ''; // Clear previous slots
                selectedSlots = []; // Reset selected slots when date changes
                updateBookButtonText();

                if (!slots || slots.length === 0) {
                    slotsGrid.innerHTML = '<div class="empty-slots">Không có ca nào trong ngày này</div>';
                    return;
                }

                slots.forEach(slot => {
                    try {
                        const btn = document.createElement('button');
                        btn.className = 'slot-btn';

                        // Handle time display
                        let timeDisplay = '';
                        if (slot.start && slot.end) {
                            const startDate = new Date(slot.start);
                            const endDate = new Date(slot.end);
                            
                            if (!isNaN(startDate.getTime()) && !isNaN(endDate.getTime())) {
                                const startHour = String(startDate.getHours()).padStart(2, '0');
                                const startMin = String(startDate.getMinutes()).padStart(2, '0');
                                const endHour = String(endDate.getHours()).padStart(2, '0');
                                const endMin = String(endDate.getMinutes()).padStart(2, '0');
                                
                                timeDisplay = `${startHour}:${startMin} - ${endHour}:${endMin}`;
                            }
                        }
                        
                        btn.textContent = timeDisplay || 'Thời gian không xác định';
                        
                        // Set data attributes safely
                        const extendedProps = slot.extendedProps || {};
                        btn.dataset.fieldId = extendedProps.slot_field_id || fieldId;
                        btn.dataset.price = extendedProps.price || '0';
                        btn.dataset.slotDate = extendedProps.slot_date || datePicker.value;
                        btn.dataset.slotStart = slot.start || '';
                        btn.dataset.slotEnd = slot.end || '';

                        // Check availability
                        const status = extendedProps.status || 'Unknown';
                        if (status !== 'Available') {
                            btn.disabled = true;
                            btn.title = 'Không thể đặt: ' + status;
                        } else {
                            const price = parseFloat(extendedProps.price || 0);
                            btn.title = `Giá: ${price.toLocaleString('vi-VN')} VNĐ`;
                        }

                        btn.onclick = function () {
                            if (btn.disabled) return;
                            toggleSlotSelection(btn);
                        };

                        slotsGrid.appendChild(btn);
                    } catch (error) {
                        console.error("Error rendering slot:", error, slot);
                    }
                });
            }

            function toggleSlotSelection(btn) {
                const slotKey = `${btn.dataset.fieldId}-${btn.dataset.slotDate}-${btn.dataset.slotStart}`;
                const existingIndex = selectedSlots.findIndex(s => s.key === slotKey);

                if (existingIndex !== -1) {
                    // Remove from selection
                    selectedSlots.splice(existingIndex, 1);
                    btn.classList.remove('selected');
                } else {
                    // Add to selection
                    selectedSlots.push({
                        key: slotKey,
                        slot_field_id: btn.dataset.fieldId,
                        price: parseFloat(btn.dataset.price) || 0,
                        slot_date: btn.dataset.slotDate,
                        start_time: btn.dataset.slotStart,
                        end_time: btn.dataset.slotEnd
                    });
                    btn.classList.add('selected');
                }

                console.log("Selected slots:", selectedSlots);
                updateBookButtonText();
            }

            function updateBookButtonText() {
                if (selectedSlots.length === 0) {
                    bookBtn.textContent = '⚽ Đặt Sân';
                } else {
                    const total = selectedSlots.reduce((sum, slot) => sum + slot.price, 0);
                    bookBtn.textContent = `⚽ Đặt ${selectedSlots.length} ca - ${total.toLocaleString('vi-VN')} VNĐ`;
                }
            }

            // Event listener cho date picker
            if (datePicker) {
                datePicker.addEventListener('change', function() {
                    loadSlots(this.value);
                });
                
                // Load slots for today by default
                console.log("Loading slots for today:", todayString);
                loadSlots(todayString);
            } else {
                console.error("datePicker element not found!");
            }

            // Function bookField
            window.bookField = function() {
                if (selectedSlots.length === 0) {
                    alert("⚠️ Vui lòng chọn ít nhất một ca!");
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

                // Disable button during booking
                const originalText = bookBtn.textContent;
                bookBtn.disabled = true;
                bookBtn.textContent = '🔄 Đang đặt sân...';

                $.ajax({
                    url: window.location.origin + '/FB_N1/dat-san',
                    method: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(bookingDetailsList),
                    timeout: 15000,
                    success: function (response) {
                        console.log("Booking response:", response);
                        
                        if (response && response.success) {
                            alert("✅ Đặt sân thành công!");
                            selectedSlots = [];
                            document.querySelectorAll('.slot-btn.selected').forEach(btn => 
                                btn.classList.remove('selected'));
                            updateBookButtonText();
                            
                            // Refresh slots to show updated availability
                            if (datePicker && datePicker.value) {
                                loadSlots(datePicker.value);
                            }
                        } else {
                            alert("❌ Lỗi đặt sân: " + (response.message || "Không rõ lỗi"));
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error("Booking error:", xhr, status, error);
                        
                        if (xhr.status === 401 || xhr.status === 302) {
                            alert("🔒 Phiên đăng nhập hết hạn. Vui lòng đăng nhập lại.");
                            window.location.href = "login";
                        } else {
                            let errorMsg = "❌ Lỗi đặt sân: ";
                            if (xhr.responseText) {
                                errorMsg += xhr.responseText;
                            } else {
                                errorMsg += `Mã lỗi ${xhr.status} - ${error}`;
                            }
                            alert(errorMsg);
                        }
                    },
                    complete: function() {
                        // Re-enable button
                        bookBtn.disabled = false;
                        updateBookButtonText();
                    }
                });
            };
        });
    </script>
</body>
</html>