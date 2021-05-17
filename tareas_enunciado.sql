-- Punto 10
-- El total de ejercicios que tiene un workout y
-- la cantidad de ejercicios separados por sus respectivas categorías.

SELECT workout.name, COUNT(*),
	SUM(IF(exercise.categoryid = 1, 1, 0)) AS 'Endurance',
    SUM(IF(exercise.categoryid = 2, 1, 0)) AS 'Strength',
    SUM(IF(exercise.categoryid = 3, 1, 0)) AS 'Hypertrophy',
    SUM(IF(exercise.categoryid = 4, 1, 0)) AS 'Cardio'
FROM wk_exercisesPerWorkout epw
INNER JOIN wk_workouts workout ON workout.workoutid = epw.workoutid
INNER JOIN wk_exercises exercise ON exercise.exerciseid = epw.exerciseid
GROUP BY workout.workoutid;


-- Extrae los mismos datos que la consulta de arriba, sin embargo, si se agregaran nuevas 
-- categorías de ejercicios, esta consulta mostraría los resultados actualizados
-- 1 Endurance
-- 2 Strength
-- 3 Hypertrophy
-- 4 Cardio

SET @query = NULL;
SET @categories = NULL;

SELECT GROUP_CONCAT(
	CONCAT("SUM(IF(exe.categoryid=",exe.categoryid,", 1, 0)) AS '",exe.categoryid, "'"), "\n"
	) INTO @categories
FROM (SELECT DISTINCT wk_exercises.categoryid FROM wk_exercises) exe;

SET @query := CONCAT(
	"SELECT wk_workouts.name, COUNT(*), ", @categories, " FROM wk_exercisesPerWorkout epw
	INNER JOIN wk_workouts ON wk_workouts.workoutid = epw.workoutid
	INNER JOIN wk_exercises exe ON exe.exerciseid = epw.exerciseid
	GROUP BY wk_workouts.workoutid");
        
PREPARE statement FROM @query;
EXECUTE statement;
DEALLOCATE PREPARE statement;




-- Punto 11
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




-- 12. Cree un stored procedure que retorne el resultado de una consulta de al menos 3 tablas unidas en 
-- formato json

drop procedure if exists workout2JSON;
DELIMITER $$
CREATE PROCEDURE workout2JSON (
	pWK_name varchar(30)
)
BEGIN
	SELECT JSON_ARRAYAGG(JSON_OBJECT('workout id', wk.workoutid, 'workout name', wk.name, 'creation time', wk.creationDate, 'preset', wk.preset, 
    'deleted', wk.deleted, 'exercise name', e.name, 'exercise description', e.description, 'steps', e.steps, 'category', c.name, 'category description', c.description, 
    'focus', eF.name, 'difficulty', d.name, 'equipment', eq.name, 'sets', ePW.reps, 'reps', ePW.reps, 'time duration', ePW.timeDuration, 
    'recommended reps', e.recommendedReps, 'recommended sets', e.recommendedSets, 'recommended time duration', e.recommendedDuration)) 
    from wk_exercisesPerWorkout ePW
	inner join wk_workouts wk on wk.workoutid = ePW.workoutid
	inner join wk_exercises e on e.exerciseid = ePW.exerciseid
	left join wk_categories c on e.categoryid = c.categoryid
	left join wk_exerciseFocus eF on e.focusid = eF.focusid
	left join wk_difficultyLevels d on e.difficultyid = d.difficultyid
	left join wk_equipment eq on e.equipmentid = eq.equipmentid
	where wk.name = pWK_name;
    
END$$
DELIMITER ;

call workout2JSON('Full body, no equipment');




-- 13. Cree un stored procedure que inserte N registros en una tabla, tomando los datos correctamente
-- identificados de una tabla temporal libre de restricciones que fue previamente llenada

-- Tabla temporal
drop temporary table if exists NewEquipment;
CREATE TEMPORARY TABLE NewEquipment (
	groupid binary(16),
	`name` varchar(20),
    descr varchar(50),
	weight decimal(5,2)
);

-- Solo para insertar algunos registros en la tabla temporal
drop procedure if exists fillTempTable;
Delimiter //
create procedure fillTempTable(
	pGroupid binary(16)
)
begin
    set @counter = 1;
    while @counter <= 5 do
		set @nameTemp = ELT(@counter, 'Jump Rope', 'Hand Grips', 'Barbells', 'Treadmill', 'Ab Wheel');
        set @descTemp = ELT(@counter, 'Rope used for jumping exercises', 'Tool used for perfecting your hand griping', 
        'Longer version of a dumbbell', 'Used for running while staying in the same place', 'Wheel used for strengthening and toning abs');
		set @weightTemp = ELT(@counter, '0.00', '0.00', '30.00', '0.00', '0.00');
        
		insert into NewEquipment(groupid, `name`, descr, weight)
        values (pGroupid, @nameTemp, @descTemp, cast(@weightTemp as decimal(5,2)));
        
        set @counter = @counter + 1;
    end while;
	
end //
Delimiter ;

-- Comprobando si se insertó en la tabla temporal
-- select * from NewEquipment;

-- Procedimiento que inserta N registros basados en un id de grupo (uuid_to_bin (uuid()))
drop procedure if exists insertNregisters;
Delimiter //
create procedure insertNregisters(
	pGroupid binary(16)
) 
begin
	select pGroupid;
    insert into wk_equipment(`name`, `description`, weight)
    select `name`, descr, weight from NewEquipment e
    where e.groupid = pGroupid;
end //
Delimiter ;


set @groupid = uuid();
call fillTempTable(uuid_to_bin(@groupid));
call insertNregisters(uuid_to_bin(@groupid));

-- Compruebar si los registros N estaban insertados
-- select * from wk_equipment;

drop temporary table NewEquipment;




-- 15. Cree un(os) query(s) para cada una de los siguientes tipos de instrucciones y/o operadores de tal 
-- manera que se demuestre claramente su uso:
-- a. Uso de un cursor
-- b. Uso de un trigger
-- c. Un substring

-- a) Cursor -- Ejemplo: Imprimir ids de permisos que contiene un rol en especifico

drop procedure if exists permissionsOfRole;
DELIMITER $$
create procedure permissionsOfRole(
	pName varchar(45)
)
BEGIN
	DECLARE done BOOLEAN DEFAULT 0;
    
    Declare permissionidP, lastPP int;
    Declare allPP varchar(100);
    
    DECLARE My_Cursor CURSOR FOR 
	SELECT permissionid
	FROM wk_permissionsPerRole p
    inner join wk_roles r on p.roleid=r.roleid 
    where r.name=pName;

    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done=1;
    
    set allPP = concat(pName, ' contains permissions: ');
    set lastPP = 0;
    
    OPEN My_Cursor; -- El cursor recorre todos los registros que cumplan el where y los utilizo para concaternarlos en un varchar para seleccionarlo al final.
		REPEAT
			fetch next from My_Cursor
			into permissionidP;
            
            if permissionidP<>lastPP
				then set allPP = concat(allPP, ' < ', permissionidP, ' > ');
            end if;
            
            set lastPP = permissionidP;
    
		UNTIL done END REPEAT;
    
    CLOSE My_Cursor;
    
    select allPP;

END$$
DELIMITER ;

call permissionsOfRole('Manager');


-- b) Trigger
-- Genere una nueva cehcksum si se actualiza el rol de un empleado

drop trigger if exists TR_wk_rolesPerEmployee_afterupdate;
delimiter //
CREATE TRIGGER TR_wk_rolesPerEmployee_afterupdate AFTER UPDATE
ON wk_rolesPerEmployee FOR EACH ROW
	update wk_rolesPerEmployee set new.`checksum` = sha2(concat(new.employeeid, new.roleid, new.editedby, new.editorid, new.lastupdate),256);
//
delimiter ;


-- c) Substring
-- Es una instruccion muy directa, nos consigue un pedazo del string en la posicion(es) que le indicamos.
-- Por ejemplo, si quiero conseguir los primeros 6 caracteres, pongo en la posicion inicial 1 y luego que agarre 6 caracteres
select substring('1234567890', 1, 6);
-- R/ '123456'

-- Si quiero agarrar del setimo caracter en adelante:
select substring('1234567890', 7);
-- R/ '7890'

-- Puedo ingresar posiciones negativas para acceder a los ultimos caracteres
-- Por ejemplo, agarrar los ultimos 10 caracteres de steps en wk_exercises
select substring(steps, -10) from wk_exercises;

-- Otro ejemplo que podemos hacer es conseguir todos los años de nacimiento de los usuarios, y ordenarlos ascendientemente
select substring(birthdate, 1, 4) from wk_users
order by birthdate ASC;




-- Punto 16
SELECT us.firstname, us.lastname, mc.name, pS.name, pA.description, pA.posttime
FROM wk_users us
INNER JOIN wk_clients cl ON us.userid = cl.userid
INNER JOIN wk_paymentAttemps pA ON pA.clientid = cl.clientid
INNER JOIN wk_paymentStatus pS ON pA.paymentStatusid = pS.paymentStatusid
INNER JOIN wk_merchants mc ON pA.merchantid = mc.merchantid
WHERE pA.paymentStatusid <> 1;




-- Punto 17
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