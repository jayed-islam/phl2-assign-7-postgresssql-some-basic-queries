-- Active: 1729753532780@@127.0.0.1@5432@assignment7

-- Table creation
-- 1 student table ->
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    age INTEGER,
    email  VARCHAR(100) UNIQUE,
    frontend_mark INTEGER,
    backend_mark INTEGER,
    status VARCHAR
)


-- 2 courses table ->
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    credits INTEGER
)


-- 3 enrollment table ->
CREATE TABLE enrollment (
    enrollment_id  SERIAL PRIMARY KEY,
    student_id  INT REFERENCES students(student_id) NOT NULL,
    course_id  INT REFERENCES courses(course_id) NOT NULL
)



-- Sample Data insert on table
-- table 1 students
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status)
VALUES 
    ('Sameer', 21, 'sameer@example.com', 48, 60, NULL),
    ('Zoya', 23, 'zoya@example.com', 52, 58, NULL),
    ('Nabil', 22, 'nabil@example.com', 37, 46, NULL),
    ('Rafi', 24, 'rafi@example.com', 41, 40, NULL),
    ('Sophia', 22, 'sophia@example.com', 50, 52, NULL),
    ('Hasan', 23, 'hasan@gmail.com', 43, 39, NULL);


-- table 2 courses
INSERT INTO courses(
    course_id, course_name, credits
)
VALUES (1, 'Next.js', 3),
(2, 'React.js', 4),
(3, 'Databases', 3),
(4, 'Prisma', 3);


-- table 3 enrollment 
INSERT INTO enrollment(
    enrollment_id, student_id, course_id
)
VALUES (1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 3, 2);


--SQL queries step-3

--Query 1:
--Insert a new student record with the following details
INSERT INTO students 
(student_name, age, email, frontend_mark, backend_mark, status)
VALUES 
('Abdullah', 25, 'abdullah-khan@example.com', 95, 80, NULL);


--Query 2:
--Retrieve the names of all students who are enrolled in the course titled 'Next.js'.
SELECT s.student_name
FROM students s
JOIN enrollment e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Next.js';


--Query 3:
--Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.
UPDATE students
SET status = 'Awarded'
WHERE student_id = (
    SELECT student_id
    FROM students
    ORDER BY (frontend_mark + backend_mark) DESC
    LIMIT 1
);



--Query 4:
--Delete all courses that have no students enrolled.
DELETE FROM courses
WHERE course_id NOT IN (
    SELECT course_id
    FROM enrollment
);


--Query 5:
--Retrieve the names of students using a limit of 2, starting from the 3rd student.
SELECT student_name
FROM students
ORDER BY student_id
LIMIT 2 OFFSET 2;


--Query 6:
--Retrieve the course names and the number of students enrolled in each course.
SELECT c.course_name, COUNT(e.student_id) AS students_enrolled
FROM courses c
JOIN enrollment e ON c.course_id = e.course_id
GROUP BY c.course_name;


--Query 7:
--Calculate and display the average age of all students.
SELECT ROUND(AVG(age), 2) AS average_age
FROM students;


--Query 8:
--Retrieve the names of students whose email addresses contain 'example.com'.
SELECT student_name
FROM students
WHERE email LIKE '%example.com%';
