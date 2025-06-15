package controller;

import dao.PostDAO;
import model.Post;
import model.Account;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ManagerPostServlet", urlPatterns = {"/admin/managerPost"})
public class ManagerPostServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
//        Account acc = (Account) session.getAttribute(   "account");
//        if (acc == null || (acc.getRoleId() != 1 && acc.getRoleId() != 2)) {
//            response.sendRedirect(request.getContextPath() + "/home");
//            return;
//        }
        PostDAO postDAO = new PostDAO();
        List<Post> posts = postDAO.getAllPosts();
        request.setAttribute("posts", posts);
        request.setAttribute("pageTitle", "Quản lý bài viết");
        request.setAttribute("colId", "ID");
        request.setAttribute("colTitle", "Tiêu đề");
        request.setAttribute("colAuthor", "Tác giả");
        request.setAttribute("colDate", "Ngày đăng");
        request.setAttribute("colStatus", "Trạng thái");
        request.setAttribute("colAction", "Hành động");
        request.getRequestDispatcher("/ADMIN/ManagerPost.jsp").forward(request, response);
    }
} 