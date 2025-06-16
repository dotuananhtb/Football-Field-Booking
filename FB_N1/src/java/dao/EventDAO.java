/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.*;
import util.DBContext;
import java.sql.ResultSet;
import java.util.List;

/**
 *
 * @author VAN NGUYEN
 */
public class EventDAO extends DBContext {

    public Event getAllEventByEventId(int eventId) {

        TitleDAO titleDAO = new TitleDAO();
        String sql = "SELECT *\n"
                + "  FROM [FootballFieldBooking].[dbo].[Event_content]\n"
                + "  where event_id = ?";

        try (PreparedStatement ptm = connection.prepareStatement(sql); ) {

            ptm.setInt(1, eventId);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Title title =titleDAO.getTitlebyEventId(eventId);
                return new Event(rs.getInt(1), rs.getString(2),
                        rs.getString(3), rs.getString(4),
                        rs.getString(5), rs.getString(6), title);
            }
        } catch (SQLException ex) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    

    public int addEvent(Event eve) {

        int n = 0;
        String sql = "INSERT INTO [dbo].[Event_content]\n"
                + "           ([image1_video]\n"
                + "           ,[image2]\n"
                + "           ,[content_1_big]\n"
                + "           ,[content_2_big]\n"
                + "           ,[content_2_small]\n"
                + "           ,[title_id])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,?)";

        try (PreparedStatement ptm = connection.prepareStatement(sql);) {
            ptm.setString(1, eve.getImage_video());
            ptm.setString(2, eve.getImage2());
            ptm.setString(3, eve.getTitle_content());
            ptm.setString(4, eve.getContent1());
            ptm.setString(5, eve.getContent2());
            ptm.setInt(6, eve.getTitle().getTitleID());
            n = ptm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public void updateEvent(Event e) {

        String sql = "UPDATE [dbo].[Event_content]\n"
                + "   SET [image1_video] = ?\n"
                + "      ,[image2] = ?\n"
                + "      ,[content_1_big] = ?\n"
                + "      ,[content_2_big] = ?\n"
                + "      ,[content_2_small] = ?\n"
                + "      ,[title_id] = ?\n"
                + " WHERE event_id = ?";
        try (PreparedStatement ptm = connection.prepareStatement(sql);) {
            ptm.setString(1, e.getImage_video());
            ptm.setString(2, e.getImage2());
            ptm.setString(3, e.getTitle_content());
            ptm.setString(4, e.getContent1());
            ptm.setString(5, e.getContent2());
            ptm.setInt(6, e.getTitle().getTitleID());
            ptm.setInt(7, e.getEventID());
             ptm.executeUpdate();
            
            
            
        }
        catch (SQLException ex) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
    public static void main(String[] args) {
        EventDAO eve = new EventDAO();
        
        Event listE = eve.getAllEventByEventId(2);
        System.out.println(listE);
        
    }

}
