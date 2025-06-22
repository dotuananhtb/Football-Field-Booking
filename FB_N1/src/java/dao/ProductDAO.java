/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import model.*;
import util.DBContext;

public class ProductDAO extends DBContext {

    public List<Product> getAllProducts() {
        String sql = "SELECT f.*,c.cate_name from Product f\n"
                + "join Cate_Product c on f.product_cate_id=c.product_cate_id";
        List<Product> listProduct = new ArrayList<>();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("product_id"));
                p.setProductCateId(rs.getInt("product_cate_id"));
                p.setProductName(rs.getString("product_name"));
                p.setProductPrice(rs.getDouble("product_price"));
                p.setProductImage(rs.getString("product_image"));
                p.setProductDescription(rs.getString("product_description"));
                p.setProductStatus(rs.getString("product_status"));

                CateProduct c = new CateProduct();
                c.setProductCateId(rs.getInt("product_cate_id"));
                c.setCateName(rs.getString("cate_name"));
                p.setCateProduct(c);

                listProduct.add(p);
            }
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return listProduct;
    }

    public List<Product> getAllProductsByCateID(String cateID) {
        List<Product> listProduct = new ArrayList<>();
        String sql = "SELECT*\n"
                + "  FROM [FootballFieldBooking].[dbo].[Product]\n"
                + "  where product_cate_id =?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, cateID);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Product p = new Product(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getByte(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7));
                listProduct.add(p);
            }
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return listProduct;
    }
/////// binh
    public List<Product> pagingProduct(String productCateId, String productName,
            Double minPrice, Double maxPrice,
            int pageIndex, int pageSize,
            String sortBy) {

        List<Product> list = new ArrayList<>();
        String sortClause = "p.product_id"; // mặc định

        switch (sortBy) {
            case "new":
                sortClause = "p.product_id DESC"; // Sản phẩm mới nhất (ID cao nhất)
                break;
            case "price_low":
                sortClause = "p.product_price ASC"; // Giá thấp đến cao
                break;
            case "price_high":
                sortClause = "p.product_price DESC"; // Giá cao đến thấp
                break;
            case "name_asc":
                sortClause = "p.product_name ASC"; // Tên A-Z
                break;
            case "name_desc":
                sortClause = "p.product_name DESC"; // Tên Z-A
                break;
            default:
                sortClause = "p.product_id DESC"; // Mặc định sản phẩm mới nhất
                break;
        }

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT p.product_id, p.product_name, p.product_price, ")
                .append("p.product_image, p.product_description, p.product_status, ")
                .append("c.product_cate_id, c.cate_name ")
                .append("FROM Product p ")
                .append("INNER JOIN Cate_Product c ON p.product_cate_id = c.product_cate_id ")
                .append("WHERE 1=1 ");

        // Thêm điều kiện lọc theo danh mục
        if (productCateId != null && !productCateId.isEmpty()) {
            sql.append("AND c.product_cate_id = ? ");
        }

        // Thêm điều kiện tìm kiếm theo tên sản phẩm
        if (productName != null && !productName.trim().isEmpty()) {
            sql.append("AND p.product_name LIKE ? ");
        }

        // Thêm điều kiện lọc theo giá tối thiểu
        if (minPrice != null) {
            sql.append("AND p.product_price >= ? ");
        }

        // Thêm điều kiện lọc theo giá tối đa
        if (maxPrice != null) {
            sql.append("AND p.product_price <= ? ");
        }

        // Thêm sắp xếp và phân trang
        sql.append("ORDER BY ").append(sortClause).append(" ")
                .append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int i = 1;

            // Set parameters theo thứ tự điều kiện WHERE
            if (productCateId != null && !productCateId.isEmpty()) {
                ps.setString(i++, productCateId);
            }

            if (productName != null && !productName.trim().isEmpty()) {
                ps.setString(i++, "%" + productName.trim() + "%");
            }

            if (minPrice != null) {
                ps.setDouble(i++, minPrice);
            }

            if (maxPrice != null) {
                ps.setDouble(i++, maxPrice);
            }

            // Set parameters cho phân trang
            ps.setInt(i++, (pageIndex - 1) * pageSize); // OFFSET
            ps.setInt(i, pageSize); // FETCH NEXT

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("product_id"));
                p.setProductName(rs.getString("product_name"));
                p.setProductPrice(rs.getDouble("product_price"));
                p.setProductImage(rs.getString("product_image"));
                p.setProductDescription(rs.getString("product_description"));
                p.setProductStatus(rs.getString("product_status"));

                // Set thông tin danh mục
                CateProduct cate = new CateProduct();
                cate.setProductCateId(rs.getInt("product_cate_id"));
                cate.setCateName(rs.getString("cate_name"));
                p.setCateProduct(cate);

                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

// Hàm đếm tổng số sản phẩm (để tính tổng số trang)
    public int countProduct(String productCateId, String productName,
            Double minPrice, Double maxPrice) {

        int count = 0;
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(*) as total ")
                .append("FROM Product p ")
                .append("INNER JOIN Cate_Product c ON p.product_cate_id = c.product_cate_id ")
                .append("WHERE 1=1 ");

        if (productCateId != null && !productCateId.isEmpty()) {
            sql.append("AND c.product_cate_id = ? ");
        }

        if (productName != null && !productName.trim().isEmpty()) {
            sql.append("AND p.product_name LIKE ? ");
        }

        if (minPrice != null) {
            sql.append("AND p.product_price >= ? ");
        }

        if (maxPrice != null) {
            sql.append("AND p.product_price <= ? ");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int i = 1;

            if (productCateId != null && !productCateId.isEmpty()) {
                ps.setString(i++, productCateId);
            }

            if (productName != null && !productName.trim().isEmpty()) {
                ps.setString(i++, "%" + productName.trim() + "%");
            }

            if (minPrice != null) {
                ps.setDouble(i++, minPrice);
            }

            if (maxPrice != null) {
                ps.setDouble(i++, maxPrice);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public Vector<Product> pagingProduct(int page, int pageSize) {
        Vector<Product> list = new Vector<>();
        String query = "SELECT *\n"
                + "  FROM [FootballFieldBooking].[dbo].[Product]\n"
                + "	order by product_id\n"
                + "	offset ? rows fetch next ? rows only";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setInt(1, (page - 1) * pageSize);
            ptm.setInt(2, pageSize);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Product p = new Product(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
////////////////
    public Vector<Product> pagingProductByCateID(int cateId, int page, int pageSize) {
        Vector<Product> list = new Vector<>();
        String query = "SELECT * FROM Product WHERE product_cate_id = ?\n"
                + "ORDER BY product_id \n"
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setInt(1, cateId);
            ptm.setInt(2, (page - 1) * pageSize);
            ptm.setInt(3, pageSize);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Product p = new Product(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countProductByCateID(int cateID) {
        String query = "SELECT COUNT(*) FROM Product WHERE product_cate_id = ?";
        try (PreparedStatement ptm = connection.prepareStatement(query);) {

            ptm.setInt(1, cateID);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getTotalProduct() {
        String query = "SELECT COUNT(*) FROM Product";
        try (PreparedStatement ptm = connection.prepareStatement(query); ResultSet rs = ptm.executeQuery();) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Product> getAllProductsWithCategory() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.product_id, p.product_name, p.product_price, "
                + "p.product_image, p.product_description, p.product_status, "
                + "p.product_cate_id, cp.cate_name "
                + "FROM Product p "
                + "INNER JOIN Cate_Product cp ON p.product_cate_id = cp.product_cate_id";

        try (PreparedStatement pstmt = connection.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                // Tạo CateProduct object
                CateProduct category = new CateProduct(
                        rs.getInt("product_cate_id"),
                        rs.getString("cate_name")
                );

                // Tạo Product với constructor đầy đủ
                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getInt("product_cate_id"),
                        rs.getString("product_name"),
                        rs.getDouble("product_price"),
                        rs.getString("product_image"),
                        rs.getString("product_description"),
                        rs.getString("product_status"),
                        category
                );

                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public int insertProduct(Product p) {
        String sql = "INSERT INTO [FootballFieldBooking].[dbo].[Product] "
                + "([product_cate_id], [product_name], [product_price], [product_image], [product_description], [product_status]) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        int n = 0;
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, p.getProductCateId());
            ptm.setString(2, p.getProductName());
            ptm.setDouble(3, p.getProductPrice());
            ptm.setString(4, p.getProductImage());
            ptm.setString(5, p.getProductDescription());
            ptm.setString(6, p.getProductStatus());
            n = ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return n;
    }

    public List<Product> searchProductByName(String productName) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.product_id, p.product_name, p.product_price, "
                + "p.product_image, p.product_description, p.product_status, "
                + "c.product_cate_id, c.cate_name "
                + "FROM Product p "
                + "INNER JOIN Cate_Product c ON p.product_cate_id = c.product_cate_id "
                + "WHERE p.product_name LIKE ? "
                + "ORDER BY p.product_name";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + productName + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setProductId(rs.getInt("product_id"));
                    product.setProductName(rs.getString("product_name"));
                    product.setProductPrice(rs.getDouble("product_price"));
                    product.setProductImage(rs.getString("product_image"));
                    product.setProductDescription(rs.getString("product_description"));
                    product.setProductStatus(rs.getString("product_status"));

                    // Set thông tin danh mục
                    CateProduct cate = new CateProduct();
                    cate.setProductCateId(rs.getInt("product_cate_id"));
                    cate.setCateName(rs.getString("cate_name"));
                    product.setCateProduct(cate);

                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public void updateProduct(Product p) {
        String sql = "UPDATE [FootballFieldBooking].[dbo].[Product] "
                + "SET [product_cate_id] = ?, [product_name] = ?, [product_price] = ?, "
                + "[product_image] = ?, [product_description] = ?, [product_status] = ? "
                + "WHERE [product_id] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, p.getProductCateId());
            ps.setString(2, p.getProductName());
            ps.setDouble(3, p.getProductPrice());
            ps.setString(4, p.getProductImage());
            ps.setString(5, p.getProductDescription());
            ps.setString(6, p.getProductStatus());
            ps.setInt(7, p.getProductId());
            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
    }

    public static void main(String[] args) {
        ProductDAO pDAO = new ProductDAO();

        int total = pDAO.countProduct(null, null, null, null);
        System.out.println("✅ Tổng số sản phẩm đang hoạt động: " + total);

//        Products pro = new Products(1, "bep nuong", "http//SE1902", 100, 50, "C004",
//                new Date(2025 - 1900, 1, 15), new Date(2025 - 1900, 1, 15));
//        int n = pDAO.insertProduct(pro);
//        if (n > 0) {
//            System.out.println("inserted");
//            pList = pDAO.getAllProducts(sql);
//            for (Products products : pList) {
//                System.out.println(products);
//            }
//        } else {
//            System.err.println("inserted fail");
//        }
//        Products pr = pDAO.searchProduct(5);
//        if (pr != null) {
//            pDAO.updateProduct(new Products(5, "ao len", "http//SE1902", 100, 100, "C005",
//                    new Date(2025 - 1900, 1, 15), new Date(2025 - 1900, 1, 15)));
//            System.out.println("updated");
//            pList = pDAO.getAllProducts(sql);
//            for (Products products : pList) {
//                System.out.println(products);
//            }
//        } else {
//            System.out.println("not found");
//        }
    }

}
