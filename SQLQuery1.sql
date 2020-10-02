USE CureTours

CREATE TABLE logindetails (username varchar(20) NOT NULL UNIQUE, userpassword varchar(20) NOT NULL, user_role varchar (5) NOT NULL);

CREATE TABLE usersEntry (username varchar(20) NOT NULL, fullname varchar(20) NOT NULL, team_name varchar(20) NOT NULL, phone varchar(20) NOT NULL, email varchar(30) NOT NULL, user_description varchar(200))

CREATE TABLE tourlist(Title varchar(30) NOT NULL, FromDate date NOT NULL, ToDate date NOT NULL, PlanDetails varchar(300) NOT NULL, TotalSeatCount INT NOT NULL, RemainSeatCount INT NOT NULL, CostPerHead INT NULL)

CREATE TABLE interested_list (username varchar(20) NOT NULL, Title varchar(30) , Time datetime)

CREATE TABLE final_accepted_list (username varchar(20) NOT NULL, Title VARCHAR(30))

INSERT INTO logindetails VALUES ('admin', 'CureMD@123', 'admin')


CREATE OR ALTER PROCEDURE LOGINVERIFY 
@USERNAME varchar(20), @PASS varchar(20)
AS BEGIN
	SELECT user_role FROM logindetails 
	WHERE BINARY_CHECKSUM(username) = BINARY_CHECKSUM(@USERNAME)
		AND BINARY_CHECKSUM(userpassword) = BINARY_CHECKSUM(@PASS)
		AND username = @USERNAME
		AND userpassword = @PASS
END

CREATE OR ALTER PROCEDURE USERNAME_SIGNUP_VERIFY
@USERNAME VARCHAR(20)
AS BEGIN
	SELECT username FROM logindetails WHERE username = @USERNAME
END

CREATE OR ALTER PROCEDURE NEW_USER_ENTRY
@USERNAME VARCHAR(20), @NAME varchar(20), @PASSWORD VARCHAR(20), @TEAM VARCHAR(15), @PHONE VARCHAR(15), @EMAIL VARCHAR(30), @DESCRIPTION VARCHAR(300)
AS BEGIN
	INSERT INTO usersEntry VALUES (@USERNAME, @NAME, @TEAM, @PHONE, @EMAIL, @DESCRIPTION)
	INSERT INTO logindetails VALUES (@USERNAME, @PASSWORD, 'user')
END

CREATE OR ALTER PROCEDURE NEW_TOUR_ADD
@TITLE VARCHAR(30), @FROMDATE DATE, @TODATE DATE, @DETAILS VARCHAR(300), @TOTALSEATS INT, @COST INT
AS BEGIN
	INSERT INTO tourlist VALUES (@TITLE, @FROMDATE, @TODATE, @DETAILS, @TOTALSEATS, @TOTALSEATS, @COST)
END

CREATE OR ALTER PROCEDURE USER_TOUR_SHOW
AS BEGIN
	SELECT Title, CONVERT(date, FromDate) AS FromDate, CONVERT(date,ToDate) As ToDate, PlanDetails, CostPerHead, RemainSeatCount from tourlist
END

CREATE OR ALTER PROCEDURE INTERESTED_USER_LIST
@USERNAME VARCHAR (30), @TOURTITLE VARCHAR(30), @TIME datetime
AS BEGIN
	IF NOT EXISTS (SELECT username FROM interested_list WHERE Title = @TOURTITLE AND username = @USERNAME)
	BEGIN
		IF NOT EXISTS (SELECT username FROM final_accepted_list WHERE Title = @TOURTITLE AND username = @USERNAME)
		BEGIN
			INSERT INTO interested_list VALUES (@USERNAME, @TOURTITLE, @TIME)
		END
	END
END

CREATE OR ALTER PROCEDURE RETURN_NAME
@USERNAME VARCHAR(30)
AS BEGIN
	SELECT fullname FROM usersEntry WHERE username = @USERNAME
END

CREATE OR ALTER PROCEDURE RETURN_ROLE
@USERNAME VARCHAR(30)
AS BEGIN
	SELECT user_role FROM logindetails WHERE username = @USERNAME
END

CREATE OR ALTER PROCEDURE RETURN_REM_SEAT_COUNT
@TITLE VARCHAR(30)
AS BEGIN
	SELECT RemainSeatCount FROM tourlist WHERE Title=@TITLE
END

CREATE OR ALTER PROCEDURE ADMIN_TOUR_SHOW
AS BEGIN
	SELECT Title, CONVERT(date, FromDate) AS FromDate, CONVERT(date,ToDate) As ToDate, PlanDetails, CostPerHead, TotalSeatCount, RemainSeatCount from tourlist
END

CREATE OR ALTER PROCEDURE SHOW_INTERESTED_DETAILS
@TITLE VARCHAR(30)
AS BEGIN
	SELECT username, Time FROM interested_list where Title=@TITLE
END

CREATE OR ALTER PROCEDURE REMOVE_INTERESTED_USER
@TITLE VARCHAR(30), @USERNAME VARCHAR(30)
AS BEGIN
	DELETE FROM interested_list WHERE Title=@TITLE AND username=@USERNAME
END

CREATE OR ALTER PROCEDURE FINALIZED_USERS
@TITLE VARCHAR(30), @USERNAME VARCHAR(30)
AS BEGIN
	INSERT INTO final_accepted_list VALUES (@USERNAME, @TITLE)
	UPDATE tourlist SET RemainSeatCount=RemainSeatCount-1 WHERE Title=@TITLE
END

CREATE OR ALTER PROCEDURE SHOW_FINALIZED_USERS
@TITLE VARCHAR(30)
AS BEGIN
	SELECT username from final_accepted_list WHERE Title=@TITLE
END

SELECT * FROM logindetails
SELECT * FROM usersEntry
SELECT * FROM tourlist
SELECT * FROM interested_list order by Time
SELECT * FROM final_accepted_list


EXEC FINALIZED_USERS 'trip to Karacho', 'farisimran'
delete from final_accepted_list where username='saadbakshi'
delete from interested_list where username='farisimran'
update tourlist set RemainSeatCount=TotalSeatCount 