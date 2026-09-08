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
import web.com.service.CategoryService;
import web.com.service.impl.CategoryServiceImpl;

@WebServlet(
        urlPatterns = {
                "/admin/category/list"
        }
)
public class CategoryController extends HttpServlet {

    private final CategoryService cateService =
            new CategoryServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp
    ) throws ServletException, IOException {

        List<Category> cateList =
                cateService.getAll();

        req.setAttribute(
                "cateList",
                cateList
        );

        RequestDispatcher dispatcher =
                req.getRequestDispatcher(
                        "/views/admin/list-category.jsp"
                );

        dispatcher.forward(req, resp);
    }
}