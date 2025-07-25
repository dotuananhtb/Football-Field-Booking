/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Đỗ Tuấn Anh
 */
public class DBContext {

    public Connection connection;

    public DBContext() {
        try {
            String host = config.SecretsConfig.get("DB_HOST");
            String port = config.SecretsConfig.get("DB_PORT");
            String dbName = config.SecretsConfig.get("DB_NAME");
            String username = config.SecretsConfig.get("DB_USER");
            String password = config.SecretsConfig.get("DB_PASSWORD");
            String url = "jdbc:sqlserver://" + host + ":" + port + ";databaseName=" + dbName;
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex);
        }
    }

    public static Connection getConnection() throws SQLException {
        String host = config.SecretsConfig.get("DB_HOST");
        String port = config.SecretsConfig.get("DB_PORT");
        String dbName = config.SecretsConfig.get("DB_NAME");
        String username = config.SecretsConfig.get("DB_USER");
        String password = config.SecretsConfig.get("DB_PASSWORD");
        String url = "jdbc:sqlserver://" + host + ":" + port + ";databaseName=" + dbName;
        return DriverManager.getConnection(url, username, password);
    }

    // TEST DB//
    public static void main(String[] args) {
        DBContext db = new DBContext();
        if (db.connection != null) {
            System.out.println("✅ Kết nối đến cơ sở dữ liệu thành công!");
        } else {
            System.out.println("❌ Kết nối thất bại!");
        }
    }

}
