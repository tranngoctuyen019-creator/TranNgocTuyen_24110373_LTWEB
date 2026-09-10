package web.com.dao.impl;

import java.time.LocalDateTime;
import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import web.com.dao.CartDAO;
import web.com.models.Cart;

public class CartDAOImpl implements CartDAO {

    private static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("ServletCRUDMVC");

    @Override
    public Cart getByAccountId(int accId) {

        EntityManager em = emf.createEntityManager();

        try {
            String jpql = "SELECT DISTINCT c FROM Cart c " +
                    "LEFT JOIN FETCH c.items i " +
                    "LEFT JOIN FETCH i.product " +
                    "WHERE c.account.id = :accId";

            TypedQuery<Cart> query = em.createQuery(jpql, Cart.class);
            query.setParameter("accId", accId);

            List<Cart> result = query.getResultList();
            return result.isEmpty() ? null : result.get(0);

        } finally {
            em.close();
        }
    }

    @Override
    public Cart getById(int cartId) {

        EntityManager em = emf.createEntityManager();

        try {
            return em.find(Cart.class, cartId);
        } finally {
            em.close();
        }
    }

    @Override
    public void insert(Cart cart) {

        EntityManager em = emf.createEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();
            em.persist(cart);
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
    public void touchUpdatedAt(int cartId) {

        EntityManager em = emf.createEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();

            Cart cart = em.find(Cart.class, cartId);

            if (cart != null) {
                cart.setUpdatedAt(LocalDateTime.now());
                em.merge(cart);
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
}
