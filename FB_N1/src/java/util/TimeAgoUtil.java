/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

/**
 *
 * @author VAN NGUYEN
 */
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.*;
import java.time.temporal.ChronoUnit;

public class TimeAgoUtil {

    public static String getTimeAgo(Timestamp timestamp) {
        LocalDateTime past = timestamp.toLocalDateTime();
        LocalDateTime now = LocalDateTime.now();
        Duration duration = Duration.between(past, now);

        long seconds = duration.getSeconds();
        long minutes = duration.toMinutes();
        long hours = duration.toHours();
        long days = ChronoUnit.DAYS.between(past, now);

        if (seconds < 60) return "Vừa đăng";
        else if (minutes < 60) return "Đăng " + minutes + " phút trước";
        else if (hours < 24) return "Đăng " + hours + " giờ trước";
        else if (days == 1) return "Đăng hôm qua";
        else return "Đăng " + days + " ngày trước";
    }
     public static String formatDate(Timestamp timestamp) {
        SimpleDateFormat sdf = new SimpleDateFormat(" HH:mm dd-MM-yyyy ");
        return sdf.format(timestamp);
    }
}
