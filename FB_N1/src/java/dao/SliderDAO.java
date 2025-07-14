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
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Slider;
import util.DBContext;

/**
 *
 * @author VAN NGUYEN
 */
public class SliderDAO extends DBContext {

    public List<Slider> getAllSlider() {
        List<Slider> listS = new ArrayList<>();
        String sql = "SELECT *\n"
                + "  FROM [FootballFieldBooking].[dbo].[Slider]";

        try  {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Slider slide = new Slider(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5), 
                        rs.getString(6));
                listS.add(slide);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SliderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }    
        return listS;
    }
     public Slider getAllSliderBySliderID(String slider_id) {

        String sql = "SELECT *\n"
                + "  FROM [FootballFieldBooking].[dbo].[Slider] where slide_id =?";

        try  {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, slider_id);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                return new Slider(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5), 
                        rs.getString(6));
                 
            }
        } catch (SQLException ex) {
            Logger.getLogger(SliderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }    
        return null;
    }
    
    
    public boolean insertSlider(Slider slider) {
    String sql = "INSERT INTO Slider (slider_name,image, content_1_big, content_1_small, content_2_small) VALUES (?,?, ?, ?, ?)";
    
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, slider.getSlider_name());
        ps.setString(2, slider.getImage());
        ps.setString(3, slider.getContent1_big());
        ps.setString(4, slider.getContent1_small());
        ps.setString(5, slider.getContent2_small());

         int rowsInserted = ps.executeUpdate();
        return rowsInserted > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}
    
    public boolean updateSlider(Slider slider) {
    String sql = "UPDATE Slider SET slider_name = ?,image = ?, content_1_big = ?, content_1_small = ?, content_2_small = ? WHERE slide_id = ?";

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, slider.getSlider_name());
        ps.setString(2, slider.getImage());
        ps.setString(3, slider.getContent1_big());
        ps.setString(4, slider.getContent1_small());
        ps.setString(5, slider.getContent2_small());
        ps.setInt(6, slider.getSlider_id());

        int rowUpdated = ps.executeUpdate();
        return rowUpdated > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}
    public int countSliders() {
    String sql = "SELECT COUNT(*) FROM Slider";
    try (PreparedStatement ps = connection.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        if (rs.next()) {
            return rs.getInt(1);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return 0;
}


    
    
    public static void main(String[] args) {
        SliderDAO dao = new SliderDAO();
        List<Slider> listS = dao.getAllSlider();     
        for(Slider s : listS){
            System.out.println(s);
        }
         Slider updatedSlider = new Slider(
                    1, // ID của slider cần cập nhật (phải tồn tại trong DB)
                    "Slider mới cập nhật",
                    "https://res.cloudinary.com/.../image.jpg",
                    "Tiêu đề lớn",
                    "Tiêu đề nhỏ 1",
                    "Tiêu đề nhỏ 2"
            );

            // 4. Gọi hàm update
            boolean result = dao.updateSlider(updatedSlider);

            // 5. In kết quả
            if (result) {
                System.out.println("✅ Cập nhật slider thành công.");
            } else {
                System.out.println("❌ Cập nhật slider thất bại.");
            }
        
       
        
        
    }

}
