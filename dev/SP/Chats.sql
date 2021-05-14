DROP PROCEDURE IF EXISTS `wk_consultChats`;

DELIMITER $$
CREATE PROCEDURE `wk_consultChats`
(
	IN pUserName VARCHAR(20)
)
BEGIN 
	
    SET @userid = 0;
    
    SELECT IFNULL(userid, @userid) INTO @userid FROM wk_users WHERE TRIM(`username`)=pUserName;
    
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

