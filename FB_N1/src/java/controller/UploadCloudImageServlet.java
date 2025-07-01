package controller;

import dao.ImageStorageDAO;
import dao.UserProfileDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import logic.CloudinaryUploader;
import model.Account;
import model.UserProfile;
import util.ToastUtil;

import java.io.IOException;

@WebServlet("/upload-cloud-image")
@MultipartConfig
public class UploadCloudImageServlet extends HttpServlet {

    private final CloudinaryUploader uploader = new CloudinaryUploader();
    private final ImageStorageDAO imageDAO = new ImageStorageDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String type = request.getParameter("type"); // avatars, field, article, etc.
        String relatedIdStr = request.getParameter("relatedId");
        int relatedId = relatedIdStr != null && !relatedIdStr.isBlank() ? Integer.parseInt(relatedIdStr) : -1;
        Account account = (Account) request.getSession().getAttribute("account");

        switch (type.toLowerCase()) {
            case "avatars":
                handleAvatarUpload(request, response, account);
                break;
            case "field":
            case "article":
            case "product":
            case "banner":
                handleMultiImageUpload(request, response, type, relatedId);
                break;
            default:
                ToastUtil.setErrorToast(request, "Loại ảnh không được hỗ trợ.");
                redirectBack(request, response);
        }
    }

    private void handleAvatarUpload(HttpServletRequest request, HttpServletResponse response, Account account) throws IOException, ServletException {
        if (account == null || account.getUserProfile() == null) {
            ToastUtil.setErrorToast(request, "Bạn cần đăng nhập để cập nhật avatar.");
            redirectBack(request, response);
            return;
        }

        Part part = request.getPart("image"); // name="image"
        try {
            String url = uploader.uploadImage(part, "avatars");
            UserProfileDAO profileDAO = new UserProfileDAO();
            boolean updated = profileDAO.updateAvatar(url, account.getAccountId());
            if (updated) {
                account.getUserProfile().setAvatar(url);
                request.getSession().setAttribute("account", account);
                ToastUtil.setSuccessToast(request, "Cập nhật avatar thành công!");
            } else {
                ToastUtil.setErrorToast(request, "Không thể cập nhật avatar.");
            }
        } catch (Exception e) {
            ToastUtil.setErrorToast(request, "Lỗi khi upload ảnh: " + e.getMessage());
        }
        redirectBack(request, response);
    }

    private void handleMultiImageUpload(HttpServletRequest request, HttpServletResponse response, String type, int relatedId) throws IOException, ServletException {
        int success = 0;
        for (Part part : request.getParts()) {
            if (!"images".equals(part.getName()) || part.getSize() == 0) {
                continue;
            }

            try {
                String url = uploader.uploadImage(part, type);
                boolean inserted = imageDAO.insertImage(url, type, relatedId);
                if (inserted) {
                    success++;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (success > 0) {
            ToastUtil.setSuccessToast(request, "Đã upload " + success + " ảnh thành công.");
        } else {
            ToastUtil.setErrorToast(request, "Không có ảnh nào được upload.");
        }
        redirectBack(request, response);
    }

    private void redirectBack(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String referer = request.getHeader("referer");
        response.sendRedirect(referer != null ? referer : request.getContextPath() + "/home");
    }
}
