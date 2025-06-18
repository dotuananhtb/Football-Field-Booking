package logic;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Map;
import java.util.Set;

public class CloudinaryUploader {

    private final Cloudinary cloudinary;
    private final Set<String> allowedExtensions = Set.of("jpg", "jpeg", "png", "gif", "webp");
    private final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB

    public CloudinaryUploader() {
        this.cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "dr64bictm",
                "api_key", "599648759456222",
                "api_secret", "2zMc1mM0OTc8wky4rQJpCLvPfQ0"
        ));
    }

    public String uploadImage(Part filePart, String folderName) throws IOException {
        validateImage(filePart); // <-- tách riêng hàm kiểm tra

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // Tạo file tạm và ghi dữ liệu vào
        File tempFile = File.createTempFile("upload_", "_" + fileName);
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, tempFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }

        // Upload lên Cloudinary
        Map uploadResult = cloudinary.uploader().upload(tempFile, ObjectUtils.asMap(
                "folder", folderName
        ));

        // Xoá file tạm
        tempFile.delete();

        // Trả về URL
        return (String) uploadResult.get("secure_url");
    }

    // ===== Hàm kiểm tra hợp lệ ảnh =====
    private void validateImage(Part filePart) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            throw new IOException("Không có tệp được chọn hoặc tệp rỗng.");
        }

        if (filePart.getSize() > MAX_FILE_SIZE) {
            throw new IOException("Dung lượng ảnh vượt quá giới hạn 5MB.");
        }

        String mimeType = filePart.getContentType();
        if (mimeType == null || !mimeType.toLowerCase().startsWith("image/")) {
            throw new IOException("Tệp không phải là ảnh hợp lệ.");
        }

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        if (!isValidExtension(fileName)) {
            throw new IOException("Định dạng ảnh không được hỗ trợ. Chỉ chấp nhận: jpg, jpeg, png, gif, webp.");
        }
    }

    private boolean isValidExtension(String fileName) {
        int dotIndex = fileName.lastIndexOf('.');
        if (dotIndex == -1) return false;

        String ext = fileName.substring(dotIndex + 1).toLowerCase();
        return allowedExtensions.contains(ext);
    }
}
