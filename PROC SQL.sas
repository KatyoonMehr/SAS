/* PROC SQL 
SELECT FROM AS 
WHERE CALCULATED (if the condition is on the calculated variable) 
CASE WHEN THEN WHEN THEN ELSE END (is like IF, ELSE IF and ELSE)*
COALESCE (replaces a missing with a defined value)*/

DATA CARS;
SET sashelp.cars;
RUN;
PROC PRINT; RUN;
/*Or*/
PROC SQL;
SELECT * FROM sashelp.cars;
QUIT;

PROC PRINT DATA = CARS;
VAR Make Model Origin Type;
RUN;
/*Or*/
PROC SQL;
SELECT Make, Model, Origin, Type FROM sashelp.cars;
QUIT;

PROC SQL;
CREATE TABLE cars AS
SELECT model, type, origin, invoice, msrp
FROM sashelp.cars;
QUIT;

PROC SORT DATA = sashelp.cars (KEEP = type) OUT=cars_sorted NODUPKEY;
BY type;
RUN;
/*Or*/
PROC SQL;
SELECT DISTINCT type FROM sashelp.cars;
QUIT;

DATA test(KEEP = type make difference);
SET sashelp.cars;
		difference = msrp - invoice;
RUN;
/*Or*/
PROC SQL;
SELECT type, make, msrp-invoice AS difference FROM sashelp.cars;
QUIT;

PROC SQL;
SELECT (msrp-invoice) AS difference FROM sashelp.cars
WHERE CALCULATED difference>=5000;
QUIT;

PROC SQL;
SELECT * FROM sashelp.cars
WHERE origin="Europe";
QUIT;

PROC SQL;
SELECT * FROM sashelp.cars
WHERE origin NOT IN ("Europe", "Asia");
QUIT;

PROC SQL;
SELECT origin FROM sashelp.cars
WHERE origin LIKE ('E%');
QUIT;

PROC SQL;
SELECT origin FROM sashelp.cars
WHERE origin LIKE ('_A%');
QUIT;

PROC SQL;
SELECT model FROM sashelp.cars
WHERE  model CONTAINS ("LX");
QUIT;

PROC SQL;
SELECT model FROM sashelp.cars
WHERE  model CONTAINS("4dr");
QUIT;


DATA HORSE_POWER;
LENGTH HORSE_POWER $12;
SET SASHELP.CARS;
    IF ENGINESIZE<=2 THEN HORSE_POWER="LOW";
  	ELSE IF 2<ENGINESIZE<=3 THEN HORSE_POWER="INTERMEDIATE";
    ELSE HORSE_POWER="HIGH";
RUN;
PROC PRINT DATA=HORSE_POWER;
VAR type make ENGINESIZE HORSE_POWER;
RUN;
/*Or*/
PROC SQL;
SELECT enginesize, make, type,
CASE
	WHEN  enginesize<=2   THEN "LOW"
	WHEN 2<enginesize<=3  THEN "INTERMEDIATE"
	ELSE                       "HIGH"
	END "HORSE_POWER"
FROM sashelp.cars;
QUIT;

PROC SQL;
SELECT COUNT(type) AS count
FROM sashelp.cars;
QUIT;

PROC SQL;
SELECT COUNT(DISTINCT type) AS count_type
FROM sashelp.cars;
QUIT;

PROC SQL;
SELECT DISTINCT type
FROM sashelp.cars;
QUIT;

PROC SQL;
SELECT type, SUM(invoice)AS total_amt_by_type format=dollar12.,
             MEAN(invoice)AS avg_amt_by_type format=dollar12.,
			 N(invoice)AS num_cars_by_type
FROM sashelp.cars
GROUP BY type;
QUIT;

PROC SQL;
SELECT * FROM sashelp.cars
GROUP BY type
ORDER BY type;
QUIT;

PROC SQL;
SELECT origin, type, sum(invoice) AS total_amt
FROM sashelp.cars
GROUP BY origin, type
ORDER BY origin DESC, type DESC;
QUIT;
*----------------------------------;


DATA example;
INPUT id $ gender $ price @@;
  tax=round(price*0.13, 0.1);
DATALINES;
001 M 218.30 002 F 663.5
003 F .      004 M 107.40
005 F 586.50 006 M .
007 M 463.20 008 F 185.00
009 M 682.30 010 M 3362.00
;
RUN;
PROC PRINT DATA = example;
RUN;
/*Or*/
PROC SQL;
SELECT id, COALESCE(price,AVG(price)) AS n_price, COALESCE(tax, AVG(tax)) AS n_tax
FROM example;
QUIT;

/* coalesce returns the first nonmissing value from a list of numeric arguments. */

DATA example1;
SET example;
IF gender ^='M' THEN gender='   ';
ELSE                gender=gender;
RUN;
PROC PRINT DATA = example1;
RUN;
/*Or*/
PROC SQL;
SELECT *, 
CASE 
	WHEN gender~='M' THEN ''
	ELSE gender
END 'gender_n'
FROM example;
QUIT;

PROC SQL;
SELECT id, (price*0.13) AS tax FORMAT=dollar8.2 LABEL="TAX_AMOUNT",
       price+(price*0.13) AS total_amt FORMAT=dollar8.2 LABEL="TOTAL_AMOUNT"
FROM example;
QUIT;

PROC SQL;
DESCRIBE TABLE example1;
QUIT;

PROC SQL;
SELECT * FROM example
WHERE price IS MISSING;
QUIT;

PROC SQL;
SELECT * FROM example
WHERE price IS NULL;
QUIT;

PROC SQL;
SELECT SUM(price, tax) AS total_amt
FROM example;
QUIT;

PROC SQL;
SELECT SUM(price, tax) AS total_amt
FROM example
WHERE CALCULATED total_amt > 500
ORDER BY CALCULATED total_amt;
QUIT;

PROC SQL;
SELECT SUM(price, tax, 0) AS total_amt
FROM example
HAVING CALCULATED total_amt>500
ORDER BY CALCULATED total_amt;
QUIT;
*----------------------------------;


DATA temperature;
INPUT city $1-10 
      @13 low_temp 
	  @21 high_temp 
	  @29 range;
CARDS;
Amsterdam   32.2    7.2     25
Algiers     21.1    0.6     20.6
Athens      31.7    5.0     26.7
Auckland    23.9    6.7     17.2
Bangkok     35      20.6    14.4
;
RUN;
PROC PRINT; RUN;

PROC SQL;
SELECT *, MEAN(low_temp, high_temp) AS avg_temp FROM temperature;
QUIT;

PROC SQL;
SELECT *, MEAN(low_temp, high_temp) AS avg_temp FROM temperature
WHERE CALCULATED avg_temp < 18;
QUIT;

PROC SQL;
SELECT *, MEAN(low_temp, high_temp) AS avg_temp FROM temperature
WHERE CALCULATED avg_temp < 18
ORDER BY CALCULATED avg_temp DESC;
QUIT;
*----------------------------------;

DATA country_population;
INPUT name $ Population area ;
CARDS;
Afghanistan 17070323 251825    
Albania 3407400 11100   
Algeria 28171132 919595    
Andorra 64634 200   
Angola 9901050 481300    
Antigua 65644 171   
Argentina 34248705 1073518    
Armenia 3556864 11500   
Australia 18255944 2966200     
Austria 8033746 32400  
;
RUN;

PROC SQL;   
TITLE 'Densities of Countries';
CREATE TABLE densities AS
SELECT Name 'Country' FORMAT $15.,
       Population FORMAT=comma10.0,
       Area 'SquareMiles',
       Population/Area FORMAT=6.2 AS Density
       FROM country_population;
QUIT;
PROC SQL;
SELECT * FROM densities;
QUIT;

PROC SQL; 
TITLE 'Densities of Countries';
CREATE VIEW V_densities AS
SELECT Name 'Country' FORMAT $15.,
       Population FORMAT=comma10.0,
       Area 'SquareMiles',
       Population/Area FORMAT=6.2 AS Density
       FROM country_population;
QUIT;
PROC SQL;
SELECT * FROM V_densities;
QUIT;
*----------------------------------;


DATA population;
INPUT name $ population;
CARDS;
     China         1202215077         
     India         929009120         
     USA           263294808         
     Indonesia     202393859         
     Brazil        160310357         
     Russia        151089979         
     Bangladesh    126387850         
     Japan         126345434         
     Pakistan      123062252         
     Nigeria       99062003         
     Mexico        93114708         
     Germany       81890690         
;
RUN;

PROC SQL;
TITLE 'Largest Country Populations'; 
SELECT Name, Population FORMAT=comma20.,
        MAX(Population) AS MaxPopulation FORMAT=comma20. 
FROM population  
ORDER BY Population DESC;
QUIT;


DATA us_city;
INPUT city $ state $ latitude longitude;
CARDS;
Albany      NY 43 -74
Albuquerque NM 36 -106
Amarillo    TX 35 -102
Anchorage   AK 61 -150
Annapolis   MD 39 -77
Atlanta     GA 34 84
Augusta     ME 44 -70
Austin      TX 30 -98
Baker       OR 45 -118
Baltimore   MD 39 -76
Bangor      ME 45 -69
Baton       LA 31 -91
;
RUN;


DATA one;
INPUT x y;
CARDS;
1 5
2 10
3 20
4 40
5 80
6 75
;
RUN;

DATA two;
INPUT x z;
CARDS;
2 100
6 200
8 300
9 500
;
RUN;

/* Inner Join */
PROC SQL;
CREATE TABLE three_1 AS
SELECT * FROM one a, two b
WHERE a.x = b.x;
QUIT;
PROC PRINT DATA = three_1; 
RUN;
/*Or*/
PROC SQL;
CREATE TABLE three_2 AS
SELECT * FROM one a
	INNER JOIN two b
		ON a.x = b.x;
QUIT;
PROC PRINT DATA = three_2; 
RUN;

/* Left Outer Join */
PROC SQL;
CREATE TABLE three_3 AS
SELECT * FROM one 
	LEFT JOIN two
		ON one.x=two.x;
QUIT;
PROC PRINT DATA = three_3; 
RUN;

/* Right Outer Join */
PROC SQL;
CREATE TABLE three_4 AS
SELECT two.x, y, z FROM one 
	RIGHT JOIN two
		ON one.x=two.x;
QUIT;
PROC PRINT DATA = three_4; 
RUN;

/* Full Outer Join */
PROC SQL;
CREATE TABLE three_5 AS
SELECT * FROM one , two;
QUIT;
PROC PRINT DATA = three_5; 
RUN;


/* Problem: The tables PAYROLL2 AND STAFF2 contains data on employees with changes 
in job code or salary and data on new employees. A report is needed in 
displaying all information only on new employees as shown below: 
IDNUM FNAME LNAME STATE JOBCODE HIRED
To produce this report, break the problem into several steps:
Find the IDNUM values of new employees. “old” employee ID’s stored in 
the STAFF table. The STAFF2 table contains the ID’s of “old” employees 
with status changes plus the ID’s of the new employees.
In a separate query, display information about all employees in 
the STAFF2 and PAYROLL2 tables. For each employee, 
display the variables IDNUM, FNAME, LNAME, AND STATE from STAFF2 table 
with the variables JOBCODE AND HIRED from the PAYROLL2 table.
Combine the 2 queries in Part a. and b. so that the results of 
the second query (displaying all employees) is subset to display 
only employees returned from the first query.
Create a report displaying employees who have changed job codes 
(column JOBCODE in the table PAYROLL differs from the same column in 
the table PAYROLL2). You may use skills acquired in earlier sections. 
Output includes the following variables:
IDNUM FNAME LNAME OLD_JOB_CODE NEW_JOB_CODE */

LIBNAME SS "C:\Users\Rayan\Desktop\Kati\Data Science\SASFile\SAS_2";

DATA ss.Staff;
INFILE "C:\Users\Rayan\Desktop\Kati\Data Science\SASFile\SAS_2\Staff.csv" DLM=',' FIRSTOBS=2;
INPUT IDNUM FNAME $ LNAME $ STATE $ JOBCODE HIRED DDMMYY10.;
RUN;
PROC PRINT DATA = ss.Staff;
FORMAT Hired DDMMYY10.;
RUN;

DATA ss.Staff2;
INFILE "C:\Users\Rayan\Desktop\Kati\Data Science\SASFile\SAS_2\Staff2.csv" DLM=',' FIRSTOBS=2;
INPUT IDNUM FNAME $ LNAME $ STATE $ JOBCODE HIRED DDMMYY10.;
RUN;
PROC PRINT DATA = ss.Staff2;
FORMAT Hired DDMMYY10.;
RUN;
PROC SQL;
SELECT * FROM ss.Staff;
QUIT;

/* IDNUM for New Employees*/
PROC SQL;
SELECT idnum FROM ss.staff2
	WHERE idnum NOT IN 
  		(SELECT idnum FROM ss.staff);
QUIT;
/*Or*/
PROC SQL;
SELECT idnum FROM ss.staff2
	EXCEPT ALL
		SELECT idnum FROM ss.staff;
QUIT;

/* existing and change job title */
PROC SQL;
SELECT DISTINCT b.idnum
FROM ss.staff2 b, ss.staff a
WHERE a.idnum = b.idnum;
QUIT;
/*Or*/
PROC SQL;
SELECT DISTINCT b.idnum FROM ss.staff2 b
	INNER JOIN ss.staff a
		ON a.idnum = b.idnum;
QUIT;

/* New and changed job old emp */
PROC SQL;
SELECT a.idnum, b.fname, b.lname, b.state, a.jobcode, a.hired
FROM ss.payroll2 a, ss.staff2 b
	WHERE a.idnum = b.idnum;
QUIT;

/* New only */
PROC SQL;
SELECT a.idnum, fname, lname, state, jobcode, hired
FROM ss.payroll2 a, ss.staff2 b
	WHERE a.idnum=b.idnum AND
        a.idnum IN 
		(SELECT idnum
		 FROM ss.staff2
		 EXCEPT ALL
		 SELECT idnum
		 FROM ss.staff);
QUIT;

PROC SQL;
SELECT a.idnum, fname, lname, state, jobcode, hired
FROM ss.staff2 a, ss.payroll2 b
	WHERE a.idnum=b.idnum AND
        a.idnum not IN
		(SELECT idnum FROM ss.staff);
QUIT;

/* All employees */
PROC SQL;
SELECT a.idnum, fname, lname, state, jobcode, salary
FROM ss.payroll2 a, ss.staff2 b
	WHERE a.idnum=b.idnum 
  	UNION
  		SELECT c.idnum, fname, lname, state, jobcode, salary
  		FROM ss.payroll c, ss.staff d
  			WHERE c.idnum=d.idnum AND
        		c.idnum not IN
				(SELECT idnum FROM sl.payroll2)
ORDER BY 1; /*Sort by first column*/
QUIT;

/* Existing employees who just changed job code */
PROC SQL;
SELECT a.idnum, b.fname, b.lname,
         						a.jobcode LABEL="old job code",
		 						c.jobcode LABEL="new job code"
FROM ss.payroll a, ss.staff b, ss.payroll2 c
	WHERE a.idnum = b.idnum AND a.idnum = c.idnum AND a.jobcode ^= c.jobcode;
QUIT;









