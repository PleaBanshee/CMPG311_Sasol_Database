-- Department View
CREATE VIEW DEPARTMENTS_ALPHABETICAL ("ID", "DEPNAME", "DEPNUM") 
AS SELECT DEP_ID AS ID, DEP_NAME AS DEPNAME, DEP_CONTACTNUMBER AS DEPNUM
   FROM DEPARTMENT 
   ORDER BY DEP_NAME;

--  Shift Views 
CREATE VIEW AllShifts
AS SELECT *
   FROM SHIFT;

CREATE VIEW ShiftHours
AS SELECT ROUND((SHIFT_END - SHIFT_START)*24,2) AS "Shift_Hours"
   FROM SHIFT;

-- All mines on the system A-Z:
CREATE VIEW AllMines
AS SELECT * 
   FROM MINE 
   ORDER BY Mine_Name ASC;

--List location of each Mine:
CREATE VIEW MineLocations
AS SELECT Mine_Name AS MINE, Location
   FROM MINE
   ORDER BY Mine_Name ASC;

--Total combined coal available at Mines:
CREATE VIEW TotalCoal
AS SELECT SUM(Coal_Quantity) AS TOTAL_COAL
   FROM MINE;

--Coal currently available at a specific Mine:
CREATE VIEW MineCoal
AS SELECT Mine_Name AS Mine, Coal_Quantity
   FROM MINE
   ORDER BY Mine_Name ASC;

--Specific Mine details: (Each must have own view - slide 41 su7)
CREATE VIEW MooikraalMine
AS SELECT * 
   FROM MINE
   WHERE Mine_Name LIKE '%Mooikraal%';

CREATE VIEW TwisdraaiMine
AS SELECT *
   FROM MINE
   WHERE Mine_Name LIKE '%Twisdraai%';

CREATE VIEW BrandspruitMine
AS SELECT *
   FROM MINE
   WHERE Mine_Name LIKE '%Brandspruit%';

CREATE VIEW CollieryMine
AS SELECT *
   FROM MINE
   WHERE Mine_Name LIKE '%Colliery%';

CREATE VIEW BojespruitMine
AS SELECT *
   FROM MINE
   WHERE Mine_Name LIKE '%Bojespruit%';

-- Look up each specific Mine's Export:
CREATE VIEW MineExport
AS SELECT M.Mine_Name AS Mine, E.Export_ID, E.Quantity, E.Transporter, E.Transporter_Stat AS Status, E.Ship_Date AS Shipping_Date, E.Arrival_Date, E.Sales_Price, E.Export_Cost, D.Dest_Name AS Destination
   FROM MINE M NATURAL JOIN EXPORT E NATURAL JOIN DESTINATION D
   ORDER BY M.Mine_Name ASC;

CREATE VIEW MooikraalExport
AS SELECT M.Mine_Name AS Mine, E.Export_ID, E.Quantity, E.Transporter, E.Transporter_Stat AS Status, E.Ship_Date AS Shipping_Date, E.Arrival_Date, E.Sales_Price, E.Export_Cost, D.Dest_Name AS Destination
   FROM MINE M NATURAL JOIN EXPORT E NATURAL JOIN DESTINATION D
   WHERE M.Mine_Name LIKE '%Mooikraal%';

CREATE VIEW TwisdraaiExport
AS SELECT M.Mine_Name AS Mine, E.Export_ID, E.Quantity, E.Transporter, E.Transporter_Stat AS Status, E.Ship_Date AS Shipping_Date, E.Arrival_Date, E.Sales_Price, E.Export_Cost, D.Dest_Name AS Destination
   FROM MINE M NATURAL JOIN EXPORT E NATURAL JOIN DESTINATION D
   WHERE M.Mine_Name LIKE '%Twisdraai%';  

CREATE VIEW BrandspruitExport
AS SELECT M.Mine_Name AS Mine, E.Export_ID, E.Quantity, E.Transporter, E.Transporter_Stat AS Status, E.Ship_Date AS Shipping_Date, E.Arrival_Date, E.Sales_Price, E.Export_Cost, D.Dest_Name AS Destination
   FROM MINE M NATURAL JOIN EXPORT E NATURAL JOIN DESTINATION D
   WHERE M.Mine_Name LIKE '%Brandspruit%';

CREATE VIEW CollieryExport
AS SELECT M.Mine_Name AS Mine, E.Export_ID, E.Quantity, E.Transporter, E.Transporter_Stat AS Status, E.Ship_Date AS Shipping_Date, E.Arrival_Date, E.Sales_Price, E.Export_Cost, D.Dest_Name AS Destination
   FROM MINE M NATURAL JOIN EXPORT E NATURAL JOIN DESTINATION D
   WHERE M.Mine_Name LIKE '%Colliery%';

CREATE VIEW BojespruitExport
AS SELECT M.Mine_Name AS Mine, E.Export_ID, E.Quantity, E.Transporter, E.Transporter_Stat AS Status, E.Ship_Date AS Shipping_Date, E.Arrival_Date, E.Sales_Price, E.Export_Cost, D.Dest_Name AS Destination
   FROM MINE M NATURAL JOIN EXPORT E NATURAL JOIN DESTINATION D
   WHERE M.Mine_Name LIKE '%Bojespruit%';

--Be able to add/adjust coal quantity:
UPDATE MINE
SET Coal_Quantity = (Coal_Quantity + 2000.8)
WHERE Mine_Name LIKE '%Mooikraal%';

UPDATE MINE
SET Coal_Quantity = (Coal_Quantity + 8800.9)
WHERE Mine_Name LIKE '%Twisdraai%';

UPDATE MINE
SET Coal_Quantity = (Coal_Quantity - 500)
WHERE Mine_Name LIKE '%Brandspruit%';

UPDATE MINE
SET Coal_Quantity = (Coal_Quantity + 6304.89)
WHERE Mine_Name LIKE '%Colliery%';

UPDATE MINE
SET Coal_Quantity = (Coal_Quantity + 4408.3)
WHERE Mine_Name LIKE '%Bojespruit%';

-- Managers sort A-Z by surname:
CREATE VIEW AllManagers
AS SELECT M.Manager_ID, E.Emp_FirstName AS Name, E.Emp_LastName AS Surname, E.Emp_ContactNumber AS Contact_Number, E.Emp_Address AS Address, E.Emp_Email AS Email, E.Job_Description 
   FROM MANAGER M, EMPLOYEE E
   WHERE M.Emp_ID = E.Emp_ID
   ORDER BY E.Emp_LastName ASC;

-- Which managers work at which Mine:
CREATE VIEW MooikraalManagers
AS SELECT M.Manager_ID, E.Emp_FirstName AS Name, E.Emp_LastName AS Surname, E.Emp_ContactNumber AS Contact_Number, E.Emp_Address AS Address, E.Emp_Email AS Email, E.Job_Description 
   FROM EMPLOYEE E, MANAGER M
   WHERE E.Mine_ID = '1' AND E.Emp_ID = M.Emp_ID
   ORDER BY E.Emp_LastName ASC;

CREATE VIEW TwisdraaiManagers
AS SELECT M.Manager_ID, E.Emp_FirstName AS Name, E.Emp_LastName AS Surname, E.Emp_ContactNumber AS Contact_Number, E.Emp_Address AS Address, E.Emp_Email AS Email, E.Job_Description 
   FROM EMPLOYEE E, MANAGER M
   WHERE E.Mine_ID = '2' AND E.Emp_ID = M.Emp_ID
   ORDER BY E.Emp_LastName ASC;

CREATE VIEW BrandspruitManagers
AS SELECT M.Manager_ID, E.Emp_FirstName AS Name, E.Emp_LastName AS Surname, E.Emp_ContactNumber AS Contact_Number, E.Emp_Address AS Address, E.Emp_Email AS Email, E.Job_Description 
   FROM EMPLOYEE E, MANAGER M
   WHERE E.Mine_ID = '3' AND E.Emp_ID = M.Emp_ID
   ORDER BY E.Emp_LastName ASC;

CREATE VIEW CollieryManagers
AS SELECT M.Manager_ID, E.Emp_FirstName AS Name, E.Emp_LastName AS Surname, E.Emp_ContactNumber AS Contact_Number, E.Emp_Address AS Address, E.Emp_Email AS Email, E.Job_Description 
   FROM EMPLOYEE E, MANAGER M
   WHERE E.Mine_ID = '4' AND E.Emp_ID = M.Emp_ID
   ORDER BY E.Emp_LastName ASC;

CREATE VIEW BojespruitManagers
AS SELECT M.Manager_ID, E.Emp_FirstName AS Name, E.Emp_LastName AS Surname, E.Emp_ContactNumber AS Contact_Number, E.Emp_Address AS Address, E.Emp_Email AS Email, E.Job_Description 
   FROM EMPLOYEE E, MANAGER M
   WHERE E.Mine_ID = '5' AND E.Emp_ID = M.Emp_ID
   ORDER BY E.Emp_LastName ASC;

-- Desitnation View
CREATE VIEW AllDestinations
AS SELECT * 
   FROM Destination 
   ORDER BY Dest_Name ASC;

-- Employee Views
CREATE VIEW EMPS_BY_ALPHABET
AS SELECT EMP_FIRSTNAME AS FNAME, EMP_LASTNAME AS LNAME 
   FROM EMPLOYEE
   ORDER BY EMP_FIRSTNAME;

CREATE VIEW EMPS_BY_DEPARTMENT
AS SELECT DEP_ID AS DEP, EMP_FIRSTNAME AS FNAME, EMP_LASTNAME AS LNAME 
   FROM EMPLOYEE
   ORDER BY DEP_ID;

CREATE VIEW EMPS_BY_JOB
AS SELECT EMP_FIRSTNAME AS FNAME, EMP_LASTNAME AS LNAME, EMP_CONTACTNUMBER AS EMPNUM, EMP_ADDRESS AS ADDRESS, EMP_EMAIL AS EMAIL, JOB_DESCRIPTION AS JOBDESC
   FROM EMPLOYEE
   ORDER BY JOB_DESCRIPTION;

CREATE VIEW EMPS_BY_SALARY
AS SELECT EMP_FIRSTNAME AS FNAME, EMP_LASTNAME AS LNAME, SALARY AS SALARY 
   FROM EMPLOYEE
   ORDER BY SALARY;


-- EXPORT VIEWS --
CREATE VIEW Trans_Status
AS SELECT Transporter, Transporter_Stat AS Status 
   FROM Export;

CREATE VIEW Export_Profits
AS SELECT Sales_Price AS Revenue, Export_Cost, (Sales_Price - Export_Cost) AS Profit
   FROM Export
   WHERE Sales_Price > Export_Cost;
   
CREATE VIEW Export_Losses
AS SELECT Sales_Price AS Revenue, Export_Cost, (Sales_Price - Export_Cost) AS Loss
   FROM Export
   WHERE Sales_Price < Export_Cost;

CREATE VIEW Total_Profit
AS SELECT SUM(Sales_Price - Export_Cost) AS "Total Profit" 
   FROM Export;

CREATE VIEW Total_Export_Costs
AS SELECT SUM(Export_Cost) AS "Total Costs" 
   FROM Export; 

CREATE VIEW Total_Revenue
AS SELECT SUM(Sales_Price) AS "Total Revenue" 
   FROM Export; 

CREATE VIEW Export_Destinations
AS SELECT Transporter, Dest_Name AS Destination
   FROM Export INNER JOIN Destination
   ON Destination.Dest_ID = Export.Dest_ID
   ORDER BY Transporter ASC;

CREATE VIEW Transporter_Loads
AS SELECT Transporter, Quantity AS "Quantity in Tons"
   FROM Export;

CREATE VIEW Export_Period
AS SELECT Transporter, Ship_Date AS "Shipping Date", Arrival_Date AS "Arrival Date"
   FROM Export
   WHERE Arrival_Date BETWEEN TO_DATE('2021/05/15','YYYY/MM/DD') AND  TO_DATE('2021/06/15','YYYY/MM/DD')
   ORDER BY Arrival_Date ASC;


CREATE VIEW Shippings_Per_Period
AS SELECT Transporter,Quantity, Ship_Date AS "Shipping Date", Arrival_Date AS "Arrival Date", ( SELECT COUNT(Ship_Date) FROM EXPORT) AS "Total Shippings"
   FROM Export
   WHERE Ship_Date BETWEEN TO_DATE('2021/05/01','YYYY/MM/DD') AND TO_DATE('2021/05/30','YYYY/MM/DD')
   ORDER BY Ship_Date ASC;

CREATE VIEW MINE_AVG_EXPORT
AS SELECT M.Mine_Name AS Mine, AVG(E.Quantity) AS Quantity
   FROM MINE M, EXPORT E 
   WHERE E.Mine_ID LIKE M.Mine_ID 
   GROUP BY M.Mine_Name;

CREATE VIEW MINE_TOTAL_EXPORT
AS SELECT M.Mine_Name AS Mine, SUM(E.Quantity) AS Quantity
   FROM MINE M, EXPORT E 
   WHERE E.Mine_ID LIKE M.Mine_ID 
   GROUP BY M.Mine_Name;

--Qualification Views
CREATE VIEW EMPLOYEE_QUAL
AS SELECT E.Emp_FirstName, E.Emp_LastName, QD.Name
   FROM EMPLOYEE E, QUALIFICATION_DETAIL QD, QUALIFICATION Q
   WHERE QD.Qual_ID LIKE Q.Qual_ID AND E.Emp_ID = Q.Emp_ID
   ORDER BY E.Emp_LastName ASC;

CREATE VIEW EMP_QUAL_STATS
AS SELECT QD.Name AS Qualification, COUNT(Q.Qual_ID) AS Qualified_Employees
   FROM QUALIFICATION_DETAIL QD, QUALIFICATION Q
   WHERE Q.Qual_ID LIKE QD.Qual_ID
   GROUP BY QD.Name;

-- Salary_History Views
CREATE VIEW AllSalaries
AS SELECT E.Emp_LastName AS "Last Name", E.Emp_FirstName AS "First Name", S.Amount, S.Sal_Date AS "Salary Date"
   FROM EMPLOYEE E JOIN SALARY_HISTORY S
   USING (Emp_ID)
   ORDER BY Emp_ID;

CREATE VIEW OneEmployee
AS SELECT E.Emp_LastName AS "Last Name", E.Emp_FirstName AS "First Name", S.Amount, S.Sal_Date AS "Salary Date"
   FROM EMPLOYEE E JOIN SALARY_HISTORY S
   USING (Emp_ID)
   WHERE Emp_ID = 1
   ORDER BY Sal_Date ASC;

CREATE VIEW TotalSalaries
AS SELECT COUNT(DISTINCT Sal_Date)
   FROM SALARY_HISTORY
   WHERE Amount > 30000;

CREATE VIEW SalariesByDate
AS SELECT E.Emp_LastName AS "Last Name", E.Emp_FirstName AS "First Name", S.Amount, S.Sal_Date AS "Salary Date"
   FROM EMPLOYEE E JOIN SALARY_HISTORY S
   USING (Emp_ID)
   ORDER BY Sal_Date DESC;

CREATE VIEW SalHistBetweenDates
AS SELECT E.Emp_LastName AS "Last Name", E.Emp_FirstName AS "First Name", S.Amount, S.Sal_Date AS "Salary Date"
   FROM EMPLOYEE E JOIN SALARY_HISTORY S
   USING (Emp_ID)
   WHERE S.Sal_Date BETWEEN '01-JAN-2018' AND '01-JAN-2019'
   ORDER BY S.Sal_Date;

CREATE VIEW SalHistByEmployee
AS SELECT E.Emp_LastName AS "Last Name", E.Emp_FirstName AS "First Name", S.Amount, S.Sal_Date AS "Salary Date"
   FROM EMPLOYEE E JOIN SALARY_HISTORY S
   USING (Emp_ID)
   ORDER BY Emp_LastName;

