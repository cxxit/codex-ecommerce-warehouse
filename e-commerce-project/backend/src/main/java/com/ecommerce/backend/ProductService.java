package com.ecommerce.backend;

import java.util.List; 
import org.springframework.stereotype.Service;

@Service // Business Logic
public class ProductService {

    public List<Product> getAllProducts() {
        Product product1 = new Product(1, "Laptop", 3500);
        Product product2 = new Product(2, "Keyboard", 150);

        return List.of(product1, product2);
    }
}
