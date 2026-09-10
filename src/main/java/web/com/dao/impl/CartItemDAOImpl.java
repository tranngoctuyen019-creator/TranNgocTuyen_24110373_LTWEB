package web.com.dao.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import web.com.dao.CartItemDAO;
import web.com.models.CartItem;

public class CartItemDAOImpl implements CartItemDAO {

    private static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("ServletCRUDMVC");

    @Override
    public CartItem getById(int id) {

        EntityManager em = emf.createEntityManager();

        try {
            String jpql = "SELECT i FROM CartItem i " +
                    "JOIN FETCH i.cart c " +
                    "JOIN FETCH c.account " +
                    "JOIN FETCH i.product " +
                    "WHERE i.id = :id";

            TypedQuery<CartItem> query = em.createQuery(jpql, CartItem.class);
            query.setParameter("id", id);

            List<CartItem> result = query.getResultList();
            return result.isEmpty() ? null : result.get(0);

        } finally {
            em.close();
        }
    }

    @Override
    public CartItem getByCartAndProduct(int cartId, int productId) {

        EntityManager em = emf.createEntityManager();

        try {
            String jpql = "SELECT i FROM CartItem i WHERE i.cart.id = :cartId AND i.product.id = :productId";

            TypedQuery<CartItem> query = em.createQuery(jpql, CartItem.class);
            query.setParameter("cartId", cartId);
            query.setParameter("productId", productId);

            List<CartItem> result = query.getResultList();
            return result.isEmpty() ? null : result.get(0);

        } finally {
            em.close();
        }
    }

    @Override
    public List<CartItem> getByCartId(int cartId) {

        EntityManager em = emf.createEntityManager();

        try {
            String jpql = "SELECT i FROM CartItem i WHERE i.cart.id = :cartId ORDER BY i.id ASC";

            TypedQuery<CartItem> query = em.createQuery(jpql, CartItem.class);
            query.setParameter("cartId", cartId);

            return query.getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public void insert(CartItem item) {

        EntityManager em = emf.createEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();
            em.persist(item);
            transaction.commit();

        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
            throw e;

        } finally {
            em.close();
        }
    }

    @Override
    public void update(CartItem item) {

        EntityManager em = emf.createEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();
            em.merge(item);
            transaction.commit();

        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
            throw e;

        } finally {
            em.close();
        }
    }

    @Override
    public void delete(int id) {

        EntityManager em = emf.createEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();

            CartItem item = em.find(CartItem.class, id);

            if (item != null) {
                em.remove(item);
            }

            transaction.commit();

        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
            throw e;

        } finally {
            em.close();
        }
    }

    @Override
    public void deleteByCartId(int cartId) {

        EntityManager em = emf.createEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();

            em.createQuery("DELETE FROM CartItem i WHERE i.cart.id = :cartId")
                    .setParameter("cartId", cartId)
                    .executeUpdate();

            transaction.commit();

        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
            throw e;

        } finally {
            em.close();
        }
    }

    @Override
    public void updateSelectedByCartId(int cartId, boolean selected) {

        EntityManager em = emf.createEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();

            em.createQuery("UPDATE CartItem i SET i.selected = :selected WHERE i.cart.id = :cartId")
                    .setParameter("selected", selected)
                    .setParameter("cartId", cartId)
                    .executeUpdate();

            transaction.commit();

        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
            throw e;

        } finally {
            em.close();
        }
    }
}
