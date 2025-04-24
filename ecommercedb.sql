CREATE DATABASE IF NOT EXISTS ecommercedb;
USE ecommercedb;

-- 1. Brand
CREATE TABLE brand (
    brand_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    logo_url VARCHAR(255)
);

-- 2. Product Category
CREATE TABLE product_category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- 3. Product
CREATE TABLE product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    base_price DECIMAL(10,2) NOT NULL,
    description TEXT,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
    FOREIGN KEY (category_id) REFERENCES product_category(category_id)
);

-- 4. Product Image
CREATE TABLE product_image (
    image_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    url VARCHAR(255) NOT NULL,
    alt_text VARCHAR(150),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- 5. Color
CREATE TABLE color (
    color_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    hex_value CHAR(7)
);

-- 6. Size Category
CREATE TABLE size_category (
    size_category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- 7. Size Option
CREATE TABLE size_option (
    size_option_id INT PRIMARY KEY AUTO_INCREMENT,
    label VARCHAR(10) NOT NULL,
    size_category_id INT NOT NULL,
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id)
);

-- 8. Product Variation
CREATE TABLE product_variation (
    variation_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    color_id INT,
    size_option_id INT,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id)
);

-- 9. Product Item (Inventory + Price Override)
CREATE TABLE product_item (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    variation_id INT NOT NULL,
    stock_quantity INT NOT NULL,
    price_override DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (variation_id) REFERENCES product_variation(variation_id)
);

-- 10. Attribute Category (e.g., Technical, Display, Material)
CREATE TABLE attribute_category (
    attribute_category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

-- 11. Attribute Type (e.g., Screen Size, RAM, Fabric)
CREATE TABLE attribute_type (
    attribute_type_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    attribute_category_id INT NOT NULL,
    data_type VARCHAR(20) NOT NULL,
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(attribute_category_id)
);

-- 12. Product Attribute (Value per product and attribute type)
CREATE TABLE product_attribute (
    attribute_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    attribute_type_id INT NOT NULL,
    value VARCHAR(256),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(attribute_type_id)
);
