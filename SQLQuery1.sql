USE CureTours
CREATE TABLE logindetails (username varchar(20) NOT NULL UNIQUE, userpassword varchar(20) NOT NULL, user_role varchar (5));

INSERT INTO logindetails VALUES ('admin', 'CureMD@123', 'admin')

SELECT * FROM logindetails

CREATE PROCEDURE LOGINVERIFY 
@USERNAME varchar(20), @PASS varchar(20)
AS
BEGIN
	SELECT user_role FROM logindetails WHERE username = @USERNAME AND userpassword = @PASS
END