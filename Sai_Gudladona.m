%-------------------------------------------------------------------------------------------------
% BMEN 3325: Sai Gudladona (sxg162431)
%
% Chapter 6: Input/Output File
% Finding Average of the Week
%    * Fileread Json file, Convert Data into the needed types
%    * Connect to Timetable to calculate for Avg Steps
%    * Plot Graph and Output calculated data to txt file
%-------------------------------------------------------------------------------------------------

% Read in every file and use jsondecode turn it into a struct (used to make data usable)

Jan = fileread('C:\Users\Sai\Documents\UTD\BMEN 3325\HWs\HW5\stepsData\steps-2018-01-02.json'); % Fileread Jan
Jan = jsondecode(Jan); % Open JSON file with jsondecode Jan
Feb = fileread('C:\Users\Sai\Documents\UTD\BMEN 3325\HWs\HW5\stepsData\steps-2018-02-01.json'); % Fileread Feb
Feb = jsondecode(Feb); % Open JSON file with jsondecode Feb
Mar = fileread('C:\Users\Sai\Documents\UTD\BMEN 3325\HWs\HW5\stepsData\steps-2018-03-03.json'); % Fileread Mar
Mar = jsondecode(Mar); % Open JSON file with jsondecode Mar
Apr = fileread('C:\Users\Sai\Documents\UTD\BMEN 3325\HWs\HW5\stepsData\steps-2018-04-02.json'); % Fileread Apr
Apr = jsondecode(Apr); % Open JSON file with jsondecode Apr
May = fileread('C:\Users\Sai\Documents\UTD\BMEN 3325\HWs\HW5\stepsData\steps-2018-05-02.json'); % Fileread May
May = jsondecode(May); % Open JSON file with jsondecode May
June = fileread('C:\Users\Sai\Documents\UTD\BMEN 3325\HWs\HW5\stepsData\steps-2018-06-01.json'); % Fileread June
June = jsondecode(June); % Open JSON file with jsondecode June
July = fileread('C:\Users\Sai\Documents\UTD\BMEN 3325\HWs\HW5\stepsData\steps-2018-07-01.json'); % Fileread July
July = jsondecode(July); % Open JSON file with jsondecode July
Aug = fileread('C:\Users\Sai\Documents\UTD\BMEN 3325\HWs\HW5\stepsData\steps-2018-07-31.json'); % Fileread Aug
Aug = jsondecode(Aug); % Open JSON file with jsondecode Aug
Sep = fileread('C:\Users\Sai\Documents\UTD\BMEN 3325\HWs\HW5\stepsData\steps-2018-08-30.json'); % Fileread Sep
Sep = jsondecode(Sep); % Open JSON file with jsondecode Sep
Oct = fileread('C:\Users\Sai\Documents\UTD\BMEN 3325\HWs\HW5\stepsData\steps-2018-09-29.json'); % Fileread Oct
Oct = jsondecode(Oct); % Open JSON file with jsondecode Oct
Nov = fileread('C:\Users\Sai\Documents\UTD\BMEN 3325\HWs\HW5\stepsData\steps-2018-10-29.json'); % Fileread Nov
Nov = jsondecode(Nov); % Open JSON file with jsondecode Nov
Dec = fileread('C:\Users\Sai\Documents\UTD\BMEN 3325\HWs\HW5\stepsData\steps-2018-11-28.json'); % Fileread Dec
Dec = jsondecode(Dec); % Open JSON file with jsondecode Dec
Jan_Again = fileread('C:\Users\Sai\Documents\UTD\BMEN 3325\HWs\HW5\stepsData\steps-2018-12-28.json'); % Fileread Jan 2019
Jan_Again = jsondecode(Jan_Again); % Open JSON file with jsondecode new Jan of 2019

%--------------------------------------------------------------------------

All_Months = [Jan;Feb;Mar;Apr;May;June;July;Aug;Sep;Oct;Nov;Dec;Jan_Again];
% Compile all struct files given for the year

Date_Cell = arrayfun(@(IDX) All_Months(IDX).dateTime, (1:numel(All_Months)).', 'Uniform', 0); 
% Draw out the DateTime data into an cell array format
% Transpose the value to be into column (.')

time_obj = datetime(Date_Cell, 'InputFormat', 'MM/dd/yyyy hh:mm:ss'); 
% Convert the date array into datetime format so that times can be easily
% processed,compiled and manipulated to how we need them. 
% Layout the Input format for how the computer should process the times

Step_Change =(str2double({All_Months.value}).');
% Draw out the values into a numeric datatype so that they can go through
% numerical operations. Also make sure to transpose 

TT_Table = array2timetable(Step_Change,'R',time_obj);
% Through creating a timetable, combined are the functional usable dates
% and the step numeric values. 

TT_Days_Sum = retime(TT_Table,'daily',@sum);
% Retime will allow the Time-series sum up all of the steps per day -> to
% be averaged the mean.

TT_Weekly_Averages = retime(TT_Days_Sum, 'weekly', 'mean');
% Retime here will separate the days into weeks and then take the mean of
% the step values. 

%--------------------------------------------------------------------------

plot(TT_Weekly_Averages.Time,TT_Weekly_Averages.Step_Change,'g')% Plot the 57 weeks and the step averages associated with it
title('Weekly Average of Steps') % Assign Title giving context to the info on the graph
xtickformat('MM/dd/yy') % Set how the date(time) should look on the graph
xlabel('Weeks') % Label for X axis values
ylabel('Steps') % Label for Y axis values

%--------------------------------------------------------------------------

writetimetable(TT_Weekly_Averages,'Step_Averages.txt') % Output the Step Averages per Week into a txt file

% -------------------------------------------------------------------------