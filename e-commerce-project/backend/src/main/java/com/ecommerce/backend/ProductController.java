package com.ecommerce.backend;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController // Presentation
public class ProductController {

    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/api/products") // (@) - declare annotation, associates HTTP GET request with a Java method
    public List<Product> getAllProducts() { // method getProduct()
    
        return this.productService.getAllProducts();
    }
}