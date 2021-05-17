DROP PROCEDURE IF EXISTS `wk_consultChats`;

DELIMITER $$
CREATE PROCEDURE `wk_consultChats`
(
	IN pUserName VARCHAR(20)
)
BEGIN 

	DECLARE INVALID_USERNAME INT DEFAULT(53000);
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @err_no = MYSQL_ERRNO, @message = MESSAGE_TEXT;
        -- si es un exception de sql, ambos campos vienen en el diagnostics
        -- pero si es una excepction forzada por el programador solo viene el ERRNO, el texto no
        
        IF (ISNULL(@message)) THEN -- quiere decir q es una excepcion forzada del programador
			SELECT message INTO @message FROM wk_errors WHERE errorid = @err_no;            
        ELSE
			-- es un exception de SQL que no queremos que salga hacia la capa de aplicacion
            -- tengo que guardar el error en una bitácora de errores... patron de bitacora
            -- sustituyo el texto del mensaje
            SET @message = CONCAT('Internal error: ', @message);
        END IF;
        
        ROLLBACK;
        
        RESIGNAL SET MESSAGE_TEXT = @message;
	END;
	
    SET @userid = 0;
    
    SELECT IFNULL(userid, @userid) INTO @userid FROM wk_users WHERE TRIM(`username`)=pUserName;
    
    IF (@userid = 0) THEN
		
         SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = INVALID_USERNAME;
         
    END IF;
    
    SELECT users.username AS `Client Username`, chatSessions.chatStatusid AS `Chat Status`, chatSessions.started AS `Started At`
	FROM wk_chatSessions AS chatSessions 
	JOIN wk_users AS users ON users.userid = chatSessions.clientid
	WHERE chatSessions.employeeid = @userid
    ORDER BY chatSessions.started DESC;

END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `wk_consultChat`
(
	IN pChatSessionid BIGINT
)
BEGIN
	SELECT users.username, content, posttime
	FROM wk_messages AS messages
	JOIN wk_users AS users ON (messages.senderid=users.userid)
	WHERE chatSessionid = pChatSessionid
	ORDER BY posttime;
END$$

