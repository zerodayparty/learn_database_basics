Q01. 전체 고객을 가입일 순서로 조회한다.  
 customer_id | customer_name |        email        | joined_on  | customer_status  
-------------+---------------+---------------------+------------+-----------------  
           1 | 김민준        | minjun@example.com  | 2026-01-03 | ACTIVE  
           2 | 이서연        | seoyeon@example.com | 2026-01-05 | ACTIVE  
           3 | 박도윤        | doyun@example.com   | 2026-01-08 | ACTIVE  
           4 | 최하린        | harin@example.com   | 2026-01-12 | ACTIVE  
           5 | 정지호        | jiho@example.com    | 2026-01-20 | ACTIVE  
           6 | 강유나        | yuna@example.com    | 2026-02-01 | ACTIVE  
           7 | 조서준        | seojun@example.com  | 2026-02-06 | ACTIVE  
           8 | 윤채원        | chaewon@example.com | 2026-02-15 | ACTIVE  
           9 | 장현우        | hyunwoo@example.com | 2026-03-01 | INACTIVE  
          10 | 임수아        | sua@example.com     | 2026-03-11 | ACTIVE  
(10 rows)  

Q02. 가격이 6000원 이상인 활성 메뉴를 비싼 순서로 조회한다.  
 menu_item_id |      menu_name      | price  
--------------+---------------------+-------  
           11 | Ham Cheese Sandwich |  7900  
            8 | Strawberry Smoothie |  6800  
           10 | Cheese Cake         |  6500  
            7 | Lemon Ade           |  6200  
(4 rows)  

Q03. 최근 주문 5개를 조회한다.  
 order_id | customer_id | order_date | order_status | payment_method  
----------+-------------+------------+--------------+----------------  
       12 |           6 | 2026-04-11 | COMPLETED    | CARD  
       11 |           3 | 2026-04-10 | COMPLETED    | CARD  
       10 |           2 | 2026-04-09 | REFUNDED     | CARD  
        9 |           1 | 2026-04-08 | COMPLETED    | CARD  
        8 |           8 | 2026-04-07 | COMPLETED    | CASH  
(5 rows)  

Q04. 카드 결제로 완료된 주문만 조회한다.  
 order_id | customer_id | order_date | payment_method  
----------+-------------+------------+----------------  
        1 |           1 | 2026-04-01 | CARD  
        3 |           3 | 2026-04-02 | CARD  
        4 |           4 | 2026-04-03 | CARD  
        7 |           7 | 2026-04-06 | CARD  
        9 |           1 | 2026-04-08 | CARD  
       11 |           3 | 2026-04-10 | CARD  
       12 |           6 | 2026-04-11 | CARD  
(7 rows)  

Q05. INNER JOIN: 주문과 고객 이름을 연결해서 조회한다.  
 order_id | customer_name | order_date | order_status  
----------+---------------+------------+--------------  
        1 | 김민준        | 2026-04-01 | COMPLETED  
        2 | 이서연        | 2026-04-01 | COMPLETED  
        3 | 박도윤        | 2026-04-02 | COMPLETED  
        4 | 최하린        | 2026-04-03 | COMPLETED  
        5 | 정지호        | 2026-04-04 | CANCELED  
        6 | 강유나        | 2026-04-05 | COMPLETED  
        7 | 조서준        | 2026-04-06 | COMPLETED  
        8 | 윤채원        | 2026-04-07 | COMPLETED  
        9 | 김민준        | 2026-04-08 | COMPLETED  
       10 | 이서연        | 2026-04-09 | REFUNDED  
       11 | 박도윤        | 2026-04-10 | COMPLETED  
       12 | 강유나        | 2026-04-11 | COMPLETED  
(12 rows)  

Q06. INNER JOIN: 주문 상세와 메뉴 이름을 연결해서 조회한다.  
 order_detail_id | order_id |      menu_name      | quantity | unit_price | line_total  
-----------------+----------+---------------------+----------+------------+------------  
               1 |        1 | Americano           |        2 |       4500 |       9000  
               2 |        1 | Butter Croissant    |        1 |       4300 |       4300  
               3 |        2 | Cafe Latte          |        1 |       5200 |       5200  
               4 |        2 | Cheese Cake         |        1 |       6500 |       6500  
               5 |        3 | Vanilla Latte       |        1 |       5800 |       5800  
               6 |        3 | Lemon Ade           |        2 |       6200 |      12400  
               7 |        4 | Chocolate Latte     |        2 |       5500 |      11000  
               8 |        4 | Ham Cheese Sandwich |        1 |       7900 |       7900  
               9 |        5 | Matcha Latte        |        1 |       5900 |       5900  
              10 |        6 | Earl Grey Tea       |        1 |       4800 |       4800  
              11 |        6 | Butter Croissant    |        2 |       4300 |       8600  
              12 |        7 | Strawberry Smoothie |        1 |       6800 |       6800  
              13 |        7 | Americano           |        1 |       4500 |       4500  
              14 |        8 | Cheese Cake         |        2 |       6500 |      13000  
              15 |        9 | Cafe Latte          |        2 |       5200 |      10400  
              16 |        9 | Lemon Ade           |        1 |       6200 |       6200  
              17 |       10 | Vanilla Latte       |        1 |       5800 |       5800  
              18 |       11 | Americano           |        3 |       4500 |      13500  
              19 |       11 | Butter Croissant    |        1 |       4300 |       4300  
              20 |       12 | Ham Cheese Sandwich |        2 |       7900 |      15800  
              21 |       12 | Earl Grey Tea       |        1 |       4800 |       4800  
(21 rows)  

Q07. 여러 JOIN: 주문별 고객 이름, 메뉴 이름, 주문 금액을 조회한다.  
 order_id | customer_name |      menu_name      | quantity | unit_price | line_total  
----------+---------------+---------------------+----------+------------+------------  
        1 | 김민준        | Americano           |        2 |       4500 |       9000  
        1 | 김민준        | Butter Croissant    |        1 |       4300 |       4300  
        2 | 이서연        | Cafe Latte          |        1 |       5200 |       5200  
        2 | 이서연        | Cheese Cake         |        1 |       6500 |       6500  
        3 | 박도윤        | Vanilla Latte       |        1 |       5800 |       5800  
        3 | 박도윤        | Lemon Ade           |        2 |       6200 |      12400  
        4 | 최하린        | Chocolate Latte     |        2 |       5500 |      11000  
        4 | 최하린        | Ham Cheese Sandwich |        1 |       7900 |       7900  
        5 | 정지호        | Matcha Latte        |        1 |       5900 |       5900  
        6 | 강유나        | Earl Grey Tea       |        1 |       4800 |       4800  
        6 | 강유나        | Butter Croissant    |        2 |       4300 |       8600  
        7 | 조서준        | Strawberry Smoothie |        1 |       6800 |       6800  
        7 | 조서준        | Americano           |        1 |       4500 |       4500  
        8 | 윤채원        | Cheese Cake         |        2 |       6500 |      13000  
        9 | 김민준        | Cafe Latte          |        2 |       5200 |      10400  
        9 | 김민준        | Lemon Ade           |        1 |       6200 |       6200  
       10 | 이서연        | Vanilla Latte       |        1 |       5800 |       5800  
       11 | 박도윤        | Americano           |        3 |       4500 |      13500  
       11 | 박도윤        | Butter Croissant    |        1 |       4300 |       4300  
       12 | 강유나        | Ham Cheese Sandwich |        2 |       7900 |      15800  
       12 | 강유나        | Earl Grey Tea       |        1 |       4800 |       4800  
(21 rows)  

Q08. LEFT JOIN: 주문이 없는 고객까지 포함해서 고객별 주문 수를 조회한다.  
 customer_id | customer_name | order_count  
-------------+---------------+-------------  
           1 | 김민준        |           2  
           2 | 이서연        |           2  
           3 | 박도윤        |           2  
           4 | 최하린        |           1  
           5 | 정지호        |           1  
           6 | 강유나        |           2  
           7 | 조서준        |           1  
           8 | 윤채원        |           1  
           9 | 장현우        |           0  
          10 | 임수아        |           0  
(10 rows)  

Q09. GROUP BY + COUNT: 고객별 주문 횟수를 조회한다.  
 customer_name | order_count  
---------------+-------------  
 강유나        |           2  
 김민준        |           2  
 박도윤        |           2  
 이서연        |           2  
 윤채원        |           1  
 정지호        |           1  
 조서준        |           1  
 최하린        |           1  
(8 rows)  

Q10. GROUP BY + SUM: 메뉴별 판매 수량과 매출을 조회한다.  
      menu_name      | sold_quantity | sales_amount  
---------------------+---------------+--------------  
 Americano           |             6 |        27000  
 Ham Cheese Sandwich |             3 |        23700  
 Cheese Cake         |             3 |        19500  
 Lemon Ade           |             3 |        18600  
 Butter Croissant    |             4 |        17200  
 Cafe Latte          |             3 |        15600  
 Vanilla Latte       |             2 |        11600  
 Chocolate Latte     |             2 |        11000  
 Earl Grey Tea       |             2 |         9600  
 Strawberry Smoothie |             1 |         6800  
 Matcha Latte        |             1 |         5900  
(11 rows)  

Q11. GROUP BY + AVG: 카테고리별 평균 메뉴 가격을 조회한다.  
 category_name | average_price  
---------------+---------------  
 Sandwich      |          7900  
 Smoothie      |          6800  
 Seasonal      |          6500  
 Ade           |          6200  
 Non Coffee    |          5700  
 Bakery        |          5400  
 Coffee        |          5167  
 Tea           |          4800  
(8 rows)  

Q12. 서브쿼리: 평균 가격보다 비싼 메뉴를 조회한다.  
      menu_name      | price  
---------------------+-------  
 Ham Cheese Sandwich |  7900  
 Strawberry Smoothie |  6800  
 Cheese Cake         |  6500  
 Summer Peach Latte  |  6500  
 Lemon Ade           |  6200  
 Matcha Latte        |  5900  
(6 rows)  

Q13. UPDATE: 비활성 고객 1명을 활성 고객으로 바꿔본 뒤 되돌린다.  
BEGIN  
UPDATE 1  
 customer_id | customer_name | customer_status  
-------------+---------------+-----------------  
           9 | 장현우        | ACTIVE  
(1 row)  

ROLLBACK  
Q14. DELETE: 취소된 주문을 삭제해본 뒤 되돌린다.  
BEGIN  
DELETE 1  
 order_id | order_status  
----------+--------------  
        1 | COMPLETED  
        2 | COMPLETED  
        3 | COMPLETED  
        4 | COMPLETED  
        6 | COMPLETED  
        7 | COMPLETED  
        8 | COMPLETED  
        9 | COMPLETED  
       10 | REFUNDED  
       11 | COMPLETED  
       12 | COMPLETED  
(11 rows)  

ROLLBACK  
Q15. 인덱스 확인: 주문일 검색에 쓰는 인덱스가 존재하는지 조회한다.  
       indexname       |                                   indexdef                                   
-----------------------+------------------------------------------------------------------------------  
 idx_orders_order_date | CREATE INDEX idx_orders_order_date ON public.orders USING btree (order_date)  
(1 row)  

BONUS 01-A. 같은 요구를 JOIN으로 풀기: Americano를 주문한 고객을 조회한다.  
 customer_name |       email        
---------------+--------------------  
 김민준        | minjun@example.com  
 박도윤        | doyun@example.com  
 조서준        | seojun@example.com  
(3 rows)  

BONUS 01-B. 같은 요구를 서브쿼리로 풀기: Americano를 주문한 고객을 조회한다.  
 customer_name |       email        
---------------+--------------------  
 김민준        | minjun@example.com  
 박도윤        | doyun@example.com  
 조서준        | seojun@example.com  
(3 rows)  

BONUS 02. FK 에러 실습: 존재하지 않는 customer_id 999로 주문을 넣으면 막힌다.  
BEGIN  
ROLLBACK  
BONUS 03-1. 미니 리포트: 일자별 매출을 조회한다.  
 order_date | daily_sales_amount  
------------+--------------------  
 2026-04-01 |              25000  
 2026-04-02 |              18200  
 2026-04-03 |              18900  
 2026-04-05 |              13400  
 2026-04-06 |              11300  
 2026-04-07 |              13000  
 2026-04-08 |              16600  
 2026-04-10 |              17800  
 2026-04-11 |              20600  
(9 rows)  

psql:/work/sql/queries.sql:219: ERROR:  insert or update on table "orders" violates foreign key constraint "orders_customer_fk"  
DETAIL:  Key (customer_id)=(999) is not present in table "customers".  



BONUS 03-2. 미니 리포트: 인기 메뉴 TOP 5를 조회한다.  
      menu_name      | sold_quantity  
---------------------+---------------  
 Americano           |             6  
 Butter Croissant    |             4  
 Cafe Latte          |             3  
 Cheese Cake         |             3  
 Ham Cheese Sandwich |             3  
(5 rows)  

BONUS 03-3. 미니 리포트: 고객별 누적 구매 금액을 조회한다.  
 customer_name | total_purchase_amount  
---------------+-----------------------  
 박도윤        |                 36000  
 강유나        |                 34000  
 김민준        |                 29900  
 최하린        |                 18900  
 윤채원        |                 13000  
 이서연        |                 11700  
 조서준        |                 11300  
(7 rows)  

