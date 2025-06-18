package logic;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

public class SaveFile {

    /**
     * Upload file vào thư mục web/UI/assets/images/upload/{type} và cả build/
     *
     * @param filePart ảnh nhận từ form
     * @param type thư mục con như: avatars, products,...
     * @param context ServletContext để tính được đường dẫn gốc động
     * @return Đường dẫn tương đối (dùng cho frontend)
     * @throws IOException
     */
    public String upload(Part filePart, String type, ServletContext context) throws IOException {
        if (filePart == null || filePart.getSize() == 0 || type == null || type.isEmpty()) {
            return null;
        }

        String fileName = getFileName(filePart).toLowerCase();
        if (fileName.isEmpty()) {
            return null;
        }

        String contentType = filePart.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            return null;
        }

        // Kiểm tra phần mở rộng hợp lệ
        if (!(fileName.endsWith(".jpg") || fileName.endsWith(".jpeg")
                || fileName.endsWith(".png") || fileName.endsWith(".gif")
                || fileName.endsWith(".webp"))) {
            return null;
        }

        // Ghi vào thư mục gốc: /web/UI/assets/images/upload/type
        String rootPath = context.getRealPath("/");
        File webRoot = new File(rootPath).getParentFile().getParentFile();
        File originalDir = new File(webRoot, "web/UI/assets/images/upload/" + type);
        if (!originalDir.exists()) {
            originalDir.mkdirs();
        }

        File fileInWeb = new File(originalDir, fileName);
        Files.copy(filePart.getInputStream(), fileInWeb.toPath(), StandardCopyOption.REPLACE_EXISTING);

        // Ghi vào thư mục build: /build/web/UI/assets/images/upload/type
        String buildUploadPath = context.getRealPath("/UI/assets/images/upload/" + type);
        File buildDir = new File(buildUploadPath);
        if (!buildDir.exists()) {
            buildDir.mkdirs();
        }

        File fileInBuild = new File(buildDir, fileName);
        Files.copy(filePart.getInputStream(), fileInBuild.toPath(), StandardCopyOption.REPLACE_EXISTING);

        return "./assets/images/upload/" + type + "/" + fileName;
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition != null) {
            for (String token : contentDisposition.split(";")) {
                if (token.trim().startsWith("filename")) {
                    return token.substring(token.indexOf("=") + 2, token.length() - 1).replace("\\", "/");
                }
            }
        }
        return "";
    }
}
