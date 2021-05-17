DELIMITER $$

CREATE PROCEDURE `wk_consultWorkoutsPerClient`
(
	IN pClientUserName VARCHAR(20)
)
BEGIN 
	SET @userid = 0;
	
    SELECT IFNULL(userid, @userid) INTO @userid FROM wk_users WHERE TRIM(`username`)=pClientUserName;
    
    SELECT workouts.name AS `Name`, workouts.creationDate AS `Creation Date`
	FROM wk_workoutSessions AS workoutSessions
	JOIN wk_workouts AS workouts ON workoutSessions.workoutid = workouts.workoutid
	JOIN wk_clients AS clients ON workoutSessions.clientid = clients.clientid
	GROUP BY workoutSessions.workoutid;
    
END$$

DELIMITER $$

CREATE PROCEDURE `wk_consultWorkout`
(
	IN pWorkoutId BIGINT
)
BEGIN 
	
    SELECT `Name`, `Steps`, `Video`, `Reps`, `Sets`, `Time Duration`
    FROM wk_execiseInformation AS exerciseInformation
    WHERE exerciseInformation.workoutid = pWorkoutId;
    
END$$

DELIMITER $$

CREATE PROCEDURE `wk_workoutsPrueba`()
BEGIN

	SELECT `name` FROM wk_workouts;
    
END$$