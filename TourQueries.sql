USE Tours

CREATE TABLE logindetails (UserID INT PRIMARY KEY IDENTITY(0,1), Username varchar(20) NOT NULL UNIQUE, UserPassword varchar(20) NOT NULL, UserRole varchar (5) NOT NULL);

CREATE TABLE usersEntry (UserID INT PRIMARY KEY IDENTITY(1,1) ,Username varchar(20) NOT NULL, FullName varchar(20) NOT NULL, TeamName varchar(20) NOT NULL, Phone varchar(20) NOT NULL, Email varchar(30) NOT NULL, UserDescription varchar(200))

CREATE TABLE tourlist(TourID INT PRIMARY KEY IDENTITY(1,1), Title varchar(30) NOT NULL, [From Date] date NOT NULL, [To Date] date NOT NULL, [Plan Details] varchar(300) NOT NULL, [Total Seats] INT NOT NULL, [Remaining Seats] INT NOT NULL, [Cost Per Head] INT NULL)

CREATE TABLE interested_list (InterestID INT PRIMARY KEY IDENTITY(1,1), UserID INT NOT NULL, TourID INT , Time datetime)

CREATE TABLE final_accepted_list (FinalID INT PRIMARY KEY IDENTITY(1,1), UserID INT NOT NULL, TourID INT)

INSERT INTO logindetails VALUES ('admin', 'CureMD@123', 'admin')

CREATE OR ALTER PROCEDURE LOGINVERIFY 
@USERNAME varchar(20), @PASS varchar(20)
AS BEGIN
	SELECT UserRole  FROM logindetails 
	WHERE BINARY_CHECKSUM(Username) = BINARY_CHECKSUM(@USERNAME)
		AND BINARY_CHECKSUM(UserPassword) = BINARY_CHECKSUM(@PASS)
		AND username = @USERNAME
		AND userpassword = @PASS
END

CREATE OR ALTER PROCEDURE USERNAME_SIGNUP_VERIFY
@USERNAME VARCHAR(20)
AS BEGIN
	SELECT Username FROM logindetails WHERE Username = @USERNAME
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
	SELECT TourID AS [No] ,Title, CONVERT(date, [From Date]) AS [From], CONVERT(date,[To Date]) As [To], [Plan Details], [Cost Per Head] AS [Cost/Head], [Remaining Seats] AS [Seats Remain] from tourlist
END

CREATE OR ALTER PROCEDURE RETURN_NAME_ROLE
@USERNAME VARCHAR(30)
AS BEGIN
	SELECT usersEntry.UserID, usersEntry.FullName, logindetails.UserRole FROM usersEntry
	FULL OUTER JOIN
	logindetails ON usersEntry.UserID = logindetails.UserID
	where usersEntry.Username = @USERNAME
END

CREATE OR ALTER PROCEDURE INTERESTED_USER_LIST
@USERID INT, @TOURID INT, @TIME datetime
AS BEGIN
	IF NOT EXISTS (SELECT InterestID FROM interested_list 
					WHERE TourID=@TOURID AND  UserID = @USERID)
	BEGIN
		IF NOT EXISTS (SELECT FinalID FROM final_accepted_list 
							WHERE TourID=@TOURID AND  UserID = @USERID)
		BEGIN
			INSERT INTO interested_list VALUES (@USERID, @TOURID, @TIME)
		END
	END
END

CREATE OR ALTER PROCEDURE ADMIN_TOUR_SHOW
AS BEGIN
	SELECT TourID AS [No], Title AS [Tour Title], CONVERT(date, [From Date]) AS [From Date], CONVERT(date,[To Date]) As [To Date], [Plan Details], [Cost Per Head] AS [Cost/Head], [Total Seats], [Remaining Seats] AS [Seat Remaining] from tourlist
END

CREATE OR ALTER PROCEDURE RETURN_TOUR
@TOURID INT
AS BEGIN
	SELECT Title FROM tourlist where TourID= @TOURID
END

CREATE OR ALTER PROCEDURE SHOW_INTERESTED_DETAILS
@TOURID INT
AS BEGIN
	SELECT usersEntry.FullName AS [Name], interested_list.[Time] FROM usersEntry
	FULL OUTER JOIN 
	interested_list On usersEntry.UserID = interested_list.UserID
	WHERE interested_list.TourID = @TOURID
	ORDER BY interested_list.[Time]
END

CREATE OR ALTER PROCEDURE RETURN_REM_SEAT_COUNT
@TOURID INT
AS BEGIN
	SELECT [Remaining Seats] FROM tourlist WHERE TourID=@TOURID
END

CREATE OR ALTER PROCEDURE ACCEPT_USER
@TOURID INT, @NAME VARCHAR(30)
AS BEGIN
	DELETE FROM interested_list 
		WHERE TourID=@TOURID AND UserID = (SELECT UserID FROM usersEntry WHERE FullName = @NAME)
	INSERT INTO final_accepted_list 
		VALUES ((SELECT UserID FROM usersEntry WHERE FullName = @NAME), @TOURID)
	UPDATE tourlist SET [Remaining Seats]=[Remaining Seats]-1 
		WHERE TourID = @TOURID
END

CREATE OR ALTER PROCEDURE REJECT_USER
@TOURID INT, @NAME VARCHAR(30)
AS BEGIN
	DELETE FROM interested_list 
		WHERE TourID=@TOURID AND UserID = (SELECT UserID FROM usersEntry WHERE FullName = @NAME)
END

CREATE OR ALTER PROCEDURE SHOW_FINALIZED_USERS
@TOURID INT
AS BEGIN
	SELECT usersEntry.FullName AS [Accepted Name] FROM usersEntry
	FULL OUTER JOIN final_accepted_list 
	ON usersEntry.UserID = final_accepted_list.UserID
	WHERE final_accepted_list.TourID=@TOURID
END

SELECT * FROM logindetails
SELECT * FROM usersEntry
SELECT * FROM tourlist
SELECT * from interested_list
SELECT * FROM final_accepted_list

delete from final_accepted_list