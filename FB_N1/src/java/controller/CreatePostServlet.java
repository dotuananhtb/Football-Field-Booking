package controller;

import dao.PostDAO;
import dao.TypeOfFieldDAO;
import dao.PostDetailsDAO;
import model.Account;
import model.Post;
import model.TypeOfField;
import model.PostDetails;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import util.ToastUtil;

@WebServlet(name = "CreatePostServlet", urlPatterns = {"/tao-bai-viet"})
public class CreatePostServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        TypeOfFieldDAO typeDAO = new TypeOfFieldDAO();
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            response.sendRedirect("dang-nhap");
            return;
        }
        List<TypeOfField> fieldTypes = typeDAO.getAllFieldTypes();
        String currentDate = java.time.LocalDate.now().toString();
        request.setAttribute("fieldTypes", fieldTypes);
        request.setAttribute("currentDate", currentDate);
        request.setAttribute("account", account);
        request.getRequestDispatcher("UI/addPost.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        TypeOfFieldDAO typeDAO = new TypeOfFieldDAO();
        PostDAO postDAO = new PostDAO();
        PostDetailsDAO postDetailsDAO = new PostDetailsDAO();
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            response.sendRedirect("dang-nhap");
            return;
        }
        String title = request.getParameter("title");
        String startTime = request.getParameter("startTime");
        String bookingDate = request.getParameter("bookingDate");
        String fieldTypeIdStr = request.getParameter("fieldTypeId");
        String userContent = request.getParameter("userContent");
        String content = userContent != null ? userContent : "";

        if (title == null || title.trim().isEmpty() || startTime == null || startTime.trim().isEmpty() || bookingDate == null || bookingDate.trim().isEmpty() || fieldTypeIdStr == null || fieldTypeIdStr.trim().isEmpty()) {
            ToastUtil.setErrorToast(request, "Vui lòng điền đầy đủ thông tin!");
            response.sendRedirect("tao-bai-viet");
            return;
        }
        int fieldTypeId = 0;
        String fieldType = "";
        try {
            fieldTypeId = Integer.parseInt(fieldTypeIdStr);
            fieldType = typeDAO.getFieldTypeNameById(fieldTypeId);
        } catch (NumberFormatException e) {
            ToastUtil.setErrorToast(request, "Loại sân không hợp lệ!");
            response.sendRedirect("tao-bai-viet");
            return;
        }
        Post post = new Post();
        post.setAccountId(account.getAccountId());
        post.setTitle(title);
        post.setContentPost(content);
        post.setStatusPost("active");
        post.setPostDate(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").format(java.time.LocalDateTime.now()));
        int postId = postDAO.createPost(post);
        if (postId <= 0) {
            ToastUtil.setErrorToast(request, "Tạo bài viết thất bại!");
            response.sendRedirect("tao-bai-viet");
            return;
        }
        PostDetails postDetails = new PostDetails(postId, bookingDate, startTime, fieldType);
        try {
            postDetailsDAO.insert(postDetails);
        } catch (Exception e) {
            e.printStackTrace();
            ToastUtil.setErrorToast(request, "Tạo chi tiết bài viết thất bại!");
            response.sendRedirect("tao-bai-viet");
            return;
        }
        ToastUtil.setSuccessToast(request, "Tạo bài viết thành công!");
        response.sendRedirect("quan-ly-bai-viet-nguoi-dung");
    }
} 