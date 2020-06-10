
/* IF - ELSE IF - THEN */
/* WHERE */

DATA empdat;
INPUT  empid empname $ salary dept $ DOJ DATE9.;
IF dept ='IT';  *Just the employees of IT departement will be saved;
* IF Salary > 700;
LABEL ID = 'Employee ID';
FORMAT DOJ DATE9.;
DATALINES;
1 Rick 623.3 IT 02APR2001
2 Dan 515.2 OPS 11JUL2012
3 Mike 611.5 IT 21OCT2000
4 Ryan 729.1 HR 30JUL2012
5 Gary 843.2 FIN 06AUG2000
6 Tusar 578.6 IT 01MAR2009
7 Pranab 632.8 OPS 16AUG1998
8 Rasmi 722.5 FIN 13SEP2014
9 Rahman 822.5 IT
;
RUN;


Data empdat1;
SET empdat;
IF salary < 600 THEN salary_range = "LOW";
ELSE IF 600 <= salary <= 700 THEN salary_range = "MEDIUM";
ELSE IF 700 < salary THEN salary_range = "HIGH";
RUN;


DATA _NULL_;
race = 'Asian';
age  = 70;
gender = 'Male';
IF race NOT IN ('White' , 'Black') THEN PUT 'Not here';
IF age < 80 THEN PUT 'out of range';

/* The IF clause after this won't work */
* IF age NOT BETWEEN 20 AND 60 THEN PUT 'out of range';
* IF gender IS NOT missing THEN PUT 'available';
* IF gender CONTAINS 'M' THEN PUT 'Yes';
RUN;


/* So we need to use WHERE Clause instead of IF to get the subsets */
DATA empdat2;
SET empdat;
* WHERE salary BETWEEN 600 AND 700;
* WHERE DOJ IS NULL;
* WHERE empname IS NOT missing;
* WHERE empname LIKE 'R%';
* WHERE empname CONTAINS 'ar';
RUN;


DATA acura;
SET sashelp.cars(WHERE = (make='Acura'));
RUN;
  
* Or;
DATA acura;
SET sashelp.cars;
IF make = 'Acura';
RUN;

* Or;
DATA acura;
SET sashelp.cars;
WHERE make = 'Acura';
RUN;



DATA _NULL_;
* LENGTH Result $8; 
* The length comes from 'Yes' in the first Then action.;
IF 'james' in ('jame', 'john', 'jerry') THEN result = "Yes";
	ELSE result = "Nooooooooooooooooooo";
PUT Result=;
RUN;


DATA _NULL_;
  status = 'OK'; 
  type = 3;
  count = 10;
  
IF status='OK' AND type=3 THEN count+1;
PUT (result count) (=);
PUT 'End';
RUN;


DATA _NULL_;
age = 25;
gender = 'F';
IF age<=20 AND (gender='F' or age>20) AND gender='F' THEN out1 = 'Yes';
   ELSE out1 = 'No';
PUT out1=;
RUN;


DATA _NULL_;
age = 25;
gender = 'F';
IF age<=20 AND gender='F' or age>20 AND gender='F' THEN out1 = 'Yes';
   ELSE out1='No';
PUT out1=;
RUN;


DATA _NULL_;
age = 45;
IF 40 < age <= 50 THEN agegroup=1;
ELSE IF 50 < age <= 60 THEN agegroup=2;
ELSE IF age > 60 THEN agegroup=3;
PUT agegroup=;
RUN;


DATA _NULL_;
score = 85;
IF score > 80 THEN DO;
	PUT SCORE=;
PUT 'Good job'; 
	PUT 'well done'; 
END;
ELSE IF Score <= 80 THEN DO;
	PUT SCORE=;
	PUT "Haha it's a Joke!";
END; 
RUN;

