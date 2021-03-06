CREATE TABLE Department (
    Dep_ID NUMBER(10) CONSTRAINT PK_DEPARTMENT PRIMARY KEY,
    Dep_Name VARCHAR(50) NOT NULL,
    Dep_ContactNumber VARCHAR(12) NOT NULL,
    CONSTRAINT UNIQUE_DEP_CONT_NUM UNIQUE(Dep_ContactNumber),
    CONSTRAINT CHECK_PHONE CHECK (LENGTH(Dep_ContactNumber) = 12 AND Dep_ContactNumber LIKE '+27%') 
);

CREATE TABLE Shift (
    Shift_ID NUMBER(10) CONSTRAINT PK_SHIFT PRIMARY KEY,
    Shift_Description VARCHAR(50) NOT NULL,
    Shift_Start DATE NOT NULL,
    Shift_End DATE NOT NULL,
    CONSTRAINT VALID_SHIFTS CHECK (Shift_End > Shift_Start)
);

CREATE TABLE Mine (
    Mine_ID NUMBER(10) CONSTRAINT PK_MINE PRIMARY KEY, 
    Mine_Name VARCHAR(50) NOT NULL,
    Location VARCHAR(120) NOT NULL, 
    Contact_Num VARCHAR(12)  NOT NULL,
    Coal_Quantity BINARY_FLOAT NOT NULL,
    CONSTRAINT UNIQUE_MINE_NAME UNIQUE(Mine_Name),
    CONSTRAINT UNIQUE_MINE_CONT_NUM UNIQUE(Contact_Num),
    CONSTRAINT CHECK_MINENUM CHECK (LENGTH(Contact_Num) = 12 AND Contact_Num LIKE '+27%'),
    CONSTRAINT CHECK_QUANTITY CHECK (Coal_Quantity >= 0) 
);

CREATE TABLE Qualification_Detail (
    Qual_ID NUMBER(10) CONSTRAINT PK_QUALDETAIL PRIMARY KEY,
    Name VARCHAR(50),
    Description VARCHAR(50) NOT NULL
);

CREATE TABLE Destination (
    Dest_ID NUMBER(10) CONSTRAINT PK_DESTINATION PRIMARY KEY,
    Dest_Name VARCHAR(50) NOT NULL,
    Dest_Location VARCHAR(120) NOT NULL
);

CREATE TABLE Employee (
    Emp_ID NUMBER(10) CONSTRAINT PK_EMPLOYEE PRIMARY KEY,  
    Dep_ID NUMBER(10) NOT NULL, 
    Shift_ID NUMBER(10) NOT NULL,
    Mine_ID  NUMBER(10) NOT NULL,
    Salary BINARY_FLOAT NOT NULL,      
    Emp_FirstName VARCHAR(50) NOT NULL,   
    Emp_LastName VARCHAR(50) NOT NULL,      
    Emp_ContactNumber VARCHAR(12) NOT NULL,
    Emp_Address VARCHAR(100) NOT NULL,     
    Emp_Email  VARCHAR(100) NOT NULL,      
    Job_Description VARCHAR(50) NOT NULL,
    CONSTRAINT UNIQUE_EMP_CONT_NUM UNIQUE(Emp_ContactNumber),
    CONSTRAINT UNIQUE_EMP_EMAIL UNIQUE(Emp_Email),
    CONSTRAINT CHECK_SAL CHECK (Salary >= 15000),
    CONSTRAINT CHECK_PHONENUM CHECK (LENGTH(Emp_ContactNumber) = 12 AND Emp_ContactNumber LIKE '+27%'),
    CONSTRAINT CHECK_EMAIL CHECK (Emp_Email LIKE '%@gmail%' OR Emp_Email LIKE '%@hotmail%'  AND Emp_Email LIKE '%.com'),
    CONSTRAINT FK_DEPARTMENT FOREIGN KEY (Dep_ID) REFERENCES Department(Dep_ID),
    CONSTRAINT FK_SHIFT FOREIGN KEY (Shift_ID) REFERENCES Shift(Shift_ID),
    CONSTRAINT FK_MINE FOREIGN KEY (Mine_ID) REFERENCES Mine(Mine_ID)
);

CREATE TABLE Export (
    Export_ID NUMBER(10) CONSTRAINT PK_EXPORT PRIMARY KEY, 
    Quantity BINARY_FLOAT NOT NULL,    
    Transporter VARCHAR(50) NOT NULL,  
    Transporter_Stat CHAR(1) NOT NULL,
    Ship_Date DATE NOT NULL,    
    Arrival_Date DATE NOT NULL, 
    Sales_Price BINARY_FLOAT NOT NULL,
    Export_Cost BINARY_FLOAT NOT NULL, 
    Dest_ID NUMBER(10) NOT NULL,
    Mine_ID NUMBER(10) NOT NULL,
    CONSTRAINT CHECK_COAL CHECK (Quantity >= 1000 AND Quantity <= 120000),
    CONSTRAINT CHECK_STATUS CHECK (Transporter_Stat = 'A' OR Transporter_Stat = 'I'),
    CONSTRAINT CHECK_EXPORTS CHECK (Arrival_Date >= Ship_Date),
    CONSTRAINT FK_DESTINATION FOREIGN KEY (Dest_ID) REFERENCES Destination(Dest_ID),
    CONSTRAINT FK_MINING FOREIGN KEY (Mine_ID) REFERENCES Mine(Mine_ID),
    CONSTRAINT VALID_EXPORTS CHECK (Ship_Date <= Arrival_Date)
);

CREATE TABLE Manager (
    Manager_ID NUMBER(10) CONSTRAINT PK_MANAGER PRIMARY KEY, 
    Emp_ID NUMBER(10) NOT NULL,
    CONSTRAINT UNIQUE_EMP_ID UNIQUE(Emp_ID),
    CONSTRAINT FK_MANAGER FOREIGN KEY (Emp_ID) REFERENCES Employee(Emp_ID)
);

CREATE TABLE Qualification (
    Qual_ID NUMBER(10) REFERENCES Qualification_Detail(Qual_ID),
    Emp_ID NUMBER(10) REFERENCES Employee(Emp_ID),
    Qualification_Num VARCHAR(10) NOT NULL,
    CONSTRAINT UNIQUE_QUAL_NUM UNIQUE(Qualification_Num),
    CONSTRAINT CHECK_QUALNUM CHECK (LENGTH(Qualification_Num) = 10),
    CONSTRAINT PK_QUALIFICATION PRIMARY KEY (Qual_ID,Emp_ID)
);

CREATE TABLE Salary_History (
    Emp_ID 	NUMBER(10) REFERENCES Employee(Emp_ID),
    Sal_Date DATE NOT NULL,
    Amount 	BINARY_FLOAT CHECK (Amount >= 3904.20) NOT NULL,
    CONSTRAINT PK_SALHISTORY PRIMARY KEY (Emp_ID, Sal_Date)
);
