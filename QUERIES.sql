-- Limitation of rows and columns
SELECT DEP_ID AS ID, DEP_NAME AS DEPNAME, DEP_CONTACTNUMBER AS DEPNUM
FROM DEPARTMENT 
ORDER BY DEP_NAME;

SELECT E.Emp_LastName AS "Last Name", E.Emp_FirstName AS "First Name", S.Amount, S.Sal_Date AS "Salary Date"
FROM EMPLOYEE E JOIN SALARY_HISTORY S
USING (Emp_ID)
WHERE S.Sal_Date BETWEEN TO_DATE('01-JAN-2018', 'DD-MON-YYYY') AND TO_DATE('01-OCT-2019', 'DD-MON-YYYY')
ORDER BY Sal_Date;

-- Sorting
SELECT * 
FROM Destination
ORDER BY Dest_Name ASC;

SELECT EMP_FIRSTNAME AS FNAME, EMP_LASTNAME AS LNAME, JOB_DESCRIPTION  
FROM EMPLOYEE
ORDER BY EMP_FIRSTNAME ASC;

-- LIKE, AND and OR
SELECT E.Emp_FirstName, E.Emp_LastName, E.Emp_ContactNumber, E.Emp_Address, E.Emp_Email, E.Job_Description
FROM EMPLOYEE E, MANAGER MG
WHERE E.Mine_ID = 3 AND E.Emp_ID = MG.Emp_ID
ORDER BY E.Emp_LastName ASC;

SELECT E.Emp_FirstName, E.Emp_LastName, QD.Name
FROM EMPLOYEE E, Qualification_Detail QD, Qualification Q
WHERE QD.Qual_ID LIKE Q.Qual_ID AND E.Emp_ID = Q.Emp_ID
ORDER BY E.Emp_LastName ASC;

SELECT E.Export_ID, M.Mine_Name AS Mine, D.Dest_Name AS Destination, E.Quantity
FROM EXPORT E, MINE M, DESTINATION D 
WHERE D.Dest_Name LIKE 'Secunda' OR D.Dest_Name LIKE 'Sasolburg' AND E.Mine_ID LIKE M.Mine_ID;

SELECT E.Export_ID, M.Mine_Name, D.Dest_Name AS Destination, E.Quantity
FROM EXPORT E, MINE M, DESTINATION D 
WHERE (E.Dest_ID = 1 OR E.Dest_ID = 2) AND (D.Dest_ID = 1 OR D.Dest_ID = 2) AND (D.Dest_ID LIKE E.Dest_ID) AND (E.Mine_ID LIKE M.Mine_ID) ;

-- CHARACTER FUNCTIONS
SELECT 
    REGEXP_SUBSTR(Emp_Address, '[^,]+', 1, 1) AS "Address Part 1",
    REGEXP_SUBSTR(Emp_Address, '[^,]+', 1, 2) AS "Address Part 2",
    REGEXP_SUBSTR(Emp_Address, '[^,]+', 1, 3) AS "Address Part 3",
    REGEXP_SUBSTR(Emp_Address, '[^,]+', 1, 4) AS "Address Part 4",
    REGEXP_SUBSTR(Emp_Address, '[^ ]+$') AS "Address Part 5"
FROM EMPLOYEE;

SELECT CONCAT(CONCAT(Emp_FirstName,' '),Emp_LastName) AS "Employee on Shift",ROUND((SHIFT_END - SHIFT_START)*24,2) AS "Shift Hours"
FROM SHIFT
INNER JOIN Employee ON Employee.Shift_ID = SHIFT.Shift_ID;

-- ROUND and/or TRUNC
SELECT ROUND(AVG(Salary),0) AS "Average Salary"
FROM EMPLOYEE;

SELECT SUM(ROUND((SHIFT_END - SHIFT_START)*24)-9) AS "TOTAL OVERTIME HOURS WORKED"
FROM SHIFT
WHERE (SHIFT_END - SHIFT_START)*24 > 9;

-- DATE FUNCTIONS
SELECT Transporter,Quantity, Ship_Date AS "Shipping Date", Arrival_Date AS "Arrival Date", (SELECT COUNT(Ship_Date) FROM EXPORT) AS "Total Shippings"
FROM Export
WHERE Ship_Date BETWEEN TO_DATE('2021/05/01','YYYY/MM/DD') AND TO_DATE('2021/05/30','YYYY/MM/DD')
ORDER BY Ship_Date ASC;

-- AGGREGATE FUNCTIONS
SELECT SUM(Coal_Quantity) AS TOTAL_COAL 
FROM MINE;

SELECT COUNT(DISTINCT Sal_Date)
FROM SALARY_HISTORY
WHERE Amount > 30000;

UPDATE MINE
SET Coal_Quantity = (Coal_Quantity + 200.8)
WHERE Mine_Name LIKE '%Mooikraal%';

SELECT SUM(ROUND((SHIFT_END - SHIFT_START)*24)-9) AS "TOTAL OVERTIME HOURS WORKED"
FROM SHIFT
WHERE (SHIFT_END - SHIFT_START)*24 > 9;

-- GROUP BY and HAVING
SELECT QD.Name AS Qualification, COUNT(Q.Qual_ID) AS Qualified_Employees
FROM Qualification_Detail QD, Qualification Q
WHERE Q.Qual_ID LIKE QD.Qual_ID
GROUP BY QD.Name;

SELECT M.Mine_Name AS Mine, SUM(E.Quantity) AS Quantity
FROM MINE M, EXPORT E
WHERE E.Mine_ID LIKE M.Mine_ID
GROUP BY M.Mine_Name;

SELECT M.Mine_Name AS Mine, AVG(E.Quantity) AS Quantity
FROM MINE M, EXPORT E
WHERE E.Mine_ID LIKE M.Mine_ID
GROUP BY M.Mine_Name;

-- JOINS
SELECT Transporter, Dest_Name AS Destination 
FROM Export
INNER JOIN Destination ON Destination.Dest_ID = Export.Dest_ID 
ORDER BY Transporter ASC;

SELECT M.Mine_Name, E.Export_ID, E.Quantity, E.Transporter, E.Transporter_Stat, E.Ship_Date, E.Arrival_Date, E.Sales_Price, E.Export_Cost, D.Dest_Name 
FROM MINE M 
NATURAL JOIN EXPORT E NATURAL JOIN DESTINATION D
ORDER BY M.Mine_Name ASC;

-- SUBQUERIES
SELECT Transporter,Quantity, Ship_Date AS "Shipping Date", Arrival_Date AS "Arrival Date", (SELECT COUNT(Ship_Date) FROM EXPORT) AS "Total Shippings"
FROM Export
WHERE Ship_Date BETWEEN TO_DATE('2021/05/01','YYYY/MM/DD') AND TO_DATE('2021/05/30','YYYY/MM/DD')
ORDER BY Ship_Date ASC;










