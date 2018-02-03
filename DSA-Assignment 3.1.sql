
# DATA 620 Assignment 3.1 
# Written by Daanish Ahmed
# Semester Spring 2017
# Professor Majed Al-Ghandour
#
# When you submit this, rename it to "XXX-Assignment 3.1.sql"
# where XXX is your initials or your name
# 
# You will submit the SQL for all the programming problems in this single file
#
# Problem 1 does not require SQL
#



# Problem 2

# This script is designed to list all of the flights that depart from Atlanta.  It will return the flight ID, 
# origin airport code, and destination airport code.  It will sort the results alphabetically based on 
# destination airport code.

SELECT Flight_ID, Airport_Code_Origin, Airport_Code_Destination FROM flights
WHERE Airport_Code_Origin = 'ATL'

ORDER BY Airport_Code_Destination;		# Orders the results alphabetically by airport destination.

# End of Problem 2.



# Problem 3

# This script is designed to insert "Frontier Airlines" as a carrier in the carriers table.

# The following statement removes any existing carriers named "Frontier Airlines" before inserting our 
# entry into the table.

DELETE FROM carriers WHERE Carrier_Name = 'Frontier Airlines';

# The carriers table has two columns: Carrier_ID (an integer) and Carrier_Name (a varchar).  The following 
# statement inserts 6 into Carrier_ID and 'Frontier Airlines' into Carrier_Name.

INSERT INTO carriers VALUES (6, 'Frontier Airlines');

SELECT * FROM carriers;				# Displays the results by showing the list of carriers.

# End of Problem 3.



# Problem 4

# This script is designed to update the list of carrier names by renaming 'Southwest' to 'Southwest Airlines.'  
# The command searches for the instance where Carrier_Name is 'Southwest' and renames that entry.

UPDATE carriers SET Carrier_Name = 'Southwest Airlines' WHERE Carrier_Name = 'Southwest';

SELECT * FROM carriers;				# Displays the results by showing the list of carriers.

# End of Problem 4.



# Problem 5

# This script is designed to return a list of all airline carriers with the number of flights for each carrier. 
# The results are sorted from the highest number of flights to the lowest.  This query makes use of a left join 
# to link the carriers, aircraft, and flights tables together.

# The following lines of code perform a left join on the carriers, aircraft, and flights tables.  A left join is 
# used to ensure that all carriers (listed in the carriers table) are included in the results, even those with 
# no recorded flights.

# The COUNT function for Flight_ID returns the number of entries with non-null flight IDs, which is listed as a 
# column named Num_Flights.

SELECT carriers.Carrier_Name, COUNT(Flight_ID) AS Num_Flights
FROM carriers LEFT JOIN aircraft
ON carriers.Carrier_ID = aircraft.Carrier_ID
LEFT JOIN flights
ON aircraft.Plane_ID = flights.Plane_ID

GROUP BY carriers.Carrier_Name			# Groups the count of flights based on their carrier name.
ORDER BY Num_Flights DESC;			# Orders the results from highest number of flights to lowest.

# End of Problem 5.



# Problem 6

# This script is designed to return the number of flights for each type of plane, sorted from highest to lowest. 
# The query creates a new column called Plane_Type which consists of a concatenation between aircraft manufacturer 
# and model number, with a dash between them.

# The following statement concatenates the aircraft manufacturer and model number (with a dash between them) and 
# displays the result as a new column named Plane_Type.  The query will once again use a COUNT function to count 
# the number of non-null flight IDs.

SELECT CONCAT(aircraft.Manufacturer, ' – ', aircraft.Model_Num) AS Plane_Type, COUNT(Flight_ID) AS Num_Flights

# The following lines of code perform an inner join on the carriers, aircraft, and flights tables.  Unlike with 
# Problem 5, it is not necessary to include carriers with no aircraft or flight information.

FROM carriers INNER JOIN aircraft
ON carriers.Carrier_ID = aircraft.Carrier_ID
INNER JOIN flights
ON aircraft.Plane_ID = flights.Plane_ID

GROUP BY Plane_Type				# Groups the count of flights based on Plane_Type.
ORDER BY Num_Flights DESC;			# Orders the results from highest number of flights to lowest.

# End of Problem 6.



# Problem 7

# This script is designed to remove the flight from Seattle to Philadelphia that takes place on July 5, 23:38.

# The following statement will look for the flight between SEA to PHL on July 5, 2017 at 23:38:00.  The entry 
# containing these values will be deleted.

DELETE FROM flights WHERE Airport_Code_Origin = 'SEA' AND Airport_Code_Destination = 'PHL' 
AND Departure_DateTime = '2017-07-05 23:38:00';

# The following statement shows the results by listing all flights from Seattle to Philadelphia.  The deleted 
# flight will not appear on the list.

SELECT * FROM flights WHERE Airport_Code_Origin = 'SEA' AND Airport_Code_Destination = 'PHL';

# End of Problem 7.



# Problem 8

# This script is designed to return information for all flights that will occur in the future.  It will return 
# the airport origin and destination codes, departure and arrival times, carrier name, plane manufacturer, and 
# model number.

# The following lines of code select the specified columns while performing an inner join between the carriers, 
# aircraft, and flights tables.  It uses abbreviations for the tables, such as using 'c' for 'carriers,' in order 
# to make the statements shorter and easier to type.

SELECT f.Airport_Code_Origin, f.Airport_Code_Destination, f.Departure_DateTime, f.Arrival_DateTime, 
c.Carrier_Name, a.Manufacturer, a.Model_Num
FROM carriers AS c INNER JOIN aircraft AS a
ON c.Carrier_ID = a.Carrier_ID
INNER JOIN flights AS f
ON a.Plane_ID = f.Plane_ID

# The following statements will ensure that the query only returns flights that will occur after the current 
# date and time.  It sorts the results to display the flights closer to the present at the top.  Likewise, the 
# flights that will happen farthest in the future will appear at the end of the list.

WHERE f.Departure_DateTime > SYSDATE()
ORDER BY f.Departure_DateTime;

# End of Problem 8.



# Problem 9

# This script is designed to return a list of all plane types for planes purchased between January 1, 2010 and 
# December 31, 2015.  The query is similar to Problem 6 in that it concatenates aircraft manufacturer and model 
# number into a new column named Plane_Type.  In addition to this, the query will return a sum of the number of 
# seats for each plane type in which planes were purchased between the specified dates.

# The following statement returns a column named Plane_Type, which consists of a concatenation between aircraft 
# manufacturer and model number (separated by a dash).  It also returns a sum of the number of seats which is 
# named Seat_Count.  It uses the CAST function to convert the number into decimal format with 2 decimal places 
# and a length of up to 7 figures (to allow for any larger numbers).  This conversion is performed to ensure that 
# the script is compatible with legacy systems.

SELECT CONCAT(Manufacturer, ' – ', Model_Num) AS Plane_Type, CAST(SUM(Number_of_Seats) AS DECIMAL(7,2)) AS Seat_Count
FROM aircraft

# The following statement sets the condition that only planes purchased between January 1, 2010 and December 31, 
# 2015 will be returned by the query.

WHERE Original_Purchase_Date BETWEEN '2010-01-01' AND '2015-12-31'

GROUP BY Plane_Type				# Groups the number of seats based on Plane_Type.
ORDER BY Seat_Count DESC;			# Orders the results from highest number of seats to lowest.

# End of Problem 9.



# Problem 10 does not require SQL

# End of Script.
