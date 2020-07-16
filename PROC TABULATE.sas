

DATA c;
INFILE DATALINES;
INPUT date : ddmmyy10.
      fname : $20.
	  sname : $20.
      x;

CARDS;
 19.2.2001 Adam Jones 102.8
 12.12.2004 Joan Jones 110.8
 ;
 RUN;
PROC PRINT DATA = c;
FORMAT date mmddyy10. ;
RUN;

/*Copy the data into a txt file*/
DATA _NULL_;
FILE 'C:\Users\Rayan\Desktop\Kati\Data Science\SASFile\CCC.txt' ;
SET c;
PUT date : ddmmyy10.
    fname : $20.
	sname : $20.
	x;
RUN;


DATA c1;
INFILE 'C:\Users\Rayan\Desktop\Kati\Data Science\SASFile\CCC.txt' ;
INPUT date : ddmmyy10.
      fname : $20.
	  sname : $20.
      x;
RUN;
PROC PRINT DATA = c1;
FORMAT date mmddyy10. ;
RUN;



/* PROC EXPORT */

PROC EXPORT DATA=Work.c1
   OUTFILE="C:\Users\Rayan\Desktop\Kati\Data Science\SASFile\C1.txt"
   DBMS=TAB REPLACE;
   PUTNAMES=YES;
RUN;



DATA golf;
INPUT coursename : $9. @10 num_holes par yeardage greenfees;
CARDS;
Ka Plan  18 73 7263 125.00
Puka tala18 72 6945 55.00
San jose 18 72 6469 35.00
Silver   18 71 .    57.00
Waie     18 72 6330 25
Grand    18 72 6122 200.00
;
RUN;
PROC PRINT DATA = golf;
RUN;


/*Copy the data into a dat file*/
DATA _NULL_;
FILE 'C:\Users\Rayan\Desktop\Kati\Data Science\SASFile\golf1.dat' ;
SET golf;
PUT coursename 'Golf Course' 
    @32  greenfees dollar7.2
    @40 'parmm' Par;
RUN;


/*Create a csv file*/
ODS CSV FILE='C:\Users\Rayan\Desktop\Kati\Data Science\SASFile\golf1.csv' ;
PROC PRINT DATA = golf;
RUN;
ODS CSV CLOSE;


/*Create a html file*/
ODS HTML 
   PATH = 'C:\Users\Rayan\Desktop\Kati\Data Science\SASFile\'
   FILE = 'golf1.html'
   STYLE = EGDefault;
PROC PRINT DATA = golf;
RUN;
ODS HTML CLOSE;



DATA marine;
INPUT name $ family $ length;
CARDS;
beluga whale 15 
dwarf shark 0.5 
basking shark 30 
humpback whale 50
whale  shark 40 
blue whale  100 
killer whale  30 
mako shark     12
;
RUN;
PROC PRINT DATA = marine; 
RUN;


ODS HTML STYLE=D3D FILE='marine.html'
                   /*FRAME='marinefRAME.html'
				   CONTENTS='marineTOC.html'*/;
ODS NOPROCTITLE;

PROC MEANS DATA = marine MEAN MAX MIN;
CLASS family;
TITLE 'Whales and Sharks';
RUN;
PROC PRINT DATA = marine; 
RUN;
ODS HTML CLOSE;

TITLE ' ';


ODS RTF FILE='C:\Users\Rayan\Desktop\Kati\Data Science\SASFile\Marine.RTF';
/*BODYTITLE STARTPAGE=NO;
ODS NOPROCTITLE;*/

PROC PRINT DATA = marine; 
RUN;
ODS RTF CLOSE;



ODS PDF FILE='C:\Users\Rayan\Desktop\Kati\Data Science\SASFile\MARINE.PDF';

ODS NOPROCTITLE;

PROC PRINT DATA = marine; 
RUN;
ODS PDF CLOSE;



DATA grain_production;
   LENGTH Country $ 3 Type $ 5;
   INPUT Year country $ type $ Kilotons;
   CARDS;
1995 BRZ  Wheat    1516
1995 BRZ  Rice     11236
1995 BRZ  Corn     36276
1995 CHN  Wheat    102207
1995 CHN  Rice     185226
1995 CHN  Corn     112331
1995 IND  Wheat    63007
1995 IND  Rice     122372
1995 IND  Corn     9800
1995 INS  Wheat    .
1995 INS  Rice     49860
1995 INS  Corn     8223
1995 USA  Wheat    59494
1995 USA  Rice     7888
1995 USA  Corn     187300
1996 BRZ  Wheat    3302
1996 BRZ  Rice     10035
1996 BRZ  Corn     31975
1996 CHN  Wheat    109000
1996 CHN  Rice     190100
1996 CHN  Corn     119350
1996 IND  Wheat    62620
1996 IND  Rice     120012
1996 IND  Corn     8660
1996 INS  Wheat    .
1996 INS  Rice     51165
1996 INS  Corn     8925
1996 USA  Wheat    62099
1996 USA  Rice     7771
1996 USA  Corn     236064
;
RUN;

PROC PRINT DATA = grain_production; 
SUM Kilotons;
BY country;
RUN;

PROC TABULATE DATA = grain_production;
CLASS country type;
VAR Kilotons;
TABLE country type, MEAN*(Kilotons);
RUN;

PROC SORT DATA = grain_production OUT = grain_sorted;
BY year country type;
RUN;
 

PROC FORMAT;
VALUE $cntry 'BRZ'='Brazil'
             'CHN'='China'
             'IND'='India'
             'INS'='Indonesia'
             'USA'='United States';
RUN;
 
PROC PRINT DATA = grain_production; 
SUM Kilotons;
BY country;
FORMAT country $cntry.;
RUN;



ODS HTML FILE = 'grain-body.htm'
     CONTENTS = 'grain-contents.htm'
        FRAME = 'grain-frame.htm'
         PAGE = 'grain-page.htm'
         /*base='http://www.yourcompany.com/local-address/'*/

    newfile=page;
 
options nobyline;
TITLE1 'Leading Grain-Producing Countries';
TITLE2 'for #byval(year)';
 

PROC REPORT DATA = grain_production /*nowindows*/
HEADLINE HEADSKIP;
   BY year;
   COLUMN country type kilotons;
   DEFINE country  / GROUP width=14 format=$cntry.;
   DEFINE type     / GROUP 'Type of Grain';
   DEFINE kilotons / format = comma12.;
   FOOTNOTE 'Measurements are in metric tons.';
RUN;
 
options byline;
TITLE1;
TITLE2;

ODS HTML CLOSE;
ODS LISTING;
 

DATA energy;
LENGTH State $2;
INPUT Region Division state $ Type Expenditures;
CARDS;
1 1 ME 1 708
1 1 ME 2 379
4 4 HI 1 273
4 4 HI 2 298
;
RUN;

PROC FORMAT;
   VALUE regfmt  1='Northeast'
                 2='South'
                 3='Midwest'
                 4='West';
   VALUE divfmt  1='New England'
                 2='Middle Atlantic'
                 3='Mountain'
                 4='Pacific';
   VALUE usetype 1='Residential Customers'
                 2='Business Customers';
RUN;
 
options nodate pageno=1 linesize=80 pagesize=60;
 
PROC TABULATE DATA = energy FORMATE=dollar12.;
CLASS region division type;
VAR expenditures;
TABLE region * division,
      type * expenditures / RTS=25;
FORMAT region regfmt. division divfmt. type usetype.;
 
TITLE1 'Energy Expenditures for Each Region';
TITLE2 '(millions of dollars)';
RUN;

TITLE1;
TITLE2;


PROC TABULATE DATA = energy;
CLASS division type;
TABLE division*
           (n='Number of customers'
            pctn<type>='% of row' 
            pctn<division>='% of column'  
            pctn='% of all customers'), 
            type/RTS=50;
FORMAT division divfmt. type usetype.;
TITLE 'Number of Users in Each Division';
RUN;
TITLE;


PROC FORMAT;
VALUE expfmt  low-<10000='red'
              10000-<20000='yellow'
              20000-high  ='green';
RUN;


ODS LISTING CLOSE;

ODS HTML FILE = 'energy-body.htm' ;
PROC TABULATE DATA = energy STYLE = D3D;
CLASS region division type;
VAR expenditures;
TABLE (region ALL)*(division ALL), type * expenditures;
TITLE 'Expenditures in Each Division';
FORMAT expenditures expfmt. region regfmt. division divfmt. type usetype.;
RUN;
ODS HTML CLOSE;

/* The RTS option provides enoughspace to display the column headings. */


Data test;
INPUT T1 T2 T3 T4 T5 Age BU;
CARDS;
1 5 2 3 4 30 300
4 5 2 1 2 31 308
3 4 4 3 2 33 285
4 3 2 5 3 37 310
1 2 4 2 1 28 278
;
RUN;

PROC TABULATE DATA = test;
VAR T1;                                                                                           
TABLE T1*(N min mean max sum);           
RUN;

PROC TABULATE DATA = test;
VAR T1;
TABLE T1 * N;
RUN;

PROC TABULATE DATA = test;
VAR T1;
TABLE T1 * (N SUM);
RUN;

PROC TABULATE DATA = test;
CLASS Age;
VAR T1;
TABLE Age, T1 * (N COLPCTN);
RUN;
/* Or */
PROC TABULATE DATA = test;
CLASS Age;
VAR T1;
TABLE T1, Age * (N ROWPCTN);
RUN;

PROC TABULATE DATAa = test;
CLASS Age;
VAR T1;
TABLE Age, T1 = "Group I" * (N="Count" COLPCTN="%");
RUN;

PROC TABULATE DATA = test;
CLASS Age;
VAR T1;                                                                             
Keylabel N="Count" COLPCTN="%";
Table Age, T1 = "Group I" * (N COLPCTN); 
Run; 

/*Best way of showing the table */
PROC TABULATE DATA = test;
CLASS Age;
VAR T1;
TABLE Age=' ', T1 = "Group I" * (N="Count" COLPCTN="%") / BOX="Age";
RUN;

PROC TABULATE DATA = test;
CLASS Age;
VAR T1;
TABLE Age=' ' ALL = "Grand Total" , T1 = "Group I" * (N="Count" COLPCTN="%")/ BOX="Age";
RUN;

PROC TABULATE DATA = test;
CLASS Age BU;
VAR T1;
TABLE T1="Group I",(Age * BU="Business Unit") * (N="Count" ROWPCTN="%");
RUN;

PROC TABULATE DATA = test;
CLASS Age BU;
VAR T1;
TABLE T1="Group I",(Age=" " * BU="Business Unit") * (N="Count" ROWPCTN="%");
RUN;

PROC FORMAT;                                                                                                                           
VALUE agefmt   1 = 'Under 18'                                                                        
               2 = '18 - 25'                                                                                           
               3 = 'Over 25';                                                                                                         
VALUE bufmt    1 = 'Analytics'                                                                                                                        
               2 = 'Technology'                                                                                                       
               3 = 'Others';                                                                                                      
RUN;
                                                                                  
PROC TABULATE DATA = test;
FORMAT Age agefmt. BU bufmt.;
CLASS Age BU;
VAR T1;                                                                                                                     
KEYLABEL N="Count" ROWPCTN="%";
TABLE T1="Group I",(Age * BU="Business Unit") * (N ROWPCTN * FORMAT=6.0); 
RUN; 

DATA test;
LENGTH BU $18.;
INPUT Location$ BU$ Gender$ Income;
CARDS;
Delhi Analytics Male 5000
Mumbai Tech Female 45000
Delhi Analytics Male 37000
Chennai Tech Male 33000
Delhi Tech Male 5000
Chennai Analytics Male 15000
Mumbai Analytics Female 440000
Delhi Analytics Female 5000
Mumbai Tech Male 45000
Delhi Analytics Female 37000
Chennai Tech Female 33000
Delhi Tech Female 5000
Chennai Analytics Male 15000
;                                                                                                                                     
RUN;   
 
PROC TABULATE DATA = test FORMAT=6.0;
CLASS Location BU Gender;
VAR Income;
TABLE Location=" " * BU=" ", Gender * Income=" " * (N="Count" ROWPCTN="%") / BOX="Location BU";
RUN;




options nodate pageno=1 linesize=80 pagesize=64;

DATA carsurvey;
INPUT Rater Age Progressa Remark Jupiter Dynamo;
DATALINES;
1   38  94  98  84  80
2   49  96  84  80  77
3   16  64  78  76  73
4   27  89  73  90  92
77   61  92  88  77  85
78   24  87  88  88  91
79   18  54  50  62  74
80   62  90  91  90  86
;
RUN;

PROC FORMAT;                                                                                                                           
VALUE agefmt (multilabel notsorted)
         15 - 29 = 'Below 30 years'
         30 - 50 = 'Between 30 and 50'
         51 - high = 'Over 50 years'
         15 - 19 = '15 to 19'
         20 - 25 = '20 to 25'
         25 - 39 = '25 to 39'
         40 - 55 = '40 to 55'
         56 - high = '56 and above';
RUN;

/* uses the MLF option to activate multilabel format processing. */

PROC TABULATE DATA = carsurvey FORMAT=10.;
CLASS age / MLF;
VAR progressa remark jupiter dynamo;
TABLE age=' ' all, n all = 'Potential Car Names' *(progressa remark jupiter dynamo)*mean/BOX=age;
   
TITLE1 "Rating Four Potential Car Names";
TITLE2 "Rating Scale 0-100 (100 is the highest rating)";
 
FORMAT age agefmt.;
RUN;

DATA energy;
LENGTH State $2;
INPUT Region Division state $ Type Expenditures;
CARDS;
1 1 ME 1 708
1 1 ME 2 379
1 1 NH 1 597
1 1 NH 2 301
1 1 VT 1 353
1 1 VT 2 188
1 1 MA 1 3264
1 1 MA 2 2498
1 1 RI 1 531
1 1 RI 2 358
1 1 CT 1 2024
1 1 CT 2 1405
1 2 NY 1 8786
1 2 NY 2 7825
1 2 NJ 1 4115
1 2 NJ 2 3558
1 2 PA 1 6478
1 2 PA 2 3695
4 3 MT 1 322
4 3 MT 2 232
4 3 ID 1 392
4 3 ID 2 298
4 3 WY 1 194
4 3 WY 2 184
4 3 CO 1 1215
4 3 CO 2 1173
4 3 NM 1 545
4 3 NM 2 578
4 3 AZ 1 1694
4 3 AZ 2 1448
4 3 UT 1 621
4 3 UT 2 438
4 3 NV 1 493
4 3 NV 2 378
4 4 WA 1 1680
4 4 WA 2 1122
4 4 OR 1 1014
4 4 OR 2 756
4 4 CA 1 10643
4 4 CA 2 10114
4 4 AK 1 349
4 4 AK 2 329
4 4 HI 1 273
4 4 HI 2 298
;
RUN;



options nodate pageno=1 linesize=64 pagesize=60;


PROC TABULATE DATA = energy F=comma12.;
CLASS region division type;
VAR expenditures;
TABLE region * (division ALL = 'Subtotal')ALL='Subtotal for all the regions' * F=dollar12.2, 
      type='Customer Base' * expenditures ALL = 'All Customers' * expenditures * F=dollar12.2 / RTS=25;
 
FORMAT region regfmt. division divfmt. type usetype.;
 
TITLE1 'Energy Expenditures for Each Region';
TITLE2 '(millions of dollars)';
RUN;


 
PROC TABULATE DATA = energy F=comma12.;
CLASS region division type;
VAR expenditures;
TABLE region * (division all='Subtotal') all='Total for All Regions'*F=dollar12.,
      type='Customer Base'*expenditures=' '*sum=' '
      all='All Customers'*expenditures=' '*sum=' ' / RTS=25;
 
FORMAT region regfmt. division divfmt. type usetype.;
 
TITLE1 'Energy Expenditures for Each Region';
TITLE2 '(millions of dollars)';
RUN;


