package web.com.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import web.com.service.CategoryService;
import web.com.service.impl.CategoryServiceImpl;

@WebServlet(
        urlPatterns = {
                "/admin/category/delete"
        }
)
public class CategoryDeleteController
        extends HttpServlet {

    private final CategoryService cateService =
            new CategoryServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp
    ) throws ServletException, IOException {

        String id =
                req.getParameter("id");

        cateService.delete(
                Integer.parseInt(id)
        );

        resp.sendRedirect(
                req.getContextPath()
                        + "/admin/category/list"
        );
    }
}