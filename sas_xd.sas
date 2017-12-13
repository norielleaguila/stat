/* import out.csv to game_sales */

data game_sales;
	infile 'C:\Users\Student\Downloads\year2010.csv' dlm=',' firstobs=2;
	input Name $ Platform $ Year_of_Release Genre $ Publisher $ Global_Sales Critic_Score Critic_Count User_Score User_Count Rating $;
run;

/* y = Global_Sales */
/* print data set */
title 'Video Game Sales for 2010';
proc print data = game_sales;
run; 

title 'Scatter Plots: Y versus Xs';
proc plot data = game_sales;
plot Global_Sales*(Platform Genre Publisher Critic_Score User_Score Rating) = '*';
run;
