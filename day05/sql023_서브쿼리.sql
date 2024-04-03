-- 서브쿼리 리뷰
-- WHERE절 서브쿼리
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

-- EXISTS, NOT EXISTS - 열을 명시안함
-- 대한민국 거주 고객에게 판매한 도서의 총판매액
-- 전체 판매액은 118,000원, 대한민국 고객 판매액 46,000원
SELECT SUM(saleprice) AS '대한민국 고객 판매액'
  FROM Orders AS o
 WHERE EXISTS (SELECT *
                FROM Customer AS c
               WHERE c.address LIKE '%대한민국%'
                 AND c.custid = o.custid);

-- 조인으로도 금액을 찾을 수 있음
SELECT SUM(o.saleprice) AS '조인도 가능'
  FROM Orders AS o, Customer AS c
 WHERE o.custid = c. custid
   AND c.address LIKE '%대한민국%';

-- SELECT절 서브쿼리, 조인으로도 가능(조인을 더 많이 쓰긴 함)
-- 이미 쿼리가 너무 복잡해서 더이상 테이블을 추가하기 힘들면, 많이 사용
-- 51. 고객별 판매액을 보이시오, GROUP BY가 들어가면 SELECT절에 반드시 집계함수가 들어가야 함!!!
SELECT SUM(o.saleprice) AS '고객별 판매액'
    -- , o.custid -- 다봤으면 주석처리!
     , (SELECT [name] FROM Customer WHERE custid = o.custid) AS '고객명'
  FROM Orders AS o
 GROUP BY o.custid;

-- 조인으로도 가능, 다음장에서 나옴

-- UPDATE에서도 사용가능
-- 사전준비
ALTER TABLE Orders ADD bookname VARCHAR(40);

-- 업데이트, 한꺼번에 필요한 필드값을 한 테이블에서 다른 테이블로 복사할 때 유용
UPDATE Orders
   SET bookname = (SELECT bookname
                     FROM Book
                    WHERE Book.bookid = Orders.bookid);

-- FROM절 서브쿼리(인라인 뷰[가상테이블])
-- 52. 고객별 판매액으로 고객명과 판매금액을 보이시오(서브쿼리-->조인)
-- 고객별 판매액 집계 쿼리가 FROM절에 들어가면 모든 속성(컬럼)에 이름 지정되어야 함
SELECT b.total
     , c.[name]
  FROM (SELECT SUM(o.saleprice) AS 'total'
             , o.custid
          FROM Orders AS o
         GROUP BY o.custid) AS b, Customer AS c
 WHERE b.custid = c.custid;

-- 고객번호가 2이하인 고객의 이름, 판매액을 보이시오
-- (★) GROUP BY에 들어갈 속성(컬럼)은 최소화 해야함, 중복 등의 문제 -> 결과 틀어짐!!
SELECT SUM(o.saleprice) AS '고객별 판매액'
     , (SELECT [name] FROM Customer WHERE custid = c.custid) AS '고객명'
  FROM (SELECT custid
             , [name]
          FROM Customer
        WHERE custid <= 2) AS c, Orders AS o
 WHERE c.custid = o.custid
 GROUP BY c.custid;