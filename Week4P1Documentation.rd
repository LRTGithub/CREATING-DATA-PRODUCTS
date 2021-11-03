Date: November 1, 2021
Author: LR
Project Name: Developing Data Products, Week4 Project1, Measuring Beta.

Description of the application: (what is the application supposed to do)
The application reads data from a file containing the 20-sessions( approximately monthly) 
returns of 8 indexes and securities: S&P500, DYX, DJI, Nasdaq100, TNX, IRX, TYX, AAPL.
The daily closing of each index/security was sourced from Yahoo finance starting in 1992
and ending in October 2021. The 20-sessions returns (approximately monthly) are calculated
daily, rolling daily. Returns at any point in time are computed as the closing of that date
minus the closing 20 sessions ago, divided by closing 20 sessions ago, times 100.
Based on the input from the user, the application does the following:
1) computes a regression line between the index or security and the S&P500 index. 
The slope of the line is "beta" for that index.
2) plots the cloud of data points, and the regression line.

User interface:
The user moves a slide which provides an reactive input to the aplication. 
The application responds with the following output:
1) the ticker of the index or security followed by "Re" (Re means returns).
2) the full name of the security.
3) beta for the security.
4) plot of the data points cloud, and regression line.

Files and data:
1) Two files, one for user interface, and one for server are included. 
2) One data file is included and must be placed in the same directory along with the rest 
of the files.
3) This documentation file.
