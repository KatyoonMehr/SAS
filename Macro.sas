/* Macro */


%LET Var1=Metro College;
%PUT &Var1;

/* Some System prepared Macro */

%PUT &SYSTEM;
%PUT &SYSDATE9;
%PUT &SYSDATE;
%PUT &SYSDAY;

%LET FNmae=Kati;
%LET Sname=Mehr;

%PUT &FName &SName;
%PUT &FName, &SName;

%LET Var1=Metro College;
%LET Var2=Student List;

DATA Test;
INPUT Gender $ Age Income @@;
DATALINES;
F 26 23400 F 40 45000 F 25 26800 F 38 44900 
F 56 65000 M 23 38000 M 28 27250 M 60 68500 
M 22 95600 M 42 42050 M 39 85230 M 25 26450
F 18 23400 F 68 95000 F 20 26800 F 18 44900 
F 66 25000 M 17 28000 M 18 27250 M 67 68500 
M 22 25600 M 19 42050 M 19 25230 M 65 66450
;
RUN;


%Kati

%MACRO Kati_1(MacroData=, Var1=, Var2=);
PROC SORT DATA=&MacroData;
By &Var1;
RUN;
PROC PRINT DATA=&MacroData NOOBS;
BY &Var1;
TITLE 'Categorised by &Var';
SUM &Var2;
RUN;
%MEND Kati_1;

%Kati_1 (MacroData=TEST, Var1=Gender, Var2=Income);


/* or  with out reading the parameters in the MACRO name and MACRO call*/
%Kati;

%MACRO Kati_2;
PROC SORT DATA=&MacroData;
By &Var1;
RUN;
PROC PRINT DATA=&MacroData NOOBS;
BY &Var1;
TITLE 'Categorised by &Var';
SUM &Var2;
RUN;
%MEND Kati_2;

%LET MacroData=Test;
%LET Var1=Gender;
%lET Var2=Income;
%Kati_2 (MacroData=&MacroData, Var1=&Var1, Var2=&Var2);
%Kati_2 (MacroData=test, Var1=gender, Var2=income);

/* The second %Kati would be easier to use because we can just change 
the variable or dataset in %Let. If we fix them we don't put  & in calling the Macro) */




DATA Score;
INPUT ID S1 S2 S3;
CARDS;
1 85 95 75
2 75 85 65
3 65 45 31
4 80 85 75
5 90 96 75
6 91 86 77
7 76 65 77
8 80 75 80
9 65 65 70
10 70 80 90
;
RUN;

%LET data=Score;
%LET Var1=s1;
%LET Var2=s2;
%LET Var3=s3;

%MACRO M_Score (data=, Var1=, Var2=, Var3=);
PROC MEANS DATA=&data ;
VAR &Var1 &Var2 &Var3;
RUN;
PROC PRINT DATA=&data;
SUM &Var1 &Var2 &Var3;
RUN;
%MEND M_Score;

%M_Score (data=&data, Var1=&var1, Var2=&var2, Var3=&var3);


%MACRO M_Plot (Var1=,  Var2=);
PROC PLOT;
PLOT &Var1*&Var2;
RUN;
%MEND M_Plot;

%M_PLOT (Var1=&var1, Var2=&var2);
%M_PLOT (Var1=&var2, Var2=&var3);
%M_PLOT (Var1=&var1, Var2=&var3);


LIBNAME Kati 'C:\Users\Rayan\Desktop\Kati\Data Science\SASFile\SAS_2';
DATA Staff;
INFILE 'C:\Users\Rayan\Desktop\Kati\Data Science\SASFile\SAS_2\Staff.csv' DLM=',' FIRSTOBS=2;
INPUT IDNUM	FNAME $	LNAME $	STATE $ JOBCODE HIRED DDMMYY10.;
RUN;
DATA Staff2;
INFILE 'C:\Users\Rayan\Desktop\Kati\Data Science\SASFile\SAS_2\Staff2.csv' DLM=',' FIRSTOBS=2;
INPUT IDNUM	FNAME $	LNAME $	STATE $ JOBCODE HIRED DDMMYY10.;
RUN;

DATA ALL_STAFF;
SET Staff;
RUN;
PROC PRINT DATA=ALL_STAFF;
RUN; 

DATA NEW_STAFF;
SET Staff2;
RUN;
PROC PRINT DATA=NEW_STAFF;
RUN;




%LET DATA1=ALL_STAFF;
%LET DATA2=NEW_STAFF;
%LET VAR1=IDNUM;
%LET VAR2=IDNUM;

%MACRO M_Employee_1;
PROC SQL;
SELECT A.* FROM &DATA1 A,
	 &DATA2 B
		WHERE A.&VAR1=B.&VAR2;
		QUIT;
%MEND M_Employee_1;
%M_Employee_1;

/*Or*/

%MACRO M_Employee (DATA1= , DATA2= , VAR1=, VAR2=);
PROC SQL;
SELECT A.* FROM &DATA1 A,
	 &DATA2 B
		WHERE A.&VAR1=B.&VAR2;
		QUIT;
%MEND M_Employee;
%M_Employee (DATA1=&DATA1, DATA2=&DATA2, VAR1=IDNUM, VAR2=IDNUM);



DATA Pipe;
INFILE 'C:\Users\Rayan\Desktop\Kati\Data Science\SASFile\Mini Project\New_Wireless_Fixed.TXT' DLM ="|" DSD FIRSTOBS=2;
INPUT 
	    @1  Acctno $13.
        @15 Actdt  mmddyy10.
        @26 Deactdt mmddyy10.
        @41 DeactReason $4. 
        @53 GoodCredit 1.
        @62 RatePlan 1. 
        @65 DealerType $2.
        @74 AGE 2.
        @80 Province $2.
        @85 Sales    dollar8.2 ;

		LABEL AGE="Age" Sales="Funds";
RUN;
PROC PRINT DATA=Pipe;
RUN;

PROC SORT DATA=Pipe OUT=Pipe_Sorted;
BY Actdt;
RUN;

DATA TT;
SET Pipe_Sorted;
IF _N_=1 THEN CALL SYMPUT ('MaxDate', Actdt);
ELSE STOP;
RUN;

%PUT &MaxDate;

DATA DATE_NEW;
Maxdate=&MaxDate;
RUN;

PROC PRINT DATA=DATE_NEW;
VAR Maxdate;
FORMAT Maxdate date9.;
RUN;




DATA _NULL_;
%LET X=long tall sally;
%LET Y=%INDEX(&X, tall);
%PUT Tall can be found at position &Y;
RUN;


DATA _NULL_;
%LET X=Kati.Iris.Mehr;
%LET Fname=%SCAN(&X, 1);
%LET Mname=%SCAN(&X, 2);
%LET Lname=%SCAN(&X, 3);
%LET Xname=%SCAN(&X, 1, M);

%PUT First Name is &Fname;
%PUT First Name is &Mname;
%PUT Last Name is &Lname;
%PUT First and Middle Names are &Xname;
RUN;



%MACRO a;
aaaaaaaaaa
%MEND a;
%a;

%MACRO b;
bbbbbbbbb
%MEND b;
%b;

%MACRO c;
ccccccccc
%MEND c;
%c;

%LET X=%NRSTR(*%a*%b*%c);
%PUT X=&x;

%PUT The First word in X, With SCAN: %SCAN (&X, 1, *);
%PUT The Second word in X, With SCAN: %SCAN (&X, 2, *);
%PUT The Tird word in X, With SCAN: %SCAN (&X, 3, *);

%PUT The Tird word in X, With QSCAN: %QSCAN (&X, 3, *);

/* The %PUT statement writes these lines to the log: 
X= %a*%b*%c
The third word in X, with SCAN: cccccc
The third word in X, with QSCAN: %c */


DATA scores;
INPUT Grade : $1. @@;
check='abcdf';
	IF VERIFY(grade,check)>0 THEN PUT @1 'INVALID ' grade=;
CARDS;
a b t c b c d f a e a q a b d d b e
;
RUN;

%PUT %VERIFY(1234,56123);
%PUT %VERIFY(abd,acefb);


%MACRO M_Means (DATA=, Var=);
PROC MEANS DATA=&data;
VAR &Var;
RUN;
%MEND M_Means;
%M_MEANS;



