package controller;

import dao.PostDAO;
import dao.CommentDAO;
import model.Post;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
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
        // List<Post> posts = postDAO.getAllPosts();
        List<Post> posts = postDAO.getAllPostsByUserRole(3);
        Map<Integer, Integer> commentCounts = new HashMap<>();
        for (Post post : posts) {
            int count = commentDAO.countCommentsByPostId(post.getPostId());
            commentCounts.put(post.getPostId(), count);
        }
        request.setAttribute("posts", posts);
        request.setAttribute("commentCounts", commentCounts);
        request.getRequestDispatcher("/admin/ManagerPost.jsp").forward(request, response);
    }
} 