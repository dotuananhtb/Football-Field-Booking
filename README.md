# ⚽ Football Field Booking (Nhóm 1 - SE1917NJ)

**Football Field Booking** là hệ thống web quản lý và đặt sân bóng đá hiện đại, bảo mật và tối ưu cho cả người dùng lẫn quản trị viên.  
Dự án sử dụng **Java Servlet/JSP**, tích hợp **Google OAuth**, **Cloudinary**, gửi email tự động và quản lý dữ liệu chuyên nghiệp.

---

## 🎯 Mục tiêu dự án

- Đơn giản hóa quy trình đặt sân bóng đá cho người dùng.
- Hỗ trợ chủ sân quản lý lịch đặt, doanh thu, thông tin khách hàng.
- Đảm bảo bảo mật thông tin, dễ dàng mở rộng và tích hợp dịch vụ bên ngoài.

---

## 🚀 Tính năng nổi bật

- ✅ Đăng ký, đăng nhập, xác thực qua Google OAuth
- ✅ Đặt sân trực tuyến, quản lý lịch đặt, trạng thái thanh toán
- ✅ Quản lý sân, ca, giá, khu vực, loại sân
- ✅ Quản lý người dùng, nhân viên, phân quyền
- ✅ Quản lý bài viết, tin tức, bình luận
- ✅ Thống kê doanh thu, số lượt đặt, báo cáo chi tiết
- ✅ Gửi email xác nhận, thông báo tự động (Jakarta Mail)
- ✅ Upload ảnh sân, avatar qua Cloudinary
- ✅ Bảo mật thông tin qua file cấu hình riêng

---

## 🛠️ Công nghệ chính

| Thành phần        | Công nghệ                                                                 |
|-------------------|--------------------------------------------------------------------------|
| **Backend**       | Java Servlet, JSP, JSTL                                                  |
| **Frontend**      | HTML5, CSS3, Bootstrap 5, JavaScript (jQuery, AJAX), DataTables          |
| **Biểu đồ**       | ApexCharts                                                               |
| **CSDL**          | SQL Server (hoặc tùy chọn: MySQL)                                       |
| **Máy chủ**       | Apache Tomcat 10+                                                        |
| **API xử lý ảnh** | Cloudinary API                                                           |
| **Xác thực OAuth**| Google OAuth 2.0 (Đăng nhập với Google)                                 |
| **Email**         | Jakarta Mail (gửi mail xác minh, thông báo đặt sân, v.v.)               |
| **Thanh toán**    | Webhook SE Pay tích hợp mã QR ngân hàng           |
| **Real-time**     | Java WebSocket API (javax.websocket) để thông báo thời gian thực         |

---

## 🔐 Bảo mật & Xác thực

- Mã hóa mật khẩu người dùng bằng thuật toán BCrypt.
- Xác minh tài khoản qua email với mã OTP.
- Giới hạn quyền truy cập theo vai trò (User, Admin, Staff).

---

## 🧾 Các thư viện/JS Frameworks tiêu biểu

- **jQuery** – xử lý AJAX, DOM, sự kiện UI nhanh chóng.
- **Bootstrap 5** – tạo giao diện responsive, hiện đại.
- **FullCalendar** – hiển thị và quản lý lịch đặt sân.
- **DataTables** – xử lý bảng dữ liệu có sắp xếp, phân trang.
- **ApexCharts** – biểu đồ phân tích số liệu (doanh thu, lượt đặt sân...).

---

## 📦 Quản lý tài nguyên & upload

- Upload hình ảnh lên **Cloudinary** thông qua RESTful API.
- Hình ảnh sân bóng, sản phẩm, bài viết đều được lưu trữ trên Cloudinary để tối ưu tốc độ tải.

---

## 💡 Các module tích hợp

- Đăng nhập/đăng ký + xác minh email.
- Quản lý đặt sân (online/offline).
- Quản lý thanh toán, thống kê doanh thu.
- Tích hợp WebSocket để đồng bộ trạng thái ca đặt theo thời gian thực.
- Quản lý sản phẩm bán kèm (nước, áo bóng đá...).
- Quản lý bài viết sự kiện.
- Quản lý người dùng (Admin, nhân viên, khách hàng).

---

## 🧪 Môi trường phát triển

- Máy chủ: Apache Tomcat 10+
- CSDL: SQL Server Management Studio
- Quản lý dự án: GitHub, Git

---




👥 Đóng góp
Chúng tôi luôn hoan nghênh sự đóng góp từ cộng đồng!

🍴 Fork dự án, tạo branch mới, commit và gửi Pull Request.

📚 Đọc kỹ tài liệu, tuân thủ chuẩn code và quy tắc bảo mật.

💬 Liên hệ qua email hoặc nhóm thảo luận nếu cần hỗ trợ thêm.


- *📬 Email: anhdthe180507@fpt.edu.vn*

Football Field Booking – Giải pháp đặt sân bóng đá hiện đại, bảo mật và chuyên nghiệp!
