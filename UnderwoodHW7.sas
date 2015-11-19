/*Sean Underwood, MATH510  */

/*First thing is to load our Orion library. I have comented this out so
it can be run easily be uncommenting.

libname orion "/folders/myfolders/Data_One";*/



/**********************************************************************/
/* EXCERCISE 3.2 LEVEL 1                                              */
/**********************************************************************/
/* the below data step creates a file "donations" in the work library*/
/* the infile command tells SAS where to find our data file, in this case
it is the path that we have previously specified (the data_one folder)
it might be worth stating that I had to change the backslash to a forward
slash since we are working in a linux environment*/
/* Our donation.dat file only contained 5 columns of data.  We create a
total column by creating a value Total and using a sum operation to
sum up the 4 quarters of data*/
/* run then signals to SAS that we have completed the Data Step*/
data work.donations;
	infile "&path/donation.dat";
	input Employee_ID Qtr1 Qtr2 Qtr3 Qtr4;
	Total=sum(Qtr1, Qtr2, Qtr3, Qtr4);
run;

/* the proc contents procedure will give us a description of the data that
we specify.  We specify the data that we want described by using the data=
code.  What follows the data= code is the data that our contents procedure
will operate on.  In this case, we are directing contents to our donations
file that we created in the work library.*/
proc contents data=work.donations;
run;

/* the proc print procedure instructs SAS to print the data followed by
the = sign */
proc print data=work.donations;
run;

/*****************************************************************************/
/* EXCERCISE 3.2 LEVEL 2                                                     */
/*****************************************************************************/
/* we create a file newpacks in our work library, */
/* we are not importing from a csv type file so the data is manually entered
following the datalines; code.  The input command is used to setup the structure
of the data.  there will be three columns of data with column names Supplier_Name,
Supplier_Country, and Product_Name.  Since this data is not comman delineated, we
have to specify what characters of data belong in each column.  The numbers
following the $ specify the range of characters that fit into each column.  The
$ lets SAS know that the data will be character data (as opposed to numeric) */
data work.newpacks;
	input Supplier_Name $ 1-20 Supplier_Country $ 23-24 Product_Name $ 28-70;
	datalines;
Top Sports            DK   Black/Black
Top Sports            DK   X-Large Bottlegreen/Black
Top Sports            DK   Comanche Women's 6000 Q Backpack. Bark
Miller Trading Inc    US   Expedition Camp Duffle Medium Backpack
Toto Outdoor Gear     AU   Feelgood 55-75 Litre Black Women's Backpack
Toto Outdoor Gear     AU   Jaguar 50-75 Liter Blue Women's Backpack
Top Sports            DK   Medium Black/Bark Backpack
Top Sports            DK   Medium Gold Black/Gold Backpack
Top Sports            DK   Medium Olive Olive/Black Backpack
Toto Outdoor Gear     AU   Trekker 65 Royal Men's Backpack
Top Sports            DK   Victor Grey/Olive Women's Backpack
Luna sastreria S.A.   ES   Hammock Sports Bag
Miller Trading Inc    US   Sioux Men's Backpack 26 Litre.
;
run;

/* the proc contents procedure will give us a description of the data that
we specify.  We specify the data that we want described by using the data=
code.  What follows the data= code is the data that our contents procedure
will operate on.  In this case, we are directing contents to our donations
file that we created in the work library.*/
proc contents data=work.newpacks;
run;

/*****************************************************/
/******ANSWERS TO QUESTIONS***************************/
/**HOW MANY OBSERVATIONS ARE IN THE DATA SET?_13__

/**HOW MANY VARIABLES ARE IN THE DATA SET?__3__

/*****************************************************/
/* the proc print procedure instructs SAS to print the data followed by
the = sign */
proc print data=work.newpacks;
run;

/************************************************************************/
/* EXCERCISE 3.2 CHALLENGE                                              */
/************************************************************************/
data work.date;
	CurrentDate=today();
	CurrentTime=time();
	CurrentDateTime=datetime();
run;

proc print data=work.date;
run;

/* CurrentDate=today() measures the number of days since January 1, 1960

/* CurrentTime=time() is in the format hh:mm:ss.ss
Time is a value representing the number of seconds since midnight of the
current day. SAS time values are between 0 and 86400.*/
/* CurrentDataTime=datatime() is in the format ddmmmyy:hh:mm:ss.ss
is a value representing the number of seconds between
January 1, 1960 and an hour/minute/second within a specified date.  In this
case, no date was specified so SAS is counting the number of seconds between
Jan. 1, 1960 and the current time.

/*****************************************************/
/******ANSWERS TO QUESTIONS***************************/
/* A SAS TIME VALUE REPRESENTS THE NUMBER OF: days since January 1, 1960

/* A SAS DATETIME VALUE REPRESENTS THE NUMBER OF: seconds between
January 1, 1960 and an hour/minute/second within a specified date.  In this
case, no date was specified so SAS is counting the number of seconds between
Jan. 1, 1960 and the current time.

/*****************************************************************************/
/* EXCERCISE 4.1 LEVEL 1                                                     */
/*****************************************************************************/
/* the following code prints the contents of the order_fact file located
in the Orion library*/
/* Problem b asks us to add a sum to the Total_Retail_Price column.  To
accomplish this we add a sum command followed by the name of the column */
proc print data=orion.order_fact;
	sum Total_Retail_Price;
run;

/* Problem c asks us to use a WHERE statement to only print obs whose
total retail price exceeds 500.  We use the code where column name > 500
to accomplish this*/
proc print data=orion.order_fact;
	sum Total_Retail_Price;
	where Total_Retail_Price > 500;
run;

/*****************************************************/
/******ANSWERS TO QUESTIONS***************************/
/* THERE ARE NOW ONLY 35 OBSERVATIONS.  BEFORE THERE WERE 617 OBSERVATIONS.
THE OBS COLUMN IS STILL IN ORDER BUT SKIPS THE OBSERVATIONS THAT DID NOT
MEET THE CRITERIA*/
/* YES.  NOW THE TOTAL RETAIL PRICE IS $32,696.60*/
/******************************************************/
/* Problem d asks us to supress the OBS column.  we accomplish this by
adding noobs immediately following hte data= assignment.*/
proc print data=orion.order_fact noobs;
	sum Total_Retail_Price;
	where Total_Retail_Price > 500;
run;

/*****************************************************/
/******ANSWERS TO QUESTIONS***************************/
/* WE KNOW THAT THERE ARE STILL 35 OBSERVATIONS BY EXAMINING THE LOG.

/******************************************************/
/* Problem e asks us to add an ID statement to use Customer_ID as the
identifying variable.*/
/* we use the id Customer_ID; command to accomplish this.  we could have
follwed id with any valid column name that we wanted to use.  In this
construction, the noobs command is not necessary.  Since the Customer_ID
column now serves as the id, SAS highlights that column in blue and does
not add an additional obs column*/
proc print data=orion.order_fact;
	sum Total_Retail_Price;
	where Total_Retail_Price > 500;
	id Customer_ID;
run;

/*****************************************************/
/******ANSWERS TO QUESTIONS***************************/
/* THERE IS NO OBS COLUMN AND THE Customer_ID COLUMN IS BLUE
/******************************************************/
/* Problem f asks us to used the VAR statement to select the columns
that we want displayed.  */
/* we add a var command immediately following the proc statement.
we list the column names of the columns that we want to include
in the order that we want to include them.  */
proc print data=orion.order_fact;
	var Customer_ID Order_ID Order_Type Quantity Total_Retail_Price;
	sum Total_Retail_Price;
	where Total_Retail_Price > 500;
	id Customer_ID;
run;

/*****************************************************/
/******ANSWERS TO QUESTIONS***************************/
/* THE Customer_ID COLUMN IS DUPLICATED
/******************************************************/
/* Problem G asks us to fix the duplication of the Customer_ID
column.*/
/* To fix the duplication issue, we remove Customer_ID from the
var statement.  This way the Customer_ID is still our id and will
appear at the beginning of each row but is not duplicated  */
proc print data=orion.order_fact;
	var Order_ID Order_Type Quantity Total_Retail_Price;
	sum Total_Retail_Price;
	where Total_Retail_Price > 500;
	id Customer_ID;
run;

/*****************************************************************************/
/* EXCERCISE 4.1 LEVEL 2                                                     */
/*****************************************************************************/
/* Problem (2a) asks us to write a print proc for orion.customer_dim*/

proc print data=orion.customer_dim;
run;

/* Problem (2b) asks us to modify our print procedure:

by subsetting our data to only include customers between the ages of 30 and 40
	First we suppress the obs column by adding noobs immediately after the
	print command data=orion.customer_dim command
	
Additionally, we need to suppress the observations column
	Next, we subset the data by using the Where operator combined with
	>=30 and <=40*
*/

proc print data=orion.customer_dim noobs;
	where Customer_Age >=30 and Customer_Age <=40;
run;

/* Problem (2c) asks us to use the Customer_ID as the identifying column instead
of the obs column.  To accomplish this we will add id Customer_ID after the
line containing the where operator*/
proc print data=orion.customer_dim;
	where Customer_age >=30 and Customer_Age <=40;
	id Customer_ID;
run;

/* Problem (2d) asks us to limit the columns that print.  To accomplish this we
add the var operator followed by the desired columns.  We do not have to
include Customer_ID after the var operator because that would duplicate the
column since it is all ready our identifying column.*/
proc print data=orion.customer_dim;
	var Customer_Name Customer_Age Customer_Type;
	where Customer_age >=30 and Customer_Age <=40;
	id Customer_ID;
run;

/*****************************************************************************/
/* EXCERCISE 4.2 LEVEL 1                                                     */
/*****************************************************************************/

/* Problem (5a) asks us to sort the employee_payroll file by salary and
print it.  We add a sort command followed by the library.file_name that 
we want to sort.  The sort command creates a new temporary file with the
sorted data so we must specify what that filename will be preceeded by out=
then we specify which column we want our data sorted by.*/

/*Problem (5b) asks us to modify the print procedure to print the 
new temporary sorted file. */

proc sort data=orion.employee_payroll
			 out=work.sort_salary;
	by Salary;
run;

/*Problem (6a) asks us to sort employee_payroll by gender and then add a 
secondary sort by salary in descending order.  We need to name our temp
sorted file sort_salary2.  To accomplish this we do the same steps as above:
a sort command followed by the library.filename that we want to sort, 
specify the name of the temp file for the output, add a by command followed
by the column name that we want to sort by.  The information following 
the by command is changed by adding the secondary sort and specifying
the order of that secondary sort. */

/*Problem (6b) asks us to modify the print procedure to print the new
temporary sorted file. */

proc sort data=orion.employee_payroll
				out=work.sort_salary2;
	by Employee_Gender descending Salary;
run;

proc print data=work.sort_salary2;
run;

/*****************************************************************************/
/* (4) EXCERCISE 4.2 LEVEL 2                                                 */
/*****************************************************************************/

/*Problem (7a) asks us to sort orion.employee_paryoll by Employee_Gender
and by Salary in descending order and place this in a temporary file
named sort_sal.  We accomplish this exactly as we did in problem 6b */

proc sort data=orion.employee_payroll
				out=work.sort_sal;
	by Employee_Gender descending Salary;
run;


/*Problem (7b) asks us to print a subset of sort_sal: 

only obs with no termination data, who earn more than $65,000.    
	We accomplish this with the where. . .; command

Group the report by Employee_Gender
	We accomplish this with the by Employee_Gender; command
	
include totals and subtotals for Salary.
	We accomplish this with the sum Salary; command
Suppress the Obs column
	We add noobs to the print procedure statement
	
display only Employee_ID, Salary, and Marital_Status.
	We accomplish this with the var command */

proc print data=work.sort_sal noobs;
	by Employee_Gender;
	sum Salary;
	where Employee_Term_Date is null and Salary > 65000;
	var Employee_ID Salary Marital_Status;
run;



/*****************************************************************************/
/* (4) EXCERCISE 4.3 LEVEL 1                                                 */
/*****************************************************************************/


/*Problem (9a&b) ask us to take the given print statement and add a var
command to limit the columns to: Obs, Employee_ID, First_Name, Last_Name,
Gender, Salary.  Note, to include Obs I just removed the noobs command */

/*Problem (9c) asks us to:
add a Title: Australian Sales Employees.
	we use the title1 command followed by the title enclosed in '';

add a Subtitle: Senior Sales Representatives
	we use the title2 command followed by the 'subtitle';
	
add a Footnote: Job_title: Sales Rep. Iv
	we use the footnote1 command
	
titlen is valid for n 1-10 and will stay in effect until we 
change the title*/

title1 'Australian Sales Employees';
title2 'Senior Sales Representatives';
footnote1 'Job_title: Sales Rep. Iv';

proc print data=orion.sales;
	where Country='AU' and Job_Title contains 'Rep. IV';
	var Employee_ID First_Name Last_Name Gender Salary;
run;

/*Problem (9e) asks us to submit the null title and footnote commands to
clear the titles and footnotes*/

title;
footnote;


/*Problem (10a) asks us to change the labels:
Employee_ID to Employee ID, First_Name to First Name, Last_Name to Last Name,
Salary to Annual Salary.  We accomplish this with the label command followed
by Column_Name='Desired Name';  Also, the label command must appear in the 
proc print line. */

title 'Entry-level Sales Representatives';
footnote 'Job_Title: Sales Rep. I';

proc print data=orion.sales label noobs;
	where Country='US' and Job_Title='Sales Rep. I';
	var Employee_ID First_Name Last_Name Gender Salary;
	label Employee_ID='Employee ID'
			First_Name='First Name'
			Last_Name='Last Name'
			Salary='Annual Salary';
run;

title;
footnote;

/*Problem (10b) asks us to use a blank space as the SPLIT= character to 
generate a two line column heading.	We use the exact same code as in 10a
but we change the label command in the proc print line to slit=' '. */


title 'Entry-level Sales Representatives';
footnote 'Job_Title: Sales Rep. I';

proc print data=orion.sales split=' ' noobs;
	where Country='US' and Job_Title='Sales Rep. I';
	var Employee_ID First_Name Last_Name Gender Salary;
	label Employee_ID='Employee ID'
			First_Name='First Name'
			Last_Name='Last Name'
			Salary='Annual Salary';
run;

title;
footnote;



/*****************************************************************************/
/* (4) EXCERCISE 4.3 LEVEL 2                                                 */
/*****************************************************************************/

/*Problem (11a) asks us to write a program to display orion.employee_addresses
as follows:

Title: Us Employees By State
	add title1 'desired title'; before the print statement

Suppress Obs #
	add noobs in the proc print line

Columns Included= Employee_ID, Employee_Name, City, Postal_Code
	use the var command followed by the desired columns using no commas
	
Have two row Col. Names and Change Col. Names to:Employee ID,Name,City,Zip Code
	the two row feature is accomplished by including split=' ' in the print st.
	use the label command within the body of the print proc followed by
	Column_Name='Desired Name'
	
Group by State
	use the by command followed by State within the print proc
	
Sort by State,City,Employee_Name
	use a separate sort proc before the print proc.  We specify the input
	and output file.  We specify the column names of the columns that we
	want to sort by 
	
Limit the output to country = US to get rid of international records
	within the print proc, we use the where command to limit obs to those
	only containing country = 'US'
	
Reset the titles. 
	this problem didn't ask us to do this but we issue the null command
	to reset the titles.
 */

title1 'US Employees By State';


proc sort data=orion.employee_addresses
			out=work.address_sort;
	by State City Employee_Name;
run;
			
proc print data=work.address_sort split=' ' noobs;
	var Employee_ID Employee_Name City Postal_Code;
	label Employee_ID='Employee ID'
			Employee_Name='Name'
			Postal_Code='Zip Code';
	by State;
	where Country = 'US';		
run;

title1;


/*****************************************************************************/
/* (5) EXCERCISE 5.1 LEVEL 1                                                 */
/*****************************************************************************/


/*Problem (1ab) asks us to open and modify the print statement to show
Employee_ID, Salary, Birth_Date, Employee_Hire_Date.  We accomplish this
with the var command followed by the desired fields. */

/*Problem (1c) deals with format.  First I will explain how formats 
work in SAS. Formats follow the <$>format<w>.<d> convention.
<$> indicates a character format
w specifies total format width including decimal places
. is required syntax
d specifies the number of decimal places to show

the problme asks us to change the formats as follows:
First, I ran the contents procedure to see how wide each field is

Salary in $ format: use dollar11.2 - specifies Dollar style to include a 
	total width of 11 with two decimal places.

Birth_Date in dd/mm/yyyy format: used mmddyy10.

Employee_Hire_Date in ddMONTHyyy style where MONTH is a three letter abbreviation:
	used date9.

 */

proc contents data=orion.employee_payroll;
run;

proc print data=orion.employee_payroll;
	var Employee_ID Salary Birth_Date Employee_Hire_Date;
	format Salary dollar11.2 Birth_Date mmddyy10. Employee_Hire_Date date9.;
run;


/*****************************************************************************/
/* (5) EXCERCISE 5.1 LEVEL 2                                                 */
/*****************************************************************************/


/*Problem (2a) asks us to write a report using orion.sales that inludes:

title1: US Sales Employees
	use title1 command before the print proc

title2: Earning Under $26,000
	use title2 command before the print proc

No Obs #'s
	add noobs in the first line of the print proc

Include the columns: Employee_ID,First_Name,Last_Name,Job_Title,Salary,Hire_Date
	use the var command followed by the desired column names	

Make the column headings two rows
	use the split=' ' command in the first line of the print proc

Change the column headings to Employee_ID,First Name,Last Name,Title,
and Date Hired
	use the label command in the body of the print proc followed by the
	column_name='desired name' for each column name we want to change
	
Format Salary to $10,000 style and Date Hired to MMMYYY where MMM are letters
	use the format command and dollar10. to give us a dollar currency format
	with a width of 10 and MONYY7. to give us the MMMYYY format
	
Subset to include only Job_Title= "Sales Rep. I" and Salary < 26000 and 
Employee_ID >= 121036
	use the where command to limit the observations
	
Sort obs by Employee ID
	prior to the print proc we make a sort proc where we identify our input
	and specify a temp output file
 */


proc sort data=orion.sales
			out=work.sales_sort;
	by Employee_ID;
run;



title1 'US Sales Employees';
title2 'Earning Under $26,000';

proc print data=work.sales_sort split=' ' noobs;
	var Employee_ID First_Name Last_Name Job_Title Salary Hire_Date;
	label First_Name='First Name'
			Last_Name='Last Name'
			Job_Title='Title'
			Hire_Date='Date Hired';
	format Salary dollar10. Hire_Date MONYY7.;
	where Job_Title='Sales Rep. I' and Salary < 26000 and Employee_ID >=121036;
run;


/*****************************************************************************/
/* (5) EXCERCISE 5.2 LEVEL 1                                                 */
/*****************************************************************************/

/*Problem (4ab) asks us to create a character format $GENDER that displays
gender codes as follows: F FEMALE M MALE  */

/* I ran a proc contents command so I could see what I am dealing with*/
proc contents data=orion.employee_payroll;
run;

/* to create a character format we use the proc format; function followed by 
the value command,$FORMAT_NAME for the format name that we want to create, and
then we assign the possible values of that field to our desired format.  Note
that the fact that GENDER is preceeded by a $ means that it is a character
format */

proc format;
	value $GENDER 'F'='Female'
					  'M'='Male'
					  other='Miscoded'
run;

/*Problem (4c) asks us to create a numeric format named MNAME that displays
month numbers as follows: 1=January, 2=February, etc. Note, sice MNAME is not
preceeded by a $, this will be a numeric format.  We will use the same 
procedure as outline in part b */

proc format;
	value MNAME 1='January'
					2='February'
					3='March'
					4='April'
					5='May'
					6='June'
					7='July'
					8='August'
					9='September'
					10='October'
					11='November'
				   12='December'
					other='Miscoded';
run;

/*Problem (4de) asks us to create a print proc that:

incorporates these two formats to Employee_Gender & Birth_Month
	use format command followed by the Column Name and format that we want to use
	followed by a period.

has columns:Obs,Employee_ID,Employee_Gender,Birth_Date
	use the var command followed by the columns that we want

the code included in p105e04.sas creates a variable BirthMonth in a temp
file work.Q1Birthdays.  We will call work.Q1Birthdays in our print proc.
*/

data Q1Birthdays;
   set orion.employee_payroll;
   BirthMonth=month(Birth_Date);
   if BirthMonth le 3;
run;
proc print data=Q1Birthdays;
	var Employee_ID Employee_Gender BirthMonth;
	format Employee_Gender $GENDER.
			 BirthMonth MNAME.;
run;


/*****************************************************************************/
/* (5) EXCERCISE 5.2 LEVEL 2                                                 */
/*****************************************************************************/

/* I run a contents proc to see what I am dealing with*/

proc contents data=orion.nonsales;
run;


/*Problem (5ab) asks us to create a format $GENDER.  We proceed as we did in
part (4b) */

proc format;
	value $GENDER 'F'='Female'
					  'M'='Male'
					  other='Invalid Code';
run;

/*Problem (5c) asks us to create a numeric format SALRANGE that creates
the following formats: 

20,000<= Salary <100,000 = 'Below $100,000'
	use proc format, value SALRANGE assings the name to our format
	I use 20000-<100000 to show that I want 20000 included and 100000 exluded

100,000<= Salary <=500,000 = '$100,000 or more'
	100000-500000 includes both 100000 and 500000

missing = 'Missing Salary'
	the . symbol designates missing data

Any other value = 'Invalid Salary'
	other= picks up everything else

   */
proc format;
	value SALRANGE 20000-<100000='Below $100,000'
					100000-500000='$100,000 or more'
					            .='Missing Salary'
					        other='Invalid Salary';
run;

/*Problem (5d) asks us to produce a print proc:

Assign GENDER to Gender and SALRANGE to Salary
	use format command followed by the column names that we want to format
	followed by the name of the format followed by a period.
*/


proc print data=orion.nonsales;
   var Employee_ID Job_Title Salary Gender;
   title1 'Salary and Gender Values';
   title2 'for Non-Sales Employees';
	format Gender $GENDER.
			 Salary SALRANGE.;
run;


/*****************************************************************************/
/* (6) EXCERCISE 6.2 LEVEL 2                                                 */
/*****************************************************************************/


/*Problem (5a) asks us to write a DATA step to create work.delays using 
orion.orders as input.
	This data step follows the format data ouput data set; set input data set;
 */

/*Problem (5b) asks us to create a new variable Order_Month and set it
to the month of the Order_Date.
	we assing month(Order_Date) to Order_Month using the month function */

/*Problem (5c) asks us to subset based on the following:
Delivery_Date Values - Order_Date >4
	we used a arithmetic operation and if statement
	
Employee_ID = 99999999
	added 'and' Employee_ID ==9999999
Order_Month = August

 */

/*Problem (5d) asks us to only include Employee_ID,Customer_ID,Order_Date,
Delivery_Date,and Order_Month
	use the keep command followed by the columns to keep
 */


/*Problem (5e) asks us to add permanent lables as follows:
Order_Date = 'Date Ordered'
Delivery_Date = 'Date Delivered'
Order_Month = 'Month Delivered'
	When we add the label statement inside of the data step, the label changes 
	are a permanent part of the data record.  The syntax is the same as when
	we change labels in the print proc except a lable or split is not required in 
	the first statement.
*/

/*Problem (5f) asks to permanently change the following formats:
Order_Date and Delivery_Date to MM/DD/YYY
	Like the label statement, when format is used inside of the data step
	it permanently changes the format.
 */	
 

data work.delays;
	set orion.orders;
	Order_Month=month(Order_date);
	if (Delivery_Date - Order_Date)>4 and Employee_ID=99999999 and 
		Order_Month=8;
	keep Employee_ID Customer_ID Order_Date Delivery_Date Order_Month;
	label Order_Date = 'Date Ordered'
			Delivery_Date = 'Month Delivered'
			Order_Month = 'Month Ordered';
	format Order_Date mmddyy10. Delivery_Date mmddyy10.;			 	
run;

/*Problem (5g) asks us to run a contents proc to verify that our changes
were in fact permanent. */ 
proc contents data=work.delays;
run;



/*Problem (5h) asks us to write a print proc  */

proc print data=work.delays label;
run;



/*****************************************************************************/
/* (9) EXCERCISE 9.1 LEVEL 2                                                 */
/*****************************************************************************/


/*Problem 2a- write a data step that reads orion.customer to create work.birthday
	We accomplish this with the first two lines of code in the data step.  The 
	format for this is: 
	
	DATA output-SAS-data-set;
		SET input-SAS-data-set;*/

/*Problem 2b- 
Bday2012- based on Birth_Date- it is the day month and 2012.
	I used the mdy() function and then the month() and day() function.  To get
	the desired format I added a Format command. 
BdayDOW2012- the day of the week of Bday2012	
Age2012-the age in 2012= (Bday2012-BirthDate)/365.25
	*/
	
/*Prolbem 2c - we use the keep function to include the desired columns  */	
	
/*Problem 2d- we all ready formatted the Bday2012.  Now we format the 
Age2012 to have no decimals. we use the 3.0 to give 3 char before the 
decimal and 0 afterwards.  */


data work.birthday;
	set orion.customer;
	Format Bday2012 Date9. BdayDOW2012 3.0;
	Bday2012=mdy(month(Birth_Date),day(Birth_Date),2012);
	BdayDOW2012=day(Bday2012);
	Age2012 = (Bday2012-Birth_Date)/365.25;
	keep Customer_Name Birth_Date Bday2012 BdayDOW2012 Age2012;	 
run;

/*Problem 2e- print in the format in the book  */

proc print data=work.birthday;
run;

/*****************************************************************************/
/* (9) EXCERCISE 9.2 LEVEL 2                                                 */
/*****************************************************************************/

/*Problem 6a- Write a data step that reads orion.customer_dim to create 
work.season.
	We accomplish this with the first two lines of code in the data step.  The 
	format for this is: 
	
	DATA output-SAS-data-set;
		SET input-SAS-data-set; */
	
/*Problem 6b- Create two new variables: 
Promo-based on month born, if first quater ='Winter', if second quarter='Spring'
	if third quarter='Summer', if fourth quarter = 'Fall'
	To do this we will use the if-then statements.  We will also use the 
	qtr(Customer_BirthDate) to convert the date into quarters. I ran a proc
	contents on customer_dim to see what the column names are.
	Additionally, I added a format command to make sure that our column width is
	at least length 6.
Promo2-based on Customer_Age, if 18<=age<=25, ='YA'; if age>=65, ='Senior'; 
	We use if then - if else construct for this.*/
	
/*Problem 6c-include Customer_FirstName,Customer_LastName, Customer_BirthDate,
Customer_Age, Promo, and Promo2.
	We use the var command followed by the columns that we want. */	


data work.season;
   set orion.customer_dim;
	format Promo $CHAR6.;
	format Promo2 $CHAR8.;
   if qtr(Customer_BirthDate)=1 then Promo='Winter';
   else if qtr(Customer_BirthDate)=2 then Promo='Spring';
   else if qtr(Customer_BirthDate)=3 then Promo='Summer';
   else if qtr(Customer_BirthDate)=4 then Promo='Winter';
   if Customer_Age >=18 and Customer_Age <= 25 then Promo2='YA';
   else if Customer _Age >=65 then Promo2='Senior';
   var Customer_FirstName Customer_LastName Customer_BirthDate 
   	Customer_Age Promo Promo2;
run;

 /*Problem 6d- create the report that looks like the one in the book.  
 	I am not sure if this is necessary or not but the one in the book has
 	the column headings in two rows for Customer_FirstName, Customer_LastName,
 	Customer_Birthdate, and Customer_Age.  To accomplish this, I will rename
 	them to include an * and then split on that character.
*/   
   
  
proc print data=work.season split='*';
	label Customer_FirstName='Customer_*FirstName'
			Customer_LastName='Customer_*LastName'
			Customer_BirthDate='Customer_*BirthDate'
			Customer_Age='Customer_*Age';		
run;

/*Problem 7a-Write a data step that reads orion.orders to create work.ordertype
	We accomplish this with the first two lines of code in the data step.  The 
	format for this is: 
	
	DATA output-SAS-data-set;
		SET input-SAS-data-set; */ 

/*Problem 7b- Create a variable- DayOfWeek which is equal to the weekday of
	Order_Date.  We will use the weekday(Order_Date) command to accomplish this.
	We add a format function to ensure that our variable is wide enough*/

/*Problem 7c- create a variable Type based on Order_Type- 
	if =1 then 'Retail Sale'; if =2 'Catalog Sale'; if =3 'Internet Sale'
	Again, we use a if then/ else if then construction and add a format command */ 	
	
/*Prolbem 7d- create a variable SaleAds based on Order_Type-
 if =2 then 'Mail'; if =3 then 'Email'.
 	We use the same construction.  I could have used the DO command but
 	I didn't realize that we had to do this when I was doing the previous
 	code.  At this point I will just add another If then construction.*/	
 	
/*Problme 7e-We use the drop command to drop the columns that we don't want */ 	

data work.ordertype;
	set orion.orders;
	format DayOfWeek $CHAR10.;
	format Type $CHAR14.;
	format SaleAds $CHAR7.;
	DayOfWeek=weekday(Order_Date);
	if Order_Type=1 then Type='Retail Sale';
	else if Order_Type=2 then Type='Catalog Sale';
	else if Order_Type=3 then Type='Internet Sale';
	if Order_Type=2 then SaleAds='Mail';
	else if Order_Type=3 then SaleAds='Email';
	drop Order_Type Employee_ID Customer_ID;
run;

/*Problem 7f- print a report that looks like the book report.  The book puts
DayOfWeek at the end so we will use the var command to rearrange the column order
The book also has Sale Ads and Day Of Week as lables.  We will add the label 
command for this.*/

proc print data=work.ordertype split='*';
	var Order_ID Order_Date Delivery_Date Type SaleAds DayOfWeek;
	label Order_ID='Order_ID'
			Order_Date='Order_*Date'
			Delivery_Date='Delivery_*Date'
			SaleAds='Sale*Ads'
			DayOfWeek='Day*of*Week';
run;

	
	
/*****************************************************************************/
/* (10) EXCERCISE 10.1 LEVEL 2                                               */
/*****************************************************************************/	
	
	
/*Problem 3a-run a proc contents and answer the questions:
ANSWERS
CHARITIES- 
Code: Type=char   Length =6
Company:Type=char   Length =40
ContactType:Type=char   Length =10

SUPPLIERS- 
Code: Type=char   Length =6
Company:Type=char   Length =30
ContactType:Type=char   Length =1

CONSULTANTS- 
Code: Type=char   Length = 6
Company:Type= char  Length = 30
ContactType:Type= char  Length = 8 */
proc contents data=orion.charities;
run;
proc contents data=orion.us_suppliers;
run;

proc contents data=orion.consultants;
run;

/* Problem 3b- concactenate orion.charities and orion.us_suppliers*/
data work.contacts;	
	set orion.charities orion.us_suppliers;
run;



/*Problem 3c- proc contents and answer: From which input data set were the
variable attributes assigned? ANSWER =  from CHARITIES. SAS checks
suppliers.  The columns have the same names so there are no problems.
*/
proc contents data=work.contacts;
run;


/*Problem 3d- concactenate orion.suppliers and orion.charities  */

data work.contacts2;	
	set orion.us_suppliers orion.charities;
run;

/*Problem 3e- wrte a proc contents and answer the question:  ANSWER-from SUPPLIERS. 
SAS checks charities.  The columns have the same names so there are no problems.

*/
proc contents data=work.contacts2;
run;

/*Problem 3f- concactenate orion.us_suppliers and orion.consultants.  
Why did the data step fail?
ANSWER: Because each file had the same variable name with different type.
 */
  
data work.contacts3;	
	set  orion.us_suppliers orion.consultants;
run;
  
  
/*****************************************************************************/
/* (10) EXCERCISE 10.3 LEVEL 2                                               */
/*****************************************************************************/	
 
/*Problem 5a - sort orion.product_list by  Product_Level  and create a 
new data set  work.product_list  */  
  
  
proc sort data=orion.product_list 
          out=work.product_list;
  	by Product_Level;
run;

/*Problem 5b- Merge orion.product_level with the sorted data set and create 
a datat set work.listlevel- we use the keep function to only keep the 
desired columns.  */


data work.listlevel;
  	merge orion.product_level work.product_list ;
  	by Product_Level;
	keep Product_ID Product_Name Product_Level Product_Level_Name;
run;

/*Problem 5c- write a print proc to hide observations and only print
the obs from Product_Level =3  */

proc print data=work.listlevel noobs;
	where Product_Level=3;   
run;
 
  
  
/*****************************************************************************/
/* (10) EXCERCISE 10.4 LEVEL 2                                               */
/*****************************************************************************/	
 
/*Problem 8a- sort orion.customer by County and create a new data set
work.customer  */
 
 
proc sort data=orion.customer
          out=work.customer;
   by Country;
run;
/*Problem 8b- create a new data set wok.allcustomer.  Use the merge function
to merge work.customer and orion.lookup_country by country.  

rename Start to Country, and Label to Country_Name.  We do thi
by adding a rename function to the merge steip in 8b */


data work.allcustomer;
	merge work.customer(in=Cust) 
         orion.lookup_country(rename=(Start=Country Label=Country_Name) in=Ctry);
	by Country;
	keep Customer_ID Country Customer_Name Country_Name;
run;
/*Problem 8c- create the report in the book.  Note, we have 308 obs  */

proc print data=work.allcustomer;
run;
  
  
/*Problem 8d- Modify the previous data step to inlcude only obs that contain both
customer and country info.  We use a subsetting if statement that references 
IN=variables  in the Merge statement. */

data work.allcustomer;
	merge work.customer(in=Cust) 
         orion.lookup_country(rename=(Start=Country Label=Country_Name) in=Ctry);
	by Country;
	keep Customer_ID Country Customer_Name Country_Name;
	if Cust=1 and Ctry=1;
run;  
  
/*Problem 8e- print again. . . note, we have 77 obs!*/
  
  
proc print data=work.allcustomer;
run; 
  

  
  
  
  
  
  
  
  
  
  
  








