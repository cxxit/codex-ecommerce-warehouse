package com.ecommerce.backend.controller;

import java.util.List;

import com.ecommerce.backend.entity.Products;
import com.ecommerce.backend.service.ProductsService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController // Presentation
public class ProductsController {

    private final ProductsService productsService;

    // Constructor injection
    public ProductsController(ProductsService productsService) {
        this.productsService = productsService;
    }
    @GetMapping("/api/products") // (@) - declare annotation, associates HTTP GET request with a Java method
    public List<Products> getAllProducts() { // method getProduct()
        return this.productsService.getAllProducts();
    }

    @PostMapping
    public Products createProduct(@RequestBody Products product) {
        return productsService.createProduct(product);
    }

}