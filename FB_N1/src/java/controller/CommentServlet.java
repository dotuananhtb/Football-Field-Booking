package controller;

import dao.CommentDAO;
import model.Comment;
import model.Account;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "CommentServlet", urlPatterns = {"/comment"})
public class CommentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String postIdStr = request.getParameter("postId");
            String content = request.getParameter("content");
            HttpSession session = request.getSession(false);
            Account acc = (Account) session.getAttribute("account");

            if (acc == null) {
                // Chưa đăng nhập, chuyển hướng về trang login
                response.sendRedirect( "/FB_N1/login");
                return;
            }

            if (postIdStr != null && content != null) {
                int postId = Integer.parseInt(postIdStr);

                Comment comment = new Comment();
                
                comment.setPostId(postId);
                comment.setAccountId(acc.getAccountId());
                comment.setContentCmt(content);

                CommentDAO commentDAO = new CommentDAO();
                commentDAO.addComment(comment);
            }
            response.sendRedirect(request.getContextPath() + "/blogdetails?postId=" + postIdStr);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi: " + e.getMessage());
        }
    }
} 