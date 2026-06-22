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


-- create a view [patient_admission] by joining patient and admission table along with datepart and case functions --
CREATE view [dbo].[patient_admission] as  (  
select admission_id,a.patient_id,triage_timestamp,acuity_level,department,discharge_timestamp,gender,age,insurance_provider ,  
DATEDIFF(hour,a.triage_timestamp,a.discharge_timestamp) length_of_stay_hours,  
case when age between 0 and 18 then '0-18'  
 when age between 19 and 35 then '19-35'  
 when age between 36 and 55 then '36-55'  
 when age between 56 and 75 then '56-75'  
 else '76+'  
end as 'Age Group' ,  
DATEPART(year,triage_timestamp) admission_year ,  
DATEPART(month,triage_timestamp) admission_month,  
DATENAME(weekday,triage_timestamp) admission_day_name  
from admission a inner join patients p   
on a.patient_id = p.patient_id  )  

-- create a final view by joining CTE and current view --

create view patient_admission_final   
as    
  
 with cte_1 as (  
 select admission_id, patient_id,triage_timestamp,  
 LEAD(triage_timestamp) over( partition by patient_id order by triage_timestamp) next_admission_date  
 from patient_admission  
 ) , cte_2 as (  
 select *,   
 DATEDIFF(day,triage_timestamp,next_admission_date) days_readmitted   
 from cte_1   
 ), cte_3 as (  
 select *,  
 case when days_readmitted < 180 then 1  
 else 0   
 end as readmitted_180_days  
 from cte_2 )  
 select p.*,r.readmitted_180_days from cte_3 r inner join   
 patient_admission p  
 on p.admission_id = r.admission_id















