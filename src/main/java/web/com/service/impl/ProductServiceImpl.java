package web.com.service.impl;

import java.util.List;

import web.com.dao.ProductDAO;
import web.com.dao.impl.ProductDAOImpl;
import web.com.models.Product;
import web.com.service.ProductService;

public class ProductServiceImpl implements ProductService {

    private final ProductDAO productDAO = new ProductDAOImpl();

    @Override
    public void insert(Product product) {
        productDAO.insert(product);
    }

    @Override
    public void edit(Product newProduct) {

        Product oldProduct = productDAO.get(newProduct.getId());

        if (oldProduct == null) {
            return;
        }

        oldProduct.setName(newProduct.getName());
        oldProduct.setPrice(newProduct.getPrice());
        oldProduct.setQuantity(newProduct.getQuantity());
        oldProduct.setDescription(newProduct.getDescription());
        oldProduct.setCategory(newProduct.getCategory());

        if (newProduct.getImage() != null && !newProduct.getImage().isBlank()) {
            oldProduct.setImage(newProduct.getImage());
        }

        productDAO.edit(oldProduct);
    }

    @Override
    public void delete(int id) {
        productDAO.delete(id);
    }

    @Override
    public Product get(int id) {
        return productDAO.get(id);
    }

    @Override
    public List<Product> getAll() {
        return productDAO.getAll();
    }

    @Override
    public List<Product> getLatest(int limit) {
        return productDAO.getLatest(limit);
    }

    @Override
    public List<Product> getPage(int page, int pageSize) {

        if (page < 1) {
            page = 1;
        }

        return productDAO.getPaged(page, pageSize);
    }

    @Override
    public int getTotalPages(int pageSize) {

        long total = productDAO.countAll();

        int pages = (int) Math.ceil(total / (double) pageSize);

        return Math.max(pages, 1);
    }

    @Override
    public List<Product> getPageByCategory(int cateId, int page, int pageSize) {

        if (page < 1) {
            page = 1;
        }

        return productDAO.getPagedByCategory(cateId, page, pageSize);
    }

    @Override
    public int getTotalPagesByCategory(int cateId, int pageSize) {

        long total = productDAO.countByCategory(cateId);

        int pages = (int) Math.ceil(total / (double) pageSize);

        return Math.max(pages, 1);
    }

    @Override
    public List<Product> getAllByCategory(int cateId) {
        return productDAO.getAllByCategory(cateId);
    }
}
