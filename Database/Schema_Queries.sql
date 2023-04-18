create database instahyre;
use instahyre;
SELECT CURRENT_USER();
DROP TABLE Company;
CREATE TABLE Company(
  CompanyID varchar(20) primary key,
  Name VARCHAR(1000),
  estab_year INTEGER,
  Employees_Count VARCHAR(1000)
);
ALTER TABLE Company
MODIFY Employees_Count INTEGER;

DROP TABLE Details;
CREATE TABLE Details(
  DetailsID varchar(20)  primary key,
  Involvement VARCHAR(100) DEFAULT 'Full-time',
  Skills varchar(1000),
  hrName varchar(1000),
  Yr_exper VARCHAR(1000),
  Standard_Experience VARCHAR(1000)
);

DROP TABLE Jobs;
CREATE TABLE Jobs
(
  Job_Id varchar(20) primary key,
  Company_id varchar(20),
  Location VARCHAR(1000),
  Designation  VARCHAR(1000),
  Details_ID varchar(20),
  FOREIGN KEY (Company_ID) REFERENCES Company(CompanyID),
  FOREIGN KEY (Details_ID) REFERENCES Details(DetailsID)
);

DROP TABLE COM_LOC;
CREATE TABLE COM_LOC(
  ID int AUTO_INCREMENT Primary Key, 
  Company_ID VARCHAR(100),
  Name VARCHAR(100),
  Location VARCHAR(100)
);

DROP TABLE DEL_SKILLS;
CREATE TABLE DEL_SKILLS(
  ID int auto_increment PRIMARY KEY,
  Details_ID VARCHAR(100),
  Skills VARCHAR(100)
);
DROP TABLE Standard_Designation;
CREATE TABLE Standard_Designation
(
   Role VARCHAR(255) PRIMARY KEY,
   Standard_Role VARCHAR(255)
);

CREATE VIEW LocationVSOpening AS 
Select TRIM(CL.Location) as Location,COUNT(Job_ID) as Opening
FROM COM_LOC CL JOIN Company C ON CL.Company_ID=C.CompanyID JOIN Jobs J on J.Company_ID=C.CompanyID
group by TRIM(Location);


DROP VIEW IF EXISTS ALL_Details;

CREATE VIEW All_Details as 
Select C.CompanyID,C.Name,estab_year,Employees_Count,J.Job_ID,TRIM(CL.Location) as Location ,hrName,Yr_exper,Standard_Experience,DS.Details_ID,DS.Skills,SD.Role,SD.Standard_Role
FROM Company C JOin COM_LOC CL on C.CompanyID=CL.Company_ID JOIN Jobs J on J.Company_id=C.CompanyID 
JOIN Details D on D.DetailsID=J.Details_ID JOIN DEL_SKILLS DS ON DS.Details_ID=D.DetailsID JOIN Standard_Designation SD on TRIM(SD.Role)=TRIM(J.Designation)


