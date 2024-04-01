-- DDL - 데이터 정의 언어
-- 객체 생성, 수정, 삭제

-- 1. NewBook이라는 테이블 생성하라
/*
    bookid(도서번호 : 기본키) - int
    bookname(도서이름) - varchar(20)
    publisher(출판사) - varchar(20)
    price(가격) - int

    -- 타입종류
    INT[정수], BIGINT[큰 정수], BINARY(n)[이진데이터], BIT[0|1],
    CHAR(n)[고정문자열], VARCHAR(n)[가변문자열], NCHAR(n), NVARCHAR(n), N-[유니코드],
    DATE[날짜], DATETIME[날짜시간], DECIMAL(18, 0)[소수점표현, 실수], FLOAT[실수],
    IMAGE[이미지 바이너리], SMALLINT[255까지의 정수], TEXT[2GB까지의 텍스트] | NTEXT[유니코드 2G]

    예(username : CHAR(10)/VARCHAR(10) ) 'hugo'
    CHAR(10) = 'hugo      ' 이름을 넣고 10개의 자리 중 빈 곳은 전부 스페이스 입력
    VARCHAR(10) = 'hugo' 이름을 넣고 10개의 자리 중 빈 곳은 전부 없앰

    -- 가장 많이 쓰는 타입
    INT, CHAR, VARCHAR, DATETIME, DECIMAL, FLOAT, TEXT 외에는 잘 안씀
*/
DROP TABLE NewBook; -- 테이블 삭제

CREATE TABLE NewBook (
    bookid INT,
    bookname VARCHAR(20),
    publisher VARCHAR(20),
    price INT
    PRIMARY KEY (bookid) -- 기본키로 bookid 지정
);

-- 기본키를 통합
CREATE TABLE NewBook (
    bookid INT PRIMARY KEY,
    bookname VARCHAR(20),
    publisher VARCHAR(20),
    price INT
);

-- 기본키가 두 개 이상이면
CREATE TABLE NewBook (
    bookid INT,
    bookname VARCHAR(20),
    publisher VARCHAR(20),
    price INT
    PRIMARY KEY (bookid, bookname) -- 기본키를 두 개 이상
);

-- 각 컬럼에 제약조건을 걸면
CREATE TABLE NewBook (
    bookname VARCHAR(20) NOT NULL,
    publisher VARCHAR(20) UNIQUE, -- 유니크 제약조건
    price INT DEFAULT 10000 CHECK(price > 1000), -- 기본값 제약조건, 체크 제약조건
    PRIMARY KEY (bookname, publisher) -- 개체 무결성 제약조건
);

-- 새 고객테이블(기본키)
CREATE TABLE NewCustomer (
    custid INT PRIMARY KEY,
    custname VARCHAR(40),
    custaddress VARCHAR(255),
    phone VARCHAR(30)
);

-- 새 주문테이블(기본키 + 외래키)
CREATE TABLE NewOrder (
    orderid INT,
    custid INT NOT NULL,
    bookid INT NOT NULL,
    saleprice INT,
    orderdate DATE,
    PRIMARY KEY (orderid),
    FOREIGN KEY (custid) REFERENCES NewCustomer(custid) ON DELETE CASCADE
);