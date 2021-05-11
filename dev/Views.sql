-- CREATE VIEW MyWorkouts.wk_clientInformation AS
SELECT CONCAT(firstname, ' ', lastname) AS `Name`, users.username AS `Username`, users.email AS `Email`, users.birthdate AS `Birthdate`
FROM wk_clients clients
JOIN wk_users users ON clients.userid = users.userid;


SELECT exercises.name, exercises.steps, exercises.description, reps, sets, timeDuration, pictures.url
FROM wk_exercisesPerWorkout AS exercisesPerWorkout
JOIN wk_exercises AS exercises ON exercisesPerWorkout.exerciseid = exercises.exerciseid
JOIN wk_pictures AS pictures ON pictures.pictureid = exercises.exerciseid;

