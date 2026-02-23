CREATE SEQUENCE student_id_seq
	AS INTEGER
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1;

CREATE SEQUENCE instructor_id_seq
    AS INTEGER
	START WITH 1
    INCREMENT BY 1
    MINVALUE 1;

CREATE SEQUENCE category_id_seq
    AS INTEGER
	START WITH 1
    INCREMENT BY 1
    MINVALUE 1;

CREATE SEQUENCE course_id_seq
    AS INTEGER
	START WITH 1
    INCREMENT BY 1
    MINVALUE 1;

CREATE SEQUENCE enrollment_id_seq
    AS INTEGER
	START WITH 1
    INCREMENT BY 1
    MINVALUE 1;

CREATE SEQUENCE assignment_id_seq
    AS INTEGER
	START WITH 1
    INCREMENT BY 1
    MINVALUE 1;

CREATE SEQUENCE payment_id_seq
    AS INTEGER
	START WITH 1
    INCREMENT BY 1
    MINVALUE 1;

CREATE SEQUENCE review_id_seq
    AS INTEGER
	START WITH 1
    INCREMENT BY 1
    MINVALUE 1;

CREATE TABLE student (
    student_id INT DEFAULT nextval('student_id_seq') PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,    
    email VARCHAR(100) NOT NULL UNIQUE
        CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    phone VARCHAR(10) NOT NULL CHECK (phone ~ '^[0-9]{10}$'),
    date_of_birth DATE NOT NULL,
    registration_date DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE instructor (
    instructor_id INT DEFAULT nextval('instructor_id_seq') PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
        CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    expertise VARCHAR(100),    
    experience_year INT CHECK (experience_year >= 0)
);

CREATE TABLE category (
    category_id INT DEFAULT nextval('category_id_seq') PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE course (
    course_id INT DEFAULT nextval('course_id_seq') PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    instructor_id INT REFERENCES instructor(instructor_id) ON DELETE SET NULL,
    category_id INT REFERENCES category(category_id) ON DELETE SET NULL,
    description TEXT NOT NULL,
    price NUMERIC(10,2) NOT NULL CHECK (price >= 0),
    duration_hour INT NOT NULL CHECK (duration_hour > 0)
);

CREATE TABLE enrollment (
    enrollment_id INT DEFAULT nextval('enrollment_id_seq') PRIMARY KEY,
    student_id INT NOT NULL REFERENCES student(student_id) ON DELETE CASCADE,
    course_id INT NOT NULL REFERENCES course(course_id) ON DELETE CASCADE,
    enrollment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    status VARCHAR(10) NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'completed', 'dropped')),
    UNIQUE(student_id, course_id)
);


CREATE TABLE assignment (
    assignment_id INT DEFAULT nextval('assignment_id_seq') PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    course_id INT NOT NULL REFERENCES course(course_id) ON DELETE CASCADE,
    max_marks INT NOT NULL CHECK (max_marks > 0),
    due_date DATE
);


CREATE TABLE payment (
    payment_id INT DEFAULT nextval('payment_id_seq')  PRIMARY KEY,
    amount NUMERIC(10,2) NOT NULL CHECK (amount > 0),
    payment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    payment_method VARCHAR(10) NOT NULL CHECK (payment_method IN ('UPI', 'CHECK', 'CASH')),
    transaction_reference VARCHAR(255),
    enrollment_id INT NOT NULL REFERENCES enrollment(enrollment_id) ON DELETE CASCADE
);


CREATE TABLE review (
    review_id INT DEFAULT nextval('review_id_seq') PRIMARY KEY,
    enrollment_id INT NOT NULL UNIQUE REFERENCES enrollment(enrollment_id) ON DELETE CASCADE,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date DATE DEFAULT CURRENT_DATE
);

INSERT INTO category (name) VALUES
('Programming'),
('Data Science'),
('Web Development'),
('Cyber Security'),
('Cloud Computing'),
('AI & ML'),
('Database'),
('Mobile Development'),
('DevOps'),
('UI/UX Design');

SELECT * FROM category;

INSERT INTO instructor (full_name, email, expertise, experience_year) VALUES
('John Smith', 'john.smith@gmail.com', 'Python & AI', 8),
('Emma Watson', 'emma.watson@gmail.com', 'Web Development', 6),
('Michael Brown', 'michael.brown@gmail.com', 'Cyber Security', 10),
('Sophia Johnson', 'sophia.j@gmail.com', 'Cloud Computing', 7),
('David Miller', 'david.m@gmail.com', 'Data Science', 9),
('Olivia Davis', 'olivia.d@gmail.com', 'UI/UX', 5),
('James Wilson', 'james.w@gmail.com', 'DevOps', 11),
('Isabella Moore', 'isabella.m@gmail.com', 'Mobile Apps', 6),
('William Taylor', 'will.t@gmail.com', 'Databases', 12),
('Ava Anderson', 'ava.a@gmail.com', 'Machine Learning', 4);

SELECT * FROM instructor;

INSERT INTO student (full_name, email, phone, date_of_birth) VALUES
('Liam Thomas', 'liam.t@gmail.com', '9876543210', '2000-05-12'),
('Noah Martin', 'noah.m@gmail.com', '9876543211', '1999-08-20'),
('Elijah Lee', 'elijah.l@gmail.com', '9876543212', '2001-02-15'),
('Lucas Walker', 'lucas.w@gmail.com', '9876543213', '1998-11-05'),
('Mason Hall', 'mason.h@gmail.com', '9876543214', '2002-07-09'),
('Logan Allen', 'logan.a@gmail.com', '9876543215', '2000-01-25'),
('Ethan Young', 'ethan.y@gmail.com', '9876543216', '1997-09-14'),
('Jacob King', 'jacob.k@gmail.com', '9876543217', '2003-04-18'),
('Aiden Wright', 'aiden.w@gmail.com', '9876543218', '1999-12-30'),
('Sebastian Scott', 'seb.scott@gmail.com', '9876543219', '2001-06-22');

SELECT * FROM student;

INSERT INTO course (title, instructor_id, category_id, description, price, duration_hour) VALUES
('Python Basics', 1, 1, 'Beginner level Python', 2000, 40),
('Advanced Python', 1, 1, 'Advanced Python concepts', 3500, 60),
('Frontend Development', 2, 3, 'HTML CSS JavaScript', 2500, 45),
('Backend with Node.js', 2, 3, 'Server-side programming', 3000, 50),
('Ethical Hacking', 3, 4, 'Cybersecurity course', 4000, 70),
('AWS Cloud Practitioner', 4, 5, 'Cloud fundamentals', 3800, 55),
('Data Science Intro', 5, 2, 'Data analysis basics', 4200, 65),
('Machine Learning', 5, 6, 'ML algorithms & projects', 5000, 80),
('PostgreSQL Mastery', 9, 7, 'Advanced database concepts', 2700, 45),
('Docker & DevOps', 7, 9, 'CI/CD and containers', 3600, 50);

SELECT * FROM course;

INSERT INTO enrollment (student_id, course_id, status) VALUES
(1, 1, 'active'),
(1, 2, 'completed'),
(2, 1, 'completed'),
(2, 3, 'active'),
(3, 3, 'dropped'),
(3, 4, 'active'),
(4, 5, 'completed'),
(5, 6, 'active'),
(6, 7, 'completed'),
(7, 8, 'active'),
(8, 9, 'completed'),
(9, 10, 'active'),
(10, 5, 'active');

SELECT * FROM enrollment;

INSERT INTO assignment (title, course_id, max_marks, due_date) VALUES
('Variables & Loops', 1, 100, CURRENT_DATE + INTERVAL '7 days'),
('Functions & OOP', 1, 100, CURRENT_DATE + INTERVAL '10 days'),
('Advanced OOP', 2, 100, CURRENT_DATE + INTERVAL '15 days'),
('HTML Project', 3, 100, CURRENT_DATE + INTERVAL '5 days'),
('CSS Layout Task', 3, 100, CURRENT_DATE + INTERVAL '8 days'),
('Node API Project', 4, 100, CURRENT_DATE + INTERVAL '12 days'),
('Security Audit', 5, 100, CURRENT_DATE + INTERVAL '14 days'),
('AWS Deployment', 6, 100, CURRENT_DATE + INTERVAL '9 days'),
('Data Cleaning Project', 7, 100, CURRENT_DATE + INTERVAL '11 days'),
('ML Model Build', 8, 100, CURRENT_DATE + INTERVAL '20 days');

SELECT * FROM assignment;

INSERT INTO payment (amount, payment_method, transaction_reference, enrollment_id) VALUES
(2000, 'UPI', 'TXN3001', 1),
(1500, 'CASH', 'TXN3002', 2),
(2000, 'UPI', 'TXN3003', 2),
(1000, 'UPI', 'TXN3004', 4),
(1500, 'CASH', 'TXN3005', 4),
(4000, 'CHECK', 'TXN3006', 7),
(2000, 'UPI', 'TXN3007', 8),
(4200, 'CASH', 'TXN3008', 9),
(5000, 'UPI', 'TXN3009', 10);

SELECT * FROM payment;

INSERT INTO review (enrollment_id, rating, comment) VALUES
(2, 5, 'Excellent advanced Python course!'),
(3, 4, 'Very good content.'),
(7, 5, 'Loved the cybersecurity examples.'),
(9, 4, 'Good data science introduction.'),
(8, 3, 'Still ongoing but informative.');

SELECT * FROM review;

-- Total Revenue Per Course
SELECT c.title, c.price*COUNT(e.course_id) AS total_revenue
FROM course c
JOIN enrollment e
	USING (course_id)
GROUP BY c.title, c.price;

-- Student per Category
SELECT c.name, COUNT(*) AS total_student
FROM category c
JOIN course 
	USING (category_id)
JOIN enrollment e
	USING (course_id)
JOIN student
	USING (student_id)
GROUP BY c.name;

-- Course per Instructor
SELECT i.instructor_id, i.full_name, COUNT(*) AS total_course
FROM course c
JOIN instructor i
	USING (instructor_id)
GROUP BY i.instructor_id, i.full_name
ORDER BY total_course DESC;

-- Courses with highest rating
SELECT c.title, ROUND(AVG(rating), 2) AS highest_rating
FROM course c
JOIN enrollment e
	USING (course_id)
JOIN review
	USING (enrollment_id)
GROUP BY c.title
ORDER BY highest_rating DESC
LIMIT 1 WITH T;

-- Student Enrolled in more than 2 course
SELECT s.student_id, s.full_name, COUNT(*) AS number_of_course
FROM student s
JOIN enrollment e
	USING (student_id)
GROUP BY s.student_id
HAVING COUNT(*) >= 2;