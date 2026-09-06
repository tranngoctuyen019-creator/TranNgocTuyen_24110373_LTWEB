package web.com.dao;

import web.com.models.Account;

public interface AccountDAO {

    void insert(Account account);

    void update(Account account);

    Account get(int id);

    Account getByUsername(String username);

    Account getByEmail(String email);
}
