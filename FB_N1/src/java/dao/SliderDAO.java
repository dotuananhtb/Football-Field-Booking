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
    
    
    public static void main(String[] args) {
        SliderDAO dao = new SliderDAO();
        List<Slider> listS = dao.getAllSlider();     
        for(Slider s : listS){
            System.out.println(s);
        }
        
        
    }

}
