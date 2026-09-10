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

@WebServlet(urlPatterns = { "/cart/clear" })
public class CartClearController extends HttpServlet {

    private final CartService cartService = new CartServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        Account account = (Account) session.getAttribute("account");

        cartService.clearCart(account);

        session.setAttribute("cartCount", 0);

        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}
