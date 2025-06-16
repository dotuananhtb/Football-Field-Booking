package controller;

import dao.PostDAO;
import dao.CommentDAO;
import model.Post;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ManagerPostServlet", urlPatterns = {"/admin/managerPost"})
public class ManagerPostServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PostDAO postDAO = new PostDAO();
        CommentDAO commentDAO = new CommentDAO();
        List<Post> posts = postDAO.getAllPosts();
        for (Post post : posts) {
            int count = commentDAO.countCommentsByPostId(post.getPostId());
            post.setCommentCount(count);
        }
        request.setAttribute("posts", posts);
        request.getRequestDispatcher("/admin/ManagerPost.jsp").forward(request, response);
    }
} 