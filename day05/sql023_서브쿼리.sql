-- 서브쿼리 리뷰
-- ALL, ANY(SOME) - ANY(SOME) 쓰는 조건은 아래의 데이터는 사용이 어려움
-- 3번 고객이 주문한 도서의 최고금액보다 더 비싼 도서를 구입한 다른 주문의 주문번호, 금액표시
SELECT *
  FROM Customer;

-- 장미란이 주문한 내역 중 최고금액
SELECT MAX(saleprice)
  FROM Orders
 WHERE custid = 3;

-- 13,000원보다 비싼 도서를 구입한 주문번호, 금액
SELECT o1.orderid
     , o1.saleprice
  FROM Orders AS o1
 WHERE o1.saleprice > 13000;

-- 13,000원 대신 2번 코드 집어넣기
SELECT o1.orderid
     , o1.saleprice
  FROM Orders AS o1
 WHERE o1.saleprice > ALL (SELECT MAX(saleprice)
                            FROM Orders
                           WHERE custid = 3);