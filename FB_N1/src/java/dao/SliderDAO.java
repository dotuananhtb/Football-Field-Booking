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
                        rs.getString(5));
                listS.add(slide);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SliderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }    
        return listS;
    }
    
    
    public void insertSlider(Slider slider) {
    String sql = "INSERT INTO Slider (image, content_1_big, content_1_small, content_2_small) VALUES (?, ?, ?, ?)";
    
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, slider.getImage());
        ps.setString(2, slider.getContent1_big());
        ps.setString(3, slider.getContent1_small());
        ps.setString(4, slider.getContent2_small());

        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
    
    public void updateSlider(Slider slider) {
    String sql = "UPDATE Slider SET image = ?, content_1_big = ?, content_1_small = ?, content_2_small = ? WHERE slider_id = ?";

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, slider.getImage());
        ps.setString(2, slider.getContent1_big());
        ps.setString(3, slider.getContent1_small());
        ps.setString(4, slider.getContent2_small());
        ps.setInt(5, slider.getSlider_id());

        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
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
        
        
    }

}
