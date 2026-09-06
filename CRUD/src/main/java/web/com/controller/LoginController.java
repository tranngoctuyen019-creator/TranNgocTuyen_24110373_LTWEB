package web.com.controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import web.com.models.Account;
import web.com.service.AccountService;
import web.com.service.impl.AccountServiceImpl;

@WebServlet(urlPatterns = { "/login" })
public class LoginController extends HttpServlet {

    private final AccountService accountService = new AccountServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/auth/login.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String usernameOrEmail = req.getParameter("username");
        String password = req.getParameter("password");

        Account account = accountService.login(usernameOrEmail, password);

        if (account == null) {
            req.setAttribute("error", "Tên đăng nhập/email hoặc mật khẩu không đúng, hoặc tài khoản chưa được kích hoạt.");
            req.setAttribute("username", usernameOrEmail);

            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
            return;
        }

        HttpSession session = req.getSession(true);
        session.setAttribute("account", account);

        resp.sendRedirect(req.getContextPath() + "/home");
    }
}
