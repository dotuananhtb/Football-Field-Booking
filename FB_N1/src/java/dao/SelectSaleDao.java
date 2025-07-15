/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import util.DBContext;

/**
 *
 * @author VAN NGUYEN
 */
public class SelectSaleDao extends DBContext {

    public String getSaleBySaleID() {
        String sql = "SELECT [sale_id]\n"
                + "  FROM [FootballFieldBooking].[dbo].[SelectedSale]\n"
                + "  where id = 1";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getString("sale_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;

    }

 
// public void updateSelectSale(String saleId) {
//    if (saleId == null || saleId.trim().isEmpty()) {
//        System.out.println("❌ Không có saleId để cập nhật!");
//        return;
//    }
//
//    String checkSql = "SELECT COUNT(*) FROM SelectedSale WHERE id = 1";
//    String insertSql = "INSERT INTO SelectedSale (id, sale_id) VALUES (1, ?)";
//    String updateSql = "UPDATE SelectedSale SET sale_id = ? WHERE id = 1";
//    try (PreparedStatement check = connection.prepareStatement(checkSql);
//         ResultSet rs = check.executeQuery()) {
//
//        if (rs.next() && rs.getInt(1) > 0) {
//            System.out.println("🔄 Đã tồn tại, tiến hành UPDATE với saleId = " + saleId);
//            try (PreparedStatement update = connection.prepareStatement(updateSql)) {
//                update.setString(1, saleId);
//                System.out.println("🔄 UPDATE với saleId = " + saleId);
//                update.executeUpdate();
//            }
//        } else {
//            System.out.println("🆕 Chưa có dòng, tiến hành INSERT với saleId = " + saleId);
//            try (PreparedStatement insert = connection.prepareStatement(insertSql)) {
//                insert.setString(1, saleId);
//                insert.executeUpdate();
//            }
//        }
//    } catch (Exception e) {
//        System.out.println("❌ Lỗi khi cập nhật ưu đãi được chọn:");
//        e.printStackTrace();
//    }
//}
public void updateSelectSale(String saleId) {
    String checkSql = "SELECT COUNT(*) FROM SelectedSale WHERE id = 1";
    String insertSql = "INSERT INTO SelectedSale (id, sale_id) VALUES (1, ?)";
    String updateSql = "UPDATE SelectedSale SET sale_id = ? WHERE id = 1";

    try (PreparedStatement check = connection.prepareStatement(checkSql);
         ResultSet rs = check.executeQuery()) {

        if (rs.next() && rs.getInt(1) > 0) {
            System.out.println("🔄 UPDATE sale_id = " + saleId);
            try (PreparedStatement update = connection.prepareStatement(updateSql)) {
                update.setString(1, saleId);
                update.executeUpdate();
            }
        } else {
            System.out.println("🆕 INSERT sale_id = " + saleId);
            try (PreparedStatement insert = connection.prepareStatement(insertSql)) {
                insert.setString(1, saleId);
                insert.executeUpdate();
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
}
    public void clearSelectedSale() {
        String sql = "UPDATE SelectedSale SET sale_id = NULL WHERE id = 1";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {

        SelectSaleDao sDao = new SelectSaleDao();
        
            sDao.updateSelectSale("2"); // test với sale_id = 3
            String id = sDao.getSaleBySaleID();
            System.out.println(id);
    }

}
