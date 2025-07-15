package controller;

import dao.ProductDAO;
import dao.ProductDetailsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Product;
import model.ProductDetails;

@WebServlet(name = "ProductDetailsServlet", urlPatterns = {"/product-details"})
public class ProductDetailsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productIdStr = request.getParameter("productId");
        if (productIdStr == null || productIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/UI/shop.jsp");
            return;
        }
        int productId;
        try {
            productId = Integer.parseInt(productIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/UI/shop.jsp");
            return;
        }
        ProductDAO productDAO = new ProductDAO();
        ProductDetailsDAO detailsDAO = new ProductDetailsDAO();
        Product product = productDAO.getProductById(productId);
        if (product == null) {
            response.sendRedirect(request.getContextPath() + "/UI/shop.jsp");
            return;
        }
        List<ProductDetails> productDetails = detailsDAO.getDetailsByProductId(productId);
        request.setAttribute("product", product);
        request.setAttribute("productDetails", productDetails);
        request.getRequestDispatcher("/UI/product-details.jsp").forward(request, response);
    }
} 