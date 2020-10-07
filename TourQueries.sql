--CREATING THE REQUIRED DATABASE FIRST
CREATE DATABASE Tours
USE Tours

--CREATING ALL THE REQUIRED TABLES
CREATE TABLE logindetails (UserID INT PRIMARY KEY IDENTITY(0,1), Username VARCHAR(20) NOT NULL UNIQUE, UserPassword VARCHAR(20) NOT NULL, UserRole VARCHAR(5) NOT NULL);

CREATE TABLE usersEntry (UserID INT PRIMARY KEY IDENTITY(1,1) ,Username VARCHAR(20) NOT NULL, FullName VARCHAR(20) NOT NULL, TeamName VARCHAR(20) NOT NULL, Phone VARCHAR(20) NOT NULL, Email VARCHAR(30) NOT NULL, UserDescription VARCHAR(200))

CREATE TABLE tourlist(TourID INT PRIMARY KEY IDENTITY(1,1), Title VARCHAR(30) NOT NULL, [From Date] DATE NOT NULL, [To Date] DATE NOT NULL, [Plan Details] VARCHAR(300) NOT NULL, [Total Seats] INT NOT NULL, [Remaining Seats] INT NOT NULL, [Cost Per Head] INT NOT NULL)

CREATE TABLE interested_list (InterestID INT PRIMARY KEY IDENTITY(1,1), UserID INT NOT NULL, TourID INT , Time datetime, [User Status] VARCHAR(10))

--INSERTING THE ADMIN CREDENTIALS BY DEFAULT
INSERT INTO logindetails VALUES ('admin', 'CureMD@123', 'admin')
GO

--LOGIN VERIFICATION 
CREATE OR ALTER PROCEDURE LOGINVERIFY 
@USERNAME varchar(20), @PASS varchar(20)
AS BEGIN
	SELECT UserID  FROM logindetails 
	WHERE BINARY_CHECKSUM(Username) = BINARY_CHECKSUM(@USERNAME)
		AND BINARY_CHECKSUM(UserPassword) = BINARY_CHECKSUM(@PASS)
		AND username = @USERNAME
		AND userpassword = @PASS
END
GO

--CHECKING IF USERNAME ALREADY EXISTS DURING SIGNUP
CREATE OR ALTER PROCEDURE USERNAME_SIGNUP_VERIFY
@USERNAME VARCHAR(20)
AS BEGIN
	SELECT Username FROM logindetails WHERE Username = @USERNAME
END
GO

--ADDING NEW USER TO EXISTING USER DATABASE
CREATE OR ALTER PROCEDURE NEW_USER_ENTRY
@USERNAME VARCHAR(20), @NAME varchar(20), @PASSWORD VARCHAR(20), @TEAM VARCHAR(15), @PHONE VARCHAR(15), @EMAIL VARCHAR(30), @DESCRIPTION VARCHAR(300)
AS BEGIN
	INSERT INTO usersEntry VALUES (@USERNAME, @NAME, @TEAM, @PHONE, @EMAIL, @DESCRIPTION)
	INSERT INTO logindetails VALUES (@USERNAME, @PASSWORD, 'user')
END
GO

--ADDING A NEW TOUR PLAN FROM ADMIN
CREATE OR ALTER PROCEDURE NEW_TOUR_ADD
@TITLE VARCHAR(30), @FROMDATE DATE, @TODATE DATE, @DETAILS VARCHAR(300), @TOTALSEATS INT, @COST INT
AS BEGIN
	INSERT INTO tourlist VALUES (@TITLE, @FROMDATE, @TODATE, @DETAILS, @TOTALSEATS, @TOTALSEATS, @COST)
END
GO

--DISPLAING A SPECFIC TOUR DETAILS 
CREATE OR ALTER PROCEDURE SHOW_SPECIFIC_TOUR
@TOURID INT
AS BEGIN
	SELECT Title, [From Date], [To Date], [Plan Details], [Total Seats], [Remaining Seats], [Cost Per Head] FROM tourlist WHERE TourID=@TOURID
END
GO

--FOR EDITING TOUR DETAILS LATER
CREATE OR ALTER PROCEDURE EDIT_TOUR
@TOURID INT, @TITLE VARCHAR(30), @FROMDATE DATE, @TODATE DATE, @DETAILS VARCHAR(300), @TOTALSEATS INT, @COST INT
AS BEGIN
	UPDATE tourlist SET Title=@TITLE, [From Date] = @FROMDATE, [To Date]=@TODATE, [Plan Details]=@DETAILS, [Total Seats]=@TOTALSEATS, [Cost Per Head]=@COST WHERE TourID=@TOURID
END
GO

--SHOWING LIST OF ALL TOURS TO USER
CREATE OR ALTER PROCEDURE USER_TOUR_SHOW
AS BEGIN
	SELECT TourID AS [No] ,Title, CONVERT(date, [From Date]) AS [From], CONVERT(date,[To Date]) As [To], [Plan Details], [Cost Per Head] AS [Cost/Head], [Remaining Seats] AS [Seats Remain] from tourlist
END
GO

--SHOWING ACCEPTED LIST TO USER
CREATE OR ALTER PROCEDURE ACCEPT_LIST_SHOW_USER
@USERID INT
AS BEGIN
	SELECT tourlist.Title, interested_list.[User Status] FROM tourlist
	FULL OUTER JOIN
	interested_list ON tourlist.TourID=interested_list.TourID
	WHERE interested_list.UserID=@USERID
END
GO

--FOR DISPLAYING NAME OF USER AND THEIR ROLE ON USERPORTAL
CREATE OR ALTER PROCEDURE RETURN_NAME_ROLE
@USERID INT
AS BEGIN
	SELECT usersEntry.FullName, logindetails.UserRole FROM usersEntry
	FULL OUTER JOIN
	logindetails ON usersEntry.Username = logindetails.Username
	where usersEntry.UserID = @USERID
END
GO

--WHEN USER SHOWS INTEREST IN A TOUR, THEIR INFO IS ADDED HERE LIKE THIS
CREATE OR ALTER PROCEDURE INTERESTED_USER_LIST
@USERID INT, @TOURID INT, @TIME datetime
AS BEGIN
	IF NOT EXISTS (SELECT InterestID FROM interested_list 
					WHERE TourID=@TOURID AND  UserID = @USERID)
	BEGIN
		INSERT INTO interested_list VALUES (@USERID, @TOURID, @TIME, 'Pending')
	END
END
GO

--FOR DISPLAYING LIST OF ALL TOURS IN DATABASE WITH ITS DETAILS (A BIT DIFFERENT THEN USER TOUR SHOW)
CREATE OR ALTER PROCEDURE ADMIN_TOUR_SHOW
AS BEGIN
	SELECT TourID AS [No], Title AS [Tour Title], CONVERT(date, [From Date]) AS [From Date], CONVERT(date,[To Date]) As [To Date], [Plan Details], [Cost Per Head] AS [Cost/Head], [Total Seats], [Remaining Seats] AS [Seat Remaining] from tourlist
END
GO

--TO SHOWLIST OF USERS AND THEIR DETAILS TO ADMIN
CREATE OR ALTER PROCEDURE USERS_SHOW
AS BEGIN
	SELECT Username, FullName as [Full Name], TeamName AS [Team Name], Phone, Email, UserDescription AS [User Description] from usersEntry
END
GO

--RETURNING NAME OF TOUR CORRESPONDING TO A SPECFIC TOUR ID
CREATE OR ALTER PROCEDURE RETURN_TOUR
@TOURID INT
AS BEGIN
	SELECT Title FROM tourlist where TourID= @TOURID
END
GO

--FOR DISPLAYING A LIST OF INTERSTED USERS CORRESPONDING TO A SPECFIC TOUR
CREATE OR ALTER PROCEDURE SHOW_INTERESTED_DETAILS
@TOURID INT
AS BEGIN
	SELECT usersEntry.FullName AS [Name], interested_list.[Time] FROM usersEntry
	FULL OUTER JOIN 
	interested_list On usersEntry.UserID = interested_list.UserID
	WHERE interested_list.TourID = @TOURID AND interested_list.[User Status] = 'Pending'
	ORDER BY interested_list.[Time]
END
GO

--FOR TELLING WHETHER SEATS REMAIN ON THE SELECTED TOUR
CREATE OR ALTER PROCEDURE RETURN_REM_SEAT_COUNT
@TOURID INT
AS BEGIN
	SELECT [Remaining Seats] FROM tourlist WHERE TourID=@TOURID
END
GO

--ACCEPTING A USER IM THE FINALIZED LIST FOR A SPECFIC TOUR
CREATE OR ALTER PROCEDURE ACCEPT_USER
@TOURID INT, @NAME VARCHAR(30)
AS BEGIN
	UPDATE interested_list SET [User Status] = 'Accept'
		WHERE TourID=@TOURID AND UserID = (SELECT UserID FROM usersEntry WHERE FullName = @NAME)
	UPDATE tourlist SET [Remaining Seats]=[Remaining Seats]-1 
		WHERE TourID = @TOURID
END
GO

--REJECTING A USER INTEREST FOR A SPECIFIC INTEREST
CREATE OR ALTER PROCEDURE REJECT_USER
@TOURID INT, @NAME VARCHAR(30)
AS BEGIN
	UPDATE interested_list SET [User Status] = 'Reject'
		WHERE TourID=@TOURID AND UserID = (SELECT UserID FROM usersEntry WHERE FullName = @NAME)
END
GO

--SHOWING LIST OF USERS FINALIZED FOR A SPECIFIC TOUR
CREATE OR ALTER PROCEDURE SHOW_FINALIZED_USERS
@TOURID INT
AS BEGIN
	SELECT usersEntry.FullName AS [Accepted Name] FROM usersEntry
	FULL OUTER JOIN interested_list
	ON usersEntry.UserID = interested_list.UserID
	WHERE interested_list.TourID=@TOURID AND interested_list.[User Status] = 'Accept'
END
GO

--DELETING TOUR BY ADMIN
CREATE OR ALTER PROCEDURE DELETE_TOUR
@TOURID INT
AS BEGIN
	DELETE FROM tourlist WHERE TourID=@TOURID
	DELETE FROM interested_list WHERE TourID=@TOURID
END
GO

--DISPLAYING OUTPUT OF ALL TABLES (FOR TEST PURPOSES)
SELECT * FROM logindetails
SELECT * FROM usersEntry
SELECT * FROM tourlist
SELECT * FROM interested_list
UPDATE tourlist SET [Remaining Seats]=[Total Seats]
