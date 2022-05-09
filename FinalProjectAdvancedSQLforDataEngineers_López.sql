--Exercise 1: Using Joins
-- Write and execute a SQL query to list the school names, community names 
-- and average attendance for communities with a hardship index of 98.
SELECT NAME_OF_SCHOOL, CPS.COMMUNITY_AREA_NAME, AVERAGE_TEACHER_ATTENDANCE, AVERAGE_STUDENT_ATTENDANCE 
FROM CHICAGO_PUBLIC_SCHOOLS AS CPS
RIGHT JOIN CENSUS_DATA AS CD
ON CPS.COMMUNITY_AREA_NUMBER = CD.COMMUNITY_AREA_NUMBER
WHERE HARDSHIP_INDEX = 98;

-- Write and execute a SQL query to list all crimes that took place at a school. 
-- Include case number, crime type and community name.
SELECT CASE_NUMBER, PRIMARY_TYPE, COMMUNITY_AREA_NAME FROM CHICAGO_CRIME_DATA AS CCD
LEFT JOIN CENSUS_DATA AS CD
ON CCD.COMMUNITY_AREA_NUMBER = CD.COMMUNITY_AREA_NUMBER
WHERE LOCATION_DESCRIPTION LIKE '%SCHOOL%';

--Exercise 2: Creating a View
-- Write and execute a SQL statement to create a view showing the columns 
-- listed in the following table, with new column names as shown in the second column.
CREATE VIEW NEW_CHICAGO_PUBLIC_SCHOOLS AS
SELECT NAME_OF_SCHOOL AS School_Name, Safety_Icon AS Safety_Rating, 
Family_Involvement_Icon	AS Family_Rating, Environment_Icon	AS Environment_Rating,
Instruction_Icon AS Instruction_Rating, Leaders_Icon AS Leaders_Rating,
Teachers_Icon AS Teachers_Rating
FROM CHICAGO_PUBLIC_SCHOOLS;

-- Write and execute a SQL statement that returns all of the columns from the view.
SELECT * FROM NEW_CHICAGO_PUBLIC_SCHOOLS;

-- Write and execute a SQL statement that returns just the school name and leaders rating from the view.
SELECT School_Name, Leaders_Rating FROM NEW_CHICAGO_PUBLIC_SCHOOLS;

--Exercise 3: Creating a Stored Procedure
-- Write the structure of a query to create or replace a stored procedure called UPDATE_LEADERS_SCORE 
-- that takes a in_School_ID parameter as an integer and a in_Leader_Score parameter as an integer. 
-- Don't forget to use the #SET TERMINATOR statement to use the @ for the CREATE statement terminator.

--#SET TERMINATOR @
CREATE PROCEDURE UPDATE_LEADERS_SCORE (
    IN IN_SCHOOL_ID INTEGER, 
    IN IN_LEADER_SCORE INTEGER 
    ) 

BEGIN
	UPDATE CHICAGO_PUBLIC_SCHOOLS
	SET LEADERS_SCORE = IN_LEADER_SCORE
	WHERE SCHOOL_ID = IN_SCHOOL_ID;	
	
	IF IN_LEADER_SCORE > 0 AND IN_LEADER_SCORE < 20 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET LEADERS_ICON = VARCHAR('Very weak')
		WHERE SCHOOL_ID = IN_SCHOOL_ID;

	ELSEIF IN_LEADER_SCORE < 40 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET LEADERS_ICON = VARCHAR('Weak')
		WHERE SCHOOL_ID = IN_SCHOOL_ID;

	ELSEIF IN_LEADER_SCORE < 60 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET LEADERS_ICON = VARCHAR('Average')
		WHERE SCHOOL_ID = IN_SCHOOL_ID;

	ELSEIF IN_LEADER_SCORE < 80 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET LEADERS_ICON = VARCHAR('Strong')
		WHERE SCHOOL_ID = IN_SCHOOL_ID;

	ELSEIF IN_LEADER_SCORE < 100 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET LEADERS_ICON = VARCHAR('Very Strong')
		WHERE SCHOOL_ID = IN_SCHOOL_ID;

	END IF;
	END 
@
--#SET TERMINATOR ;

CALL UPDATE_LEADERS_SCORE(609674,50);

DROP PROCEDURE UPDATE_LEADERS_SCORE;

--Exercise 4: Using Transactions
-- Update your stored procedure definition. Add a generic ELSE clause to the IF statement 
-- that rolls back the current work if the score did not fit any of the preceding categories.

--#SET TERMINATOR @
CREATE PROCEDURE UPDATE_LEADERS_SCORE (
    IN IN_SCHOOL_ID INTEGER, 
    IN IN_LEADER_SCORE INTEGER 
    ) 

BEGIN
	UPDATE CHICAGO_PUBLIC_SCHOOLS
	SET LEADERS_SCORE = IN_LEADER_SCORE
	WHERE SCHOOL_ID = IN_SCHOOL_ID;	
	
	IF IN_LEADER_SCORE > 0 AND IN_LEADER_SCORE < 20 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET LEADERS_ICON = VARCHAR('Very weak')
		WHERE SCHOOL_ID = IN_SCHOOL_ID;

	ELSEIF IN_LEADER_SCORE < 40 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET LEADERS_ICON = VARCHAR('Weak')
		WHERE SCHOOL_ID = IN_SCHOOL_ID;

	ELSEIF IN_LEADER_SCORE < 60 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET LEADERS_ICON = VARCHAR('Average')
		WHERE SCHOOL_ID = IN_SCHOOL_ID;

	ELSEIF IN_LEADER_SCORE < 80 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET LEADERS_ICON = VARCHAR('Strong')
		WHERE SCHOOL_ID = IN_SCHOOL_ID;

	ELSEIF IN_LEADER_SCORE < 100 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET LEADERS_ICON = VARCHAR('Very Strong')
		WHERE SCHOOL_ID = IN_SCHOOL_ID;
	
	ELSE 
		ROLLBACK WORK;
		
	END IF;
	COMMIT WORK;
	END 
@
--#SET TERMINATOR ;




