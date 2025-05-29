<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thay đổi mật khẩu - Football Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #00bcd4;
            --secondary-color: #4caf50;
            --accent-color: #ff9800;
            --dark-color: #2c3e50;
            --light-color: #ecf0f1;
        }
        
        body {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
                        url('assets/images/football-stadium.jpg') no-repeat center center fixed;
            background-size: cover;
            min-height: 100vh;
            display: flex;
            align-items: center;
            position: relative;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(0, 188, 212, 0.2), rgba(255, 152, 0, 0.2));
            pointer-events: none;
        }

        .change-password-container {
            background: rgba(255, 255, 255, 0.95);
            max-width: 500px;
            margin: 20px auto;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 0 30px rgba(0, 188, 212, 0.3);
            border: 2px solid var(--primary-color);
            position: relative;
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
        }

        .page-title {
            color: var(--primary-color);
            font-weight: bold;
            text-transform: uppercase;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 3px solid var(--accent-color);
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
            position: relative;
        }

        .page-title::after {
            content: '';
            position: absolute;
            bottom: -3px;
            left: 0;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, var(--accent-color), var(--primary-color));
        }

        .form-label {
            font-weight: 600;
            color: var(--dark-color);
        }

        .form-control {
            border-radius: 10px;
            padding: 12px;
            border: 2px solid var(--light-color);
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.9);
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(0, 188, 212, 0.25);
            background: white;
        }

        .btn-primary {
            background: linear-gradient(45deg, var(--primary-color), #00e5ff);
            border: none;
            padding: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            border-radius: 10px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 188, 212, 0.3);
        }

        .btn-primary:hover {
            background: linear-gradient(45deg, #00e5ff, var(--primary-color));
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 188, 212, 0.4);
        }

        .btn-secondary {
            background: linear-gradient(45deg, var(--dark-color), #34495e);
            border: none;
            padding: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(44, 62, 80, 0.3);
        }

        .btn-secondary:hover {
            background: linear-gradient(45deg, #34495e, var(--dark-color));
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(44, 62, 80, 0.4);
        }

        .alert {
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
            border: none;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .alert-danger {
            background: linear-gradient(45deg, #ff5252, #ff1744);
            color: white;
        }

        .alert-success {
            background: linear-gradient(45deg, #4caf50, #00e676);
            color: white;
        }

        .password-requirements {
            font-size: 0.9rem;
            color: var(--dark-color);
            margin-top: 5px;
            padding: 8px;
            background-color: rgba(236, 240, 241, 0.9);
            border-radius: 8px;
        }

        .input-group-text {
            background-color: rgba(236, 240, 241, 0.9);
            border: 2px solid var(--light-color);
            border-left: none;
            border-radius: 0 10px 10px 0;
        }

        .nav-icon {
            font-size: 32px;
            color: var(--accent-color);
            margin-right: 10px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }

        .password-toggle {
            color: var(--primary-color);
            transition: all 0.3s ease;
        }

        .password-toggle:hover {
            color: var(--accent-color);
            transform: scale(1.1);
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .change-password-container {
            animation: fadeIn 0.5s ease-out;
        }

        /* Thêm hiệu ứng cho container */
        .change-password-container::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(45deg, var(--primary-color), var(--accent-color));
            border-radius: 22px;
            z-index: -1;
            opacity: 0.5;
            transition: opacity 0.3s ease;
        }

        .change-password-container:hover::before {
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="change-password-container">
            <div class="text-center mb-4">
                <i class="fas fa-futbol nav-icon"></i>
                <h2 class="page-title">Thay đổi mật khẩu</h2>
            </div>
            
            <%
            // Kiểm tra người dùng đã đăng nhập
            //String username = (String) session.getAttribute("username");
            //if(username == null) {
            //    response.sendRedirect("login.jsp");
            //    return;
            //}
            %>
            
            <% if(request.getAttribute("error") != null) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            <% if(request.getAttribute("success") != null) { %>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle me-2"></i>
                    <%= request.getAttribute("success") %>
                </div>
            <% } %>
            
            <form method="post" action="changePassword" class="needs-validation" novalidate>
                <div class="mb-4">
                    <label for="currentPassword" class="form-label">
                        <i class="fas fa-lock me-2"></i>Mật khẩu hiện tại
                    </label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                        <span class="input-group-text">
                            <i class="fas fa-eye-slash password-toggle" onclick="togglePassword('currentPassword')"></i>
                        </span>
                    </div>
                </div>
                
                <div class="mb-4">
                    <label for="newPassword" class="form-label">
                        <i class="fas fa-key me-2"></i>Mật khẩu mới
                    </label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="newPassword" name="newPassword" required 
                               pattern=".{6,}" title="Mật khẩu phải có ít nhất 6 ký tự">
                        <span class="input-group-text">
                            <i class="fas fa-eye-slash password-toggle" onclick="togglePassword('newPassword')"></i>
                        </span>
                    </div>
                    <div class="password-requirements">
                        <i class="fas fa-info-circle me-1"></i>Mật khẩu phải có ít nhất 6 ký tự
                    </div>
                </div>
                
                <div class="mb-4">
                    <label for="confirmPassword" class="form-label">
                        <i class="fas fa-check-double me-2"></i>Xác nhận mật khẩu mới
                    </label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                        <span class="input-group-text">
                            <i class="fas fa-eye-slash password-toggle" onclick="togglePassword('confirmPassword')"></i>
                        </span>
                    </div>
                </div>
                
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save me-2"></i>Thay đổi mật khẩu
                    </button>
                    <a href="/home" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form validation
        (function () {
            'use strict'
            var forms = document.querySelectorAll('.needs-validation')
            Array.prototype.slice.call(forms)
                .forEach(function (form) {
                    form.addEventListener('submit', function (event) {
                        if (!form.checkValidity()) {
                            event.preventDefault()
                            event.stopPropagation()
                        }
                        form.classList.add('was-validated')
                    }, false)
                })
        })()

        // Kiểm tra mật khẩu xác nhận
        document.getElementById('confirmPassword').addEventListener('input', function() {
            if(this.value !== document.getElementById('newPassword').value) {
                this.setCustomValidity('Mật khẩu xác nhận không khớp');
            } else {
                this.setCustomValidity('');
            }
        });

        // Toggle password visibility
        function togglePassword(inputId) {
            const input = document.getElementById(inputId);
            const icon = input.nextElementSibling.querySelector('i');
            
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            } else {
                input.type = 'password';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            }
        }

        // Add hover effect to password toggle icons
        document.querySelectorAll('.password-toggle').forEach(icon => {
            icon.style.cursor = 'pointer';
            icon.addEventListener('mouseover', function() {
                this.style.color = '#ff9800';
            });
            icon.addEventListener('mouseout', function() {
                this.style.color = '#00bcd4';
            });
        });
    </script>
</body>
</html> 