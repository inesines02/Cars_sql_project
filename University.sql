-- Create the University DataBase

CREATE DATABASE University;
USE University; 

-- Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) UNIQUE,
    Faculty VARCHAR(100)
);

-- Courses Table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    DepartmentID INT,
    CourseName VARCHAR(100),
    Credits INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Instructors Table
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    DepartmentID INT,
    InstructorName VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

--check all the tables

select * from Departments;
select * from Courses;
select * from Instructors;

-- Select all courses offered by the Computer Science department.
SELECT CourseName
FROM Courses
WHERE DepartmentID = (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Computer Science');

-- Find the total number of credits for courses in the Mathematics department.
SELECT SUM(Credits) AS TotalCredits
FROM Courses
WHERE DepartmentID = (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Mathematics');

--List all instructors in the Engineering faculty
SELECT InstructorName
FROM Instructors
WHERE DepartmentID IN (
    SELECT DepartmentID
    FROM Departments
    WHERE Faculty = 'Engineering'
);


-- Get the maximum credits offered for a course in each department
SELECT DepartmentID, MAX(Credits) AS MaxCredits
FROM Courses
GROUP BY DepartmentID;

--Count the number of instructors in each department.

SELECT DepartmentID, COUNT(*) AS InstructorCount
FROM Instructors
GROUP BY DepartmentID;

-- Order the courses by credits in ascending order for each department.

SELECT DepartmentID, CourseName, Credits
FROM Courses
ORDER BY DepartmentID, Credits ASC;

-- Find the total number of courses offered by the Physics department.

SELECT COUNT(*) AS TotalCourses
FROM Courses
WHERE DepartmentID = (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Physics');

-- List all instructors who belong to the Science faculty.

SELECT InstructorName
FROM Instructors
WHERE DepartmentID IN (
    SELECT DepartmentID
    FROM Departments
    WHERE Faculty = 'Science'
);

-- Delete all courses offered by the Chemistry department.
DELETE FROM Courses
WHERE DepartmentID = (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Chemistry');






