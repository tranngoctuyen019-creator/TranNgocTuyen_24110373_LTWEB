package web.com.service;

import java.math.BigDecimal;
import java.util.List;

import web.com.models.Account;
import web.com.models.Cart;
import web.com.models.CartItem;

public interface CartService {

    Cart getOrCreateCart(Account account);

    Cart getCart(Account account);

    void addToCart(Account account, int productId, int quantity);

    void updateQuantity(Account account, int itemId, int quantity);

    void removeItem(Account account, int itemId);

    void setSelected(Account account, int itemId, boolean selected);

    void setSelectedAll(Account account, boolean selected);

    void clearCart(Account account);

    BigDecimal getSelectedTotal(List<CartItem> items);

    int getTotalItemCount(Account account);
}
