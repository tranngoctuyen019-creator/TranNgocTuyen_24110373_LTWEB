package web.com.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import web.com.models.Product;
import web.com.service.ProductService;
import web.com.service.impl.ProductServiceImpl;
import web.com.utils.Constant;

@WebServlet(urlPatterns = { "/product" })
public class ProductListController extends HttpServlet {

    private final ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int page = 1;

        String pageParam = req.getParameter("page");

        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        if (page < 1) {
            page = 1;
        }

        int pageSize = Constant.PRODUCT_PAGE_SIZE;

        int totalPages = productService.getTotalPages(pageSize);

        if (page > totalPages) {
            page = totalPages;
        }

        List<Product> products = productService.getPage(page, pageSize);

        req.setAttribute("productList", products);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);

        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/product-list.jsp");
        dispatcher.forward(req, resp);
    }
}
