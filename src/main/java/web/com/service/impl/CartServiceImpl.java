package web.com.service.impl;

import java.math.BigDecimal;
import java.util.List;

import web.com.dao.CartDAO;
import web.com.dao.CartItemDAO;
import web.com.dao.ProductDAO;
import web.com.dao.impl.CartDAOImpl;
import web.com.dao.impl.CartItemDAOImpl;
import web.com.dao.impl.ProductDAOImpl;
import web.com.models.Account;
import web.com.models.Cart;
import web.com.models.CartItem;
import web.com.models.Product;
import web.com.service.CartService;

public class CartServiceImpl implements CartService {

    private final CartDAO cartDAO = new CartDAOImpl();
    private final CartItemDAO cartItemDAO = new CartItemDAOImpl();
    private final ProductDAO productDAO = new ProductDAOImpl();

    @Override
    public Cart getOrCreateCart(Account account) {

        Cart cart = cartDAO.getByAccountId(account.getId());

        if (cart == null) {
            cart = new Cart(account);
            cartDAO.insert(cart);
            cart = cartDAO.getByAccountId(account.getId());
        }

        return cart;
    }

    @Override
    public Cart getCart(Account account) {
        return cartDAO.getByAccountId(account.getId());
    }

    @Override
    public void addToCart(Account account, int productId, int quantity) {

        if (quantity < 1) {
            quantity = 1;
        }

        Product product = productDAO.get(productId);

        if (product == null) {
            return;
        }

        Cart cart = getOrCreateCart(account);

        CartItem existing = cartItemDAO.getByCartAndProduct(cart.getId(), productId);

        if (existing != null) {

            int newQty = existing.getQuantity() + quantity;

            if (product.getQuantity() > 0 && newQty > product.getQuantity()) {
                newQty = product.getQuantity();
            }

            existing.setQuantity(newQty);
            existing.setPrice(product.getPrice());
            cartItemDAO.update(existing);

        } else {

            if (product.getQuantity() > 0 && quantity > product.getQuantity()) {
                quantity = product.getQuantity();
            }

            CartItem item = new CartItem(cart, product, quantity);
            cartItemDAO.insert(item);
        }

        cartDAO.touchUpdatedAt(cart.getId());
    }

    @Override
    public void updateQuantity(Account account, int itemId, int quantity) {

        if (quantity < 1) {
            quantity = 1;
        }

        CartItem item = cartItemDAO.getById(itemId);

        if (item == null || item.getCart().getAccount().getId() != account.getId()) {
            return;
        }

        Product product = item.getProduct();

        if (product.getQuantity() > 0 && quantity > product.getQuantity()) {
            quantity = product.getQuantity();
        }

        item.setQuantity(quantity);
        cartItemDAO.update(item);
        cartDAO.touchUpdatedAt(item.getCart().getId());
    }

    @Override
    public void removeItem(Account account, int itemId) {

        CartItem item = cartItemDAO.getById(itemId);

        if (item == null || item.getCart().getAccount().getId() != account.getId()) {
            return;
        }

        int cartId = item.getCart().getId();
        cartItemDAO.delete(itemId);
        cartDAO.touchUpdatedAt(cartId);
    }

    @Override
    public void setSelected(Account account, int itemId, boolean selected) {

        CartItem item = cartItemDAO.getById(itemId);

        if (item == null || item.getCart().getAccount().getId() != account.getId()) {
            return;
        }

        item.setSelected(selected);
        cartItemDAO.update(item);
    }

    @Override
    public void setSelectedAll(Account account, boolean selected) {

        Cart cart = cartDAO.getByAccountId(account.getId());

        if (cart == null) {
            return;
        }

        cartItemDAO.updateSelectedByCartId(cart.getId(), selected);
    }

    @Override
    public void clearCart(Account account) {

        Cart cart = cartDAO.getByAccountId(account.getId());

        if (cart == null) {
            return;
        }

        cartItemDAO.deleteByCartId(cart.getId());
        cartDAO.touchUpdatedAt(cart.getId());
    }

    @Override
    public BigDecimal getSelectedTotal(List<CartItem> items) {

        BigDecimal total = BigDecimal.ZERO;

        if (items == null) {
            return total;
        }

        for (CartItem item : items) {
            if (item.isSelected()) {
                total = total.add(item.getSubtotal());
            }
        }

        return total;
    }

    @Override
    public int getTotalItemCount(Account account) {

        Cart cart = cartDAO.getByAccountId(account.getId());

        if (cart == null || cart.getItems() == null) {
            return 0;
        }

        return cart.getItems().size();
    }
}
