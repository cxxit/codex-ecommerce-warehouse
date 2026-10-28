package com.ecommerce.backend.service;

import java.util.List;


import com.ecommerce.backend.entity.Products;
import com.ecommerce.backend.repository.ProductsRepository;
import org.springframework.stereotype.Service;

@Service // Business Logic
public class ProductsService {

    private final ProductsRepository productsRepository;

    ProductsService(ProductsRepository productsRepository) {
        this.productsRepository = productsRepository;
    }

    public List<Products> getAllProducts() {
        return productsRepository.findAll();
    }

    public Products createProduct(Products product) {
        return productsRepository.save(product);
    }
}
