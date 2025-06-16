package controller;

import dao.PostDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DeletePostServlet", urlPatterns = {"/deletePost"})
public class DeletePostServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String postIdStr = request.getParameter("postId");
        if (postIdStr != null) {
            int postId = Integer.parseInt(postIdStr);
            PostDAO postDAO = new PostDAO();
            postDAO.softDeletePost(postId);
        }
        response.sendRedirect("managerPostUser");
    }
} 