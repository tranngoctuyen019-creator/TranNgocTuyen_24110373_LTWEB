package web.com.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import web.com.service.AccountService;
import web.com.service.impl.AccountServiceImpl;

@WebServlet(urlPatterns = { "/resend-otp" })
public class ResendOtpController extends HttpServlet {

    private final AccountService accountService = new AccountServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");

        String error = accountService.resendActivationOtp(email);

        req.setAttribute("email", email);

        if (error != null) {
            req.setAttribute("error", error);
        } else {
            req.setAttribute("message", "Đã gửi lại mã OTP tới email của bạn.");
        }

        req.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(req, resp);
    }
}
