/* Welcome to the SQL mini project. For this project, you will use
Springboard' online SQL platform, which you can log into through the
following link:

https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

Note that, if you need to, you can also download these tables locally.

In the mini project, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */



/* Q1: Some of the facilities charge a fee to members, but some do not.
Please list the names of the facilities that do. */

SQL query: SELECT ( name ) FROM `Facilities` WHERE membercost !=0 LIMIT 0, 30 ;
Rows: 5

 This table does not contain a unique column. Grid edit, checkbox, Edit, Copy and Delete features are not available.
name	
Tennis Court 1
Tennis Court 2
Massage Room 1
Massage Room 2
Squash Court




/* Q2: How many facilities do not charge a fee to members? */

SQL query: SELECT COUNT(*) FROM `Facilities` WHERE membercost = 0;
Rows: 1

 This table does not contain a unique column. Grid edit, checkbox, Edit, Copy and Delete features are not available.
COUNT(*)	
4

/* Q3: How can you produce a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost?
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */

SQL query: SELECT (name) FROM `Facilities` WHERE monthlymaintenance * .2 > membercost LIMIT 0, 30 ;
Rows: 9

 This table does not contain a unique column. Grid edit, checkbox, Edit, Copy and Delete features are not available.
name	
Tennis Court 1
Tennis Court 2
Badminton Court
Table Tennis
Massage Room 1
Massage Room 2
Squash Court
Snooker Table
Pool Table


/* Q4: How can you retrieve the details of facilities with ID 1 and 5?
Write the query without using the OR operator. */

SQL query: SELECT * FROM `Facilities` WHERE facid = 1 or facid = 5 ORDER BY `Facilities`.`facid` ASC LIMIT 0, 30 ;
Rows: 2

facid	name	membercost	guestcost	initialoutlay	monthlymaintenance	
1	Tennis Court 2	5.0	25.0	8000	200
5	Massage Room 2	9.9	80.0	4000	3000


/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */

SQL query: SELECT name, monthlymaintenance, CASE WHEN monthlymaintenance > 100 THEN 'Expensive' ELSE 'Cheap' END AS Price FROM `Facilities` LIMIT 0, 30 ;
Rows: 9

 This table does not contain a unique column. Grid edit, checkbox, Edit, Copy and Delete features are not available.
name	monthlymaintenance	Price	
Tennis Court 1	200	Expensive
Tennis Court 2	200	Expensive
Badminton Court	50	Cheap
Table Tennis	10	Cheap
Massage Room 1	3000	Expensive
Massage Room 2	3000	Expensive
Squash Court	80	Cheap
Snooker Table	15	Cheap
Pool Table	15	Cheap


/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */

SQL query: SELECT DISTINCT firstname, surname FROM `Members` WHERE zipcode !=0 LIMIT 0, 30 ;
Rows: 29

 This table does not contain a unique column. Grid edit, checkbox, Edit, Copy and Delete features are not available.
firstname	surname	
Darren	Smith
Tracy	Smith
Tim	Rownam
Janice	Joplette
Gerald	Butters
Burton	Tracy
Nancy	Dare
Tim	Boothe
Ponder	Stibbons
Charles	Owen
David	Jones
Anne	Baker
Jemima	Farrell
Jack	Smith
Florence	Bader
Timothy	Baker
David	Pinker
Matthew	Genting
Anna	Mackenzie
Joan	Coplin
Ramnaresh	Sarwin
Douglas	Jones
Henrietta	Rumney
David	Farrell
Henry	Worthington-Smyth
Millicent	Purview
Hyacinth	Tupperware
John	Hunt
Erica	Crumpet



/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

SQL query: SELECT CONCAT( Members.firstname, ' ', Members.surname ) AS Name, Facilities.name FROM `Bookings` JOIN `Facilities` ON Bookings.facid = Facilities.facid JOIN `Members` ON Bookings.memid = Members.memid WHERE Facilities.facid =0 OR Facilities.facid =1 LIMIT 0, 30 ;
Rows: 30

 This table does not contain a unique column. Grid edit, checkbox, Edit, Copy and Delete features are not available.
Name	name	
Tracy Smith	Tennis Court 1
Tracy Smith	Tennis Court 1
GUEST GUEST	Tennis Court 2
GUEST GUEST	Tennis Court 1
GUEST GUEST	Tennis Court 1
Tracy Smith	Tennis Court 1
Tracy Smith	Tennis Court 1
GUEST GUEST	Tennis Court 1
Tracy Smith	Tennis Court 1
Tim Rownam	Tennis Court 2
Tim Rownam	Tennis Court 1
Tracy Smith	Tennis Court 1
Darren Smith	Tennis Court 2
Darren Smith	Tennis Court 2
Tracy Smith	Tennis Court 1
Tracy Smith	Tennis Court 1
Tracy Smith	Tennis Court 1
GUEST GUEST	Tennis Court 2
Darren Smith	Tennis Court 2
GUEST GUEST	Tennis Court 1
GUEST GUEST	Tennis Court 1
Janice Joplette	Tennis Court 1
Tracy Smith	Tennis Court 1
GUEST GUEST	Tennis Court 1
GUEST GUEST	Tennis Court 1
Tracy Smith	Tennis Court 1
Tracy Smith	Tennis Court 1
GUEST GUEST	Tennis Court 2
GUEST GUEST	Tennis Court 2
GUEST GUEST	Tennis Court 1


/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

SQL query: SELECT surname AS Member, name AS Facility, CASE WHEN Members.memid =0 THEN Bookings.slots * Facilities.guestcost ELSE Bookings.slots * Facilities.membercost END AS cost FROM Members JOIN Bookings ON Members.memid = Bookings.memid JOIN Facilities ON Bookings.facid = Facilities.facid WHERE Bookings.starttime >= '2012-09-14' AND Bookings.starttime < '2012-09-15' AND ((Members.memid =0 AND Bookings.slots * Facilities.guestcost >30) OR (Members.memid !=0 AND Bookings.slots * Facilities.membercost >30)) ORDER BY cost DESC LIMIT 0, 30 ;
Rows: 12

 This table does not contain a unique column. Grid edit, checkbox, Edit, Copy and Delete features are not available.
Member	Facility	cost	
GUEST	Massage Room 2	320.0
GUEST	Massage Room 1	160.0
GUEST	Massage Room 1	160.0
GUEST	Massage Room 1	160.0
GUEST	Tennis Court 2	150.0
GUEST	Tennis Court 1	75.0
GUEST	Tennis Court 2	75.0
GUEST	Tennis Court 1	75.0
GUEST	Squash Court	70.0
Farrell	Massage Room 1	39.6
GUEST	Squash Court	35.0
GUEST	Squash Court	35.0

/* Q9: This time, produce the same result as in Q8, but using a subquery. */


/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */

HAVING total_revenue >1000 LIMIT 0, 30 ;
Rows: 9

 This table does not contain a unique column. Grid edit, checkbox, Edit, Copy and Delete features are not available.
name	total_revenue	
Badminton Court	5936.5
Massage Room 1	56547.1
Massage Room 2	9978.9
Pool Table	4180.0
Snooker Table	2220.0
Squash Court	9240.0
Table Tennis	2015.0
Tennis Court 1	12240.0
Tennis Court 2	11670.0

