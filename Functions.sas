*Functions
- SUM(OF )
- N
- NMISS
- MEAN
- ROUND
- INT
- CEIL (Returns the smallest integer that is greater than or equal to the argument)
- FLOOR (Returns the largest integer that is less than or equal to the argument)
- UPCASE
- LOWCASE
- PROPCASE
- LEFT 
- RIGHT
- SUBSTR
- SCAN (Extracts words within a value that is marked by delimiters)
- COMPBL (Removes extra spaces just keeps one blank in between)
- COMPRESS (Removes all the spaces)
- TRIM (Removes space from the end)
- STRIP (Removes space from the begining and end)

- TODAY()
- MDY (Converts MONTH, DAY, and YEAR values to a SAS date value)
- YRDIF (Returns the difference in years between two dates)
- Contant time: "date"D, "time"T, "datetime"DT
- YEAR
- QTR
- MONTH
- DAY
- WEEKDAY
- INTCK (Returns the number of time units between two dates) 
- INTNX (Returns a SAS date value by adding a specific number of increments to an initial start date)



DATA _NULL_; *data value;
x = MDY(10,19,1999);
PUT x=;
RUN;


*Numeric Functions;
DATA _NULL_;
x = 9.1; 
y = 6; 
z = SQRT(x**2 + y**2);
PUT z=;           /* display variable and value */
PUT (x y z) (=);
RUN;


DATA _NULL_;
x1 =  55;
x2 = 35;
x3 = 6;
x4 = SUM(OF x1-x3, 5);
PUT x4=;
RUN;


DATA _NULL_;
x1=5; x2=6; x3=4; x4=9;
y1=34; y2=12; y3=74; y4=39;
result = SUM(OF x1-x4, OF y1-y5);
PUT result=;
PUT (x1 x2 x3 x4 y1 y2 y3 y4 y5)(=);
RUN;


DATA _NULL_;
y1=20;
y2=30;
x6=SUM(OF y:);
PUT x6=;
RUN;


*mean, min, max, median;
DATA _NULL_;
x1=55;
x2=35;
x3=6;
x4=.;
count = N(OF x1-x4, 5);
missore = NMISS(OF x1-x4, 5);
meanscore = MEAN(OF x1-x4, 5);
average1 = ROUND(meanscore,.1);
average2 = INT(meanscore);
PUT _ALL_;
RUN;


DATA _NULL_;
x1=55/6;
x2=37/3;
x3=7/8;
roundx1 = ROUND(x1,.2);
ceil1 = CEIL(x2);
ceil2 = CEIL(0.25);
floor1 = FLOOR(x2);
floor2 = FLOOR(10.75);
floor3 = FLOOR(10.25);
PUT _ALL_;
RUN;


*Character Functions;
DATA _NULL_;
Full_name = 'Kati    S.     Mehr';
New_name = COMPBL(full_name);
PUT _ALL_;
RUN;


DATA _NULL_;
Full_name = 'Kati    S.     Mehr';
New_name = COMPRESS(full_name);
Address="40 Eglinton-Ave. E, Toronto, M4P3A2";
New_add = COMPRESS(address,",.-");
PUT _ALL_;
RUN;


DATA test1;
INPUT name $5. +4 gender $1. age height weight;
gender_up = UPCASE(gender);   *LOWCASE;
CARDS;
Alice    f    10   61   97
Beth     f    11   64   105
Bill     m    12   63   110
Kati	 f    17   67   112
Rumy     f    16   66   109
;
RUN;


DATA test2;
First_name = '   Stephen';
Last_name = 'goodnight   ';
First_name_1 = LEFT(first_name);
Last_name_2 = RIGHT(last_name);
ss = propcase('john steven');
PUT _ALL_;
RUN;


DATA _NULL_;

Last_name = 'good night';
Last_1 = SUBSTR(last_name,1,3);
Last_2 = SUBSTR(last_name,1,1);
Last_3 = SUBSTR(last_name,1);

Address_1 = '2000 Eglinton Ave. Mississauga Ontario L5J4L0';
Address_2 = '2000, Eglinton Ave., Mississauga, Ontario, L5J4L0';
Num_1 = SCAN(address_1,1);
Num_2 = SCAN(address_2,1,',');
Street_name_1 = SCAN(address_1,2);
Street_name_2 = SCAN(address_2,2,',');

PUT _ALL_;
RUN;


* || is concatenate;
DATA _ NULL_;
full_name = 'Stephen Goodnight    ';
name1 = TRIM(full_name) || "**";
name2 = full_name || "**";
New_name = TRIM(SCAN(full_name,2)) ||','|| TRIM(SCAN(full_name,1));
PUT _ALL_;
RUN;


DATA _NULL_;
LENGTH text $15;
FORMAT text $char15.;
text = '  ab   cde  f   ';
trim = '*'||TRIM(text)||'*';  * Removes space from the end;
compress = '*'||COMPRESS(text)||'*'; * Removes all the spaces; 
strip = '*'||STRIP(text)||'*'; * Remove spaces from begining and end;
PUT trim= ;
PUT compress= ;
PUT strip=;
RUN; 


*Dates;
DATA WineRanking;
    INPUT company $ type $ score date MMDDYY10.;
	FORMAT date MMDDYY8.;
    DATALINES;
	  Helmes Pinot 56 09/14/2012
	  Helmes Reisling 38 09/14/2012
	  Vacca Merlot 91 09/15/2012
	  Sterling Pinot 65 06/30/2012
	  Sterling Prosecco 72 06/30/2012
	;
RUN;


DATA WineRanking;
    INFORMAT date MMDDYY10.; 
    INPUT company $ type $ score date;
	FORMAT date MMDDYY8.;
    DATALINES;
	  Helmes Pinot 56 09/14/2012
	  Helmes Reisling 38 09/14/2012
	  Vacca Merlot 91 09/15/2012
	  Sterling Pinot 65 06/30/2012
	  Sterling Prosecco 72 06/30/2012
	;
RUN;
PROC PRINT DATA = WineRanking;
VAR company type score date;
RUN;



*Yearcutoff;
/*
specifies the first year of the 100-year span. 
Range: 1582-1990
Default: 1920
*/

OPTIONS YEARCUTOFF = 1920; *1820;


DATA yearcut;
    INPUT company $ type $ score date MMDDYY8.;
	FORMAT date MMDDYY10.;
    DATALINES;
	  Helmes Pinot 56 09/14/12
	  Helmes Reisling 38 09/14/12
	  Vacca Merlot 91 09/15/12
	  Sterling Pinot 65 06/30/12
	  Sterling Prosecco 72 06/30/12
	;
RUN;
PROC PRINT DATA = yearcut;
RUN;


*Date in expressions;
DATA expression;
    INPUT company $ type $ score date MMDDYY10.;
	new_date = date + 10;
	FORMAT date new_date MMDDYY8.;
    DATALINES;
	  Helmes Pinot 56 09/14/2012
	  Helmes Reisling 38 09/14/2012
	  Vacca Merlot 91 09/15/2012
	  Sterling Pinot 65 06/30/2012
	  Sterling Prosecco 72 06/30/2012
	;
RUN; 


*Date constant with "date"D;
DATA _NULL_;
const = "08may2018"D;
FORMAT const mmddyy8.;
PUT const=;
RUN;


*Date functions : YRDIF;
DATA _NULL_;
bday = "11JUN1978"D;
current_age = INT (YRDIF(bday, TODAY()));
PUT current_age=;
RUN;


DATA _NULL_;
Age1 = INT((today()-'11JUN78'D)/365.25);
Age2 = INT((today()- MDY(06,11,78))/365.25);
PUT (age1 age2)(=);
RUN;


DATA _NULL_;
today = TODAY();
Y = YEAR(today);
Q = QTR(today);
M = MONTH(today);
D = DAY(today);
W = WEEKDAY(today);
PUT _ALL_;
RUN;


DATA _NULL_;
dob = "11JUN1978"D;
Years = INTCK('year',dob,today());
Diff_Y = YEAR(TODAY())-YEAR(dob);
quarters = INTCK('qtr',dob,today());
months = INTCK('month',dob,today());
weeks = INTCK('week',dob,today());
days = INTCK('day',dob,today());
PUT _ALL_;
RUN;


DATA _NULL_;
date1 = INTNX('month',"11JUN78"D,5,'beginning');
date2 = INTNX ('day', "11JUN78"D, 250 , 'middle');
PUT date1;
PUT date2;
PUT date1 date9.;
PUT date2 date7.;
RUN;

/* Alignments:
s- same day
b- beginning
m- middle
e- end */

*You can create a date constant, time constant, or 
datetime constant by specifying the date or time in 
single or double quotation marks, followed by a 
D (date), T (time), or DT (datetime);

