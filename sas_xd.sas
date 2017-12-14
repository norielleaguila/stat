/* import out.csv to game_sales */
data game_sales;
	infile '/folders/myfolders/data/top2016-fix.csv' dlm=',' firstobs=2;
	input Name $ Platform $ Year_of_Release Publisher $ NA_Sales EU_Sales JP_Sales Other_Sales Global_Sales Critic_Score User_Score Rating $ Pub1 Pub2 Pub3 Pub4 Plat1 Plat2 Plat3 Plat4 Plat5;
run;

/* print data set */
title 'Video Game Sales for 2016';
proc print data=game_sales;
run;

title 'Scatter Plots';
proc plot data=game_sales;
plot Global_Sales*(Critic_Score User_Score Pub1 Pub2 Pub3 Pub4 Plat1 Plat2 Plat3 Plat4 Plat5) = '*';
run;

/* Correlation Matrix*
proc corr data=game_sales;
	var Global_Sales Critic_Score User_Score Pub1 Pub2 Pub3 Pub4 Plat1 Plat2 Plat3 Plat4 Plat5;
run;

title 'Full (Saturated) Model';
proc reg data = game_sales ;

	model Global_Sales = Critic_Score User_Score Pub1 Pub2 Pub3 Pub4 Plat1 Plat2 Plat3 Plat4 Plat5  / 
		clm clb corrb dwprob 
		influence all r 
		collin tol vif alpha = 0.05 ;

	output out=result1 p=yhat r=residual;
run;
	
proc univariate data=result1 normal plot;
var residual;
run;