/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import model.*;
import util.DBContext;

/**
 *
 * @author Đỗ Tuấn Anh
 */
public class ProductDAO extends DBContext {

    public Vector<Product> getAllProducts(String sql) {
        Vector<Product> listProduct = new Vector<>();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
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

    public Vector<Product> getAllProductsByCateID(String cateID) {
        Vector<Product> listProduct = new Vector<>();
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

    public Vector<Product> getAllProductsWithCategory() {
        Vector<Product> products = new Vector<>();
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

    public Product searchProduct(int productId) {
        String sql = "SELECT * FROM [FootballFieldBooking].[dbo].[Product] WHERE product_id = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, productId);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                Product pro = new Product(
                        rs.getInt("product_id"),
                        rs.getInt("product_cate_id"),
                        rs.getString("product_name"),
                        rs.getDouble("product_price"),
                        rs.getString("product_image"),
                        rs.getString("product_description"),
                        rs.getString("product_status"));
                return pro;
            }
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return null;
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
        String sql = "SELECT * FROM [dbo].[tblProducts]";
        ProductDAO pDAO = new ProductDAO();
        Vector<Product> p = pDAO.getAllProducts(sql);
        Vector<Product> pList = pDAO.getAllProducts(sql);

//        for (Products products : p) {
//            System.out.println(products);
//        }
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
