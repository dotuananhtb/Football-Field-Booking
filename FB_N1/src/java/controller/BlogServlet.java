package controller;

import dao.*;
import java.io.IOException;
import java.util.Vector;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Post;

@WebServlet(name = "BlogServlet", urlPatterns = {"/blog"})
public class BlogServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            PostDAO postDAO = new PostDAO();
            CommentDAO commentDAO = new CommentDAO();
            
            String pageStr = request.getParameter("page");
            int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
            int pageSize = 4;

            String search = request.getParameter("search");
            Vector<Post> posts;
            int totalPosts;
            if (search != null && !search.trim().isEmpty()) {
                posts = postDAO.searchPostsByTitle(search, page, pageSize);
                totalPosts = postDAO.countPostsByTitle(search);
                request.setAttribute("search", search);
            } else {
                posts = postDAO.getAllPosts(page, pageSize);
                totalPosts = postDAO.getTotalPosts();
            }
            // Set commentCount cho từng post
            for (Post post : posts) {
                int count = commentDAO.countCommentsByPostId(post.getPostId());
                post.setCommentCount(count);
            }
            int totalPages = (int) Math.ceil((double) totalPosts / pageSize);

            // Lấy 3 bài viết mới nhất cho Recent News
            Vector<Post> recentPosts = postDAO.getAllPosts(1, 3);
            request.setAttribute("recentPosts", recentPosts);

            request.setAttribute("posts", posts);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.getRequestDispatcher("UI/blog.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi: " + e.getMessage());
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
} 