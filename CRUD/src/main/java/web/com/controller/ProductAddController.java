package web.com.controller;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import web.com.models.Category;
import web.com.models.Product;
import web.com.service.CategoryService;
import web.com.service.ProductService;
import web.com.service.impl.CategoryServiceImpl;
import web.com.service.impl.ProductServiceImpl;
import web.com.utils.Constant;

@WebServlet(urlPatterns = { "/admin/product/add" })
@MultipartConfig
public class ProductAddController extends HttpServlet {

    private final ProductService productService = new ProductServiceImpl();
    private final CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Category> cateList = categoryService.getAll();
        req.setAttribute("cateList", cateList);

        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/admin/add-product.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String name = req.getParameter("name");
        String priceStr = req.getParameter("price");
        String quantityStr = req.getParameter("quantity");
        String description = req.getParameter("description");
        int cateId = Integer.parseInt(req.getParameter("cateId"));

        Part imagePart = req.getPart("image");
        String imagePath = null;

        if (imagePart != null
                && imagePart.getSize() > 0
                && imagePart.getSubmittedFileName() != null
                && !imagePart.getSubmittedFileName().isBlank()) {

            String originalName = new File(imagePart.getSubmittedFileName()).getName();
            String extension = "";
            int index = originalName.lastIndexOf('.');

            if (index >= 0) {
                extension = originalName.substring(index);
            }

            String fileName = System.currentTimeMillis() + extension;

            File uploadDir = new File(Constant.DIR, "product");

            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            File file = new File(uploadDir, fileName);
            imagePart.write(file.getAbsolutePath());

            imagePath = "product/" + fileName;
        }

        Category category = categoryService.get(cateId);

        Product product = new Product(
                name,
                new BigDecimal(priceStr),
                Integer.parseInt(quantityStr),
                description,
                imagePath,
                category
        );

        productService.insert(product);

        resp.sendRedirect(req.getContextPath() + "/admin/product/list");
    }
}
