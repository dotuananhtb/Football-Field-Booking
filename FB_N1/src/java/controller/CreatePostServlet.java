package controller;

import dao.PostDAO;
import dao.TypeOfFieldDAO;
import model.Account;
import model.Post;
import model.TypeOfField;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import util.ToastUtil;

@WebServlet(name = "CreatePostServlet", urlPatterns = {"/createPost"})
public class CreatePostServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            response.sendRedirect("login");
            return;
        }
        
        // Lấy danh sách loại sân
        TypeOfFieldDAO typeDAO = new TypeOfFieldDAO();
        List<TypeOfField> fieldTypes = typeDAO.getAllFieldTypes();
        // Lấy ngày hiện tại
        String currentDate = java.time.LocalDate.now().toString();
        request.setAttribute("fieldTypes", fieldTypes);
        request.setAttribute("currentDate", currentDate);
        request.setAttribute("account", account);
        request.getRequestDispatcher("UI/addPost.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            response.sendRedirect("login");
            return;
        }
        String title = request.getParameter("title");
        String startTime = request.getParameter("startTime");
        String bookingDate = request.getParameter("bookingDate");
        String fieldTypeId = request.getParameter("fieldTypeId");
        String userContent = request.getParameter("userContent");
        
        // Ghép nội dung
        String content;
        if (startTime != null && !startTime.isEmpty() && bookingDate != null && !bookingDate.isEmpty() && fieldTypeId != null && !fieldTypeId.isEmpty()) {
            // Có thông tin booking
            TypeOfFieldDAO typeDAO = new TypeOfFieldDAO();
            String fieldTypeName = typeDAO.getFieldTypeNameById(Integer.parseInt(fieldTypeId));
            content = "Giờ muốn đặt: " + startTime +
                     ", Ngày muốn đặt: " + bookingDate +
                     ", Loại sân muốn chơi: " + fieldTypeName;
            if (userContent != null && !userContent.trim().isEmpty()) {
                content += ", Ghi chú: " + userContent;
            }
        } else {
            
            content = userContent != null ? userContent : "";
        }
        
        PostDAO postDAO = new PostDAO();
        Post post = new Post();
        post.setAccountId(account.getAccountId());
        post.setTitle(title);
        post.setContentPost(content);
        post.setStatusPost("active");
        postDAO.createPost(post);
        ToastUtil.setSuccessToast(request, "Tạo bài viết thành công!");
        response.sendRedirect("managerPostUser");
    }
} 