CREATE VIEW MyWorkouts.wk_ticketInformation AS
SELECT tickets.ticketid AS ticketid, tickets.employeeid AS employeeid, clients.username AS `Client Username`, employees.username AS `Employee Username`,
	   description AS `Description`, ticketCategories.name AS `Ticket Category`, ticketPriority.name AS `Ticket Priority`,
       ticketStatus.name AS `Ticket Status`, date AS `Date and Time of Creation`
FROM wk_tickets AS tickets
JOIN wk_users AS clients ON tickets.clientid = clients.userid
JOIN wk_users AS employees ON tickets.employeeid = employees.userid
JOIN wk_ticketCategories AS ticketCategories ON tickets.ticketCategoryid = ticketCategories.ticketCategoryid
JOIN wk_ticketStatus AS ticketStatus ON tickets.ticketStatusid = ticketStatus.ticketStatusid
JOIN wk_ticketPriorities AS ticketPriority ON tickets.ticketPriorityid = ticketPriority.ticketPriorityid;

CREATE VIEW wk_execiseInformation AS
SELECT exercisesPerWorkout.workoutid AS workouid, exercises.name AS `Name`, exercises.steps AS `Steps`, exercises.description AS `Description`, 
	   exercisesPerWorkout.reps AS `Reps`, exercisesPerWorkout.sets AS `Sets`, exercisesPerWorkout.timeDuration AS `Time Duration`,
	   categories.name AS `Category`, focus.name AS `Focus`, difficulty.name AS `Dificulty`, IFNULL(equipment.name, 'No Equipment') AS `Equipment`,
       videos.url AS `Video`
FROM wk_exercises AS exercises 
JOIN wk_exercisesPerWorkout AS exercisesPerWorkout ON exercises.exerciseid = exercisesPerWorkout.exerciseid  
JOIN wk_categories AS categories ON exercises.categoryid = categories.categoryid
JOIN wk_exerciseFocus AS focus ON exercises.focusid = focus.focusid
JOIN wk_difficultyLevels AS difficulty ON exercises.difficultyid = difficulty.difficultyid
LEFT OUTER JOIN wk_equipment AS equipment ON exercises.equipmentid = equipment.equipmentid 
JOIN wk_videosPerExercise AS videosPerExercise ON exercisesPerWorkout.exerciseid = videosPerExercise.exerciseid
JOIN wk_videos AS videos ON videosPerExercise.videoid = videos.videoid;