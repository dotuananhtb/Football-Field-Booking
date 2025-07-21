/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.ArrayList;
import java.util.List;
import model.Status_Blog;
import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author VAN NGUYEN
 */
public class StatusBlogDAO extends DBContext {

    public List<Status_Blog> getAllStatus() {
        List<Status_Blog> list = new ArrayList<>();
        String sql = "SELECT  [status_blog_id]\n"
                + "      ,[status_blog_name]\n"
                + "  FROM [FootballFieldBooking].[dbo].[Status_Blog]";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Status_Blog s = new Status_Blog();
                s.setStatus_id(rs.getInt("status_blog_id"));
                s.setStatus_des(rs.getString("status_blog_name"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public static void main(String[] args) {
        StatusBlogDAO s = new StatusBlogDAO();
        List<Status_Blog> list = s.getAllStatus();
        for (Status_Blog status_Blog : list) {
            System.out.println(status_Blog);
        }
    }

}
