LIBNAME KatiLib 'C:\Users\Rayan\Desktop\Kati\Data Science\SASFile';

DATA Customers;
INPUT 	@1 Customer_ID $10.
		@12 FirstName $25.
		@39 LastName $20.
        @60 DOB DDMMYY8.
		@69 Gender $1.
		@71 Employ_Stat $1.
		@73 Income 9.2
		@83 Family_Size 1.
		@85 HomePhone ; 
LABEL Income='Approximate Annual Income' DOB='Date of Birth' Family_Size='Number of People in the family'
FirstName=' First Name' LastName='Last Name' Employ_Stat='Employment Status' HomePhone='Home Phone';
DATALINES;
CUST000001 Kicheal                    Mosley               25101967 M A 500000.00 4 3452345786
CUST000002 Carl                       Mohat                14101956 M A 45000.00  3 2346543478
CUST000003 Kati                       Mehr                 11061978 F C 66000.00  4 6478308228
CUST000004 Jane                       Ear                  30121988 F A 50000.00  2 5642311444
CUST000005 John                       Vincent              12121945 M A 67000.00  3 4564564566
CUST000006 Robert                     Moeeini              30101999 F A 450000.00 3 4445556667
CUST000009 Maryam                     Mani                 22031994 F A 150900.00 2 5554324321
CUST000010 Hosein                     Hazar                24101979 M C 70000.00  5 6654543210
CUST000011 William                    Montbllan            25111977 M A 500000.00 4 3452345786
CUST000012 Carl                       Mohat                14102000 M A 45000.00  3 2346543478
CUST000013 Katline                    Wayne                11121978 F C 166000.00 4 6478308228
CUST000014 Jane                       Mallin               20121998 F A 50000.00  5 5642311444
CUST000015 Gebreil                    Vinous               12101965 M A 67000.00  4 4564564566
CUST000016 Rofael                     Honk                 16121998 M C 30000.00  2 5675675677
CUST000017 Mansor                     Mostafa              15121998 M C 29000.00  1 7778889990
CUST000018 Leanna                     Massah               30111999 F A 450000.00 1 4445556667
CUST000019 Meloryna                   Massah               22031999 F A 150900.00 1 5554324321
CUST000020 Eric                       Natan                24111979 M C 70000.00  4 6654543210
;
RUN;

PROC SORT DATA=Customers OUT=New_Customers;
BY Gender;
RUN;

PROC FORMAT;
VALUE $EmpStat C='Client' A='Associate';
RUN;


PROC PRINT DATA=NEW_Customers LABEL;
	TITLE 'List of Customers';
	FORMAT DOB MMDDYYS10. Employ_Stat $EmpStat.;
	BY Gender;
RUN;


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

DATA TesTMissing;
INPUT @1 Gender $1. @3Age 2. @5Income;
DATALINES;
F 26 23400
F 40 45000 
F 25 26800 
F 38 44900 
F 56 65000 
M 23 38000 
M 28 27250 
M 60 68500 
M 22 95600 
M 42 42050 
M 39 85230 
M 25 26450
F 18 23400 
F 68 95000 
F 20 26800 
F 18 44900 
F 66 25000 
M 17 28000 
M 18 27250 
M 67 68500 
M 22 25600 
M 19 42050 
M 19 25230 
M 65 66450
  18 45000 
F .  35000 
F 22 25800 
  45 55000
;
RUN;

PROC PRINT DATA=TestMissing;
RUN;

PROC FORMAT;
VALUE $Gender 'M'='Male' 'F'='Female';
VALUE AgeGrp 0-19='<20 Yrs' 20-64='20-64 Yrs' 65-HIGH='>=65 Yrs';
RUN;


PROC PRINT DATA=TestMissing;
FORMAT Gender $Gender. Age AgeGrp.;
RUN;

PROC PRINT DATA=Test;
RUN;

PROC MEANS DATA=Test MAXDEC=2;
VAR Age Income;
RUN;

PROC MEANS DATA=Test MAXDEC=2;
VAR Income;
CLASS Age Gender;
FORMAT Age AgeGrp. Gender $Gender. Income DOLLAR.2;
RUN;


PROC SUMMARY DATA=Test;
VAR Age Income;
OUTPUT OUT=New_Test;
RUN;


PROC SUMMARY DATA=Test MAXDEC=2;
VAR Income;
CLASS Gender Age;
FORMAT Age AgeGrp. Gender $Gender.;
OUTPUT OUT=New_Test1 N=Number;
RUN;

PROC PRINT DATA=New_Test1;
RUN;


PROC UNIVARIATE DATA=Test NORMAL PLOT FREQ;
VAR Age Income;
OUTPUT OUT=New_Test2;
HISTOGRAM;
RUN;

PROC FREQ DATA=Test;
TABLE Gender;
FORMAT Gender $Gender.;
RUN;


PROC FREQ DATA=Test;
TABLE Age*Gender /OUT=New_Test3;
FORMAT Gender $Gender. Age AgeGrp.;
RUN;


PROC FREQ DATA=Test;
TABLE Gender*Age/missing;
FORMAT Gender $Gender. Age Agegrp.;
RUN;


PROC FREQ DATA=TestMissing;
TABLE Gender*Age/missing;
FORMAT Gender $Gender. Age Agegrp.;
RUN;

PROC PRINT DATA=New_Test3;
RUN;


ODS GRAPHICS ON;
PROC CORR DATA=Test NMISS PLOTS=SCATTER(NVAR=2);
VAR Age Income;
RUN;
ODS GRAPHICS OFF;



DATA Gardener;
INFILE 'C:\Users\Administrator\Desktop\KatiSAS\Gardener.txt' DLM=',' FIRSTOBS=2;
INPUT Name $ Tomatos Zucchinis Peas Grapes;
Zone = 14;
Type = 'Home';
Total1 = Tomatos+Zucchinis+Peas+Grapes;
Total2 = SUM(Tomatos, Zucchinis, Peas, Grapes);
PerTom = (Tomatos/Total2)*100;
RUN;
PROC PRINT DATA=Gardener;
RUN;


DATA mydata;
INPUT gender $ age income;
CARDS;
F 26 23400
F 40 45000
F 25 26800
F 38 44900
F 56 65000
M 23 38000
M 28 47250
M 60 68500
M 22 95600
M 42 42050
M 39 85230
M 25 66450
;
RUN;

PROC PRINT DATA = mydata;
RUN;

*Proc Means;
PROC MEANS DATA = mydata;
VAR age income;
TITLE1 'Mean';
RUN;

PROC FORMAT;
     VALUE $gender  'M'='Male' 'F'='Female';
	 VALUE agegrp 	0 - 19 = "<20 yrs"
					20 - 40 = "20-40yrs"
					41 - 64 = "21-64yrs"
					65 - high = ">=65yrs";

RUN;

PROC MEANS DATA = mydata MAXDEC = 2;
 	VAR income;
	CLASS gender age;
	FORMAT gender $gender. Age agegrp.;
RUN;

*Proc Summary; 
*Values in variable _TYPE_ correspond to the different levels of summarization requested in PROC SUMMARY, 
which depend on the number of variables in the CLASS statement;
PROC SUMMARY DATA = mydata;
 	VAR age income;
	OUTPUT OUT = sumdata;
RUN;

PROC SUMMARY DATA = mydata MAXDEC = 2;
 	VAR income;
	CLASS gender age;
	FORMAT gender $gender. Age agegrp.;
	OUTPUT OUT = sumdata N = number MIN = min MEAN = mean STD = stdev SUM = total;
Run;

* Proc Univariate;
PROC UNIVARIATE DATA = mydata;
	VAR age income;
RUN;

PROC UNIVARIATE DATA = mydata; *normal plot freq;
	VAR income age;
	OUTPUT OUT = sumdata
			n=n min=min
			mean=mean std=std
			median=median;
			HISTOGRAM;
RUN;

*Proc Frequency;
PROC FREQ DATA = mydata;
	TABLE gender;
	FORMAT gender $gender.;
RUN;

PROC FREQ DATA = mydata;
 TABLE age / OUT=agefreq;
RUN;

PROC FREQ DATA = mydata;
	TABLE gender*age / MISSING;
	FORMAT gender $gender. Age agegrp.;
RUN;


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
PROC PRINT DATA = WineRanking;
RUN;









