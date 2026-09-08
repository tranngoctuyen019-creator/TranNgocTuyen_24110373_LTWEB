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

@WebServlet(urlPatterns = { "/admin/product/list" })
public class ProductController extends HttpServlet {

    private final ProductService productService = new ProductServiceImpl();
    private final CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Integer cateId = null;
        String cateIdParam = req.getParameter("cateId");

        if (cateIdParam != null && !cateIdParam.isBlank()) {
            try {
                cateId = Integer.parseInt(cateIdParam);
            } catch (NumberFormatException e) {
                cateId = null;
            }
        }

        List<Product> productList;
        Category selectedCategory = null;

        if (cateId != null) {
            productList = productService.getAllByCategory(cateId);
            selectedCategory = categoryService.get(cateId);
        } else {
            productList = productService.getAll();
        }

        List<Category> categories = categoryService.getAll();

        req.setAttribute("productList", productList);
        req.setAttribute("categories", categories);
        req.setAttribute("selectedCateId", cateId);
        req.setAttribute("selectedCategory", selectedCategory);

        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/admin/list-product.jsp");
        dispatcher.forward(req, resp);
    }
}
