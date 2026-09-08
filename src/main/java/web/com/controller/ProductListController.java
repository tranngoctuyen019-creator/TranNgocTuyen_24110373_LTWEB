package web.com.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import web.com.models.Category;
import web.com.models.Product;
import web.com.service.CategoryService;
import web.com.service.ProductService;
import web.com.service.impl.CategoryServiceImpl;
import web.com.service.impl.ProductServiceImpl;
import web.com.utils.Constant;

@WebServlet(urlPatterns = { "/product" })
public class ProductListController extends HttpServlet {

    private final ProductService productService = new ProductServiceImpl();
    private final CategoryService categoryService = new CategoryServiceImpl();

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

        Integer cateId = null;
        String cateIdParam = req.getParameter("cateId");

        if (cateIdParam != null && !cateIdParam.isBlank()) {
            try {
                cateId = Integer.parseInt(cateIdParam);
            } catch (NumberFormatException e) {
                cateId = null;
            }
        }

        List<Product> products;
        int totalPages;

        if (cateId != null) {
            totalPages = productService.getTotalPagesByCategory(cateId, pageSize);
            if (page > totalPages) {
                page = totalPages;
            }
            products = productService.getPageByCategory(cateId, page, pageSize);
        } else {
            totalPages = productService.getTotalPages(pageSize);
            if (page > totalPages) {
                page = totalPages;
            }
            products = productService.getPage(page, pageSize);
        }

        List<Category> categories = categoryService.getAll();

        req.setAttribute("productList", products);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("categories", categories);
        req.setAttribute("selectedCateId", cateId);

        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/product-list.jsp");
        dispatcher.forward(req, resp);
    }
}
