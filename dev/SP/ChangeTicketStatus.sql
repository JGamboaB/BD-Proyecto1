DELIMITER $$

CREATE PROCEDURE wk_changeTicketStatus
(
	IN pNewTicketStatus VARCHAR(20),
    IN pTicketid INT
)
BEGIN
	
    SET @ticketStatusid = 0;
    SET @employeeid = 0;
    
    -- make a description of the change made, based on the new ticket status
    SET @description = CONCAT('Changed Ticket Status to: ', pNewTicketStatus);
    -- get the ticketstatusid corresponding to the new ticket status
    SELECT IFNULL(ticketStatusid, @ticketStatusid) INTO @ticketStatusid FROM wk_ticketStatus WHERE TRIM(`name`)=pNewTicketStatus;
    -- get the employeeid of the ticket
    SELECT employeeid INTO @employeeid FROM wk_tickets WHERE ticketid = pTicketid;
    
    -- make a transaction that change the ticket status and add a step on the steps table
    START TRANSACTION;
		UPDATE wk_tickets SET ticketStatusid = @ticketStatusid
        WHERE ticketid = pTicketid;
        
        INSERT INTO wk_steps(ticketid, employeeid, description, started, finished)
        VALUES (pTicketid, @employeeid, @description, NOW(), NOW());
	COMMIT;
END$$