package controller;

import dao.PostDAO;
import dao.CommentDAO;
import model.Post;
import model.Comment;
import java.io.IOException;
import java.util.Vector;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "BlogDetailsServlet", urlPatterns = {"/blogdetails"})
public class BlogDetailsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String postIdStr = request.getParameter("postId");
            if (postIdStr == null) {
                response.sendRedirect("blog");
                return;
            }
            int postId = Integer.parseInt(postIdStr);

            PostDAO postDAO = new PostDAO();
            CommentDAO commentDAO = new CommentDAO();

            Post post = postDAO.getPostById(postId);
            Vector<Comment> comments = commentDAO.getCommentsByPostId(postId);

            request.setAttribute("post", post);
            request.setAttribute("comments", comments);
            request.getRequestDispatcher("UI/blogDetails.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi: " + e.getMessage());
        }
    }
} 