
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Title;
import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author VAN NGUYEN
 */
public class TitleDAO extends DBContext {

    public Title getTitlebyEventId(String eventID) {
        String sql = "SELECT * FROM title_content \n"
                + "WHERE title_id = (SELECT title_id FROM Event_content WHERE event_id = ?)";

        try (PreparedStatement ptm = connection.prepareStatement(sql);) {

            ptm.setString(1, eventID);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                return new Title(rs.getInt(1), rs.getString(2));
            }

        } catch (SQLException ex) {
            Logger.getLogger(TitleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

    public List<Title> getAllTitle() {

        String sql = "SELECT  [title_id]\n"
                + "      ,[title1]\n"
                + "  FROM [FootballFieldBooking].[dbo].[title_content]";
        List<Title> list = new ArrayList<>();

        try (PreparedStatement ptm = connection.prepareStatement(sql); ResultSet rs = ptm.executeQuery();) {
            while (rs.next()) {
                Title t = new Title(rs.getInt(1), rs.getString(2));

                list.add(t);

            }

        } catch (SQLException ex) {
            Logger.getLogger(TitleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;

    }

    public int insertTitle(Title t) {
        int n = 0;
        String sql = "INSERT INTO [dbo].[title_content]\n"
                + "           ([title1])\n"
                + "     VALUES\n"
                + "           (?)";
        try (PreparedStatement ptm = connection.prepareStatement(sql);) {
            ptm.setString(1, t.getTitle1());

            n = ptm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(TitleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

    public void updateTitle(Title t) {
        String sql = "UPDATE [dbo].[title_content]\n"
                + "   SET [title1] = ?\n"
                + " WHERE title_id = ?";
        try (PreparedStatement ptm = connection.prepareStatement(sql);) {
            ptm.setString(1, t.getTitle1());
            ptm.setInt(2, t.getTitleID());

            ptm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(TitleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
