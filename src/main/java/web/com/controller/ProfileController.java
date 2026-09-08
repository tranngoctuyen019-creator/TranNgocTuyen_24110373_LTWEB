package web.com.controller;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import web.com.models.Account;
import web.com.service.AccountService;
import web.com.service.impl.AccountServiceImpl;
import web.com.utils.Constant;

@WebServlet(urlPatterns = { "/profile" })
@MultipartConfig(maxFileSize = 5 * 1024 * 1024)
public class ProfileController extends HttpServlet {

    private final AccountService accountService = new AccountServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        Account sessionAccount = (session == null) ? null : (Account) session.getAttribute("account");

        if (sessionAccount == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Account account = accountService.getById(sessionAccount.getId());
        req.setAttribute("account", account);

        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/account/profile.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        Account sessionAccount = (session == null) ? null : (Account) session.getAttribute("account");

        if (sessionAccount == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");

        String avatarPath = null; // null = giữ nguyên ảnh cũ

        Part avatarPart = req.getPart("avatar");

        if (avatarPart != null
                && avatarPart.getSize() > 0
                && avatarPart.getSubmittedFileName() != null
                && !avatarPart.getSubmittedFileName().isBlank()) {

            String originalName = new File(avatarPart.getSubmittedFileName()).getName();
            String extension = "";
            int index = originalName.lastIndexOf('.');

            if (index >= 0) {
                extension = originalName.substring(index);
            }

            String fileName = "acc" + sessionAccount.getId() + "_" + System.currentTimeMillis() + extension;

            File uploadDir = new File(Constant.DIR, "avatar");

            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            File file = new File(uploadDir, fileName);
            avatarPart.write(file.getAbsolutePath());

            avatarPath = "avatar/" + fileName;
        }

        String error = accountService.updateProfile(sessionAccount.getId(), fullName, phone, avatarPath);

        Account updated = accountService.getById(sessionAccount.getId());

        if (error != null) {
            req.setAttribute("error", error);
            req.setAttribute("account", updated);
            req.getRequestDispatcher("/views/account/profile.jsp").forward(req, resp);
            return;
        }

        session.setAttribute("account", updated);

        req.setAttribute("message", "Cập nhật hồ sơ thành công.");
        req.setAttribute("account", updated);

        req.getRequestDispatcher("/views/account/profile.jsp").forward(req, resp);
    }
}
