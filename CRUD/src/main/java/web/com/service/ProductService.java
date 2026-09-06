package web.com.service;

import java.util.List;

import web.com.models.Product;

public interface ProductService {

    void insert(Product product);

    void edit(Product product);

    void delete(int id);

    Product get(int id);

    List<Product> getAll();

    List<Product> getLatest(int limit);

    List<Product> getPage(int page, int pageSize);

    int getTotalPages(int pageSize);
}
