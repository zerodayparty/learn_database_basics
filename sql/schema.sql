-- Cafe order database schema for PostgreSQL
-- PostgreSQL 전용 문법: SERIAL은 자동 증가 정수 컬럼을 만드는 PostgreSQL 문법이다.

DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS menu_items;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20) UNIQUE,
    joined_on DATE NOT NULL,
    customer_status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT customers_status_check CHECK (customer_status IN ('ACTIVE', 'INACTIVE'))
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE menu_items (
    menu_item_id SERIAL PRIMARY KEY,
    category_id INTEGER NOT NULL,
    menu_name VARCHAR(80) NOT NULL UNIQUE,
    price INTEGER NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT menu_items_price_check CHECK (price > 0),
    CONSTRAINT menu_items_category_fk
        FOREIGN KEY (category_id)
        REFERENCES categories (category_id)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_date DATE NOT NULL,
    order_status VARCHAR(20) NOT NULL DEFAULT 'COMPLETED',
    payment_method VARCHAR(20) NOT NULL,
    CONSTRAINT orders_status_check CHECK (order_status IN ('COMPLETED', 'CANCELED', 'REFUNDED')),
    CONSTRAINT orders_payment_method_check CHECK (payment_method IN ('CARD', 'CASH', 'COUPON')),
    CONSTRAINT orders_customer_fk
        FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id)
);

CREATE TABLE order_details (
    order_detail_id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL,
    menu_item_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price INTEGER NOT NULL,
    CONSTRAINT order_details_quantity_check CHECK (quantity > 0),
    CONSTRAINT order_details_unit_price_check CHECK (unit_price > 0),
    CONSTRAINT order_details_order_fk
        FOREIGN KEY (order_id)
        REFERENCES orders (order_id)
        ON DELETE CASCADE,
    CONSTRAINT order_details_menu_item_fk
        FOREIGN KEY (menu_item_id)
        REFERENCES menu_items (menu_item_id)
);

CREATE INDEX idx_orders_order_date ON orders (order_date);
CREATE INDEX idx_orders_customer_id ON orders (customer_id);
CREATE INDEX idx_order_details_menu_item_id ON order_details (menu_item_id);
