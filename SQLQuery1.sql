USE CureTours

CREATE TABLE logindetails (username varchar(20) NOT NULL UNIQUE, userpassword varchar(20) NOT NULL, user_role varchar (5) NOT NULL);

CREATE TABLE usersEntry (username varchar(20) NOT NULL, fullname varchar(20) NOT NULL, team_name varchar(20) NOT NULL, phone varchar(20) NOT NULL, email varchar(30) NOT NULL, user_description varchar(200))

CREATE TABLE tourlist(title varchar(30) NOT NULL, fromDate date NOT NULL, toDate date NOT NULL, PlanDetails varchar(300) NOT NULL, totalSeatCount INT NOT NULL, remainSeatCount INT NOT NULL)

INSERT INTO logindetails VALUES ('admin', 'CureMD@123', 'admin')


CREATE OR ALTER PROCEDURE LOGINVERIFY 
@USERNAME varchar(20), @PASS varchar(20)
AS
BEGIN
	SELECT user_role FROM logindetails 
	WHERE BINARY_CHECKSUM(username) = BINARY_CHECKSUM(@USERNAME)
		AND BINARY_CHECKSUM(userpassword) = BINARY_CHECKSUM(@PASS)
END

CREATE PROCEDURE USERNAME_SIGNUP_VERIFY
@USERNAME VARCHAR(20)
AS
BEGIN
	SELECT username FROM logindetails WHERE username = @USERNAME
END

CREATE OR ALTER PROCEDURE NEW_USER_ENTRY
@USERNAME VARCHAR(20), @NAME varchar(20), @PASSWORD VARCHAR(20), @TEAM VARCHAR(15), @PHONE VARCHAR(15), @EMAIL VARCHAR(30), @DESCRIPTION VARCHAR(300)
AS
BEGIN
	INSERT INTO usersEntry VALUES (@USERNAME, @NAME, @TEAM, @PHONE, @EMAIL, @DESCRIPTION)
	INSERT INTO logindetails VALUES (@USERNAME, @PASSWORD, 'user')
END

CREATE OR ALTER PROCEDURE NEW_TOUR_ADD
@TITLE VARCHAR(30), @FROMDATE DATE, @TODATE DATE, @DETAILS VARCHAR(300), @TOTALSEATS INT
AS
BEGIN
	INSERT INTO tourlist VALUES (@TITLE, @FROMDATE, @TODATE, @DETAILS, @TOTALSEATS, @TOTALSEATS)
END


SELECT * FROM logindetails
SELECT * FROM usersEntry
SELECT * FROM tourlist

