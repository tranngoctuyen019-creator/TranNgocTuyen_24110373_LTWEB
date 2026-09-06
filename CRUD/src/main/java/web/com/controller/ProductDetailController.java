package web.com.controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import web.com.models.Product;
import web.com.service.ProductService;
import web.com.service.impl.ProductServiceImpl;

@WebServlet(urlPatterns = { "/product/detail" })
public class ProductDetailController extends HttpServlet {

    private final ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idParam = req.getParameter("id");

        if (idParam == null) {
            resp.sendRedirect(req.getContextPath() + "/product");
            return;
        }

        Product product = productService.get(Integer.parseInt(idParam));

        if (product == null) {
            resp.sendRedirect(req.getContextPath() + "/product");
            return;
        }

        req.setAttribute("product", product);

        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/product-detail.jsp");
        dispatcher.forward(req, resp);
    }
}
