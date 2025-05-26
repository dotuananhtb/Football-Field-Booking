/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Stack;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.PostViewDetail;
import util.DBContext;

/**
 *
 * @author VAN NGUYEN
 */
public class PostViewDetail_DAO extends DBContext {

    public Stack<PostViewDetail> getAllPost() {
        String sql = "SELECT p.post_id\n"
                + "		, username,\n"
                + "		avatar,\n"
                + "		p.account_id,\n"
                + "		title,\n"
                + "		content_post,\n"
                + "		post_date,\n"
                + "		status_post,\n"
                + "	  [comment_id]\n"
                + "      ,[content_cmt]\n"
                + "      ,[cmt_date]\n"
                + "  FROM [FootballFieldBooking].[dbo].[Comment] c join [dbo].[Post] p on c.post_id = p.post_id \n"
                + "  join [dbo].[Account] a on p.account_id = a.account_id join [dbo].[UserProfile] u on a.account_id = u.account_id";
                Stack<PostViewDetail> listPost = new Stack<>();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                PostViewDetail pv = new PostViewDetail(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getDate(7),
                        rs.getString(8),
                        rs.getInt(9),
                        rs.getString(10),
                        rs.getDate(11));
                listPost.push(pv);
            }
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return listPost;

    }

}
