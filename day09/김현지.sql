-- 2024-04-09 코딩테스트

-- 1번 문제
SELECT Email
	 , Mobile
	 , Names
	 , Addr
  FROM membertbl
 ORDER BY Addr DESC, Email ASC, Names DESC;

-- 2번 문제
SELECT Names AS '도서명'
	 , Author AS '저자'
	 , ISBN
	 , Price AS '정가'
  FROM bookstbl
 ORDER BY Price DESC;

-- 3번 문제
SELECT m.Names AS '회원명'
	 , m.Levels AS '회원등급'
	 , m.Addr AS '회원주소'
	 , NULL AS '대여일'
  FROM membertbl AS m
 WHERE m.Levels = 'A' AND m.memberIdx NOT IN (SELECT r.memberIdx
											    FROM rentaltbl AS r, membertbl AS m
											   WHERE r.memberIdx = m.memberIdx)

-- 4번 문제
SELECT d.Names AS '책 장르'
	 , FORMAT(SUM(Price), '#,#') + '원' AS '총합계금액'
  FROM bookstbl AS b, divtbl AS d
 WHERE b.Division = d.Division
 GROUP BY d.Names

-- 5번 문제
SELECT ISNULL(d.Names, '--합계--') AS '책 장르'
	 , COUNT(b.Division) AS '권수'
	 , FORMAT(SUM(Price), '#,#') + '원' AS '총합계금액'
  FROM bookstbl AS b, divtbl AS d
 WHERE b.Division = d.Division
 GROUP BY d.Names WITH ROLLUP

