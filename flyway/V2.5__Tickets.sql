DELIMITER $$
CREATE PROCEDURE `wk_consultTickets`
(
	IN pEmployeeUserName VARCHAR(20)
)
BEGIN
	
    SET @userid = 0;

	SELECT IFNULL(userid, @userid) INTO @userid FROM wk_users WHERE TRIM(`username`)=pEmployeeUserName;
    
    SELECT `Client Username`, `Ticket Status`, DATE(`Date and Time of Creation`) AS `Date`
    FROM wk_ticketInformation AS ticketInformation
    WHERE ticketInformation.employeeid = @userid;
    
END$$

DELIMITER ;


DELIMITER $$
CREATE PROCEDURE `wk_consultTicket`
(
	IN pTicketId INT
)
BEGIN 

	SELECT `Client Username`, `Employee Username`, `Description`, `Ticket Category`, `Ticket Status`, `Date and Time of Creation` 
    FROM wk_ticketInformation AS ticketInformation
    WHERE ticketInformation.ticketid = pTicketId;
    
END$$

