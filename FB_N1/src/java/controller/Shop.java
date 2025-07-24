/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CateProduct_DAO;
import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.CateProduct;
import model.Product;
import util.ToastUtil;

/**
 *
 * @author Admin
 */
@WebServlet(name = "Shop", urlPatterns = {"/Shop"})
public class Shop extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Shop</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Shop at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDAO dao = new ProductDAO();
        CateProduct_DAO cDAO = new CateProduct_DAO();
        List<CateProduct> listC = cDAO.getAllCategory();
        String indexPage = request.getParameter("index");
        String sortBy = request.getParameter("sortBy");
        String productCateId = request.getParameter("productCateId");
        String productName = request.getParameter("productName");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        String pageSizeStr = request.getParameter("pageSize");
        int index = 1;
        if (indexPage != null && !indexPage.isEmpty()) {
            try {
                index = Integer.parseInt(indexPage);
            } catch (NumberFormatException e) {
                index = 1;
            }
        }

        // Xử lý sortBy
        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "new"; // Mặc định sắp xếp theo sản phẩm mới nhất
        }

        // Xử lý giá min/max
        Double minPrice = null, maxPrice = null;
        if (minPriceStr != null && !minPriceStr.isEmpty()) {
            try {
                minPrice = Double.parseDouble(minPriceStr);
            } catch (NumberFormatException e) {
                minPrice = null;
            }
        }
        if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
            try {
                maxPrice = Double.parseDouble(maxPriceStr);
            } catch (NumberFormatException e) {
                maxPrice = null;
            }
        }

        // Xử lý tên sản phẩm
        if (productName != null && productName.trim().isEmpty()) {
            productName = null;
        }

        // Xử lý category ID
        if (productCateId != null && productCateId.trim().isEmpty()) {
            productCateId = null;
        }

        // Đếm tổng số sản phẩm
        int count = dao.countProduct(productCateId, productName, minPrice, maxPrice);

        // Tính số trang
        int pageSize = 8;
        if (pageSizeStr != null && !pageSizeStr.isEmpty()) {
            try {
                pageSize = Integer.parseInt(pageSizeStr);
                // Giới hạn pageSize trong khoảng hợp lý
                if (pageSize < 4) {
                    pageSize = 4;
                }
                if (pageSize > 100) {
                    pageSize = 100;
                }
            } catch (NumberFormatException e) {
                pageSize = 8; // Fallback về mặc định
            }
        }// Số sản phẩm trên mỗi trang
        int endPage = count / pageSize;
        if (count % pageSize != 0) {
            endPage++;
        }

        boolean isSearching = request.getParameter("productName") != null;

// Lấy danh sách sản phẩm theo trang (chỉ khi không phải search hoặc search hợp lệ)
        List<Product> listP = null;
        String errorMessage = null;
        java.util.List<Product> products = null;

// Nếu đang thực hiện search (có parameter productName)
        if (isSearching) {
            // Validate input search - bắt cả trường hợp null, rỗng, và chỉ có dấu cách
            if (productName == null || productName.trim().isEmpty()) {
                ToastUtil.setErrorToast(request, "Lỗi tìm kiếm yêu cầu nhập lại sản phẩm");
                // Không lấy sản phẩm nào, chỉ forward về trang với lỗi
                request.setAttribute("listC", listC);
                request.setAttribute("endP", 0);
                request.setAttribute("total", 0);
                request.setAttribute("showing", 0);
                request.getRequestDispatcher("UI/shop.jsp").forward(request, response);
                return;
            }

            // Search theo Product Name
            products = dao.searchProductByName(productName.trim());

            if (products == null || products.isEmpty()) {
                ToastUtil.setErrorToast(request, "Không tìm thấy sản phẩm nào");
                // Không hiển thị sản phẩm nào
                request.setAttribute("listC", listC);
                request.setAttribute("searchedProductName", productName);
                request.setAttribute("endP", 0);
                request.setAttribute("total", 0);
                request.setAttribute("showing", 0);
                request.getRequestDispatcher("UI/shop.jsp").forward(request, response);
                return;
            }

            // Search thành công
            request.setAttribute("products", products);
            request.setAttribute("searchedProductName", productName);
            listP = products; // Hiển thị kết quả search

        } else {
            // Lần đầu vào trang hoặc filter/pagination bình thường
            listP = dao.pagingProduct(productCateId, productName,
                    minPrice, maxPrice, index, pageSize, sortBy);
        }

        request.setAttribute("endP", endPage);
        request.setAttribute("page", index);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("total", count);
        request.setAttribute("showing", listP.size());
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("listC", listC);
        request.setAttribute("ListP", listP);


        request.getRequestDispatcher("UI/shop.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
