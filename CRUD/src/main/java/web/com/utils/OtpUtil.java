package web.com.utils;

import java.security.SecureRandom;
import java.time.LocalDateTime;

public class OtpUtil {

    private static final SecureRandom RANDOM = new SecureRandom();
    
    public static String generateOtp() {
        int number = 100000 + RANDOM.nextInt(900000);
        return String.valueOf(number);
    }

    public static LocalDateTime newExpiry() {
        return LocalDateTime.now().plusMinutes(Constant.OTP_EXPIRE_MINUTES);
    }

    public static boolean isExpired(LocalDateTime expiry) {
        return expiry == null || LocalDateTime.now().isAfter(expiry);
    }
}
