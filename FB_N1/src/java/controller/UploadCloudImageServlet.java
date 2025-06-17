package controller;

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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Part filePart = request.getPart("image"); // name="image" trong form
        String type = request.getParameter("type"); // avatars, products,...
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        try {
            String cloudinaryUrl = uploader.uploadImage(filePart, type);

            if (cloudinaryUrl == null) {
                ToastUtil.setErrorToast(request, "Vui lòng chọn đúng định dạng ảnh (jpg, png, jpeg, gif, webp).");
                redirectBack(request, response);
                return;
            }

            switch (type.toLowerCase()) {
                case "avatars":
                    if (account == null) {
                        ToastUtil.setErrorToast(request, "Bạn cần đăng nhập để thay đổi avatar.");
                        break;
                    }

                    UserProfileDAO profileDAO = new UserProfileDAO();
                    UserProfile profile = account.getUserProfile();

                    if (profile == null) {
                        ToastUtil.setErrorToast(request, "Không tìm thấy hồ sơ người dùng.");
                        break;
                    }

                    boolean updated = profileDAO.updateAvatar(cloudinaryUrl, account.getAccountId());
                    if (updated) {
                        profile.setAvatar(cloudinaryUrl);
                        account.setUserProfile(profile);
                        session.setAttribute("account", account);
                        ToastUtil.setSuccessToast(request, "Cập nhật avatar thành công!");
                    } else {
                        ToastUtil.setErrorToast(request, "Không thể cập nhật avatar.");
                    }
                    break;
//////-----Các key khác viết ở dưới---------------------////
                case "products":
                    ToastUtil.setWarningToast(request, "Tính năng đang được phát triển.");

                case "banners":
                    ToastUtil.setWarningToast(request, "Tính năng đang được phát triển.");

                case "fatherproducts":
                    ToastUtil.setWarningToast(request, "Tính năng đang được phát triển.");
                    break;

                default:
                    ToastUtil.setErrorToast(request, "Loại ảnh không hợp lệ.");
            }

        } catch (Exception e) {
            e.printStackTrace(); // ❗ In lỗi chi tiết ra console
            ToastUtil.setErrorToast(request, "Lỗi upload ảnh: " + e.getMessage());
        }

        redirectBack(request, response);
    }

    private void redirectBack(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String referer = request.getHeader("referer");
        response.sendRedirect(referer != null ? referer : request.getContextPath() + "/home");
    }
}
