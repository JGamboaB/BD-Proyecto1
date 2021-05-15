USE MyWorkouts;

-- 11. ========================================
-- Se crea un stored procedure que va a crear un nuevo permiso para un rol nuevo
-- para un empleado nuevo

DROP PROCEDURE IF EXISTS newPermission;
DELIMITER $$
CREATE PROCEDURE newPermission
(
	-- Para wk_permissions
	pName VARCHAR(45),
    pDescription VARCHAR(100),
    pCode VARCHAR(30),
    
    -- Para wk_permissionsPerRole
    pEditedBy VARCHAR(30),
    pEditorId BIGINT,
    
    -- Para wk_roles
	pName_r VARCHAR(45),
    pDescription_r VARCHAR(100),
    
    -- Para wk_rolesPerEmployee
    pEditedby_r VARCHAR(30),
    pEditorId_r BIGINT,
    
    -- Para wk_users
	pGenderId_e TINYINT,
    pEmail_e VARCHAR(250),
    pUsername_e VARCHAR(20),
    pPassword_e VARBINARY(250),
    pFirstname_e VARCHAR(45),
    pLastname_e VARCHAR(45),
    pBirthdate_e DATE,
    
    -- Para wk_employees
    pDepartmentId_e TINYINT
)
BEGIN
	-- ERROR HANDLING
    DECLARE INVALID_EMAIL INT DEFAULT(52000);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @err_no = MYSQL_ERRNO, @message = MESSAGE_TEXT;
     
        IF (@email = ' ') THEN
			SET @message = 'Email Vacio - ROLLBACK';
        ELSE

            SET @message = CONCAT('Internal error: ', @message);
        END IF;
        
        ROLLBACK;
        
        RESIGNAL SET MESSAGE_TEXT = @message;
	END;
    
    -- Error si el email es vacio, ' '
	SELECT pEmail_e INTO @email;
    IF (@email = ' ') THEN
		SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = INVALID_EMAIL;
    END IF;
    
	-- Transaction
	SET autocommit = 0;
	START TRANSACTION;
    
		INSERT INTO wk_permissions (moduleid, `name`, `description`, `code`)
		VALUES
		(1, pName, pDescription, pCode);
		
		SELECT LAST_INSERT_ID() INTO @permissionsid;
		-- CALL a newRole para obtener roleid
		CALL newRole (pName_r, pDescription_r, pEditedby_r, pEditorId_r,
        pGenderId_e, pEmail_e, pUsername_e, pPassword_e, 
        pFirstname_e, pLastname_e, pBirthdate_e, pDepartmentId_e, @roleid);
		
		INSERT INTO wk_permissionsPerRole (permissionid, roleid, editedby, editorid, lastupdate, `checksum`)
		VALUES
		(@permissionsid, @roleid, pEditedBy, pEditorId, NOW(), sha2(concat(permissionid,roleid,editedby,editorid,lastupdate),256));
    
	COMMIT;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS newRole;
DELIMITER $$
CREATE PROCEDURE newRole
(
	-- Para wk_roles
	pName VARCHAR(45),
    pDescription VARCHAR(100),
    
    -- Para wk_rolesPerEmployee
    pEditedby VARCHAR(30),
    pEditorId BIGINT,
    
    -- Para wk_users
	pGenderId_e TINYINT,
    pEmail_e VARCHAR(250),
    pUsername_e VARCHAR(20),
    pPassword_e VARBINARY(250),
    pFirstname_e VARCHAR(45),
    pLastname_e VARCHAR(45),
    pBirthdate_e DATE,
    
    -- Para wk_employees
    pDepartmentId_e TINYINT,
    
    OUT pRoleId INT
)
BEGIN
	
    INSERT INTO wk_roles (`name`, `description`)
	VALUES
	(pName, pDescription);
	
	SELECT LAST_INSERT_ID() INTO @roleid;
	-- CALL a newEmployee para obtener employeeid
	CALL newEmployee (pGenderId_e, pEmail_e, pUsername_e, pPassword_e, 
	pFirstname_e, pLastname_e, pBirthdate_e, pDepartmentId_e, @employeeid);
	
	INSERT INTO wk_rolesPerEmployee (employeeid, roleid, editedby, editorid, lastupdate, `checksum`)
	VALUES
	(@employeeid, @roleid, pEditedBy, pEditorId, NOW(), sha2(concat(employeeid, roleid, editedby, editorid, lastupdate),256));
    
    SELECT @roleid INTO pRoleId;
    
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS newEmployee;
DELIMITER $$
CREATE PROCEDURE newEmployee
(
	-- Para wk_users
	pGenderId TINYINT,
    pEmail VARCHAR(250),
    pUsername VARCHAR(20),
    pPassword VARBINARY(250),
    pFirstname VARCHAR(45),
    pLastname VARCHAR(45),
    pBirthdate DATE,
    
    -- Para wk_employees
    pDepartmentId TINYINT,
    
    OUT pEmployeeId BIGINT
)
BEGIN
	
    INSERT INTO wk_users (genderid, email, username, `password`, firstname, lastname, birthdate, registeredAt)
	VALUES
	(pGenderId, pEmail, pUsername, pPassword, pFirstname, pLastname, pBirthdate, NOW());
	
	SELECT LAST_INSERT_ID() INTO @userid;
	
	INSERT INTO wk_employees (userid, departmentid)
	VALUES
	(@userid, pDepartmentId);
    
    SELECT LAST_INSERT_ID() INTO pEmployeeId;
    
END $$
DELIMITER ;

-- PRUEBAS --
-- COMMIT
CALL newPermission ('Promotion', 'Permission to promote the app.', 508, 
'Managment', 0,
'Marketing', 'Role in charge of making adds and promoting the app.',
'Managment', 0,
1, 'joema@hotmail.com', 'joemam777', 'x_joe_ma_x', 'JOE', 'MARINO', DATE(FROM_UNIXTIME(RAND() * (63075600 - 978310800) + 1230796800)), 
3);

SELECT * FROM wk_permissions;
SELECT * FROM wk_roles;
SELECT * FROM wk_employees;
SELECT * FROM wk_users;

-- ROLLBACK
-- Error si el user email es vacio
CALL newPermission ('Staff Manager', 'Permission to acess the staff section.', 509, 
'Managment', 0,
'Human Resources', 'Role in charge of the hire and fire of employees.',
'Managment', 0,
1, ' ', 'AlanP2', 'alanCitoPe_2', 'ALAN', 'PEREZ', DATE(FROM_UNIXTIME(RAND() * (63075600 - 978310800) + 1230796800)), 
5);

-- Error si el user email es repetido (error de sql porque email es UNIQUE)
CALL newPermission ('Staff Manager', 'Permission to acess the staff section.', 509, 
'Managment', 0,
'Human Resources', 'Role in charge of the hire and fire of employees.',
'Managment', 0,
1, 'chlim@yahoo.ca', 'AlanP2', 'alanCitoPe_2', 'ALAN', 'PEREZ', DATE(FROM_UNIXTIME(RAND() * (63075600 - 978310800) + 1230796800)), 
5);



-- 17. ========================================
SELECT * FROM wk_workoutSessions;

-- Inserts adicionales solo para pruebas
INSERT INTO wk_workoutSessions(workoutid, clientid, started, finished)
VALUES 
(1, 1, '2021-01-15 04:10:57', '2021-12-01 04:30:57'),
(1, 1, '2021-03-16 04:10:57', '2021-12-01 04:30:57'),
(1, 1, '2021-02-15 04:10:57', '2021-12-01 04:30:57'),
(1, 1, '2021-02-16 04:10:57', '2021-12-01 04:30:57'),
(1, 1, '2021-03-15 04:10:57', '2021-12-01 04:30:57'),
(1, 1, '2021-03-16 04:10:57', '2021-12-01 04:30:57'),
(1, 1, '2021-04-15 04:10:57', '2021-12-01 04:30:57'),
(1, 1, '2021-04-16 04:10:57', '2021-12-01 04:30:57'),
(1, 1, '2021-04-15 04:10:57', '2021-12-01 04:30:57'),
(1, 1, '2021-06-16 04:10:57', '2021-12-01 04:30:57'),
(1, 1, '2021-07-16 04:10:57', '2021-12-01 04:30:57'),
(1, 1, '2021-07-17 04:10:57', '2021-12-01 04:30:57'),
(1, 1, '2021-07-18 04:10:57', '2021-12-01 04:30:57'),
(1, 1, '2021-07-19 04:10:57', '2021-12-01 04:30:57'),
(1, 1, '2021-08-13 04:10:57', '2021-12-01 04:30:57'),
(1, 1, '2021-08-14 04:10:57', '2021-12-01 04:30:57'),
(1, 1, '2021-08-15 04:10:57', '2021-12-01 04:30:57'),
(1, 1, '2021-08-16 04:10:57', '2021-12-01 04:30:57'),
(1, 1, '2021-08-17 04:10:57', '2021-12-01 04:30:57'),
(1, 1, '2021-09-17 04:10:57', '2021-12-01 04:30:57'),
(1, 1, '2021-10-17 04:10:57', '2021-12-01 04:30:57'),
(1, 1, '2021-10-17 04:10:57', '2021-12-01 04:30:57'),
(1, 1, '2021-11-17 04:10:57', '2021-12-01 04:30:57'),
(1, 1, '2021-12-17 04:10:57', '2021-12-01 04:30:57'),
(1, 1, '2021-12-17 04:10:57', '2021-12-01 04:30:57'),
(1, 1, '2021-12-17 04:10:57', '2021-12-01 04:30:57');


-- SELECTS SEPARADOS --

-- SELECT MONTH(started) Mes, COUNT(*) Volumen_Bajo FROM wk_workoutSessions
-- WHERE started >= '2021-09-01' AND started <= '2021-09-30'
-- GROUP BY MONTH(started) HAVING Volumen_Bajo <= 2
-- ORDER BY Mes ASC;
-- SELECT MONTH(started) Mes, COUNT(*) Volumen_Medio FROM wk_workoutSessions
-- WHERE started >= '2021-09-01' AND started <= '2021-09-30'
-- GROUP BY MONTH(started) HAVING Volumen_Medio > 2 AND Volumen_Medio <= 4
-- ORDER BY Mes ASC;
-- SELECT MONTH(started) Mes, COUNT(*) Volumen_Alto FROM wk_workoutSessions
-- WHERE started >= '2021-09-01' AND started <= '2021-09-30'
-- GROUP BY MONTH(started) HAVING Volumen_Alto > 4 AND Volumen_Alto <= 6
-- ORDER BY Mes ASC;


-- UN SOLO SELECT --

SELECT * FROM (
    SELECT MONTH(started) Mes, 
    COUNT(*) Volumen_Bajo, 0 Volumen_Medio, 0 Volumen_Alto FROM wk_workoutSessions
	WHERE started >= '2021-09-01' AND started <= '2021-09-30'
    GROUP BY MONTH(started) HAVING Volumen_Bajo <= 2
    
    UNION
    
	SELECT MONTH(started) Mes, 
    0 Volumen_Bajo, COUNT(*) Volumen_Medio, 0 Volumen_Alto FROM wk_workoutSessions
    WHERE started >= '2021-09-01' AND started <= '2021-09-30'
    GROUP BY MONTH(started) HAVING Volumen_Medio > 2 AND Volumen_Medio <= 4
    
	UNION
    
	SELECT MONTH(started) Mes,
    0 Volumen_Bajo, 0 Volumen_Medio, COUNT(*) Volumen_Alto FROM wk_workoutSessions
    WHERE started >= '2021-09-01' AND started <= '2021-09-30'
	GROUP BY MONTH(started) HAVING Volumen_Alto > 4 AND Volumen_Alto <= 6
) AS Conteo
ORDER BY Mes ASC;