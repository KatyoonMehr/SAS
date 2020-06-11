*IF - ELSE IF - THEN;
*WHERE;
*Grouping Observations with IF-THEN DO-END Statements;
*DO TO BY OUTPUT END;
*DO WHILE;
*DO UNTIL;
*RETAIN;
*First. and Last. Indicators;


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




DATA test;
INPUT gender $ age income @@;
CARDS;
F 26 23400 F 17 30000
F 40 45000 M 18 32000
F 25 26800 M 34 65000
F 38 44900 F 34 60000
F 56 65000 M 35 66450
M 23 38000 F 35 66450
M 28 47250 M 54 86450
M 60 68500 M 64 66450
M 22 95600 M 65 86450
M 42 42050 F 64 61000
M 39 85230 M 25 66450
RUN;


DATA new_test1;
SET test;
IF 	gender='M' THEN DO;
	IF income>=45000 THEN ind='High_M';
		ELSE ind='Low_M';
	END;
ELSE IF gender='F' THEN DO;
	IF income>=30000 THEN ind='High_F';
		ELSE ind='Low_F';
    END;
PUT _ALL_;
RUN;


DATA test;
SET test;
	IF age<=17 THEN agegrp='0-17yrs';
		ELSE IF age<=34 THEN agegrp='18-34yrs';
			ELSE IF age<=64 THEN agegrp='35-64yrs';
				ELSE IF age>=65 THEN agegrp='65+yrs';
RUN;


PROC FORMAT;
VALUE agegrp  0-17='0-17yrs'
			  18-34='18-34yrs'
			  35-64='35-64yrs'
			  65-high='65+yrs';
VALUE $gender 'F'='Female' 'M'='Male';
RUN;


DATA new_test2;
SET test;
gendernew = PUT(gender,$gender.);
agegrp = PUT(age,agegrp.);
RUN;


* Loops;
* DO / END;

DATA xx;
	DO i=1 TO 10;
			c = sqrt(i);
		OUTPUT;
	END;
RUN;
PROC PRINT DATA = xx NOOBS;
RUN;


DATA distance;
	DO miles = 1 TO 20;
			kilometers = miles * 1.61;
		OUTPUT;
	END;
RUN;
PROC PRINT DATA = distance;
RUN;


DATA table1;
	DO n = 1 TO 10;
			Square = n*n;
			SquareRoot = ROUND(SQRT(n), 0.01);
		OUTPUT;
	END;
RUN;
TITLE "Table of SQ & SQRT";
PROC PRINT DATA = table1 NOOBS;
RUN;

DATA CtoF_1;
	c=1;
	DO WHILE (c<=50);
			F = ROUND ((9/5 * c + 32), 0.1);
		OUTPUT;
		c + 2;	
	END;
RUN; 

DATA CtoF_2;
	c=1;
	DO UNTIL (c>50);
			F = ROUND ((9/5 * c + 32), 0.1);
		OUTPUT;
		c + 2;
	END;
RUN; 


DATA A;
y = 0;
DO i = 1 TO 5 BY 0.5 WHILE (y < 20);
   y = i**2; 
   OUTPUT;
END;
RUN;


*Retain and sum;

DATA profits;
INPUT month profit;
DATALINES;
 1 12451
 2 54325
 3 43514
 4 13455
 5 45161
 6 54151
 7 54261
 8 43251
 9 43515
 10 83711
 11 45236
 12 54361
 RUN;

DATA cumul_profits1;
SET profits;
cumulative_profit = SUM(profit,cumulative_profit);
RETAIN cumulative_profit;
RUN;

*Or;
DATA cumul_profits1;
SET profits;
RETAIN cumulative_profit;
cumulative_profit = SUM(profit,cumulative_profit);
RUN;

*Or;
DATA cumul_profits2;
SET profits;
cum_prof + profit;
RUN;

/* To use + instead of SUM we should use IF */

PROC SORT DATA = profits;
BY profit;
RUN;

DATA cumul_profits3;
SET profits;
BY profit;
FIRST_NEW=FIRST.PROFIT;
*RETAIN com_prof;
*IF first.profit THEN cum_prof = profit;
*ELSE cum_prof = cum_prof + profit;
RUN;


*First. and Last. Indicators;

DATA prdsale_cdn_sofa;
SET sashelp.prdsale;
WHERE country = 'CANADA' AND product = 'SOFA';
DROP region division prodtype predict quarter;
RUN;
PROC SORT DATA = prdsale_cdn_sofa;
BY month actual;
RUN; 
DATA first_last;
SET prdsale_cdn_sofa;
BY month;
 
IF first.month = 1 THEN month_order = 'FIRST';
IF last.month = 1 THEN month_order = 'LAST';
 
RUN;

DATA first_last;
SET prdsale_cdn_sofa;
BY month;
 
IF first.month = 1 THEN month_order = 'FIRST';
	ELSE IF Last.month = 1 THEN month_order = 'LAST';
 		ELSE month_order = 'OTHER';
 
RUN;
 
DATA prdsale_cdn_sofa_noretain;
SET prdsale_cdn_sofa;
BY month;
 
RETAIN cumulative_actual;

IF first.month THEN cumulative_actual = actual;
	ELSE cumulative_actual = cumulative_actual + actual;
 
RUN;
