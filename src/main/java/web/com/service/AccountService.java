package web.com.service;

import web.com.models.Account;

public interface AccountService {
	
    String register(String username, String password, String email, String fullName, String role);
    String verifyRegisterOtp(String email, String otp);
    String resendActivationOtp(String email);
    Account login(String usernameOrEmail, String password);
    String sendForgotPasswordOtp(String email);
    String resetPassword(String email, String otp, String newPassword);
    Account getById(int id);
    String updateProfile(int id, String fullName, String phone, String avatarPath);
}
