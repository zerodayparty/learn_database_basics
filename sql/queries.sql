-- Cafe order database core queries
-- 컨테이너 Linux 쉘 접속 예시:
-- docker exec -it cafe-postgres bash
-- PostgreSQL CLI 접속 예시:
-- psql -U postgres -d cafe_order_db
-- PostgreSQL CLI 안에서 실행 예시:
-- \i /work/sql/queries.sql
-- PostgreSQL CLI 안에서 결과 저장 예시:
-- \! mkdir -p /work/results
-- \o /work/results/query_results.txt
-- \i /work/sql/queries.sql
-- \o

\qecho 'Q01. 전체 고객을 가입일 순서로 조회한다.'
SELECT
    customer_id,
    customer_name,
    email,
    joined_on,
    customer_status
FROM customers
ORDER BY joined_on;

\qecho 'Q02. 가격이 6000원 이상인 활성 메뉴를 비싼 순서로 조회한다.'
SELECT
    menu_item_id,
    menu_name,
    price
FROM menu_items
WHERE price >= 6000
    AND is_active = TRUE
ORDER BY price DESC;

\qecho 'Q03. 최근 주문 5개를 조회한다.'
SELECT
    order_id,
    customer_id,
    order_date,
    order_status,
    payment_method
FROM orders
ORDER BY order_date DESC, order_id DESC
LIMIT 5;

\qecho 'Q04. 카드 결제로 완료된 주문만 조회한다.'
SELECT
    order_id,
    customer_id,
    order_date,
    payment_method
FROM orders
WHERE payment_method = 'CARD'
    AND order_status = 'COMPLETED'
ORDER BY order_id;

\qecho 'Q05. INNER JOIN: 주문과 고객 이름을 연결해서 조회한다.'
SELECT
    o.order_id,
    c.customer_name,
    o.order_date,
    o.order_status
FROM orders AS o
INNER JOIN customers AS c
    ON o.customer_id = c.customer_id
ORDER BY o.order_id;

\qecho 'Q06. INNER JOIN: 주문 상세와 메뉴 이름을 연결해서 조회한다.'
SELECT
    od.order_detail_id,
    od.order_id,
    mi.menu_name,
    od.quantity,
    od.unit_price,
    od.quantity * od.unit_price AS line_total
FROM order_details AS od
INNER JOIN menu_items AS mi
    ON od.menu_item_id = mi.menu_item_id
ORDER BY od.order_detail_id;

\qecho 'Q07. 여러 JOIN: 주문별 고객 이름, 메뉴 이름, 주문 금액을 조회한다.'
SELECT
    o.order_id,
    c.customer_name,
    mi.menu_name,
    od.quantity,
    od.unit_price,
    od.quantity * od.unit_price AS line_total
FROM orders AS o
INNER JOIN customers AS c
    ON o.customer_id = c.customer_id
INNER JOIN order_details AS od
    ON o.order_id = od.order_id
INNER JOIN menu_items AS mi
    ON od.menu_item_id = mi.menu_item_id
ORDER BY o.order_id, od.order_detail_id;

\qecho 'Q08. LEFT JOIN: 주문이 없는 고객까지 포함해서 고객별 주문 수를 조회한다.'
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS order_count
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY c.customer_id;

\qecho 'Q09. GROUP BY + COUNT: 고객별 주문 횟수를 조회한다.'
SELECT
    c.customer_name,
    COUNT(o.order_id) AS order_count
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY order_count DESC, c.customer_name;

\qecho 'Q10. GROUP BY + SUM: 메뉴별 판매 수량과 매출을 조회한다.'
SELECT
    mi.menu_name,
    SUM(od.quantity) AS sold_quantity,
    SUM(od.quantity * od.unit_price) AS sales_amount
FROM order_details AS od
INNER JOIN menu_items AS mi
    ON od.menu_item_id = mi.menu_item_id
GROUP BY mi.menu_name
ORDER BY sales_amount DESC;

\qecho 'Q11. GROUP BY + AVG: 카테고리별 평균 메뉴 가격을 조회한다.'
SELECT
    ca.category_name,
    ROUND(AVG(mi.price), 0) AS average_price
FROM categories AS ca
INNER JOIN menu_items AS mi
    ON ca.category_id = mi.category_id
GROUP BY ca.category_name
ORDER BY average_price DESC;

\qecho 'Q12. 서브쿼리: 평균 가격보다 비싼 메뉴를 조회한다.'
SELECT
    menu_name,
    price
FROM menu_items
WHERE price > (
    SELECT AVG(price)
    FROM menu_items
)
ORDER BY price DESC;

\qecho 'Q13. UPDATE: 비활성 고객 1명을 활성 고객으로 바꿔본 뒤 되돌린다.'
BEGIN;
UPDATE customers
SET customer_status = 'ACTIVE'
WHERE customer_id = 9;
SELECT
    customer_id,
    customer_name,
    customer_status
FROM customers
WHERE customer_id = 9;
ROLLBACK;

\qecho 'Q14. DELETE: 취소된 주문을 삭제해본 뒤 되돌린다.'
BEGIN;
DELETE FROM orders
WHERE order_status = 'CANCELED';
SELECT
    order_id,
    order_status
FROM orders
ORDER BY order_id;
ROLLBACK;

\qecho 'Q15. 인덱스 확인: 주문일 검색에 쓰는 인덱스가 존재하는지 조회한다.'
SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE tablename = 'orders'
    AND indexname = 'idx_orders_order_date';

\qecho 'BONUS 01-A. 같은 요구를 JOIN으로 풀기: Americano를 주문한 고객을 조회한다.'
SELECT DISTINCT
    c.customer_name,
    c.email
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
INNER JOIN order_details AS od
    ON o.order_id = od.order_id
INNER JOIN menu_items AS mi
    ON od.menu_item_id = mi.menu_item_id
WHERE mi.menu_name = 'Americano'
ORDER BY c.customer_name;

\qecho 'BONUS 01-B. 같은 요구를 서브쿼리로 풀기: Americano를 주문한 고객을 조회한다.'
SELECT
    customer_name,
    email
FROM customers
WHERE customer_id IN (
    SELECT o.customer_id
    FROM orders AS o
    WHERE o.order_id IN (
        SELECT od.order_id
        FROM order_details AS od
        WHERE od.menu_item_id = (
            SELECT mi.menu_item_id
            FROM menu_items AS mi
            WHERE mi.menu_name = 'Americano'
        )
    )
)
ORDER BY customer_name;

\qecho 'BONUS 02. FK 에러 실습: 존재하지 않는 customer_id 999로 주문을 넣으면 막힌다.'
BEGIN;
INSERT INTO orders (customer_id, order_date, order_status, payment_method)
VALUES (999, '2026-04-12', 'COMPLETED', 'CARD');
ROLLBACK;

\qecho 'BONUS 03-1. 미니 리포트: 일자별 매출을 조회한다.'
SELECT
    o.order_date,
    SUM(od.quantity * od.unit_price) AS daily_sales_amount
FROM orders AS o
INNER JOIN order_details AS od
    ON o.order_id = od.order_id
WHERE o.order_status = 'COMPLETED'
GROUP BY o.order_date
ORDER BY o.order_date;

\qecho 'BONUS 03-2. 미니 리포트: 인기 메뉴 TOP 5를 조회한다.'
SELECT
    mi.menu_name,
    SUM(od.quantity) AS sold_quantity
FROM order_details AS od
INNER JOIN menu_items AS mi
    ON od.menu_item_id = mi.menu_item_id
INNER JOIN orders AS o
    ON od.order_id = o.order_id
WHERE o.order_status = 'COMPLETED'
GROUP BY mi.menu_name
ORDER BY sold_quantity DESC, mi.menu_name
LIMIT 5;

\qecho 'BONUS 03-3. 미니 리포트: 고객별 누적 구매 금액을 조회한다.'
SELECT
    c.customer_name,
    SUM(od.quantity * od.unit_price) AS total_purchase_amount
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
INNER JOIN order_details AS od
    ON o.order_id = od.order_id
WHERE o.order_status = 'COMPLETED'
GROUP BY c.customer_name
ORDER BY total_purchase_amount DESC;
