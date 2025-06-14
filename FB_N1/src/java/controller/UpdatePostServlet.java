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

@WebServlet(name = "UpdatePostServlet", urlPatterns = {"/updatePost"})
public class UpdatePostServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String postIdStr = request.getParameter("postId");
        if (postIdStr == null) {
            response.sendRedirect("managerPostUser");
            return;
        }
        int postId = Integer.parseInt(postIdStr);
        PostDAO postDAO = new PostDAO();
        Post post = postDAO.getPostById(postId);

        TypeOfFieldDAO typeDAO = new TypeOfFieldDAO();
        List<TypeOfField> fieldTypes = typeDAO.getAllFieldTypes();
        String currentDate = java.time.LocalDate.now().toString();

        request.setAttribute("post", post);
        request.setAttribute("fieldTypes", fieldTypes);
        request.setAttribute("currentDate", currentDate);
        request.getRequestDispatcher("UI/updatePost.jsp").forward(request, response);
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
        String postIdStr = request.getParameter("postId");
        if (postIdStr == null || postIdStr.isEmpty()) {
            response.sendRedirect("managerPostUser");
            return;
        }
        int postId = Integer.parseInt(postIdStr);
        String title = request.getParameter("title");
        String userContent = request.getParameter("userContent");
        String content = userContent != null ? userContent : "";

        Post post = new Post();
        post.setPostId(postId);
        post.setTitle(title);
        post.setContentPost(content);
        post.setStatusPost("active");
        PostDAO postDAO = new PostDAO();
        postDAO.updatePost(post);

        response.sendRedirect("managerPostUser");
    }
} 