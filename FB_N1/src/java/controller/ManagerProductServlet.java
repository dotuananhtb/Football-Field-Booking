package controller;

import dao.CateProduct_DAO;
import dao.ImageStorageDAO;
import dao.ProductDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.CateProduct;
import model.ImageStorage;
import model.Product;
import util.ToastUtil;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ManagerProductServlet", urlPatterns = {"/admin/manager-product"})
public class ManagerProductServlet extends HttpServlet {

    // Helper method để kiểm tra quyền admin
    private boolean isAdmin(Account account) {
        if (account == null || account.getUserProfile() == null) {
            return false;
        }
        // roleId = 1 là ADMIN theo dữ liệu mẫu trong database
        return account.getUserProfile().getRoleId() == 1;
    }

   
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        Account account = (session != null) ? (Account) session.getAttribute("account") : null;

        if (!isAdmin(account)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        ProductDAO productDAO = new ProductDAO();
        CateProduct_DAO cateDAO = new CateProduct_DAO();
        String action = request.getParameter("action");
        String searchKeyword = request.getParameter("search");

        // Lấy danh sách category để hiển thị trong form
        List<CateProduct> categories = cateDAO.getAllCategory();
        request.setAttribute("categories", categories);

        if ("search".equals(action) && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            // Tìm kiếm product
            List<Product> products = productDAO.searchProductByName(searchKeyword.trim());
            
            request.setAttribute("products", products);
            request.setAttribute("searchKeyword", searchKeyword);
        } else if ("filter".equals(action)) {
            // Lọc theo category và giá
            String categoryId = request.getParameter("categoryId");
            String minPriceStr = request.getParameter("minPrice");
            String maxPriceStr = request.getParameter("maxPrice");
            Double minPrice = null, maxPrice = null;
            if (minPriceStr != null && !minPriceStr.isEmpty()) {
                try { minPrice = Double.parseDouble(minPriceStr); } catch (NumberFormatException e) { minPrice = null; }
            }
            if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
                try { maxPrice = Double.parseDouble(maxPriceStr); } catch (NumberFormatException e) { maxPrice = null; }
            }
            List<Product> products;
            if ((categoryId != null && !categoryId.isEmpty()) || minPrice != null || maxPrice != null) {
                // Sử dụng pagingProduct để lọc theo danh mục và giá
                products = new ProductDAO().pagingProduct(
                    categoryId,
                    null, // productName
                    minPrice,
                    maxPrice,
                    1, // pageIndex
                    1000, // pageSize (hiện tất cả)
                    "new" // sortBy
                );
                
                request.setAttribute("selectedCategory", categoryId);
            } else {
                products = productDAO.getAllProducts();
                
            }
            request.setAttribute("products", products);
            request.setAttribute("minPrice", minPriceStr);
            request.setAttribute("maxPrice", maxPriceStr);
        } else {
            // Hiển thị tất cả product
            List<Product> products = productDAO.getAllProducts();
            
            request.setAttribute("products", products);
        }

        request.getRequestDispatcher("/admin/manager-shop.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        Account account = (session != null) ? (Account) session.getAttribute("account") : null;

        if (!isAdmin(account)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        ProductDAO productDAO = new ProductDAO();
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            // Thêm product mới
            try {
                Product product = new Product();
                product.setProductName(request.getParameter("productName"));
                product.setProductCateId(Integer.parseInt(request.getParameter("categoryId")));
                product.setProductPrice(Double.parseDouble(request.getParameter("productPrice")));
                product.setProductImage(request.getParameter("productImage"));
                product.setProductDescription(request.getParameter("productDescription"));
                product.setProductStatus("active");

                if (productDAO.addProduct(product)) {
                    ToastUtil.setSuccessToast(request, "Thêm sản phẩm thành công!");
                } else {
                    ToastUtil.setErrorToast(request, "Thêm sản phẩm thất bại!");
                }
            } catch (Exception e) {
                ToastUtil.setErrorToast(request, "Lỗi: " + e.getMessage());
            }
        } else if ("addCategory".equals(action)) {
            // Thêm loại sản phẩm mới
            try {
                String cateName = request.getParameter("categoryName");
                CateProduct_DAO cateDAO = new CateProduct_DAO();
                // Kiểm tra trùng tên
                CateProduct existed = cateDAO.searchCategoriesByName(cateName);
                if (existed != null) {
                    ToastUtil.setErrorToast(request, "Tên loại sản phẩm đã tồn tại!");
                } else {
                    // Tạo id mới (tăng tự động hoặc lấy max+1)
                    List<CateProduct> all = cateDAO.getAllCategory();
                    int newId = 1;
                    for (CateProduct c : all) {
                        if (c.getProductCateId() >= newId) newId = c.getProductCateId() + 1;
                    }
                    CateProduct newCate = new CateProduct(newId, cateName);
                    int result = cateDAO.insertCategories(newCate);
                    if (result > 0) {
                        ToastUtil.setSuccessToast(request, "Thêm loại sản phẩm thành công!");
                    } else {
                        ToastUtil.setErrorToast(request, "Thêm loại sản phẩm thất bại!");
                    }
                }
            } catch (Exception e) {
                ToastUtil.setErrorToast(request, "Lỗi: " + e.getMessage());
            }
        } else if ("update".equals(action)) {
            // Cập nhật product
            try {
                int productId = Integer.parseInt(request.getParameter("productId"));
                Product product = productDAO.getProductById(productId);
                
                if (product != null) {
                    product.setProductName(request.getParameter("productName"));
                    product.setProductCateId(Integer.parseInt(request.getParameter("categoryId")));
                    product.setProductPrice(Double.parseDouble(request.getParameter("productPrice")));
                    product.setProductImage(request.getParameter("productImage"));
                    product.setProductDescription(request.getParameter("productDescription"));
                    product.setProductStatus(request.getParameter("productStatus"));

                    if (productDAO.updateProduct1(product)) {
                        ToastUtil.setSuccessToast(request, "Cập nhật sản phẩm thành công!");
                    } else {
                        ToastUtil.setErrorToast(request, "Cập nhật sản phẩm thất bại!");
                    }
                } else {
                    ToastUtil.setErrorToast(request, "Không tìm thấy sản phẩm!");
                }
            } catch (Exception e) {
                ToastUtil.setErrorToast(request, "Lỗi: " + e.getMessage());
            }
        } else if ("delete".equals(action)) {
            // Xóa product
            try {
                int productId = Integer.parseInt(request.getParameter("productId"));
                if (productDAO.deleteProduct(productId)) {
                    ToastUtil.setSuccessToast(request, "Xóa sản phẩm thành công!");
                } else {
                    ToastUtil.setErrorToast(request, "Xóa sản phẩm thất bại!");
                }
            } catch (Exception e) {
                ToastUtil.setErrorToast(request, "Lỗi: " + e.getMessage());
            }
        } else if ("toggleStatus".equals(action)) {
            // Thay đổi trạng thái product
            try {
                int productId = Integer.parseInt(request.getParameter("productId"));
                String currentStatus = request.getParameter("currentStatus");
                String newStatus = "active".equals(currentStatus) ? "inactive" : "active";
                
                if (productDAO.updateProductStatus(productId, newStatus)) {
                    ToastUtil.setSuccessToast(request, "Cập nhật trạng thái sản phẩm thành công!");
                } else {
                    ToastUtil.setErrorToast(request, "Cập nhật trạng thái sản phẩm thất bại!");
                }
            } catch (Exception e) {
                ToastUtil.setErrorToast(request, "Lỗi: " + e.getMessage());
            }
        } else if ("deleteCategory".equals(action)) {
            // Xoá loại sản phẩm
            try {
                int cateId = Integer.parseInt(request.getParameter("categoryId"));
                CateProduct_DAO cateDAO = new CateProduct_DAO();
                int result = cateDAO.deleteCategories(cateId);
                if (result > 0) {
                    ToastUtil.setSuccessToast(request, "Xoá loại sản phẩm thành công!");
                } else {
                    ToastUtil.setErrorToast(request, "Xoá loại sản phẩm thất bại! (Có thể còn sản phẩm thuộc loại này)");
                }
            } catch (Exception e) {
                ToastUtil.setErrorToast(request, "Lỗi: " + e.getMessage());
            }
        } else if ("editCategory".equals(action)) {
            // Chỉnh sửa loại sản phẩm
            try {
                int cateId = Integer.parseInt(request.getParameter("categoryId"));
                String cateName = request.getParameter("categoryName");
                CateProduct_DAO cateDAO = new CateProduct_DAO();
                // Kiểm tra trùng tên (trừ chính nó)
                CateProduct existed = cateDAO.searchCategoriesByName(cateName);
                if (existed != null && existed.getProductCateId() != cateId) {
                    ToastUtil.setErrorToast(request, "Tên loại sản phẩm đã tồn tại!");
                } else {
                    CateProduct cate = new CateProduct(cateId, cateName);
                    cateDAO.updateCategories(cate);
                    ToastUtil.setSuccessToast(request, "Cập nhật loại sản phẩm thành công!");
                }
            } catch (Exception e) {
                ToastUtil.setErrorToast(request, "Lỗi: " + e.getMessage());
            }
        }

        // Redirect về trang quản lý product
        response.sendRedirect(request.getContextPath() + "/admin/manager-product");
    }
} 