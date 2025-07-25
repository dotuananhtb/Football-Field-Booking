package config;

import java.io.InputStream;
import java.io.IOException;
import java.util.Properties;

public class SecretsConfig {
    private static final String CONFIG_PATH = "config/secrets.env";
    private static Properties props = new Properties();

    static {
        try (InputStream is = SecretsConfig.class.getClassLoader().getResourceAsStream(CONFIG_PATH)) {
            if (is == null) {
                throw new RuntimeException("Không tìm thấy file cấu hình bảo mật trong classpath: " + CONFIG_PATH);
            }
            props.load(is);
        } catch (IOException e) {
            throw new RuntimeException("Không thể đọc file cấu hình bảo mật: " + CONFIG_PATH, e);
        }
    }

    public static String get(String key) {
        return props.getProperty(key);
    }

    // Ví dụ: SecretsConfig.get("DB_PASSWORD")
}
