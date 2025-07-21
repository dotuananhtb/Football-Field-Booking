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
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author VAN NGUYEN
 */
public class EventDAO extends DBContext {

    public List<Event> getAllEvent() {
        List<Event> listE = new ArrayList<>();
        String sql = "SELECT e.*,t.title_id,t.title1 \n"
                + "  FROM [FootballFieldBooking].[dbo].[Event_content] e join title_content t on e.title_id = t.title_id";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Event event = new Event();
                event.setEventID(rs.getInt("event_id"));
                event.setImage_video(rs.getString("image1_video"));
                event.setImage2(rs.getString("image2"));
                event.setTitle_content(rs.getString("content_1_big"));
                event.setContent1(rs.getString("content_2_big"));
                event.setContent2(rs.getString("content_2_small"));

                // Gán dữ liệu cho Title
                Title title = new Title();
                title.setTitleID(rs.getInt("title_id"));
                title.setTitle1(rs.getString("title1"));

                // Gán title vào Event
                event.setTitle(title);

                listE.add(event);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listE;
    }

    public Event getFirstEvent() {
        Event event = null;
        String sql = "SELECT TOP 1 e.*, t.title1"
                + "FROM Event_content e "
                + "JOIN title_content t ON e.title_id = t.title_id "
                + "ORDER BY e.event_id ASC";  // hoặc DESC tùy bạn muốn cái đầu tiên theo chiều nào

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                event = new Event();
                event.setEventID(rs.getInt("event_id"));
                event.setImage_video(rs.getString("image1_video"));
                event.setImage2(rs.getString("image2"));
                event.setTitle_content(rs.getString("content_1_big"));
                event.setContent1(rs.getString("content_2_big"));
                event.setContent2(rs.getString("content_2_small"));

                // Set title object
                Title title = new Title();
                title.setTitleID(rs.getInt("title_id"));
                title.setTitle1(rs.getString("title1"));

                event.setTitle(title);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return event;
    }

    public Event getAllEventByEventId(String eventId) {

        TitleDAO titleDAO = new TitleDAO();
        String sql = "SELECT *\n"
                + "  FROM [FootballFieldBooking].[dbo].[Event_content]\n"
                + "  where event_id = ?";

        try (PreparedStatement ptm = connection.prepareStatement(sql);) {

            ptm.setString(1, eventId);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Title title = titleDAO.getTitlebyEventId(eventId);
                return new Event(rs.getInt(1), rs.getString(2),
                        rs.getString(3), rs.getString(4),
                        rs.getString(5), rs.getString(6), title);
            }
        } catch (SQLException ex) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean addEvent(Event eve) {
        boolean success = false;

        String sqlInsertTitle = "INSERT INTO [dbo].[title_content]\n"
                + "           ([title1])\n"
                + "     VALUES\n"
                + "           (?)";
        String sqlInsertEvent = "INSERT INTO [dbo].[Event_content] "
                + "(image1_video, image2, content_1_big, content_2_big, content_2_small, title_id) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try {
            connection.setAutoCommit(false);

            // Insert title
            int generatedTitleId = -1;
            try (PreparedStatement psTitle = connection.prepareStatement(sqlInsertTitle, PreparedStatement.RETURN_GENERATED_KEYS)) {
                Title title = eve.getTitle();
                psTitle.setString(1, title.getTitle1());

                int rows = psTitle.executeUpdate();
                if (rows == 0) {
                    throw new SQLException("Insert title failed.");
                }

                try (ResultSet rs = psTitle.getGeneratedKeys()) {
                    if (rs.next()) {
                        generatedTitleId = rs.getInt(1);
                        title.setTitleID(generatedTitleId);
                    } else {
                        throw new SQLException("Failed to retrieve title_id.");
                    }
                }
            }

            // Insert event
            try (PreparedStatement psEvent = connection.prepareStatement(sqlInsertEvent)) {
                psEvent.setString(1, eve.getImage_video());
                psEvent.setString(2, eve.getImage2());
                psEvent.setString(3, eve.getTitle_content());
                psEvent.setString(4, eve.getContent1());
                psEvent.setString(5, eve.getContent2());
                psEvent.setInt(6, generatedTitleId);

                int rows = psEvent.executeUpdate();
                success = rows > 0;
            }

            connection.commit();
        } catch (SQLException ex) {
            ex.printStackTrace();
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
        } finally {
            try {
                if (connection != null) {
                    connection.setAutoCommit(true);
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        return success;
    }

   public boolean updateEventAndTitle(Event event) {
    String updateEventSQL = "UPDATE Event_content SET image1_video = ?, image2 = ?, content_1_big = ?, content_2_big = ?, content_2_small = ? WHERE event_id = ?";
    String updateTitleSQL = "UPDATE [dbo].[title_content]\n"
                + "   SET [title1] = ?\n"
                + " WHERE title_id = ?";

    try (
         PreparedStatement psEvent = connection.prepareStatement(updateEventSQL);
         PreparedStatement psTitle = connection.prepareStatement(updateTitleSQL)) {

        // Cập nhật bảng Event_content
        psEvent.setString(1, event.getImage_video());
        psEvent.setString(2, event.getImage2());
        psEvent.setString(3, event.getTitle_content());
        psEvent.setString(4, event.getContent1());
        psEvent.setString(5, event.getContent2());
        psEvent.setInt(6, event.getEventID());
        int updatedEvent = psEvent.executeUpdate();

        // Cập nhật bảng title_content
        Title title = event.getTitle();
        psTitle.setString(1, title.getTitle1());
        psTitle.setInt(2, title.getTitleID());
        int updatedTitle = psTitle.executeUpdate();

        return updatedEvent > 0 && updatedTitle > 0;
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}

//    public List<Event> getUpcomingEvents(int limit) {
//        List<Event> list = new ArrayList<>();
//        String sql = "SELECT TOP (?) * FROM Event_content WHERE event_date > GETDATE() ORDER BY event_date ASC";
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setInt(1, limit);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                Event event = new Event();
//                event.setEventID(rs.getInt("event_id"));
//                event.setTitle_content(rs.getString("content_1_big"));
//                event.setEventDate(rs.getDate("event_date"));
//                event.setLocation(rs.getString("location"));
//                list.add(event);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return list;
//    }


    public static void main(String[] args) {
        EventDAO eve = new EventDAO();

        Title title = new Title("ABC");
        Event listE = new Event("abc.png", "xyz.jpg", "ABC ", "XYZ", "MKL", title);

        boolean a = eve.addEvent(listE);
        System.out.println(a);

    }

}
