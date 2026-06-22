-- Answering Business questions -- 
-- 1) How many admissions occurred in each department?  --
select department , COUNT(admission_id) admissions from patient_admission_final  group by department ; 

-- 2)  What is the monthly trend of admissions?  -- 
select admission_year,admission_month, count(admission_id) admission from patient_admission_final  group by admission_year,admission_month
order by admission_year,admission_month ;

-- 3) Which day of the week has the highest number of admissions? -- 
select top 1 admission_day_name,count(admission_id) admissions from patient_admission_final group by admission_day_name order by count(admission_id) desc ;

-- 4) Which age group has the highest number of admissions? -- 
select top 1 [Age Group],count(admission_id) admissions from  patient_admission_final group by [Age Group] order by count(admission_id) desc

-- 5) What is the gender distribution of admitted patients ?
select gender, count(admission_id) admissions from patient_admission_final  group by gender 

-- 6) What is the average length of stay by department? --
select department, cast(avg(cast( length_of_stay_hours as float )) as decimal (4,2) ) avg_length_of_stay from patient_admission_final 
group by department ;

-- 7) How many patients were admitted more than once? --
select count(*) admitted_more_than_once from patient_admission_final where readmitted_180_days = 1

-- 8) What is the average patient-to-nurse ratio by shift? -- 
select shift_type, cast(avg(cast(actual_patient_count as float)/cast(scheduled_nurses as float)) as decimal(4,2) )  from staffing_log group by shift_type

-- 9) What is the average patient-to-doctor ratio by shift? -- 
select shift_type, cast(avg(cast(actual_patient_count as float)/cast(scheduled_doctors as float)) as decimal(4,2) )  from staffing_log group by shift_type

-- 10)  Which insurance provider has the highest readmission rate?
select insurance_provider,count(readmitted_180_days) count_of_readmission  from patient_admission_final where readmitted_180_days=1  
group by insurance_provider order by count(readmitted_180_days) desc







