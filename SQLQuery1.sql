CREATE DATABASE shop_quanao;
USE shop_quanao;

CREATE TABLE users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(255),
    created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE products (
    product_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock INT DEFAULT 0,
    category_id INT,
    created_at DATETIME DEFAULT GETDATE()
);


CREATE TABLE categories (
    category_id INT  PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(50) NOT NULL,
    description TEXT
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    order_date DATETIME DEFAULT GETDATE(),
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Pending' CHECK (status IN ('Pending', 'Shipped', 'Delivered', 'Canceled')),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


CREATE TABLE order_items (
    order_item_id INT  PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE product_images (
    image_id INT  PRIMARY KEY IDENTITY(1,1),
    product_id INT,
    image_url VARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE cart (
    cart_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


CREATE TABLE cart_items (
    cart_item_id INT  PRIMARY KEY IDENTITY(1,1),
    cart_id INT,
    product_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (cart_id) REFERENCES cart(cart_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

