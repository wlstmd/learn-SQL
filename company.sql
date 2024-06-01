show databases;

SELECT DATABASE();

SHOW CREATE TABLE TABLE_name; // Error Check

CREATE DATABASE company;

DROP TABLE TABLE_name;

use company;

---

CREATE TABLE DEPARTMENT (
  id INT PRIMARY KEY,
  name VARCHAR(20) NOT NULL UNIQUE,
  leader_id INT
);

---

CREATE TABLE EMPLOYEE (
  id INT PRIMARY KEY,
  name VARCHAR(30) NOT NULL,
  birth_date DATE,
  sex CHAR(1) CHECK (sex IN ('M', 'F')),
  position VARCHAR(10),
  salary INT DEFAULT 50000000,
  dept_id INT,
  CHECK (salary >= 50000000),
  FOREIGN KEY (dept_id) REFERENCES DEPARTMENT(id) ON DELETE SET NULL ON UPDATE CASCADE
);

---

CREATE TABLE PROJECT (
    id INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL UNIQUE,
    leader_id INT, start_date DATE,
    end_date DATE,
    FOREIGN KEY (leader_id) REFERENCES EMPLOYEE(id) on delete SET NULL on update CASCADE,
    CHECK (start_date < end_date)
);

---

CREATE TABLE WORKS_ON (
  empl_id INT,
  proj_id INT,
  PRIMARY KEY (empl_id, proj_id),
  FOREIGN KEY (empl_id) REFERENCES EMPLOYEE(id) on delete CASCADE on update CASCADE,
  FOREIGN KEY (proj_id) REFERENCES PROJECT(id) on delete CASCADE on update CASCADE
);

---

ALTER TABLE DEPARTMENT ADD FOREIGN KEY (leader_id)
  REFERENCES employee(id)
  on update CASCADE
  on delete SET NULL;