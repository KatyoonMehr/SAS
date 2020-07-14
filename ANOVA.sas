* -- PROC ANOVA
         CLASS
         MODEL

* -- MEANS (CLASS Variable) / TUKEY;


TITLE1 'Nitrogen Content of Red Clover Plants'; 
DATA Clover; 
INPUT Strain $ Nitrogen @@; 
DATALINES;
3DOK1 19.4 3DOK1 32.6 3DOK1 27.0 3DOK1 32.1 
3DOK1 33.0 3DOK5 17.7 3DOK5 24.8 3DOK5 27.9 
3DOK5 25.2 3DOK5 24.3 3DOK4 17.0 3DOK4 19.4 
3DOK4 9.1 3DOK4 11.9 3DOK4 15.8 3DOK7 20.7 
3DOK7 21.0 3DOK7 20.5 3DOK7 18.8 3DOK7 18.6 
3DOK13 14.3 3DOK13 14.4 3DOK13 11.8 3DOK13 11.6 
3DOK13 14.2 COMPOS 17.3 COMPOS 19.4 COMPOS 19.1 
COMPOS 16.9 COMPOS 20.8 
;
RUN;
TITLE1;
PROC PRINT DATA = Clover;
RUN;

PROC ANOVA DATA = Clover;
CLASS strain; 
MODEL Nitrogen = Strain; 
RUN;

MEANS strain / TUKEY;
RUN;


ODS GRAPHICS ON; 
PROC ANOVA DATA = Clover;
CLASS strain; 
MODEL Nitrogen = Strain; 
RUN;
ODS GRAPHICS OFF;


TITLE2 'Randomized Complete Block'; 
DATA RCB; 
INPUT Block Treatment $ Yield Worth @@; 
DATALINES; 
1 A 32.6 112 1 B 36.4 130 1 C 29.5 106 2 
A 42.7 139 2 B 47.1 143 2 C 32.9 112 3 
A 35.3 124 3 B 40.1 134 3 C 33.6 116 
; 
RUN;
TITLE2;
PROC PRINT DATA = RCB;
RUN;

PROC ANOVA DATA = RCB;
CLASS Block Treatment;
MODEL Yield Worth = Block Treatment; 
RUN;

MEANS Treatment / TUKEY; 
RUN;

MEANS Block / TUKEY; 
RUN;
