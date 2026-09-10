package web.com.dao;

import web.com.models.Cart;

public interface CartDAO {

    Cart getByAccountId(int accId);

    Cart getById(int cartId);

    void insert(Cart cart);

    void touchUpdatedAt(int cartId);
}
