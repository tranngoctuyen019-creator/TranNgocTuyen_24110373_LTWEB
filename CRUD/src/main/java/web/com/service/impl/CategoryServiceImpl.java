package web.com.service.impl;

import web.com.dao.CategoryDAO;
import web.com.dao.impl.CategoryDAOImpl;
import web.com.models.Category;
import web.com.service.CategoryService;

import java.util.List;


public class CategoryServiceImpl implements CategoryService {

	private final CategoryDAO categoryDao =
            new CategoryDAOImpl();


    @Override
    public void insert(Category category) {

        categoryDao.insert(category);
    }


    @Override
    public void edit(Category newCategory) {

        Category oldCategory =
                categoryDao.get(
                        newCategory.getId()
                );

        if (oldCategory == null) {

            return;
        }

        oldCategory.setName(
                newCategory.getName()
        );

        if (newCategory.getIcon() != null
                && !newCategory
                .getIcon()
                .isBlank()) {

            oldCategory.setIcon(
                    newCategory.getIcon()
            );
        }


        categoryDao.edit(
                oldCategory
        );
    }


    @Override
    public void delete(int id) {

        categoryDao.delete(id);
    }


    @Override
    public Category get(int id) {

        return categoryDao.get(id);
    }


    @Override
    public Category get(String name) {

        return categoryDao.get(name);
    }


    @Override
    public List<Category> getAll() {

        return categoryDao.getAll();
    }


    @Override
    public List<Category> search(
            String keyword
    ) {

        return categoryDao.search(
                keyword
        );
    }
}
