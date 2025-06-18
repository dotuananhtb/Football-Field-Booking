package controller;

import dao.UserProfileDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import logic.SaveFile;
import model.Account;
import model.UserProfile;
import util.ToastUtil;

import java.io.IOException;

@WebServlet("/upload-image")
@MultipartConfig
public class UploadImageServlet extends HttpServlet {

    private final SaveFile saveFile = new SaveFile();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Part filePart = request.getPart("image"); // name="image" trong form
        String type = request.getParameter("type"); // type = avatars, products, ...
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        try {
            String relativePath = saveFile.upload(filePart, type, getServletContext());
            if (relativePath == null) {
                ToastUtil.setErrorToast(request, "Vui lòng chọn đúng định dạng ảnh (jpg, jpeg, png, gif, webp).");
                redirectBack(request, response);
                return;
            }

            switch (type.toLowerCase()) {
                case "avatars":
                    if (account == null) {
                        ToastUtil.setErrorToast(request, "Bạn cần đăng nhập để thay đổi avatar.");
                        break;
                    }

                    UserProfileDAO userProfileDAO = new UserProfileDAO();
                    UserProfile userProfile = account.getUserProfile();

                    if (userProfile == null) {
                        ToastUtil.setErrorToast(request, "Không tìm thấy hồ sơ người dùng.");
                        break;
                    }

                    boolean updated = userProfileDAO.updateAvatar(relativePath, account.getAccountId());
                    if (updated) {
                        userProfile.setAvatar(relativePath);
                        account.setUserProfile(userProfile);
                        session.setAttribute("account", account);
                        ToastUtil.setSuccessToast(request, "Cập nhật avatar thành công!");
                    } else {
                        ToastUtil.setErrorToast(request, "Không thể cập nhật avatar.");
                    }
                    break;

                case "products":
                case "banners":
                case "fatherproducts":
                    ToastUtil.setWarningToast(request, "Tính năng đang phát triển.");
                    break;

                default:
                    ToastUtil.setErrorToast(request, "Loại ảnh không hợp lệ.");
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
            ToastUtil.setErrorToast(request, "Đã xảy ra lỗi khi xử lý ảnh.");
        }

        redirectBack(request, response);
    }

    private void redirectBack(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String referer = request.getHeader("referer");
        if (referer != null && !referer.isEmpty()) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}
