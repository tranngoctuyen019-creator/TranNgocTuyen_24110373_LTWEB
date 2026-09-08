package web.com.dao.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import web.com.dao.ProductDAO;
import web.com.models.Product;

public class ProductDAOImpl implements ProductDAO {

    private static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("ServletCRUDMVC");

    @Override
    public void insert(Product product) {

        EntityManager em = emf.createEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();
            em.persist(product);
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
    public void edit(Product product) {

        EntityManager em = emf.createEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();
            em.merge(product);
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

            Product product = em.find(Product.class, id);

            if (product != null) {
                em.remove(product);
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
    public Product get(int id) {

        EntityManager em = emf.createEntityManager();

        try {
            return em.find(Product.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> getAll() {

        EntityManager em = emf.createEntityManager();

        try {
            TypedQuery<Product> query = em.createNamedQuery("Product.findAll", Product.class);
            return query.getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> getLatest(int limit) {

        EntityManager em = emf.createEntityManager();

        try {
            TypedQuery<Product> query = em.createNamedQuery("Product.findLatest", Product.class);
            query.setMaxResults(limit);
            return query.getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> getPaged(int page, int pageSize) {

        EntityManager em = emf.createEntityManager();

        try {
            String jpql = "SELECT p FROM Product p ORDER BY p.id DESC";

            TypedQuery<Product> query = em.createQuery(jpql, Product.class);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);

            return query.getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public long countAll() {

        EntityManager em = emf.createEntityManager();

        try {
            TypedQuery<Long> query = em.createNamedQuery("Product.countAll", Long.class);
            return query.getSingleResult();

        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> getPagedByCategory(int cateId, int page, int pageSize) {

        EntityManager em = emf.createEntityManager();

        try {
            String jpql = "SELECT p FROM Product p WHERE p.category.id = :cateId ORDER BY p.id DESC";

            TypedQuery<Product> query = em.createQuery(jpql, Product.class);
            query.setParameter("cateId", cateId);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);

            return query.getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public long countByCategory(int cateId) {

        EntityManager em = emf.createEntityManager();

        try {
            String jpql = "SELECT COUNT(p) FROM Product p WHERE p.category.id = :cateId";

            TypedQuery<Long> query = em.createQuery(jpql, Long.class);
            query.setParameter("cateId", cateId);

            return query.getSingleResult();

        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> getAllByCategory(int cateId) {

        EntityManager em = emf.createEntityManager();

        try {
            String jpql = "SELECT p FROM Product p WHERE p.category.id = :cateId ORDER BY p.id DESC";

            TypedQuery<Product> query = em.createQuery(jpql, Product.class);
            query.setParameter("cateId", cateId);

            return query.getResultList();

        } finally {
            em.close();
        }
    }
}
