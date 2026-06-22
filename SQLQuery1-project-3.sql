-- create HealthcareOperations DATABASE ---
CREATE DATABASE HealthcareOperations ; 
USE HealthcareOperations;

--- create 3 tables (patients, staffing_log and admission )  ---

CREATE TABLE patients ( 
patient_id VARCHAR (10) PRIMARY KEY ,
gender CHAR(1) ,
age INT,
insurance_provider VARCHAR (50) );

CREATE TABLE staffing_log (
shift_date	DATE ,
shift_type	VARCHAR(10) ,
scheduled_nurses INT ,
scheduled_doctors INT,
actual_patient_count INT ,
-- composite PRIMARY KEY as shift_date is same for day and night shift -- 
PRIMARY KEY ( shift_date,shift_type ) );

CREATE TABLE admission (
admission_id VARCHAR(10) PRIMARY KEY ,
patient_id	VARCHAR(10) FOREIGN KEY REFERENCES patients(patient_id),
triage_timestamp DATETIME ,
acuity_level	INT ,
department	VARCHAR (30) ,
discharge_timestamp	 DATETIME ,
readmitted_30_days INT  ) ;

SELECT * FROM patients;
SELECT * FROM patients_temp;

INSERT INTO patients 
select * from patients_temp 
drop table patients_temp

insert into  staffing_log
select * from [dbo].[staffing_log_temp] order  by shift_date

SELECT * FROM admission;











