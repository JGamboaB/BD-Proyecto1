DROP VIEW IF EXISTS wk_execiseInformation;
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `MyWorkouts`.`wk_execiseInformation` AS
    SELECT 
        `exercisesPerWorkout`.`workoutid` AS `workoutid`,
        `exercises`.`name` AS `Name`,
        `exercises`.`steps` AS `Steps`,
        `exercises`.`description` AS `Description`,
        `exercisesPerWorkout`.`reps` AS `Reps`,
        `exercisesPerWorkout`.`sets` AS `Sets`,
        `exercisesPerWorkout`.`timeDuration` AS `Time Duration`,
        `categories`.`name` AS `Category`,
        `focus`.`name` AS `Focus`,
        `difficulty`.`name` AS `Dificulty`,
        IFNULL(`equipment`.`name`, 'No Equipment') AS `Equipment`,
        `videos`.`url` AS `Video`
    FROM
        (((((((`MyWorkouts`.`wk_exercises` `exercises`
        JOIN `MyWorkouts`.`wk_exercisesPerWorkout` `exercisesPerWorkout` ON ((`exercises`.`exerciseid` = `exercisesPerWorkout`.`exerciseid`)))
        JOIN `MyWorkouts`.`wk_categories` `categories` ON ((`exercises`.`categoryid` = `categories`.`categoryid`)))
        JOIN `MyWorkouts`.`wk_exerciseFocus` `focus` ON ((`exercises`.`focusid` = `focus`.`focusid`)))
        JOIN `MyWorkouts`.`wk_difficultyLevels` `difficulty` ON ((`exercises`.`difficultyid` = `difficulty`.`difficultyid`)))
        LEFT JOIN `MyWorkouts`.`wk_equipment` `equipment` ON ((`exercises`.`equipmentid` = `equipment`.`equipmentid`)))
        JOIN `MyWorkouts`.`wk_videosPerExercise` `videosPerExercise` ON ((`exercisesPerWorkout`.`exerciseid` = `videosPerExercise`.`exerciseid`)))
        JOIN `MyWorkouts`.`wk_videos` `videos` ON ((`videosPerExercise`.`videoid` = `videos`.`videoid`)))