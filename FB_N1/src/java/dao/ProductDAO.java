/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import model.Product;
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
    
    public int insertProduct(Product p) {
        String sql = "INSERT INTO [FootballFieldBooking].[dbo].[Product] "
                   + "([product_cate_id], [product_name], [product_price], [product_image], [product_description], [product_status]) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";
        int n=0;
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

    public int deleteProducts(int productID) {
        int n = 0;
        String sql = "DELETE FROM [FootballFieldBooking].[dbo].[Product] WHERE [product_id] = ?";


        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, productID);
            ResultSet rs = getData("select *\n"
                    + "From tblOrderDetails\n"
                    + "Where productID=" + productID);
            n = ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return n;
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
        Product pr = pDAO.searchProduct(4);
        if (pr != null) {
            pDAO.deleteProducts(pr.getProductId());
            System.out.println("deleted");
            pList = pDAO.getAllProducts(sql);
            for (Product products : pList) {
                System.out.println(products);
            }
        } else {
            System.out.println("not found");
        }
    }

}


