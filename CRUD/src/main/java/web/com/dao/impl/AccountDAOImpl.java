package web.com.dao.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import web.com.dao.AccountDAO;
import web.com.models.Account;

public class AccountDAOImpl implements AccountDAO {

    private static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("ServletCRUDMVC");

    @Override
    public void insert(Account account) {

        EntityManager em = emf.createEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();
            em.persist(account);
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
    public void update(Account account) {

        EntityManager em = emf.createEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();
            em.merge(account);
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
    public Account get(int id) {

        EntityManager em = emf.createEntityManager();

        try {
            return em.find(Account.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public Account getByUsername(String username) {

        EntityManager em = emf.createEntityManager();

        try {
            String jpql = "SELECT a FROM Account a WHERE a.username = :username";

            TypedQuery<Account> query = em.createQuery(jpql, Account.class);
            query.setParameter("username", username);
            query.setMaxResults(1);

            List<Account> list = query.getResultList();

            return list.isEmpty() ? null : list.get(0);

        } finally {
            em.close();
        }
    }

    @Override
    public Account getByEmail(String email) {

        EntityManager em = emf.createEntityManager();

        try {
            String jpql = "SELECT a FROM Account a WHERE a.email = :email";

            TypedQuery<Account> query = em.createQuery(jpql, Account.class);
            query.setParameter("email", email);
            query.setMaxResults(1);

            List<Account> list = query.getResultList();

            return list.isEmpty() ? null : list.get(0);

        } finally {
            em.close();
        }
    }
}
