package dao;

import java.sql.*;
import java.util.*;
import model.ProductDetails;
import util.DBContext;

public class ProductDetailsDAO extends DBContext {
    public List<ProductDetails> getDetailsByProductId(int productId) {
        List<ProductDetails> list = new ArrayList<>();
        String sql = "SELECT * FROM ProductDetails WHERE product_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductDetails pd = new ProductDetails(
                        rs.getInt("product_details_id"),
                        rs.getInt("product_id"),
                        rs.getString("color"),
                        rs.getString("size"),
                        rs.getString("material"),
                        rs.getObject("weight") != null ? rs.getDouble("weight") : null,
                        rs.getString("origin"),
                        rs.getString("warranty"),
                        rs.getString("more_info")
                    );
                    list.add(pd);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insertProductDetails(ProductDetails pd) {
        String sql = "INSERT INTO ProductDetails (product_id, color, size, material, weight, origin, warranty, more_info) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, pd.getProductId());
            ps.setString(2, pd.getColor());
            ps.setString(3, pd.getSize());
            ps.setString(4, pd.getMaterial());
            if (pd.getWeight() != null) {
                ps.setDouble(5, pd.getWeight());
            } else {
                ps.setNull(5, java.sql.Types.DECIMAL);
            }
            ps.setString(6, pd.getOrigin());
            ps.setString(7, pd.getWarranty());
            ps.setString(8, pd.getMoreInfo());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateProductDetails(ProductDetails pd) {
        String sql = "UPDATE ProductDetails SET color=?, size=?, material=?, weight=?, origin=?, warranty=?, more_info=? WHERE product_details_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, pd.getColor());
            ps.setString(2, pd.getSize());
            ps.setString(3, pd.getMaterial());
            if (pd.getWeight() != null) {
                ps.setDouble(4, pd.getWeight());
            } else {
                ps.setNull(4, java.sql.Types.DECIMAL);
            }
            ps.setString(5, pd.getOrigin());
            ps.setString(6, pd.getWarranty());
            ps.setString(7, pd.getMoreInfo());
            ps.setInt(8, pd.getProductDetailsId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteProductDetails(int productDetailsId) {
        String sql = "DELETE FROM ProductDetails WHERE product_details_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productDetailsId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
} 