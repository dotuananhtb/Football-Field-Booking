<%-- 
    Document   : DEMO_UPANH
    Created on : Jun 24, 2025, 6:47:36 PM
    Author     : Đỗ Tuấn Anh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Upload Ảnh Demo</title>
    <style>
        .preview-img {
            width: 100px;
            height: auto;
            margin: 5px;
            border: 1px solid #ccc;
            object-fit: cover;
        }
    </style>
</head>
<body>
    <h2>Upload 1 ảnh (ví dụ avatar)</h2>
    <form action="${pageContext.request.contextPath}/upload-cloud-image" method="post" enctype="multipart/form-data" id="formSingle">
        <input type="file" name="image" accept="image/*" id="singleImageInput" required>
        <input type="hidden" name="type" value="avatars">
        <div id="singlePreview"></div>
        <button type="submit">Tải lên</button>
    </form>

    <hr>

    <h2>Upload nhiều ảnh (ảnh sân, sản phẩm...)</h2>
    <form action="${pageContext.request.contextPath}/upload-cloud-image" method="post" enctype="multipart/form-data" id="formMultiple">
        <input type="file" name="images" accept="image/*" multiple id="multiImageInput" required>
        <input type="hidden" name="type" value="field"> <!-- thay value bằng tên thư mục (loại của ảnh sân , bài viết, đều lưu trên thư mục riêng biệt trên clouddinary để dễ quản lí??) -->
        <input type="hidden" name="relatedId" value="1"> <!-- ID sân hoặc bài viết -->
        <div id="multiPreview"></div>
        <button type="submit">Tải lên</button>
    </form>

    <script>
        // Preview ảnh 1 ảnh duy nhất
        document.getElementById('singleImageInput').addEventListener('change', function () {
            const preview = document.getElementById('singlePreview');
            preview.innerHTML = ""; // clear cũ
            const file = this.files[0];
            if (!file) return;

            const reader = new FileReader();
            reader.onload = function (e) {
                const img = document.createElement('img');
                img.src = e.target.result;
                img.className = "preview-img";
                preview.appendChild(img);
            };
            reader.readAsDataURL(file);
        });

        // Preview nhiều ảnh
        document.getElementById('multiImageInput').addEventListener('change', function () {
            const preview = document.getElementById('multiPreview');
            preview.innerHTML = "";

            [...this.files].forEach(file => {
                const reader = new FileReader();
                reader.onload = function (e) {
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    img.className = "preview-img";
                    preview.appendChild(img);
                };
                reader.readAsDataURL(file);
            });
        });
    </script>
</body>
</html>
