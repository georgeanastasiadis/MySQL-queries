use company;

#Question: Query the results of the details of facilities with ID 1 and 5 without the usage of the OR operator
SELECT *
FROM facilities
WHERE facid IN (1,5);

SELECT joindate
FROM members;
/*Question: Write a query that will print the firstname, surname and joindate of the members table who 
who joined after the start of September 2012*/
SELECT firstname, surname, joindate
FROM members
WHERE joindate > "2012-09-01";

/*Question: Write a query that will print the first 10 surnames of the members table.
  Ordered without */
SELECT DISTINCT surname
FROM members
ORDER BY surname
LIMIT 10;

/* Question: Query a list of all facilities with the word 'Tennis' in their name without the usage
    of the '=' operator */
SELECT *
FROM facilities
WHERE name like '%Tennis%';

/* Question: Write a query that will print the name and monthly maintenance of the facilities that are
   labelled as 'cheap' or 'expensive'. This is dependent on if their monthlymaintenace > 100 */
SELECT name, monthlymaintenance,
CASE
    WHEN monthlymaintenance > 100 then 'expensive'
    ELSE 'cheap'
    END AS 'label'
FROM facilities
GROUP BY name,monthlymaintenance;

/* Question: Write a query that will print the first name, last name and the date of the last member
   who signed up*/
SELECT firstname, surname, joindate
FROM members
ORDER BY joindate DESC
LIMIT 1;

/*Question: Write a query that will print the name and surname of ALL of the members who have
  used a tennis court facility without duplicate*/
SELECT DISTINCT m.firstname,m.surname
FROM members AS m
INNER JOIN bookings AS b
ON m.memid = b.memid
INNER JOIN facilities AS f
ON b.facid = f.facid
WHERE f.facid IN (0,1);

/* Question: Write a query that will print a COUNT of the recommendations each member has made */
SELECT recommendedby, COUNT(recommendedby) AS num_of_rec
FROM members
WHERE recommendedby IS NOT NULL
GROUP BY recommendedby;

/*Question: Write a query that will print the total slots booked in the year of 2012 per facility per month*/
SELECT facid,MONTH(starttime) AS Month, SUM(slots)
FROM bookings
WHERE starttime >= '2012-01-01' AND starttime <='2012-12-30'
GROUP BY facid,MONTH(starttime);


SELECT DISTINCT m.firstname, b.memid
FROM bookings as b
INNER JOIN members as m
ON b.memid = m.memid;

/*Write a query that will print the name and total revenue of each facility
	- Take int consideration that each facility has different price for members and guests*/
SELECT f.name, SUM(slots*
CASE
	WHEN m.memid = 0 THEN guestcost
    ELSE membercost
END) AS Total_Revenue
FROM facilities AS f
INNER JOIN bookings as b
ON f.facid = b. facid
INNER JOIN members AS m
ON b.memid = m.memid
GROUP BY f.name
ORDER BY Total_Revenue DESC;

/*Query a list of the start times for bookings by members named "Matthew Genting"*/
SELECT b.starttime
FROM bookings as b
INNER JOIN members AS m
ON b.memid = m.memid
WHERE m.firstname = 'Matthew' AND m.surname = 'Genting';

/*Write a query that will print the name and revenue of facilities with total revenue less than 1000*/
SELECT f.name, SUM(slots*
CASE
	WHEN m.memid = 0 THEN guestcost
    ELSE membercost
END) AS Total_Revenue
FROM facilities AS f
INNER JOIN bookings AS b
ON f.facid = b.facid
INNER JOIN members AS m
ON b.memid = m.memid
GROUP BY f.name
HAVING Total_Revenue < 1000;

/*Write a query that will print the facility(facid) with the highest number of booked slots */
SELECT f.facid, SUM(b.slots) AS total_slots
FROM facilities AS f
INNER JOIN bookings AS b
ON f.facid = b.facid
GROUP BY f.facid
ORDER BY total_slots DESC
LIMIT 1; 

/*Write a query that will print the firstname and surname of all the members who have
  recommended another member, without duplicates */
SELECT DISTINCT m.firstname, m.surname
FROM members AS m
INNER JOIN members AS m2
ON m.memid = m2.recommendedby
ORDER BY m.firstname,m.surname ;

