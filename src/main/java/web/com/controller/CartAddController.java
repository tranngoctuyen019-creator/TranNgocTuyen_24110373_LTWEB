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

@WebServlet(urlPatterns = { "/cart/add" })
public class CartAddController extends HttpServlet {

    private final CartService cartService = new CartServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        boolean isAjax = "XMLHttpRequest".equals(req.getHeader("X-Requested-With"));

        HttpSession session = req.getSession(false);
        Account account = (Account) session.getAttribute("account");

        int productId;

        try {
            productId = Integer.parseInt(req.getParameter("productId"));
        } catch (NumberFormatException e) {
            if (isAjax) {
                writeJson(resp, HttpServletResponse.SC_BAD_REQUEST, false,
                        "Sản phẩm không hợp lệ.", null);
            } else {
                resp.sendRedirect(req.getContextPath() + "/product");
            }
            return;
        }

        int quantity = 1;
        String qtyParam = req.getParameter("quantity");

        if (qtyParam != null) {
            try {
                quantity = Integer.parseInt(qtyParam);
            } catch (NumberFormatException e) {
                quantity = 1;
            }
        }

        cartService.addToCart(account, productId, quantity);

        int cartCount = cartService.getTotalItemCount(account);
        session.setAttribute("cartCount", cartCount);

        if (isAjax) {
            writeJson(resp, HttpServletResponse.SC_OK, true,
                    "Đã thêm sản phẩm vào giỏ hàng!", cartCount);
        } else {
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    private void writeJson(HttpServletResponse resp, int status, boolean success,
            String message, Integer cartCount) throws IOException {

        resp.setStatus(status);
        resp.setContentType("application/json;charset=UTF-8");

        String json = "{\"success\":" + success
                + ",\"message\":\"" + escapeJson(message) + "\""
                + (cartCount != null ? ",\"cartCount\":" + cartCount : "")
                + "}";

        resp.getWriter().write(json);
    }

    private String escapeJson(String value) {
        return value == null ? "" : value.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
