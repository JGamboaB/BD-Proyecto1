DELIMITER $$

CREATE PROCEDURE `wk_consultPaymentAttempts`
(
	IN pClientUserName VARCHAR(20)
)
BEGIN 
	SET @clientid = 0;
    
    SELECT IFNULL(userid, @userid) INTO @userid FROM wk_users WHERE TRIM(`username`)=pClientUserName;
    
END$$