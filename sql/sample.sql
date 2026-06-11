-- Cafe order database sample data
-- 부모 테이블(customers, categories, menu_items)을 먼저 넣고, 자식 테이블(orders, order_details)을 나중에 넣는다.

INSERT INTO customers (customer_name, email, phone, joined_on, customer_status) VALUES
    ('김민준', 'minjun@example.com', '010-1000-0001', '2026-01-03', 'ACTIVE'),
    ('이서연', 'seoyeon@example.com', '010-1000-0002', '2026-01-05', 'ACTIVE'),
    ('박도윤', 'doyun@example.com', '010-1000-0003', '2026-01-08', 'ACTIVE'),
    ('최하린', 'harin@example.com', '010-1000-0004', '2026-01-12', 'ACTIVE'),
    ('정지호', 'jiho@example.com', '010-1000-0005', '2026-01-20', 'ACTIVE'),
    ('강유나', 'yuna@example.com', '010-1000-0006', '2026-02-01', 'ACTIVE'),
    ('조서준', 'seojun@example.com', '010-1000-0007', '2026-02-06', 'ACTIVE'),
    ('윤채원', 'chaewon@example.com', '010-1000-0008', '2026-02-15', 'ACTIVE'),
    ('장현우', 'hyunwoo@example.com', '010-1000-0009', '2026-03-01', 'INACTIVE'),
    ('임수아', 'sua@example.com', '010-1000-0010', '2026-03-11', 'ACTIVE');

INSERT INTO categories (category_name, description) VALUES
    ('Coffee', '커피 음료'),
    ('Non Coffee', '커피가 들어가지 않는 음료'),
    ('Tea', '차 종류'),
    ('Ade', '탄산 과일 음료'),
    ('Smoothie', '스무디 음료'),
    ('Bakery', '빵과 디저트'),
    ('Sandwich', '간단한 식사 메뉴'),
    ('Seasonal', '시즌 한정 메뉴'),
    ('Bottle', '병 음료'),
    ('Goods', '카페 굿즈');

INSERT INTO menu_items (category_id, menu_name, price, is_active) VALUES
    (1, 'Americano', 4500, TRUE),
    (1, 'Cafe Latte', 5200, TRUE),
    (1, 'Vanilla Latte', 5800, TRUE),
    (2, 'Chocolate Latte', 5500, TRUE),
    (2, 'Matcha Latte', 5900, TRUE),
    (3, 'Earl Grey Tea', 4800, TRUE),
    (4, 'Lemon Ade', 6200, TRUE),
    (5, 'Strawberry Smoothie', 6800, TRUE),
    (6, 'Butter Croissant', 4300, TRUE),
    (6, 'Cheese Cake', 6500, TRUE),
    (7, 'Ham Cheese Sandwich', 7900, TRUE),
    (8, 'Summer Peach Latte', 6500, FALSE);

INSERT INTO orders (customer_id, order_date, order_status, payment_method) VALUES
    (1, '2026-04-01', 'COMPLETED', 'CARD'),
    (2, '2026-04-01', 'COMPLETED', 'CASH'),
    (3, '2026-04-02', 'COMPLETED', 'CARD'),
    (4, '2026-04-03', 'COMPLETED', 'CARD'),
    (5, '2026-04-04', 'CANCELED', 'CARD'),
    (6, '2026-04-05', 'COMPLETED', 'COUPON'),
    (7, '2026-04-06', 'COMPLETED', 'CARD'),
    (8, '2026-04-07', 'COMPLETED', 'CASH'),
    (1, '2026-04-08', 'COMPLETED', 'CARD'),
    (2, '2026-04-09', 'REFUNDED', 'CARD'),
    (3, '2026-04-10', 'COMPLETED', 'CARD'),
    (6, '2026-04-11', 'COMPLETED', 'CARD');

INSERT INTO order_details (order_id, menu_item_id, quantity, unit_price) VALUES
    (1, 1, 2, 4500),
    (1, 9, 1, 4300),
    (2, 2, 1, 5200),
    (2, 10, 1, 6500),
    (3, 3, 1, 5800),
    (3, 7, 2, 6200),
    (4, 4, 2, 5500),
    (4, 11, 1, 7900),
    (5, 5, 1, 5900),
    (6, 6, 1, 4800),
    (6, 9, 2, 4300),
    (7, 8, 1, 6800),
    (7, 1, 1, 4500),
    (8, 10, 2, 6500),
    (9, 2, 2, 5200),
    (9, 7, 1, 6200),
    (10, 3, 1, 5800),
    (11, 1, 3, 4500),
    (11, 9, 1, 4300),
    (12, 11, 2, 7900),
    (12, 6, 1, 4800);
