USE CureTours
CREATE TABLE logindetails (username varchar(20) NOT NULL UNIQUE, userpassword varchar(20) NOT NULL, user_role varchar (5) NOT NULL);

CREATE TABLE usersEntry (username varchar(20) NOT NULL, fullname varchar(20) NOT NULL, team_name varchar(20) NOT NULL, phone varchar(20) NOT NULL, email varchar(30) NOT NULL, user_description varchar(200))

INSERT INTO logindetails VALUES ('admin', 'CureMD@123', 'admin')


CREATE PROCEDURE LOGINVERIFY 
@USERNAME varchar(20), @PASS varchar(20)
AS
BEGIN
	SELECT user_role FROM logindetails WHERE username = @USERNAME AND userpassword = @PASS
END

EXEC LOGINVERIFY @USERNAME='admin', @PASS = 'x'

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

SELECT * FROM logindetails
SELECT * FROM usersEntry


EXEC NEW_USER_ENTRY @USERNAME = 'muhamza', @NAME = 'Muhammad Hamza', @PASSWORD = 'Hamza@123', @TEAM='Integration', @PHONE='+92-320-6606260', @EMAIL='mohammad.hamza@curemd.com',  @DESCRIPTION='love travelling'


DELETE FROM logindetails WHERE username=''
DELETE FROM usersEntry WHERE fullname = 'aaawwq'