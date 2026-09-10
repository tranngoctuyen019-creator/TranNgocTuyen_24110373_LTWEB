package web.com.controller;

import java.io.IOException;
import java.math.BigDecimal;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import web.com.models.Account;
import web.com.models.Cart;
import web.com.service.CartService;
import web.com.service.impl.CartServiceImpl;

@WebServlet(urlPatterns = { "/cart" })
public class CartController extends HttpServlet {

    private final CartService cartService = new CartServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        Account account = (Account) session.getAttribute("account");

        Cart cart = cartService.getOrCreateCart(account);
        BigDecimal cartTotal = cartService.getSelectedTotal(cart.getItems());

        boolean allSelected = !cart.getItems().isEmpty()
                && cart.getItems().stream().allMatch(item -> item.isSelected());

        req.setAttribute("cart", cart);
        req.setAttribute("cartTotal", cartTotal);
        req.setAttribute("itemCount", cart.getItems().size());
        req.setAttribute("allSelected", allSelected);

        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/cart.jsp");
        dispatcher.forward(req, resp);
    }
}
