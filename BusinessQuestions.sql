-- Step 1: Create Database
CREATE DATABASE CampusEdgeDB;
USE CampusEdgeDB;

-- Step 2: Create Tables
CREATE TABLE Students (
       StudentID INT PRIMARY KEY,
       FirstName VARCHAR(50) NOT NULL,
       LastName VARCHAR(50) NOT NULL,
       Email VARCHAR(100) UNIQUE
);

CREATE TABLE Courses (
       CourseID INT PRIMARY KEY,
       CourseName VARCHAR(100) NOT NULL,
       Credits INT NOT NULL
);

CREATE TABLE Enrollments (
       EnrollmentID INT PRIMARY KEY,
       StudentID INT, 
       CourseID INT, 
       Grade VARCHAR(2), 
       FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
       FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
       CHECK (Grade IN ('A', 'B', 'C', 'D', 'F', NULL))
);

-- Students
INSERT INTO Students(StudentID, FirstName, LastName, Email)
            VALUES (1, 'Alice', 'Wong', 'alice@campusedge.com');
INSERT INTO Students(StudentID, FirstName, LastName, Email)
            VALUES(2, 'Brian', 'Kim', 'brian@campusedge.com');
INSERT INTO Students(StudentID, FirstName, LastName, Email)
            VALUES(3, 'Carla', 'Lopez', 'carla@campusedge.com');
INSERT INTO Students(StudentID, FirstName, LastName, Email)
            VALUES(4, 'David', 'Lee', 'david@campusedge.com');
INSERT INTO Students(StudentID, FirstName, LastName, Email)
            VALUES(5, 'Eva', 'Singh', 'eva@campusedge.com');

-- Courses
INSERT INTO Courses(CourseID, CourseName, Credits)
            VALUES(101, 'Intro to SQL', 3);
INSERT INTO Courses(CourseID, CourseName, Credits)
            VALUES(102, 'Database Design', 4);
INSERT INTO Courses(CourseID, CourseName, Credits)
            VALUES(103, 'Web Development Basics', 3);

-- Enrollments 
INSERT INTO Enrollments(EnrollmentID, StudentID, CourseID, Grade)
            VALUES(1, 1, 101, 'A');
INSERT INTO Enrollments(EnrollmentID, StudentID, CourseID, Grade)
            VALUES(2, 1, 102, 'B');
INSERT INTO Enrollments(EnrollmentID, StudentID, CourseID, Grade)
            VALUES(3, 2, 101, 'A');
INSERT INTO Enrollments(EnrollmentID, StudentID, CourseID, Grade)
            VALUES(4, 2, 103, 'C');
INSERT INTO Enrollments(EnrollmentID, StudentID, CourseID, Grade)
            VALUES(5, 3, 101, 'B');
INSERT INTO Enrollments(EnrollmentID, StudentID, CourseID, Grade)
            VALUES(6, 3, 102, 'A');
INSERT INTO Enrollments(EnrollmentID, StudentID, CourseID, Grade)
            VALUES(7, 3, 103, 'A');
INSERT INTO Enrollments(EnrollmentID, StudentID, CourseID, Grade)
            VALUES(8, 4, 102, 'D');
INSERT INTO Enrollments(EnrollmentID, StudentID, CourseID, Grade)
            VALUES(9, 5, 103, NULL);
INSERT INTO Enrollments(EnrollmentID, StudentID, CourseID, Grade)
            VALUES(10, 5, 101, 'B');
            
-- Business Questions & SQL Reports 
-- 1. Which students are enrolled in each course, and what grade 
-- did they get?
SELECT FirstName, LastName, CourseName, Grade
FROM Enrollments JOIN Students USING (StudentID)
                 JOIN Courses USING (CourseID)
ORDER BY CourseName, LastName;

-- 2. What are the average grades (letter grade frequencies)
-- per course?
SELECT CourseName, Grade, COUNT(*) AS GradeCount
FROM Enrollments JOIN Courses USING (CourseID)
WHERE Grade IS NOT NULL
GROUP BY CourseName, Grade
ORDER BY CourseName, GradeCount DESC;

-- 3. Which course has the highest number of enrollments?
SELECT CourseName, COUNT(EnrollmentID) AS EnrollmentCount
FROM Courses JOIN Enrollments USING (CourseID)
GROUP BY CourseName
ORDER BY EnrollmentCount DESC
LIMIT 1;

-- 4. Which student(s) are enrolled in the most credits?
SELECT FirstName, LastName, SUM(Credits) AS TotalCredits
FROM Enrollments JOIN Students USING (StudentID)
				 JOIN Courses USING (CourseID)
GROUP BY StudentID
ORDER BY TotalCredits DESC
LIMIT 1;

-- 5. Are there any students not enrolled in any course yet?
SELECT FirstName, LastName, Email
FROM Students LEFT JOIN Enrollments USING (StudentID)
WHERE EnrollmentID IS NULL;


