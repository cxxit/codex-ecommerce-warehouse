package com.ecommerce.backend.entity;

import jakarta.persistence.*;

@Entity 
@Table(name = "products", schema="public")
public class Products {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="product_id")
    private int product_id;

    @Column(name="product_name")
    private String product_name;

    @Column(name="product_category_name")
    private String product_category_name;

    // Required by JPA, default constructor
    public Products(){

    }

    // parameterized constructor
    public Products(int product_id, String product_name, String product_category_name) {
        this.product_id = product_id;
        this.product_name = product_name;
        this.product_category_name = product_category_name;
    }

    public int getProductId() {
        return this.product_id;
    }

    public String getProductName() {
        return this.product_name;
    }

    public String getProductCategoryName() {
        return this.product_category_name;
    }

    public void setProductName(String product_name) {
        this.product_name = product_name;
    }

    public void setProductCategoryName(String product_category_name) {
        this.product_category_name = product_category_name;
    }
}
