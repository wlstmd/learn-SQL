SELECT * FROM table_name;

# EMPLOYEE

INSERT INTO employee VALUES (1, 'MESSI', '1987-02-01', 'M', 'DEV_BACK', 100000000, null);

INSERT INTO employee VALUES (2, 'JANE', '1996-05-05', 'F', 'DSGN', 90000000, null);

INSERT INTO employee (name, birth_date, sex, position, id) VALUES ('JENNY', '2000-10-12', 'F', 'DEV_BACK', 3);

---

# DEPARTMENT

INSERT INTO department VALUES 
  (1001, 'headquarter', 4),
  (1002, 'HR', 6),
  (1003, 'development', 1),
  (1004, 'design', 3),
  (1005, 'product', 13);

---

# PROJECT

INSERT INTO project VALUES
  (2001, '쿠폰 구매/선물 서비스 개발', 13, '2022-03-10', '2022-07-09'),
  (2002, '확장성 있게 백엔드 리팩토링', 13, '2022-01-23', '2022-03-23'),
  (2003, '홈페이지 UI 개선', 11, '2022-05-09', '2022-06-11');

---

# WORKS_ON

INSERT INTO works_on VALUES
  (5, 2001),
  (13, 2001),
  (1, 2001),
  (8, 2001),
  ...
  (7, 2003),
  (2, 2003),
  (12, 2003);

---

UPDATE employee SET dept_id = 1003 WHERE id = 1;

UPDATE employee SET salary = salary * 2 WHERE dept_id = 1003;

UPDATE employee, works_on SET salary = salary * 2 WHERE id = empl_id and proj_id = 2003;

UPDATE employee, works_on SET salary = salary * 2 WHERE employee.id = works_on.empl_id and proj_id = 2003;

UPDATE employee SET salary = salary * 2;

---

DELETE FROM employee WHERE id = 8;

DELETE FROM works_on WHERE impl_id = 2;

DELETE FROM works_on WHERE impl_id = 5 and proj_id = 2002;

DELETE FROM works_on WHERE impl_id = 5 and proj_id <> 2001; # <> === !=