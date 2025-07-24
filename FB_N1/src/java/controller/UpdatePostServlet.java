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

@WebServlet(name = "UpdatePostServlet", urlPatterns = {"/cap-nhat-bai-viet"})
public class UpdatePostServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PostDAO postDAO = new PostDAO();
        PostDetailsDAO postDetailsDAO = new PostDetailsDAO();
        TypeOfFieldDAO typeDAO = new TypeOfFieldDAO();
        String postIdStr = request.getParameter("postId");
        if (postIdStr == null) {
            response.sendRedirect("quan-ly-bai-viet-nguoi-dung");
            return;
        }
        int postId;
        try {
            postId = Integer.parseInt(postIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("quan-ly-bai-viet-nguoi-dung");
            return;
        }
        Post post = postDAO.getPostById(postId);
        if (post == null) {
            ToastUtil.setErrorToast(request, "Không tìm thấy bài viết!");
            response.sendRedirect("quan-ly-bai-viet-nguoi-dung");
            return;
        }
        PostDetails postDetails = postDetailsDAO.getByPostId(postId);
        if (postDetails == null) {
            ToastUtil.setErrorToast(request, "Không tìm thấy chi tiết bài viết!");
            response.sendRedirect("quan-ly-bai-viet-nguoi-dung");
            return;
        }
        List<TypeOfField> fieldTypes = typeDAO.getAllFieldTypes();
        String currentDate = java.time.LocalDate.now().toString();

        request.setAttribute("post", post);
        request.setAttribute("postDetails", postDetails);
        request.setAttribute("fieldTypes", fieldTypes);
        request.setAttribute("currentDate", currentDate);
        request.getRequestDispatcher("UI/updatePost.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PostDAO postDAO = new PostDAO();
        PostDetailsDAO postDetailsDAO = new PostDetailsDAO();
        TypeOfFieldDAO typeDAO = new TypeOfFieldDAO();
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            response.sendRedirect("login");
            return;
        }
        String postIdStr = request.getParameter("postId");
        if (postIdStr == null || postIdStr.isEmpty()) {
            response.sendRedirect("quan-ly-bai-viet-nguoi-dung");
            return;
        }
        int postId;
        try {
            postId = Integer.parseInt(postIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("quan-ly-bai-viet-nguoi-dung");
            return;
        }
        String title = request.getParameter("title");
        String userContent = request.getParameter("userContent");
        String content = userContent != null ? userContent : "";
        String matchDate = request.getParameter("matchDate");
        String matchTime = request.getParameter("matchTime");
        String fieldTypeIdStr = request.getParameter("fieldTypeId");
        String fieldType = "";
        if (fieldTypeIdStr != null && !fieldTypeIdStr.isEmpty()) {
            try {
                int fieldTypeId = Integer.parseInt(fieldTypeIdStr);
                fieldType = typeDAO.getFieldTypeNameById(fieldTypeId);
            } catch (NumberFormatException ignored) {}
        }
        if (title == null || title.trim().isEmpty() || matchDate == null || matchDate.trim().isEmpty() || matchTime == null || matchTime.trim().isEmpty() || fieldType.isEmpty()) {
            ToastUtil.setErrorToast(request, "Vui lòng điền đầy đủ thông tin!");
            response.sendRedirect("cap-nhat-bai-viet?postId=" + postId);
            return;
        }
        Post post = new Post();
        post.setPostId(postId);
        post.setTitle(title);
        post.setContentPost(content);
        post.setStatusPost("active");
        postDAO.updatePost(post);
        postDetailsDAO.update(postId, matchDate, matchTime, fieldType);
        ToastUtil.setSuccessToast(request, "Cập nhật bài viết thành công!");
        response.sendRedirect("quan-ly-bai-viet-nguoi-dung");
    }
} 