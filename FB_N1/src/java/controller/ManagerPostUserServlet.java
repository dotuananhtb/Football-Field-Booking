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

@WebServlet(name = "ManagerPostUserServlet", urlPatterns = {"/quan-ly-bai-viet-nguoi-dung"})
public class ManagerPostUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            response.sendRedirect("dang-nhap");
            return;
        }
        int userId = account.getAccountId();

        String pageStr = request.getParameter("page");
        String search = request.getParameter("search");
        int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
        int pageSize = 4;

        PostDAO postDAO = new PostDAO();
        List<Post> userPosts;
        int totalPosts;
        
        if (search != null && !search.trim().isEmpty()) {
            userPosts = postDAO.searchPostsByUserAndTitle(userId, search, page, pageSize);
            totalPosts = postDAO.countPostsByUserAndTitle(userId, search);
        } else {
            userPosts = postDAO.getPostsByAccountIdPaging(userId, page, pageSize);
            totalPosts = postDAO.countPostsByAccountId(userId);
        }

        int totalPages = (int) Math.ceil((double) totalPosts / pageSize);

        // Lấy danh sách loại sân
        TypeOfFieldDAO typeDAO = new TypeOfFieldDAO();
        List<TypeOfField> fieldTypes = typeDAO.getAllFieldTypes();

        request.setAttribute("userPosts", userPosts);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("search", search);
        request.setAttribute("fieldTypes", fieldTypes); // truyền sang JSP
        request.getRequestDispatcher("UI/managerPostUser.jsp").forward(request, response);
    }
}