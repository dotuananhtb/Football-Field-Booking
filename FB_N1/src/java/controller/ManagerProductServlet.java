package controller;

import dao.CateProduct_DAO;
import dao.ProductDAO;
import dao.ProductDetailsDAO;
import java.io.IOException;
import java.util.List;
import java.util.Set;
import java.util.HashSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;
import model.CateProduct;
import model.Product;
import model.ProductDetails;
import util.ToastUtil;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import logic.CloudinaryUploader;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ManagerProductServlet", urlPatterns = {"/admin/manager-product"})
@MultipartConfig
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

       

        ProductDAO productDAO = new ProductDAO();
        CateProduct_DAO cateDAO = new CateProduct_DAO();
        String action = request.getParameter("action");
        // Lấy danh sách category để hiển thị trong form
        List<CateProduct> categories = cateDAO.getAllCategory();
        request.setAttribute("categories", categories);
        dao.ProductDetailsDAO detailsDAO = new dao.ProductDetailsDAO();

        List<Product> products;
        if ("filter".equals(action)) {
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
                for (Product p : products) {
                    List<ProductDetails> details = detailsDAO.getDetailsByProductId(p.getProductId());
                    p.setProductDetailsList(details);
                }
                request.setAttribute("selectedCategory", categoryId);
            } else {
                products = productDAO.getAllProducts();
                for (Product p : products) {
                    List<ProductDetails> details = detailsDAO.getDetailsByProductId(p.getProductId());
                    p.setProductDetailsList(details);
                }
            }
            request.setAttribute("products", products);
            request.setAttribute("minPrice", minPriceStr);
            request.setAttribute("maxPrice", maxPriceStr);
        } else {
            // Hiển thị tất cả product
            products = productDAO.getAllProducts();
            for (Product p : products) {
                List<ProductDetails> details = detailsDAO.getDetailsByProductId(p.getProductId());
                p.setProductDetailsList(details);
            }
            request.setAttribute("products", products);
        }

        request.getRequestDispatcher("/admin/manager-shop.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        Account account = (session != null) ? (Account) session.getAttribute("account") : null;



        ProductDAO productDAO = new ProductDAO();
        String action = request.getParameter("action");
        CloudinaryUploader uploader = new CloudinaryUploader();

        if ("add".equals(action)) {
            // Thêm product mới
            try {
                Product product = new Product();
                product.setProductName(request.getParameter("productName"));
                product.setProductCateId(Integer.parseInt(request.getParameter("categoryId")));
                product.setProductPrice(Double.parseDouble(request.getParameter("productPrice")));
                Part imagePart = request.getPart("productImageFile");
                String imageUrl = null;
                if (imagePart != null && imagePart.getSize() > 0) {
                    imageUrl = uploader.uploadImage(imagePart, "products");
                }
                product.setProductImage(imageUrl != null ? imageUrl : "");
                product.setProductDescription(request.getParameter("productDescription"));
                product.setProductStatus("active");

                boolean addSuccess = productDAO.addProduct(product);
                int productId = productDAO.getLastInsertedProductId();

                // Lấy các biến thể từ request
                String[] colors = request.getParameterValues("color[]");
                String[] sizes = request.getParameterValues("size[]");
                String[] materials = request.getParameterValues("material[]");
                String[] weights = request.getParameterValues("weight[]");
                String[] origins = request.getParameterValues("origin[]");
                String[] warranties = request.getParameterValues("warranty[]");
                String[] moreInfos = request.getParameterValues("moreInfo[]");

                ProductDetailsDAO detailsDAO = new dao.ProductDetailsDAO();
                if (colors != null) {
                    for (int i = 0; i < colors.length; i++) {
                        ProductDetails pd = new ProductDetails();
                        pd.setProductId(productId);
                        pd.setColor(colors[i]);
                        pd.setSize(sizes != null ? sizes[i] : null);
                        pd.setMaterial(materials != null ? materials[i] : null);
                        pd.setWeight(weights != null && weights[i] != null && !weights[i].isEmpty() ? Double.parseDouble(weights[i]) : null);
                        pd.setOrigin(origins != null ? origins[i] : null);
                        pd.setWarranty(warranties != null ? warranties[i] : null);
                        pd.setMoreInfo(moreInfos != null ? moreInfos[i] : null);
                        detailsDAO.insertProductDetails(pd);
                    }
                }

                if (addSuccess) {
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
                    Part imagePart = request.getPart("productImageFile");
                    if (imagePart != null && imagePart.getSize() > 0) {
                        String imageUrl = uploader.uploadImage(imagePart, "products");
                        product.setProductImage(imageUrl);
                    }
                    // Nếu không upload file mới thì giữ nguyên ảnh cũ
                   

                    if (productDAO.updateProduct1(product)) {
                        // Xử lý biến thể
                        String[] detailsIds = request.getParameterValues("productDetailsId[]");
                        String[] colors = request.getParameterValues("color[]");
                        String[] sizes = request.getParameterValues("size[]");
                        String[] materials = request.getParameterValues("material[]");
                        String[] weights = request.getParameterValues("weight[]");
                        String[] origins = request.getParameterValues("origin[]");
                        String[] warranties = request.getParameterValues("warranty[]");
                        String[] moreInfos = request.getParameterValues("moreInfo[]");
                        ProductDetailsDAO detailsDAO = new dao.ProductDetailsDAO();
                        List<ProductDetails> oldDetails = detailsDAO.getDetailsByProductId(productId);
                        Set<Integer> oldIds = new HashSet<>();
                        for (ProductDetails d : oldDetails) oldIds.add(d.getProductDetailsId());
                        Set<Integer> newIds = new HashSet<>();
                        for (int i = 0; i < colors.length; i++) {
                            String idStr = detailsIds[i];
                            if (idStr != null && !idStr.isEmpty()) {
                                int detailId = Integer.parseInt(idStr);
                                newIds.add(detailId);
                                ProductDetails pd = new ProductDetails();
                                pd.setProductDetailsId(detailId);
                                pd.setProductId(productId);
                                pd.setColor(colors[i]);
                                pd.setSize(sizes != null ? sizes[i] : null);
                                pd.setMaterial(materials != null ? materials[i] : null);
                                pd.setWeight(weights != null && weights[i] != null && !weights[i].isEmpty() ? Double.parseDouble(weights[i]) : null);
                                pd.setOrigin(origins != null ? origins[i] : null);
                                pd.setWarranty(warranties != null ? warranties[i] : null);
                                pd.setMoreInfo(moreInfos != null ? moreInfos[i] : null);
                                detailsDAO.updateProductDetails(pd);
                            } else {
                                ProductDetails pd = new ProductDetails();
                                pd.setProductId(productId);
                                pd.setColor(colors[i]);
                                pd.setSize(sizes != null ? sizes[i] : null);
                                pd.setMaterial(materials != null ? materials[i] : null);
                                pd.setWeight(weights != null && weights[i] != null && !weights[i].isEmpty() ? Double.parseDouble(weights[i]) : null);
                                pd.setOrigin(origins != null ? origins[i] : null);
                                pd.setWarranty(warranties != null ? warranties[i] : null);
                                pd.setMoreInfo(moreInfos != null ? moreInfos[i] : null);
                                detailsDAO.insertProductDetails(pd);
                            }
                        }
                        for (Integer oldId : oldIds) {
                            if (!newIds.contains(oldId)) {
                                detailsDAO.deleteProductDetails(oldId);
                            }
                        }
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