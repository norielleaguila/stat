data job;
input Subject	X1	X2	X3	X4	Y D1 D2;
label 	Y = 'job proficiency score'
		X1 = 'Test1 Score'
		X2 = 'Test2 Score'
		X3 = 'Test3 Score'
		X4 = 'Test4 Score';
datalines;
1	86	110	100	87	88	1	0
2	62	97	99	100	90	1	0
3	110	107	103	103	96	1	0
4	101	117	93	95	76	1	0
5	100	101	95	88	80	1	0
6	78	85	95	84	73	1	0
7	120	77	80	74	58	1	0
8	105	122	116	102	116	1	0
9	112	119	106	105	104	1	0
10	120	89	105	97	99	1	0
11	87	81	90	88	64	0	1
12	133	120	113	108	126	0	1
13	140	121	96	89	94	0	1
14	84	113	98	78	71	0	1
15	106	102	109	109	111	0	1
16	109	129	102	108	109	0	1
17	104	83	100	102	100	0	1
18	150	118	107	110	127	0	1
19	98	125	108	95	99	0	1
20	120	94	95	90	82	0	1
21	74	121	91	85	67	0	1
22	96	114	114	103	109	0	1
23	104	73	93	80	78	0	1
24	96	121	115	104	115	0	1
25	91	129	97	83	83	0	1
26	65	109	88	84	58	0	1
27	85	90	104	98	92	0	1
28	93	73	91	82	71	0	1
29	95	57	95	85	77	0	1
30	102	139	101	92	92	0	1
31	63	101	93	84	66	0	0
32	81	129	88	76	61	0	0
33	111	102	83	72	57	0	0
34	67	98	98	84	66	0	0
35	91	111	96	84	75	0	0
36	128	99	98	89	98	0	0
37	116	103	103	103	100	0	0
38	105	102	88	83	67	0	0
39	99	132	109	105	111	0	0
40	93	95	106	98	97	0	0
41	99	113	104	95	99	0	0
42	110	114	91	78	74	0	0
43	128	134	108	98	117	0	0
44	99	110	96	97	92	0	0
45	111	113	101	91	95	0	0
46	109	120	104	106	104	0	0
47	78	125	115	102	100	0	0
48	115	119	102	94	95	0	0
49	129	70	94	95	81	0	0
50	136	104	106	104	109	0	0

;
run;

title 'Data for MLRM - JOB PROFICIENCY DATA';
proc print data = job;
run;

title 'Scatter Plots: Y versus Xs';
proc plot data = job vpercent = 50 hpercent = 50 ;
plot y*(x1 - x4);
run;


title 'Correlation Matrix';
proc corr data = job ;
var y x1 - x4;
run;


title 'Full (Saturated) Model';
proc reg data = job ;

	model y = X1 X2 X3 X4 / 
		clm clb corrb dwprob 
		influence all r 
		collin tol vif alpha = 0.05 ;

	output out= result  p = yhat r=residual ;
run;

/* normality */

proc univariate data = result normal plot;
var residual;
run;


/* Model 2 without X2 */

title 'Model 2 (X1, X3, X4)';
proc reg data = job;
	model y = X1 X3 X4/
		clm clb corrb dwprob
		influence all r
		collin tol vif alpha = 0.05;

	output out=result2 p = yhat r = residual;
run;

title 'MLRM Results: Model 2';
proc print data = result2;
run;

proc univariate data = result2 normal plot;
var residual;
run;

title 'MLRM Results: Model 2';
proc print data = result2;
run;

/* Modified Model 2 */
 
title 'Modified Model 2 (X1, X3, X4)';
proc reg data = job;
	model y = X1 X3 X4 D1 D2/
		clm clb corrb dwprob
		influence all r
		collin tol vif alpha = 0.05;

	output out=result3 p = yhat r = residual;
run;

title 'MLRM Results: Modified Model 2';
proc print data = result3;
run;

proc univariate data = result3 normal plot;
var residual;
run;


title 'All Possible Regression Procedure';
proc reg data = job ;

	model y = X1 X2 X3 X4 
		/ selection = rsquare sse mse adjrsq cp press aic bic sbc
		clm clb corrb dwprob 
		influence all r influence collin tol vif alpha = 0.05 ;

	output out= result1  p = yhat r=residual ;
run;

title 'MLRM Results: All Possible Regression';
proc print data = result1;
run;


title 'Backward Elimination Procedure';
proc reg data = job ;

	model y = X1 X2 X3 X4 
		/ selection = backward slstay = 0.05
		clm clb corrb dwprob 
		influence all r influence 
		collin tol vif alpha = 0.05 ;

	output out= result2  p = yhat r=residual ;
run;

title 'MLRM Results: Backward Elimination';
proc print data = result2;
run;


title 'Forward Selection Procedure';
proc reg data = job ;

	model y = X1	X2	X3	X4  
		/ selection = forward slentry = 0.05
		clm clb corrb dwprob 
		influence all r influence 
		collin tol vif alpha = 0.05 ;

	output out= result3  p = yhat r=residual ;
run;

title 'MLRM Results: Forward Selection';
proc print data = result3;
run;


title 'Stepwise Selection Procedure';
proc reg data = job ;

model y = X1 X2 X3 X4  
	/ selection = stepwise slentry = 0.05 slstay = 0.05
	clm clb corrb dwprob 
	influence all r influence 
	collin tol vif alpha = 0.05 ;

output out= result4  p = yhat r=residual ;
run;
title 'MLRM Results: Stepwise Selection Procedure';
proc print data = result4;
run;


title 'Normality Diagnostics, etc.';
proc univariate data = result plot freq normal;
var residual;
run;

title 'Residual Plots';
proc plot data = result;
plot residual*(x1 - x4 yhat);
run;
proc sort data = result;
by y;
run;
proc print data = result;
run;


title 'Tests for Homoscedasticity';
data res;
set result;
if y <= 80 then resgrp = 1;
else if y > 80 and y <= 100 then resgrp = 2;
else resgrp = 3;
run;

proc print data = res;
run;

proc plot data = res;
plot residual*resgrp;
run;

proc glm data = res;
class resgrp;
model residual = resgrp;
means resgrp / hovtest = bartlett hovtest = levene;
run;


title 'Breusch Pagan Test for Homoscedasticity';
proc model data = job; 
      parms b0 b1 b2 b3 b4; 
      y = b0 + b1*x1 + b2*x2 + b3*x3 + b4*x4; 
      fit y / white breusch =( 1 x1 x2 x3 x4 ); 
run;

