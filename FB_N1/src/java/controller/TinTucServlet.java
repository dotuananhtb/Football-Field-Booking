package controller;

import dao.PostDAO;
import dao.CommentDAO;
import model.Post;
import model.Comment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@WebServlet(name = "TinTucServlet", urlPatterns = {"/tin-tuc"})
public class TinTucServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        try {
            // Lấy tham số tìm kiếm và trang
            String search = request.getParameter("search");
            String pageStr = request.getParameter("page");
            int currentPage = 1;
            if (pageStr != null && !pageStr.isEmpty()) {
                currentPage = Integer.parseInt(pageStr);
            }
            
            PostDAO postDAO = new PostDAO();
            CommentDAO commentDAO = new CommentDAO();
            
            // Lấy danh sách bài viết của admin và staff với tìm kiếm và phân trang
            List<Post> posts;
            int totalPosts;
            int postsPerPage = 5;
            
            if (search != null && !search.trim().isEmpty()) {
                posts = postDAO.searchPostsByStaffAndAdmin(search, currentPage, postsPerPage);
                totalPosts = postDAO.countSearchPostsByStaffAndAdmin(search);
            } else {
                posts = postDAO.getPostsByStaffAndAdmin(currentPage, postsPerPage);
                totalPosts = postDAO.countPostsByStaffAndAdmin();
            }
            
            // Tính tổng số trang
            int totalPages = (int) Math.ceil((double) totalPosts / postsPerPage);
            
            // Lấy số bình luận cho mỗi bài viết
            Map<Integer, Integer> commentCounts = new HashMap<>();
            for (Post post : posts) {
                int count = commentDAO.countCommentsByPostId(post.getPostId());
                commentCounts.put(post.getPostId(), count);
            }
            
            // Lấy bình luận cho mỗi bài viết
            Map<Integer, List<Comment>> commentsMap = new HashMap<>();
            for (Post post : posts) {
                List<Comment> comments = commentDAO.getCommentsByPostId(post.getPostId());
                commentsMap.put(post.getPostId(), comments);
            }
            
            // Lấy 3 bài viết gần đây nhất của admin và staff
            List<Post> recentPosts = postDAO.getRecentPostsByStaffAndAdmin(3);
            
            // Set attributes
            request.setAttribute("posts", posts);
            request.setAttribute("commentCounts", commentCounts);
            request.setAttribute("commentsMap", commentsMap);
            request.setAttribute("recentPosts", recentPosts);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("search", search);
            
            // Forward đến trang Tin-Tuc.jsp
            request.getRequestDispatcher("/UI/Tin-Tuc.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi server: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet hiển thị trang tin tức cho staff và admin";
    }
} 