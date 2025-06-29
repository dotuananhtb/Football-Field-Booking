package util;

import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class AccountCredentialsGenerator {

    private static final String UPPER = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private static final String LOWER = "abcdefghijklmnopqrstuvwxyz";
    private static final String DIGITS = "0123456789";
    private static final String SPECIAL = "!@#$%^&*()-_=+[]{}|;:,.<>?";
    private static final String ALL = UPPER + LOWER + DIGITS + SPECIAL;

    private static final SecureRandom random = new SecureRandom();

    private static boolean isUsernameExists(Connection connection, String username) throws SQLException {
        String sql = "SELECT 1 FROM Account WHERE username = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // true nếu tồn tại
            }
        }
    }

    public static String generateSecurePassword() {
        int length = 8 + random.nextInt(5); // 8 - 12 ký tự
        StringBuilder password = new StringBuilder();

        // Đảm bảo đủ các loại ký tự
        password.append(randomChar(UPPER));
        password.append(randomChar(LOWER));
        password.append(randomChar(DIGITS));
        password.append(randomChar(SPECIAL));

        for (int i = 4; i < length; i++) {
            password.append(randomChar(ALL));
        }

        // Shuffle
        List<Character> chars = new ArrayList<>();
        for (char c : password.toString().toCharArray()) chars.add(c);
        Collections.shuffle(chars, random);

        StringBuilder finalPassword = new StringBuilder();
        for (char c : chars) finalPassword.append(c);

        return finalPassword.toString();
    }

    public static String generateUniqueUsername(Connection connection) throws SQLException {
        String username;
        int attempts = 0;
        do {
            username = "user" + (100000 + random.nextInt(900000)); // user123456
            attempts++;
        } while (isUsernameExists(connection, username) && attempts < 10);

        if (attempts >= 10) {
            throw new RuntimeException("Không thể tạo username duy nhất sau nhiều lần thử.");
        }
        return username;
    }

    private static char randomChar(String chars) {
        return chars.charAt(random.nextInt(chars.length()));
    }

    public static Map<String, String> generateAccountCredentials(Connection connection) throws SQLException {
        Map<String, String> credentials = new HashMap<>();
        credentials.put("username", generateUniqueUsername(connection));
        credentials.put("password", generateSecurePassword());
        return credentials;
    }
}
