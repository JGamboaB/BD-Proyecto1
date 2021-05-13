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
