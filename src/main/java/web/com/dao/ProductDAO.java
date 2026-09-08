package web.com.dao;

import java.util.List;

import web.com.models.Product;

public interface ProductDAO {

    void insert(Product product);

    void edit(Product product);

    void delete(int id);

    Product get(int id);

    List<Product> getAll();

    List<Product> getLatest(int limit);

    List<Product> getPaged(int page, int pageSize);

    long countAll();

    List<Product> getPagedByCategory(int cateId, int page, int pageSize);

    long countByCategory(int cateId);

    List<Product> getAllByCategory(int cateId);
}
