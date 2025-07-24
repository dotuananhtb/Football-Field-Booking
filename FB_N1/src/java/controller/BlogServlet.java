package controller;

import dao.*;
import java.io.IOException;
import java.util.Vector;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Post;
import model.Comment;
import model.Account;

@WebServlet(name = "BlogServlet", urlPatterns = {"/bai-viet"})
public class BlogServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            
            PostDAO postDAO = new PostDAO();
            CommentDAO commentDAO = new CommentDAO();
            
            String pageStr = request.getParameter("page");
            int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
            int pageSize = 4;

            String search = request.getParameter("search");

            Vector<Post> posts;
            int totalPosts;
            if (search != null && !search.trim().isEmpty()) {
                posts = postDAO.searchPostsByRegularUsers(search, page, pageSize);
                totalPosts = postDAO.countSearchPostsByRegularUsers(search);
                request.setAttribute("search", search);
            } else {
                posts = postDAO.getPostsByRegularUsers(page, pageSize);
                totalPosts = postDAO.countPostsByRegularUsers();
            }
            
            // Tạo Map lưu số comment cho từng post
            Map<Integer, Integer> commentCounts = new HashMap<>();
            Map<Integer, List<Comment>> commentsMap = new HashMap<>();
            for (Post post : posts) {
                int count = commentDAO.countCommentsByPostId(post.getPostId());
                commentCounts.put(post.getPostId(), count);
                commentsMap.put(post.getPostId(), commentDAO.getCommentsByPostId(post.getPostId()));
            }
            int totalPages = (int) Math.ceil((double) totalPosts / pageSize);
            // Lấy 3 bài viết mới nhất của user thường
            Vector<Post> recentPosts = postDAO.getRecentPostsByRegularUsers(3);
            request.setAttribute("posts", posts);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", page);
            request.setAttribute("commentCounts", commentCounts);
            request.setAttribute("recentPosts", recentPosts);
            request.setAttribute("commentsMap", commentsMap);
            request.setAttribute("search", search);
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