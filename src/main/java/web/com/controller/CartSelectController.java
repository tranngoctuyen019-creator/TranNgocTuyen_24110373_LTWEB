package web.com.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import web.com.models.Account;
import web.com.service.CartService;
import web.com.service.impl.CartServiceImpl;

@WebServlet(urlPatterns = { "/cart/select" })
public class CartSelectController extends HttpServlet {

    private final CartService cartService = new CartServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        Account account = (Account) session.getAttribute("account");

        String allParam = req.getParameter("all");

        if (allParam != null) {

            boolean selected = Boolean.parseBoolean(allParam);
            cartService.setSelectedAll(account, selected);

        } else {

            try {
                int itemId = Integer.parseInt(req.getParameter("itemId"));
                boolean selected = Boolean.parseBoolean(req.getParameter("selected"));

                cartService.setSelected(account, itemId, selected);

            } catch (NumberFormatException e) {
            }
        }

        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}
