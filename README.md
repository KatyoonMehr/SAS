## SAS Basic:
- Different way to enter data (INPUT, LENGTH, INFORMAT),

- Read Ecternal file (PROC IMPORT, INFILE)

- Array

- PROC PRINT, PROC SORT, PROC CONTENT

## Functions:
SUM(OF ), N, NMISS, MEAN, ROUND, INT, CEIL, FLOOR, UPCASE, LOWCASE, PROPCASE, LEFT, RIGHT, SUBSTR, SCAN, COMPBL

COMPRESS (Removes all the spaces)

TRIM (Removes space from the end)

STRIP (Removes space from the begining and end)

Date Functions: TODAY(), MDY, YRDIF, YEAR, QTR, MONTH, DAY, WEEKDAY, INTCK, INTNX

Contant time: "date"D, "time"T, "datetime"DT

OPTIONS YEARCUTOFF = 1920

## Keep and Drop
How to use KEEP and DROP statements and KEEP= and DROP= options efficiently.

## Conditions:
IF - ELSE IF - THEN

WHERE

Grouping Observations with IF-THEN DO-END Statements

DO TO BY   OUTPUT END

DO WHILE   OUTPUT END

DO UNTIL   OUTPUT END

RETAIN (copies retaining values by telling the SAS not to reset the variables 
		 to missing at the beginning of each iteration of the DATA step)
		 
First. and Last. Indicators
