/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.util.Vector;
import model.CateProduct;
import util.DBContext;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author VAN NGUYEN
 */
public class CateProduct_DAO extends DBContext {

    public List<CateProduct> getAllCategory() {
        String sql = "SELECT *\n"
                + "  FROM [FootballFieldBooking].[dbo].[Cate_Product]";
        List<CateProduct> listCategories = new ArrayList<>();

        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                CateProduct c = new CateProduct(
                        rs.getInt(1),
                        rs.getString(2));
                listCategories.add(c);
            }
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return listCategories;
    }

    public List<CateProduct> getAllCategory2() {
        List<CateProduct> listCategories = new ArrayList<>();
        String sql = "SELECT *\n"
                + "  FROM [FootballFieldBooking].[dbo].[Cate_Product]";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                CateProduct c = new CateProduct(
                        rs.getInt(1),
                        rs.getString(2));
                listCategories.add(c);
            }
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return listCategories;
    }

    public int insertCategories(CateProduct c) {
        String sql = "INSERT INTO [dbo].[Cate_Product]\n"
                + "           ([product_cate_id]\n"
                + "           ,[cate_name])\n"
                + "     VALUES\n"
                + "           (?,?)";

        int n = 0;
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, c.getProductCateId());
            ptm.setString(2, c.getCateName());
            n = ptm.executeUpdate();
        } catch (SQLException e) {
            e.getStackTrace();
        }
        return n;
    }

    public CateProduct searchCategories(int categoryID) {
        String sql = "SELECT *\n"
                + "  FROM [FootballFieldBooking].[dbo].[Cate_Product]\n"
                + "  where product_cate_id = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, categoryID);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                CateProduct cat = new CateProduct(categoryID,
                        rs.getString(2));
                return cat;
            }
        } catch (SQLException e) {
            e.getStackTrace();
        }
        return null;

    }

    public CateProduct searchCategoriesByName(String cateName) {
        String sql = "SELECT *\n"
                + "  FROM [FootballFieldBooking].[dbo].[Cate_Product]\n"
                + "  where cate_name = ?";
        try {

            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, cateName);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                CateProduct cat = new CateProduct(rs.getInt(1),
                        cateName);
                return cat;
            }
        } catch (SQLException e) {
            e.getStackTrace();
        }
        return null;

    }

    public void updateCategories(CateProduct c) {
        String sql = "UPDATE [dbo].[Cate_Product]\n"
                + "   SET [cate_name] = ?\n"
                + " WHERE [product_cate_id] = ?";

        try {
            PreparedStatement ptm = connection.prepareStatement(sql);

            ptm.setString(1, c.getCateName());
            ptm.setInt(2, c.getProductCateId());
            ptm.executeUpdate();
        } catch (SQLException e) {
            e.getStackTrace();
        }

    }

    public int deleteCategories(int categoryID) {
        int n = 0;
        String sql = "DELETE FROM [dbo].[Cate_Product]\n"
                + "      WHERE product_cate_id = ?";

        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, categoryID);
            n = ptm.executeUpdate(); // Nếu không có sản phẩm, xóa bình thường
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return n;

    }

    public static void main(String[] args) {
        CateProduct_DAO dao = new CateProduct_DAO();
        List<CateProduct> listc = dao.getAllCategory();

        for (CateProduct c : listc) {
            System.out.println("cateid" + c.getProductCateId() + "  cate name:" + c.getCateName());
        }
    }

}
