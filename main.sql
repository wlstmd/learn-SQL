# 1. 테이블 생성하기


-- 테이블 생성하기
-- 테이블의 이름: member
-- 열 이름: id, name, number, addr, height
-- id의 조건: CHAR(3), PRIMARY KEY, NOT NULL
-- name의 조건: CHAR(5), NOT NULL
-- number의 조건: SMALLINT
-- addr의 조건: CHAR(3), NOT NULL
-- height의 조건: INT

CREATE TABLE member (
  id CHAR(3) PRIMARY KEY NOT NULL,
  name CHAR(5) NOT NULL,
  number SMALLINT,
  addr CHAR(3) NOT NULL,
  height INT
);



# 2. 데이터 입력/수정/삭제 (INSERT/UPDATE/DELETE)

CREATE TABLE student (
id VARCHAR(3) PRIMARY KEY,
name VARCHAR(10) NOT NULL,
addr VARCHAR(10)
);

INSERT INTO student (id, name, addr) VALUES
('KDH', '김도희', '부산'),
('CHW', '최한울', '칠곡'),
('KH', '강한', NULL),
('JYS', '정윤성', '구미'),
('KSW', '강승우', '칠곡'),
('HKS', '황기성', '구미'),
('KMJ', '강민재', NULL),
('HYJ', '한유준', '부산');

-- ‘LSM, 이수민, 의성’ 데이터 삽입하기
INSERT INTO member VALUES ('LSM', '이수민', '의성');

-- 똑같은 데이터를 두 번 삽입하면 오류가 발생한다. 이유는?
-- 데이터의 무결성을 보장하고 중복 데이터로 인한 모호성을 방지하기

-- KMJ의 addr 값을 ‘구미’로 변경하기
UPDATE student
SET addr = '구미'
WHERE id = 'KMJ';

-- KSW의 name 값을 김상우로, addr 값을 울진으로 변경하기
UPDATE student
SET name = '김상우', addr = '울진'
WHERE id = 'KSW';

-- KH 데이터 삭제하기
DELETE FROM student
WHERE id = 'KH';



# 3. SELECT문

# 1 테이블
CREATE TABLE member (
id VARCHAR(3) PRIMARY KEY,
name VARCHAR(10) NOT NULL,
mem INT NOT NULL,
addr VARCHAR(10) NOT NULL,
height INT NOT NULL
);

INSERT INTO member (id, name, mem, addr, height) VALUES
('APN', '에이핑크', 6, '경기', 165),
('BLK', '블랙핑크', 4, '경북', 168),
('GRL', '소녀시대', 8, '서울', 168),
('ITZ', '있지', 5, '경북', 168),
('MMU', '마마무', 4, '경기', 165),
('RIZ', '라이즈', 7, '경기', 180),
('SVT', '세븐틴', 13, '서울', 180);

-- 지역별로 몇 개의 그룹이 사는지 조회하기
SELECT addr, count(id)
FROM member
GROUP BY addr;

--- 10명 이상 사는 지역과 몇 명이 사는지 조회하기     
SELECT addr, SUM(mem) AS total_members
FROM member
GROUP BY addr
HAVING SUM(mem) >= 10;

## 2 테이블
CREATE TABLE buy (
    num INT,
    id VARCHAR(10),
    prod VARCHAR(50),
    price INT,
    amount INT
);

INSERT INTO buy (num, id, prod, price, amount) VALUES
(1, 'BLK', '지갑', 30, 2),
(2, 'BLK', '맥북', 1000, 1),
(3, 'APN', '아이폰', 200, 1),
(4, 'MMU', '아이폰', 200, 5),
(5, 'BLK', '청바지', 50, 3),
(6, 'RIZ', '에어팟', 80, 10),
(7, 'SVT', '책', 15, 5),
(8, 'SVT', '책', 15, 2),
(9, 'RIZ', '청바지', 50, 1),
(10, 'MMU', '지갑', 30, 1),
(11, 'APN', '책', 15, 1),
(12, 'MMU', '지갑', 30, 4);

-- 구매한 제품 종류가 2개 이상인 그룹 조회
SELECT id, COUNT(DISTINCT prod) AS product_count
FROM buy
GROUP BY id
HAVING COUNT(DISTINCT prod) >= 2;
