-- INNER JOIN
SELECT * FROM TableA A
INNER JOIN TableB B ON
A.key = B.key



-- LEFT OUTER JOIN
SELECT * FROM TableA A
LEFT JOIN TableB B ON
A.key = B.key

SELECT * FROM TableA A
LEFT JOIN TableB B ON
A.key = B.key WHERE B.key IS NULL



-- RIGHT OUTER JOIN
SELECT * FROM TableA A
RIGHT JOIN TableB B ON
A.key = B.key

SELECT * FROM TableA A
RIGHT JOIN TableB B ON
A.key = B.key WHERE A.key IS NULL



-- FULL OUTER JOIN
SELECT * FROM TableA A
FULL OUTER JOIN TableB B ON
A.key = B.key



-- 실습 해보기

-- Student 테이블 생성 및 데이터 삽입
CREATE TABLE Student (
    student_id INT,
    student_name VARCHAR(50)
);

INSERT INTO Student (student_id, student_name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David');

-- Grade 테이블 생성 및 데이터 삽입
CREATE TABLE Grade (
    student_id INT,
    grade CHAR(1)
);

INSERT INTO Grade (student_id, grade) VALUES
(1, 'A'),
(2, 'B'),
(4, 'A'),
(5, 'C');  -- 학생 테이블에 없는 학생 ID

-- 초기 테이블 모습
Grade
+------------+-------+
| student_id | grade |
+------------+-------+
|          1 | A     |
|          2 | B     |
|          4 | A     |
|          5 | C     | 
+------------+-------+
Student
+------------+--------------+
| student_id | student_name |
+------------+--------------+
|          1 | Alice        |
|          2 | Bob          |
|          3 | Charlie      |
|          4 | David        |
+------------+--------------+

-- INNER JOIN : INNER JOIN은 두 테이블에서 일치하는 데이터만 반환합니다.
SELECT * FROM Student S
INNER JOIN Grade G ON S.student_id = G.student_id;

mysql> SELECT * FROM Student S
    -> INNER JOIN Grade G ON S.student_id = G.student_id;
+------------+--------------+------------+-------+
| student_id | student_name | student_id | grade |
+------------+--------------+------------+-------+
|          1 | Alice        |          1 | A     |
|          2 | Bob          |          2 | B     |
|          4 | David        |          4 | A     |
+------------+--------------+------------+-------+

-- LEFT OUTER JOIN : LEFT JOIN은 왼쪽 테이블(Student)의 모든 행과 오른쪽 테이블(Grade)의 일치하는 행을 반환합니다. 일치하지 않는 오른쪽 테이블의 행에는 NULL이 반환됩니다.
SELECT * FROM Student S
LEFT JOIN Grade G ON S.student_id = G.student_id;

mysql> SELECT * FROM Student S
    -> LEFT JOIN Grade G ON S.student_id = G.student_id;
+------------+--------------+------------+-------+
| student_id | student_name | student_id | grade |
+------------+--------------+------------+-------+
|          1 | Alice        |          1 | A     |
|          2 | Bob          |          2 | B     |
|          3 | Charlie      |       NULL | NULL  |
|          4 | David        |          4 | A     |
+------------+--------------+------------+-------+

-- LEFT OUTER JOIN에서 NULL 값만 반환 : 왼쪽 테이블(Student)에 있고 오른쪽 테이블(Grade)에 없는 데이터를 조회합니다.
SELECT * FROM Student S
LEFT JOIN Grade G ON S.student_id = G.student_id
WHERE G.student_id IS NULL;

mysql> SELECT * FROM Student S
    -> LEFT JOIN Grade G ON S.student_id = G.student_id
    -> WHERE G.student_id IS NULL;
+------------+--------------+------------+-------+
| student_id | student_name | student_id | grade |
+------------+--------------+------------+-------+
|          3 | Charlie      |       NULL | NULL  |
+------------+--------------+------------+-------+

-- RIGHT OUTER JOIN : RIGHT JOIN은 오른쪽 테이블(Grade)의 모든 행과 왼쪽 테이블(Student)의 일치하는 행을 반환합니다. 일치하지 않는 왼쪽 테이블의 행에는 NULL이 반환됩니다.
SELECT * FROM Student S
RIGHT JOIN Grade G ON S.student_id = G.student_id;

mysql> SELECT * FROM Student S
    -> RIGHT JOIN Grade G ON S.student_id = G.student_id;
+------------+--------------+------------+-------+
| student_id | student_name | student_id | grade |
+------------+--------------+------------+-------+
|          1 | Alice        |          1 | A     |
|          2 | Bob          |          2 | B     |
|          4 | David        |          4 | A     |
|       NULL | NULL         |          5 | C     |
+------------+--------------+------------+-------+

-- RIGHT OUTER JOIN에서 NULL 값만 반환 : 오른쪽 테이블(Grade)에 있고 왼쪽 테이블(Student)에 없는 데이터를 조회합니다.
SELECT * FROM Student S
RIGHT JOIN Grade G ON S.student_id = G.student_id
WHERE S.student_id IS NULL;

mysql> SELECT * FROM Student S
    -> RIGHT JOIN Grade G ON S.student_id = G.student_id
    -> WHERE S.student_id IS NULL;
+------------+--------------+------------+-------+
| student_id | student_name | student_id | grade |
+------------+--------------+------------+-------+
|       NULL | NULL         |          5 | C     |
+------------+--------------+------------+-------+