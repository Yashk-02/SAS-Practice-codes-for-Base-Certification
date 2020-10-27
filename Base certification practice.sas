/*SAS Naming conventions while naming columns and tables
-> SAS column names can be 1-32 characters long
→ The name must start with letters or computers and can continue with any combinations of numbers, letters or underscores, no blanks are allowed.
→ SAS column names can be uppercase, lowercase and mixed case.
→ You can use the name either in lowercase or uppercase without impacting the location it is been stored.
REMEMBER:
SAS has two datatypes:
1.	Categorical
2.	Numerical

/*

------------------------To import data from csv file-----------
data ABC;
	infile '/folders/myfolders/continents data.csv' dlm = ',' firstobs = 2;##Infile statement tells that data is within the file at particular location whereas same thing is applied during dataline its just that datalines shows that the data is within datastep.
	input Year $ Europe Asia America Africa;
run;
------------To import Data or text file-------------------------------
data ABCdat;
	infile '/folders/myfolders/cars.dat';
	input first $ Second $ Third $ Fourth $;
run;

-----Usage of dlm in DAT file
libname friday '/folders/myfolders/';

filename hmm '/folders/myfolders/dlmm.dat';

data friday.dlm;
infile hmm dlm = ',';
input name $ age;
run;

--------------------Using List input style and Column input style-----------
Data ABC;
infile hmm;
input Name $ Age;  ##List input style
run;

/*List input style has many disadvantages like the character variable should not be greater than 8 character and many like if we put space in a name it will not be printed properly*/

Data ABC;
infile hmm;
input Name $1-4 Age 5-7; ## Column input style
run;
 -------------DSD is used to display the names if it is in Quotes
libname friday '/folders/myfolders/';
filename hmm '/folders/myfolders/dlmm.dat';
data friday.dlm;
infile hmm dsd dlm = '&';
input name $ age age2;
run;

---------------------------LIBNAME-------------------------------------
/*In order to Access the SAS Table you must submit a libname statement to make SAS know that you want to access the folder as a SAS library*/
---to create permanent library in University edition ----
libname STUDY1 "/folders/myfolders/"; ## We have to give this specific path
run;
----------Create a data set in SAS-------------------------
Data ABCkipractice;
input Name $ Dob Position $15-40;
datalines;
ABC 02121994 Director_Senior
Priya 04091994 Assosiate_Director
;
run;
-------------To copy Dataset from local library to permanent library-------------------
data Study1. practice;
	set bhailu;
run;
----------SAS Dataset with where clause and somewhere it can ----------------------
data study1. pactice2;
 set bhailu;
 where year>'1997' and Europe<50 and Africa > 50 ;
run;
----------Creating a new variable in SAS-------------------
data study1. pactice2;
	set bhailu;
	sum = Europe+Asia+America+Africa;
run;

------------------------to round the values of new variable to 10th decimal place--------------
data study1. pactice2;
	set bhailu;
	sum = Europe+Asia+America+Africa;
	sum = round(sum, .1);
run;
--------------------------To create another variable containing string------------------------------
data study1. pactice2;
	set bhailu;
	sum = Europe+Asia+America+Africa;
	sum = round(sum, .001);
	Warning = 'All are sample data';
run;
----------------------------------------SAS DATES-----------------------------------------
/*SAS stores dates as numeric values using a base date of January 1st, 1960, so people born before 1960 have a negative birthdate*/
-----------------FORMAT and FORMAT Statement---------------------------------------
A format is an instruction that tells SAS how to display a value. THE FORMAT Statement associates a particular format with a variable.
example:
proc print data = work.ABCkipractice;
format total comma9.2 dob date9.;
run;
2. PROC PRINT DATA = ABCKIPRACTICE;
	format total dollar10.2 Birthdate mmddyy10.;
RUN;
3.proc print data = Sashelp.workers;
 format date mmddyy10.;
run;

libname sat '/folders/myfolders';

filename satmix '/folders/myfolders/Chalomix.txt';

data satvadu;
infile satmix;
input city $1-13 country $ year salary;
informat salary comma9.;
format salary comma9.;
run;

------------------------To Calculate the frequency of the data of a particular column--------------------
1. proc freq data = work.ABCkipractice;
 tables Birth_Date /nocum;
run;
2. proc freq data = work.ABCkipractice;
tables Birth_Date /nocum;                ##nocum means no cumulative frequency or cumilative percentage.
format Birth_date year4.;
run;
3.proc freq data = sashelp.workers;
 tables date;
 format date year4. ;
run;
4.proc freq data = sashelp.workers;
 tables date;
 format date MONYY. ;
run;
---------------------------------------Sorting data in SAS----------------------------------
1.proc sort data = sashelp.workers out = work.ABCuda;
 by Electric;
run;
2.proc sort data = sashelp.workers out = work.ABCuda;
 by descending Electric descending masonry;
run;
3.proc sort data = WOHHO out = sala;
by descending Europe;
run;
4.proc sort data = import out = hello nodup dupout = chalo; ##nodup helps us to remove duplicate if
by sales;
run;

now print and know which item is having duplicate value

proc print data = chalo;
run;

proc sort data = import out = hello nodupkey
by descending sales ;
run;

proc print data = hello;
run;




-----------------FORMATS AND INFORMATS------------------------------
Formats and informats are basically used to display the types if the values you want to display
Informat-- It is used to convert Nonstandard data into standard data
Format - It is used to convert standard data into non-standard data
10/09/08--special character-->Non standard data
40,000--special character-->Non standard data
34987--numeric--->standard data
10/09/08 - -Non standard--informat--mmddyy8.
11/11/2014--Non standard--informat--mmddyy10.
10/Mar/09--Non standard--Date9.
$50,000--Non standard--informat--Dollar7.
75,000--Non-standard--informat--comma6.
Euro50,000--Nonstandard--Euro7.
----------------------FORMAT AND INFORMAT Examples---------
data Tus;
input no name$5-14 Date;
informat date mmddyy10.;
/**informat Date mmddyy10.;**/
format Date mmddyy8.;
datalines;
123 ABC      02/12/1994
154 Chayanika 11/11/1993
;
run;
2.data Tues21;
input id name$ dob doj;
informat dob mmddyy10. doj mmddyy10.;
format dob ddmmyy8. doj ddmmyy8.;
datalines;
1001 ABC 12/02/1994 12/16/2016
1002 Chayanika 11/17/1993 09/23/2016
;
run;

proc print data = Tues21;
run;
3. data Tues22;
input id name$ dob salary;
informat dob ddmmyy10. salary comma9.; 
format dob ddmmyy8. salary rupees9.;
datalines;
1001 ABC 02/12/1994 50,000
1003 Sohaib 12/04/1994 800,000
;
run;

proc print data = Tues22;
run;
4.data Tues22;
input id name$ dob salary;
informat dob ddmmyy10. salary comma9.; 
format dob ddmmyy8. salary words22.;
datalines;
1001 ABC 02/12/1994 50,000
1003 Sohaib 12/04/1994 800,000
;
run;

proc print data = Tues22;
run;

5.data Tues23;
input num name$ dob comm;
informat dob mmddyy8. comm percent3.;
format dob mmddyyc8. comm percent3.;
datalines;
1001 ABC       12/02/1994 30%
1002 Chayanika  11/17/1993 40%
;
run;

proc print data = Tues23;
run;
6. data tues24;
input num name $ dob;
informat dob mmddyy10.;
format dob mmddyyc10.;
datalines;
1002 ABC     12/02/1994
1004 Chayanks 11/17/1993
;
run;
proc print data = tues24;
run;
7. data tues24;
input num name $ dob;
informat dob mmddyy10.;
format num roman5. dob mmddyyc10.;
datalines;
1002 ABC     12/02/1994
1004 Chayanks 11/17/1993
;
run;
proc print data = tues24;
run;
8.data tues42;
retain var1-var4 9872;
run;


proc print data = tues42;
format var1 mmddyy8. var2 mmddyy10. var3 dollar6. var4 words32.;
run;
9. data tues53;
input phone;
format phone best18.;
datalines;
98786950545342322
;
run;


------------------------different types in date format you can use------------
/*
for example mmddyyd8. for dashes between dates instead of slash
different types are:
c- colon(:)
p-point(.)
s-slash(/)
n-empty()
d-Dash(-)
*/
-----------------------------To select date according to which century we use----------
/* Default yearcutoff in SAS is 1920
and the year cutoff has a span of 100 years:
12/07/41  → 12/07/1941
12/07/15  → 12/07/2015……..if the yearcutoff value is 1920.*/
options yearcutoff = 2000;
data tues66;
input date;
informat date mmddyy8.;
format date mmddyy10.;
datalines;
12/02/94
11/05/30
07/03/09
;
run;
------------------------------------To select a particular variables with title-------------------------
1.	proc print data = study.continents;
	title "Waah ABC Waah";
	var year Asia America;
run;
2.proc print data = study.continents;
	title "Hmmm";
	var Year Asia America;
	sum Europe Asia America;
run;

-------------------------Temporary and permanent data files-------------------------------
/*Temporary data files are one level data set which just uses one level name to define a data set name
whereas permanent data files are two level data set name which uses two level name to define a data set name.*/
For example-----creating the Permanent library reference named MYSASLIB
libname mysaslib ‘C:\SASDATA’;
data mysaslib.mydata;
input @1 Id $3. @4 SBP 3.;
datalines;
1001 80034
1002 30092
;
run;
proc print data = mysaslib.mydata;
run;
-----------------------------To Use LABEL Statement in SAS--------------------------------------
data thursd;
input id Name $;
datalines;
1001 ABC
1002 Priya
;
run;
proc print data = thursd LABEL;
Label id = 'Identification'
       name = 'Naming Convention';
run;

-------------------------------PROC MEANS-------------------------------------------------------------------------
Use:
Aggregating data
Descriptive statistics
Hypothesis Testing
Data Validation
------Example----
data thursd Label;
input id Name $;
datalines;
1001 ABC
1002 Priya
;
Label id = 'Identification'
      name = 'Naming Convention';
run;
proc means data = thursd;
run;

2>data thursd Label;
input id Name $;
datalines;
1001 ABC
1002 Priya
;
Label id = 'Identification'
      name = 'Naming Convention';
run;
proc means data = thursd n nmiss mean median p1 p5 p10;
run;
INPUT AND OUTPUTTT
proc means data = WOHHO;
var Europe Asia America Africa;
run;

proc summary data = WOHHO print;
var Europe Asia America Africa;
run;


proc means data = WOHHO n nmiss mean median p5 p95 p25 p75 std stderr clm;
var Europe America Asia Africa;
run;
 

proc means data = WOHHO (where (season = 'summer'));
var Europe America Asia Africa;
run;

proc means data = WOHHO (where (season = 'summer'));
var Europe America Asia Africa;
run;

proc means data = Teja sum min max maxdec = 2 nonobs;
class region;
var customers discount sales;
run;

proc means data = Teja sum min max maxdec = 2 nonobs noprint;
class region;
var customers discount sales;
output out = outdata mean = avgsales avgdiscount avgprofit max=;
run;

proc means data = teja maxdec = 2;
class region;
var sales customers Discount;
output out = ohho /autoname;
run;
###Above and below code gives same output####

proc means data = teja;
class region;
var customers sales discount;
run;

BUTTT
proc means data = teja maxdec = 2;
class region;
var sales customers Discount;
output out = ohho mean= max= min=/autoname;
run;
give output as 
 
proc means data = teja maxdec=2 noprint;
class region;
var customers sales discount;
output out = okk mean(Sales)= max(customers discount)=/autoname;
run;





--------------ALSO-----PROC summary---------------------------------
/*The main difference between Proc means and summary is we can get everything from mean that we get in summary.
In summary basically we get number of counts of observation */

proc summary data = WOHHO print;
run;
Will give the output as just the number of observation whereas
proc means data = WOHHO;
var Europe Asia America Africa;
run;

data shoerange;
set sashelp.shoes;
length salesrange $ 20;
if sales lt $100,000 then
    salesrange = 'Lower';
else if $100,000 <= sales <= $200,000 then
     salesrange = 'Middle';
else salesrange = 'Upper';
run;


proc summary data = WOHHO print;
var Europe Asia America Africa;
run;
BOTH GIVES THE SAME OUTPUT
--------------------------------To print the distinct data in the column------------------------

proc sql;
select distinct name from thursd;
run;

--------------IF/ELSE Statement-----------------------------------------------
data vaishnav;
set import;
if sales < 50000 then sales = .;
run;

data shoerange;
set sashelp.shoes;
length salesrange $ 20;
if sales lt $100,000 then
    salesrange = 'Lower';
else if $100,000 <= sales <= $200,000 then
     salesrange = 'Middle';
else salesrange = 'Upper';
run;
------------------------------------------------------Retain/sum statement--------------------------------
data vaishanvwithretain;
set import;
retain tot;
tot = sum(tot, sales);
run;
OOORRRRR by simply using sum statement
data vaishanvwithretain;
set import;
retain tot;
tot = sum(tot, sales);
run;

data whhhy;
set import;
retain tot 1000;
tot+sales;
run;

------------------------------Tilde Modifier-------------------------------------------------------
*/ Tilde modifiers are used to make SAS read data if the data has any delimeter other than mentioned in the dlm statement then we use tilde modifier in the form ‘~’/*
libname sat '/folders/myfolders';

filename satmix '/folders/myfolders/Chalomix.txt';

data satvadu;
infile satmix dsd dlm=',';
input city : $20. Country : $20. Year : $4. Salary ~ $10.;
run;

In this scenario Salary contained dash in between the values the output we got is like:
 

-----------------------?, ?? modifiers-------------------------------------------------
*/ It is used to NOT PRINT the garbage value if any column contains other than intended /*
Input data 
 

OUTPUT
 

libname sat '/folders/myfolders';

filename satmix '/folders/myfolders/Chalomix.txt';

data satvadu;
infile satmix dsd dlm='-';
input city : $20. Country : $20. Year  Salary : ~ ?? comma9. ;
run;

-----------------------------------------------STOPOVER-----------------------------------------
Stopover make s SAS to stop if it encounters any space or wierd values
libname sat '/folders/myfolders';
filename satmix '/folders/myfolders/People.txt';
data satvadu;
infile satmix stopover;
input Name $ marks;
run;

-----------------------------------------MISSOVER------------------------------
/* Missover make a SAS to continue reading the data set even  if it encounters any missing values this helps us to stop loosing the data because in the normal scenario we lose the data if we encounter any missing values */
libname sat '/folders/myfolders';
filename satmix '/folders/myfolders/People.txt';

data satvadu;
infile satmix missover;
input Name $ marks;
run;
--------------------------------------------------------Truncover-------------------------------------

/* Truncover helps us by making SAS read the dat even if it is not meeting the criteria of what it expects or whatever is mentioned in the input statement.
for example if the user has mentioned that the size of the particular variable would be 20 but the size of the value is 4.
If it is normal like if we don’t use the turnover in the infile statement then it will not read the values if the first variable doesn’t meet the criteria.
BY using truncover we can make SAS read the data if it doesn’t meet the criteria. */
INPUT
 

WITHOUT Missover
libname sat '/folders/myfolders';

filename satmix '/folders/myfolders/nice.txt';

data satvadu;
infile satmix;
input Name $8. Country $20. ;
run;

OUTPUT
 
With Missover
libname sat '/folders/myfolders';

filename satmix '/folders/myfolders/nice.txt';

data satvadu;
infile satmix missover;
input Name $8. Country $20. ;
run;
 

WITH TRUNCOVER
libname sat '/folders/myfolders';

filename satmix '/folders/myfolders/nice.txt';

data satvadu;
infile satmix truncover;
input Name $8. Country $20. ;
run;
 

/* By using truncover we can get the desired result so use truncover if you feel that SAS will not read your data. It would not be satisfied without using TRUNCOVER. */

---------------------------------------SCANOVER------------------------------------------------------------------
/* Scanover is used to help user and make SAS read the data if it is of the format Dictionary ie
Name and its values.*/
INPUT
 
/* if we don’t use Scanover still we can read the data using TRUNCOVER and MISSOVER but if we use this before its not confirm we will be able to print the data for (Missover). If we use TRUNCOVER */

libname sat '/folders/myfolders';
filename satmix '/folders/myfold
ers/nice.txt';
data satvadu;
infile satmix truncover ;
input @'Name:' Name : $45. @'State:' State : $34.;
run;
OUTPUT
 
IF we use SCNOVER still we will get the same output
Sorry for wasting your time:p

-----------------UPPERCASE, LOWERCASE, PROPCASE-------------------------------
data Sat;
set test;
upper_case = upcase(make);
lowercase = lowcase(make);
propcase = propcase(make);
run;
----------------------------------------------COMPBL--------------
Compbl is used to reduce the two or more space between the lines to single space
data Satnew;
input call $45.;
datalines;
I have  an issue   with this    report
;
run;
data satt;
set Satnew;
new_call= compbl(call);
run;

--------------------------------------COMPRESS--------------------------
Compress is used to remove special character including the space from the values you want to print.
data Satnew;
input Phone $45.;
datalines;
(+353) 0899 622 569
;
run;

data Wo;
set Satnew;
phone_1 = compress(Phone, "() " );
run;
OUTPUT
 
-------------------------ANY FUNCTION IN SAS---------------------------------------------------
ANY Functions helps us to find punctuations, Alphanumeric, Anydigit in the values so that we can remove using Compress functions.
data Wo;
set Satnew;
phone_1= anypunct(Phone);
phone_2= anyalnum(Phone);
phone_3= anydigit(Phone);
phone_4= compress(Phone, "() ?");
run;

-------------------------------------------#n ----------------------------------
#n in SAS means the no of lines in the dataset for example:



-------------------------------------@@-------------------------------------
@@ is used to make SAS read the line if the other row is in the same row for example:
 
here we just want first row to view till 50, then Isha in the next row.
If we just write a normal dataset it will not print Isha rather it will stop displaying the records after 50 because we have mentioned only SIX variables in the input statement and it will read till six variables.
BUT if we use @@ in the input statement it will continue reading the data even if it encounters six variables.

filename sunmix '/folders/myfolders/sun.txt';
data sunfun;
infile sunmix;
input Name $ Country $ Maths Science History English @@;
run;

--------------------------------------PROC EXPORT DATA----------------------------
Remember the colon where it is used and where it is not:
proc export data=SUNFUN
outfile = '/folders/myfolders/Sunday.xlsx'
DBMS = 'xlsx' Replace;
Sheet = 'Sheet1';
run;

This is used to export data into excel


--------------------------------------------Program Data Vector------------------------------
SAS data set is processed successfully in two phase:
1.	Compilation phase
2.	Execution phase
------------------------------PRoc Import Procedures-------------------------
proc import datafile='/folders/myfolders/continents data.csv'
DBMS = CSV
OUT = Continents
Replace;
Getnames = Yes;
Sheet = ‘Continents’;


Run;

###Using Guessingrows statement
proc import datafile='/folders/myfolders/mon.txt' 
DBMS = dlm
Out = Wohho
replace;
delimiter=',';
guessingrows = max;
getnames = yes;
run;
-----------------Keep Drop firstobs Rename---------------------------------------
data Monday;
set Continents (keep=year Europe Asia );    ###Keep statement
run;

data Monday;
set Continents (keep=year Europe Asia Rename=(year= saal Europe=EU Asia=AApdu)); ##Rename                                                                               
run;

data Monday;
set Continents (keep=year Europe Asia Rename=(year= saal Europe=EU Asia=AApdu));
Total = Eu+AApdu; ##for selecting and inserting new variable, to access we have to mention renamed names.
run;


data Monday;
set Continents (keep=year Europe Asia Rename=(year= saal Europe=EU Asia=AApdu));
EU = Eu*100;
AApdu = Aapdu*100;
Total = Eu+AApdu;
run;

data Monday;
set Continents (keep=year Europe Asia Rename=(year= saal Europe=EU Asia=AApdu) firstobs=10 obs=19);
EU = Eu*100;
AApdu = Aapdu*100;
Total = Eu+AApdu;
run;

data Monday;
set Continents (keep=year Europe Asia Rename=(year= saal Europe=EU Asia=AApdu) where=(saal<2000 and EU<50));
Total = Eu+AApdu;
run;


-----------------------------------------------Select Statement---------------------------------
data Mondayfun2;
set Mondayfun(keep=year Europe Rename=(year = saal));
select (saal);
when (1990) saal_1='Unniso';
when (1991) saal_1='Dohazar';
End;
run;

data Heart / view=Heart;
set sashelp.heart;
select (Smoking_Status);
   when ('Non-smoker')        Smoking_Cat=1;
   when ('Light (1-5)')       Smoking_Cat=2;
   when ('Moderate (6-15)')   Smoking_Cat=3;
   when ('Heavy (16-25)')     Smoking_Cat=4;
   when ('Very Heavy (> 25)') Smoking_Cat=5;
   otherwise                  Smoking_Cat=.;
end;
run;
-----------------------------PROC Content data-------------------------------
proc contents data = Mondayfun;
run;
TO see all the individual files without exploring the inside of it we can write the below code:
proc contents data = work._all_ nods;
run;

To make a complete table of the names of the column present in the data we can use proc content. The main use of this code is in predictive analysis where we have to mention the name of the columns of the table.
proc contents data = sashelp.cars
out = vars(keep= varnum name)
noprint;
run;
---------------------------------PROC Print DATA-----------------------------
proc print data = sashelp.cars noobs;
run;
##noobs is basically used to supress the number of columns in the observation
Basically it is not much useful but just to remove the unnecessary column in the output



-------------READING MICROSOFT EXCEL DATA USING XLSX ENGINE----------------------------------------
libname xl XLSX '/folders/myfolders/bhaisahab.xlsx';
proc print data = Xl.sheet1;
run;

------------------------------Merging data sets---------------------------------------
Use Set statement to make all the inputs into one dataset or concatenate the two datasets

SET Statement takes the lenght and print the number of observation only those number of observations which are present in the smallest data sets.
for example:
data main;
input x y z;
datalines;
1 2 3
7 8 9
;
run;
data more_people;
input x y z;
datalines;
4 5 6
7 8 9
;
run;
data final;
set main more_people;  ###This will make both the above statement into one
run;
---------Merge statement------
Proc sort data first all the data you want tot merge.
Merge is a statement used to merge the data by a particular common variable
For example
data final_merge;
merge student student_more_info;
by id;
run;

OR

data merging;
merge student student_more_info;
by descending id;
run;


--------------Concatenating statement------------------
data one_to_one;
set student student_more_info;
run;

---------------Appending Statement-------------
Proc append base = ok
                       data = wo;
run;

--------------------RENAMING the dataset in Merge Statement------------------
Suppose you have two datasets and both of them have same name variable Data but with different meaning.
One data set has the meaning of date as Date of Birth and the other one data set has the meaning of date as date of visit.
Do to differentiate while merging, we can rename the dataset which is merged to avoid the confusion.
For example :
data merge_final_o;
merge student(rename=(date=Birthdate))
            student_more_info(rename=(date=Visitdate));
run;

-----------------------DROP KEEP RENAME Statement---------------------------
Suppose i have one data set names satABC
data satABC;
input name $ salary;
datalines;
ABC 30000
susain 4843
khushbu 4842323
;
run;
--------------Keep 
Now if i want to make another dataset
data satABC2(keep = Name);
set satABC;
run;
--------------DROP
Now if in the new dataset you want to drop a particular variable
data satABC2(Drop = Name);
set satABC;
run;
-----------RENAME
Now if in the new dataset you want to rename a particular variable
data satABC2(Rename = (Name=Employee_name));
set satABC;
run;
data satABC2(drop = name);
set satABC;
run;

---------------USING DO END Statement in SAS-------------------------------------
data satABCu2;
set satABCu;
if age>20 and merit<20 then do;
admit = 1;
Status = "Admitted";
end;
else do;
admit = 0;
Status = "Not Admitted";
end;
run;
-----------------------IF/ Else Statement in SAS statement------------------------------------
data satABCu2;
set satABCu;
if age<20 then admit = 1; else if 30<age<45 then admit = 0; else admit = 2;
run;

------------Assign Constant date value to a variable-------------------
data ABCusat;
set satABCu;
TestDate='01jan2000'd;
Time='9:25't;
run;


-------------------Assigning the length of the variable by defining the length statement---------------
data satABCu2;
set satABCu;
length Status $ 20;
if age>20 and merit<20 then do;
admit = 1;
Status = "Admitted";
end;
else do;
admit = 0;
Status = "Not Admitted";
end;
run;
-----------------------First. Last.----------------------------------------
Suppose if we want to see the first. last. variable in the dataset then we have to first make a dataset like this:

data satABCuda;
input name $ age salary Merit;
datalines;
ABC 24 4823232 12
Susain 25 32321 34
sakshi 24 121212 43
Arpit 26 129948 12
Kuku 26 3231212 24
Dan 34 1212312 10
;
run;

then we will sort the dataset
proc sort data = satABCuda out= sat7;
by age;
run;

if we want to see if the data set is having unique value or duplicate value we can use the below code for SAS.
data satABCuda8;
set sat7;
by age Merit;
first = first.age;
last = last.age;
first1 = first.Merit;
last1 = last.Merit;
if first.age and last.age then Single = 1;
else Double = 1;
run;

------------------------------SCAN STATEMENT--------------
Scan statement is used to search a character value and extract a portion of the value.
for example: if the name variable contains ABC KASHIWALA then we can separate the name as last name and first name with the help of SCAN function.
data satABCuda;
input name $ age salary Merit;
datalines;
ABC Kashiwala 24 4823232 12
Susain Chopra 25 32321 34
sakshi Wankhede 24 121212 43
Arpit Gosain 26 129948 12
Kuku Kotnala 26 3231212 24
DanHaydock 34 1212312 10
;
run;

data ScanABCuda;
set satABCuda;
Lastname = scan(Name,2);
Firstname = scan(Name,1);
run;

-----SCAN, UPCASE, LOWCASE, PROPCASE, TRIM--------------
data ScanABCuda;
set satABCuda;
Lastname = scan(Name,2);
Firstname = scan(Name,1);
Lastname_upper = upcase(Lastname);
Firstname_lower = lowcase(Firstname);
Name_Init = propcase(name);
run;


TRIm Function is used to remove the trailing space from the variable for exmaple in the code below we are concetenating the two variables and while concatenating we are facing the spaces in between the names so we can use TRIm function to remove the trailing spaces between the names.
data ScanABCuda;
set satABCuda;
length Okay $11;
Lastname = scan(Name,2);
Firstname = scan(Name,1);
Lastname_upper = upcase(Lastname);
Firstname_lower = lowcase(Firstname);
Name_Init = propcase(name);
Newname = Trim(Firstname)|| Lastname;
run;
------Substr function-------------
data ScanABCuda;
set satABCuda;
length Okay $11;
Lastname = scan(Name,2);
Firstname = scan(Name,1);
Lastname_upper = upcase(Lastname);
Firstname_lower = lowcase(Firstname);
Name_Init = propcase(name);
Newname = Trim(Firstname)|| Lastname;
run;
We use Substr function in order to select a particular variable from the variable for example if we want to print the initials of the first name then we can use the SUBSTR function in the way given in the code:
data ScanABCuda;
set satABCuda;
length Okay $11;
Lastname = scan(Name,2);
Firstname = scan(Name,1);
Lastname_upper = upcase(Lastname);
Firstname_lower = lowcase(Firstname);
Name_Init = propcase(name);
Newname = Trim(Firstname)|| Lastname;
Initials = Substr(Firstname, 1, 1);
Lastinitials = Substr(Lastname, 4,1);
run;
--------------------------------INT FUNCTION--------------------------------------
Int function is used to round the decimal function
data sunABCuda2;
set sunABCu;
Examples1 = int(Examples);
run;
----------------------TRANWRD FUNCTION----------------------
Tranwrd function is used to replece a particular string with anothe word or string
For example:
data ABCudasun;
set sunABCuda2;
Examles7 = tranwrd(name,'ABC', 'Kashi');
run;
-------------------INTCK---------------------------------
It  is used to see the difference between the mentioned date and today.ie it is used to find the years between mentioned date and today.
data ABCudasun;
set sunABCuda2;
Examles7 = tranwrd(name,'ABC', 'Kashi');
Years = intck('year', '15jun1999'd, today());
run;


OUTPUT for years would be 21.

-----------------------MDY FUNCTION, TODAY, DATE and TIME--------------------------
If you have a Month day and year value separately then we use MDY function in order to put the value in single year variable.
data sunABCwant2(drop= month day year);
set sunABCwant;
years = mdy(month,day,year);
run;

DATE FUNCTION returns the todays date if you print it using Format function
data ABCwantrao;
editdate = date();
format editdate date9.;
run;

data sunABCuda2;
set sunABCuda1;
curtime = time();
format curtime time8.0;
run;
Time() function helps to display the current time and in order to display the time in normal format we use timew.d.

--------------------------YEAR , QTR, MONTH and DAY----------------------------
All these functions are used to extract the date values such as Year, Month, Day, QTR from the date value.
data ABCudaa;
set sunABCwant;
year = year(dob);
Qtr = QTR(dob);
Month = month(dob);
Day = day(dob);
run;

-----------------------INTNX, DATDIF, YRDIF-----------------------------
INTNX function is similar to INTCK function but INTNX is used to set target date from the date which we had by ordering in the INTNX format.
This can be done for Month, Dat, year for example:

data ABCudaa;
format date1 date9.;
format date2 date9.;
set sunABCwant;
year = year(dob);
Qtr = QTR(dob);
Month = month(dob);
Day = day(dob);
date1 = intnx('month', dob, 5 , 'b');
date2 = intnx('Year', dob, 5, 'm');
run;



data ABCudaa;
YRDIF is used to calculate the difference between the two date datasets.
format date1 date9.;
format date2 date9.;
set sunABCwant;
year = year(dob);
Qtr = QTR(dob);
Month = month(dob);
Day = day(dob);
date1 = intnx('month', dob, 5 , 'b');
date2 = intnx('Year', dob, 5, 'm');
Datad = yrdif(dob, today(), '30/360');
run;


data ABCudaa;
format date1 date9.;
format date2 date9.;
set sunABCwant;
year = year(dob);
Qtr = QTR(dob);
Month = month(dob);
Day = day(dob);
date1 = intnx('month', dob, 5 , 'b');
date2 = intnx('Year', dob, 5, 'm');
Datad = yrdif(dob, today(), '30/360');
Datad1 = yrdif(dob, today(), 'ACT/ACT');
Datad2 = datdif(dob, today(), '30/360');
Datad3 = datdif(dob, today(), 'ACT/ACT');
run;

BOTH DATDIF, YRDIF do the same thing but as the name suggests DATDIF will give the difference between the dates and will give the date values while YRDIF will give the difference between in years.
SYNTAX is like this
DATDIF(start_date, end_date, basis)
YRDIF(start_date, end_date, basis)
BASIS are of two types for DATDIF and four types for YRDIF
1.	30/360  2. ACT/ACT  3. ACT/360  4. ACT/365

-------------------------AUTOMATIC CONVERSION OF Datatypes from Character to NUmeric and from NUmeric to Character--------------------------------

proc Data ABCwaah;
input Name $ Age $ salary;
datalines;
ABC 34 2345
Susain 23 23212
Raksha 12 3212
;
run;
In this if we do Proc contents data = ABCwaah;
run;

we can see that the age variable is character so in order to change the variable age to numeric we will perform the following operations
data oyeABCu;
set ABCWAAH;
sum = Age+2;
run;

This will convert the Age into numeric like we used Age as numeric and if we do proc contents data = oyeABCu we can see that Sum is having  a numeric datatype.

---------------------------------INPUT and PUT Function----------------------
In order to convert the variable with character datatype to numeric we use INPUT function and in order to convert Numeric datatype to character datatype we use PUT Function.
For example:
data ohho;
set ABCWaah;
a = input(age, best5.);
b = put(salary, best8.);
run;proc contents data = ohho;
Here Age is character variable while salary is numeric variable so to convert both of them to numeric and charcter respectively we used input and PUT function.




------------------------------------PROC TRANSPOSE---------------------
data subjects;
input sub1 $ sub2 $ sub3 $ sub4$;
datalines;
12 32 43 19
65 34 29 87
M F M G
;
run;


PROC TRANSPOSE data = subjects
out = Transposed ;
var sub1 sub2 sub3;
run;

/* In this the output will be transposed with the default column name as col1 col2 col3. */

To change the name of the default coulmns name to for example INFO1 INFO2 INFO3
we will use the following code:
proc transpose data = subjects
out = transposed PREFIX = INFO;
var sub1 sub2 sub3;
run;

Proc print data = TRANSPOSED;
run;

NOWWWW TO RENAME THE COLUMNS IN THE TRANSPOSED DATA
data new;
set transposed;
RENAME INFO1= T1 INFO2= T2
		INFO3= T3 INFO4= T4 _NAME_=SUBJECT;
run;

--------------
data subjects;
input lab $ sub1 $ sub2 $ sub3 $ sub4 $;
datalines;
BASELINE 12 43 54 12
TIME1 43 23 12 43
TIME2 43 12 43 65
TIME3 12 34 56 54
GENDER F M F M
;
IT will give the below output
 


proc transpose data = subjects
out = Waah;
id lab;
var sub1 sub2 sub3 sub4;
run;
ID will make the columns into proper transposed with the  values
This will give the below output:
 


------------------------------------USER DEFINED FORMAT---------------------------------------
proc print data = sashelp.class;
format age age.;
run;
Here we can see i used the format age. but we don’t have any format called age. so we have to create our own format in order to use this format.
proc format;
value age 1 - 15 = 'Child'
15 - 40 = 'Adult';
run;

---------------------------------------ODS--------------
ODS is basically used to create output objects.
Output objects can be of many types such as RTF, PDF, Excel and many others.
The main advantage of ODS is that it gives you much more flexibility and you can save your output in various format such as HTML, PDF.

GENERAL FORM OF USING an ODS SYSTEM
ods open destination;
ods close destination CLOSE;
→ the file is stored in HTML format by default
ods listing;
proc print data = sasuser.mydata;
run;
ods listing close;
SGS PLOT--------------
Sgs plot is used to visualise the data.
They are of different types such as scatter plot, bar charts, box plots, ubble plot, line charts, histogram and lot more.
suppose if you want to visualize the stock data for a particular time period then :
 ods graphics on;
proc sgplot data = sashelp.stocks;
series y = close x = date / group=stock;
run;
quit;

-----------------------SUM Statement Special Class----------------
data ABC2;
input ABC1 ABC2 ABC3;
datalines;
12 13 15
;
run;

data ABC3
set ABC2;
sum = sum(of ABC:);
run;



-----------------------------------Merging data set result as per one of the question in Analytics Exam------
 

PUTLOG
Putlog statement specifies the message that you want to put on SAS log.
Putlog statement is similar to Error statement the only difference is that it does not put value as 1 as error statement does.

----------------INDEX Function---------------------------------------------
The index function enables you to search for a specific character value for a specified value.
for example :
index(job, ‘word processing’)

------------Analytics IF/Else Statement------------------------
data shoerange;
set sashelp.shoes;
length salesrange $ 20;
if Sales lt 100000 then salesrange = 'Lower';
else if (Sales gt 100000 and Sales lt 200000) then salesrange = 'Middle';
else salesrange = 'Upper';
run;
proc means data = shoerange;
where salesrange = 'Middle';
run;


------------------PROC TABULATE-------------
proc tabulate sashelp.shoes;
class region subsidiary;
table region*subsidiary;
run;

-------------------PROC REPORT -------------------
/* Proc Report data is same as proc print data but in proc report you can add column, format etc. */

proc report data = sashelp.class nowd headskip headline;
columns = Name age sex
proc report data = sashelp.class headskip ;
columns name age sex; 
define name/'Bhailu';
run;
--------------------------------------LINESIZE AND PAGESIZE------------------
options number date pagesize=15; 
 proc print data=sasuser.admit; 
 run;

/* Here pagesize means the number of lines each page will contain */

ODS listing;
 options number linesize=64;  
proc print data=flights.europe;  
run;
Here the Linesize specifies the width of the print line for the procedural output.


-------------------ODS Again-------------------------------------------
• the BODY= specification creates data.html in the c:\records directory. The body file contains the results of the two procedures.  
• the CONTENTS= specification creates toc.html in the c:\records directory. The table of contents file has links to each procedure output in the body file.  
• the FRAME= specification creates frame.html in the c:\records directory. The frame file integrates the table of contents and the body file. 

-------------------------DOuble statement------------------------
/* Double statement is used to create double spaceit. If you want to change the space of the output or make it double space then we use Double in the statement. */
---Footnotes and Titles------------------------
footnote1 'Data from Treadmill Tests'; 
footnote3 '1st Quarter Admissions';  
proc print data=clinic.stress;    
 var resthr maxhr rechr;    
where tolerance='I'; 
 run;

/* Footnote title appears into the bottom of the observations and title are used if you want to make titles. */


















































