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



-- Punto 16
select * from wk_paymentStatus;
-- 1 Approved
-- 2 Denied
-- 3 In Transit

select * from wk_paymentAttemps;

SELECT usr.firstname, usr.lastname, pA.paymentTimeStamp, pA.paymentStatusid, pA.amount
FROM wk_users usr
INNER JOIN wk_clients cnt ON usr.userid = cnt.userid
INNER JOIN wk_paymentAttemps pA ON cnt.clientid = pA.clientid
WHERE pA.paymentStatusid = 2 OR pA.paymentStatusid = 3
GROUP BY pA.paymentStatusid;























