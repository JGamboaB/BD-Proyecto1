USE `MyWorkouts`;
DROP procedure IF EXISTS `wk_registerPayment`;

USE `MyWorkouts`;
DROP procedure IF EXISTS `MyWorkouts`.`wk_registerPayment`;
;

DELIMITER $$
USE `MyWorkouts`$$
CREATE DEFINER=`root`@`%` PROCEDURE `wk_registerPayment`(
	 IN pClientUserName VARCHAR(20),
     IN pMerchantName VARCHAR(200),
     IN pAmount DECIMAL(5,2)
)
BEGIN

	-- Error Handler
	DECLARE NOT_ENOUGH_MONEY INT DEFAULT(53000);
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @err_no = MYSQL_ERRNO, @message = MESSAGE_TEXT;
        SET @paymentStatusid = 2;
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
    
    SET autocommit = 0;
    
	SET @paymentStatusid = 1;
    SET @userid = 0;
    SET @merchantid = 0;
    SET @amount = 0;
    SET @ipAdress = '';
    SET @description = 'Premium Payment';
    
    SELECT IFNULL(userid, @userid) INTO @userid FROM wk_users WHERE TRIM(`username`)=pClientUserName;
    
    SELECT IFNULL(merchantid, @merchantid) INTO @merchantid FROM wk_merchants WHERE TRIM(`name`)=pMerchantName;
    
    SELECT amount INTO @amount FROM wk_plans WHERE planid = 1;
    
    SELECT HOST INTO @ipAdress FROM information_schema.processlist WHERE ID=connection_id();
    
    IF (@amount < pAmount) THEN
		SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = INVALID_FUND;
    END IF;
		
    START TRANSACTION;
		INSERT INTO wk_paymentAttemps(clientid, paymentStatusid, merchantid, posttime, amount, currentSymbol, errorNumber, merchantTransNumber, description, paymentTimeStamp,
									  computerName, username, ipAdress, `checkSum`)
		VALUES(@userid, @paymentStatusid, @merchantid, NOW(), pAmount, '$', @err_no, 145236985, @description, NOW(), 'MY_PC', pClientUserName, @ipAdress, 
				sha2(concat('MY_PC', pClientUserName, @ipAdress), 256));
		
        UPDATE wk_clients SET planid = 1
        WHERE userid = @userid;
        
	COMMIT;
    
END$$

DELIMITER ;
;
