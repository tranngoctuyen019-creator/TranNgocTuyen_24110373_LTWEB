package web.com.controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import web.com.service.AccountService;
import web.com.service.impl.AccountServiceImpl;

@WebServlet(urlPatterns = { "/verify-otp" })
public class VerifyOtpController extends HttpServlet {

    private final AccountService accountService = new AccountServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("email", req.getParameter("email"));

        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/auth/verify-otp.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        String otp = req.getParameter("otp");

        String error = accountService.verifyRegisterOtp(email, otp);

        if (error != null) {
            req.setAttribute("error", error);
            req.setAttribute("email", email);

            req.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(req, resp);
            return;
        }

        req.setAttribute("message", "Kích hoạt tài khoản thành công. Vui lòng đăng nhập.");

        req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
    }
}
