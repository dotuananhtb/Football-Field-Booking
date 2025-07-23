package controller;

import dao.PostDAO;
import dao.CommentDAO;
import dao.TypeOfFieldDAO;
import dao.PostDetailsDAO;
import model.Post;
import model.Comment;
import model.TypeOfField;
import model.PostDetails;
import java.io.IOException;
import java.util.Vector;
import java.util.List;
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
            TypeOfFieldDAO typeDAO = new TypeOfFieldDAO();
            PostDetailsDAO postDetailsDAO = new PostDetailsDAO();

            Post post = postDAO.getPostById(postId);
            if (post == null) {
                response.sendRedirect("blog");
                return;
            }
            // Lấy số điện thoại người đăng
            String phone = null;
            if (post.getAccount() != null && post.getAccount().getAccountId() > 0) {
                dao.AccountDAO accountDAO = new dao.AccountDAO();
                model.Account acc = accountDAO.getAccountById(post.getAccountId());
                if (acc != null && acc.getUserProfile() != null) {
                    phone = acc.getUserProfile().getPhone();
                }
            }
            Vector<Comment> comments = commentDAO.getCommentsByPostId(postId);
            List<TypeOfField> fieldTypes = typeDAO.getAllFieldTypes();
            PostDetails postDetails = postDetailsDAO.getByPostId(postId);

            request.setAttribute("post", post);
            request.setAttribute("comments", comments);
            request.setAttribute("fieldTypes", fieldTypes); // truyền sang JSP
            request.setAttribute("postDetails", postDetails); // truyền sang JSP (PostDetails)
            request.setAttribute("posterPhone", phone); // truyền sang JSP (sđt người đăng)
            request.getRequestDispatcher("UI/blogDetails.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi: " + e.getMessage());
        }
    }
}