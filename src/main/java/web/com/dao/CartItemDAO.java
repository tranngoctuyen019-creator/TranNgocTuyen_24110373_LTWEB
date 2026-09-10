package web.com.dao;

import java.util.List;

import web.com.models.CartItem;

public interface CartItemDAO {

    CartItem getById(int id);

    CartItem getByCartAndProduct(int cartId, int productId);

    List<CartItem> getByCartId(int cartId);

    void insert(CartItem item);

    void update(CartItem item);

    void delete(int id);

    void deleteByCartId(int cartId);

    void updateSelectedByCartId(int cartId, boolean selected);
}
