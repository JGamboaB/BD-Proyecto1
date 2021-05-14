-- CREATE VIEW MyWorkouts.wk_clientInformation AS
-- Client Information
SELECT CONCAT(firstname, ' ', lastname) AS `Name`, users.username AS `Username`, users.email AS `Email`, users.birthdate AS `Birthdate`
FROM wk_clients clients
JOIN wk_users users ON clients.userid = users.userid;

-- list of exercises
-- CREATE VIEW MyWorkouts.wk_displayWorkouts AS
SELECT exercises.name, exercises.steps, exercises.description, pictures.url
FROM wk_exercisesPerWorkout AS exercisesPerWorkout
JOIN wk_exercises AS exercises ON exercisesPerWorkout.exerciseid = exercises.exerciseid
JOIN wk_pictures AS pictures ON pictures.pictureid = exercises.exerciseid;

-- list of workouts 
SELECT workouts.name, workouts.creationDate
	FROM wk_workoutSessions AS workoutSessions
	JOIN wk_workouts AS workouts ON workoutSessions.workoutid = workouts.workoutid
	JOIN wk_clients AS clients ON workoutSessions.clientid = clients.clientid
	WHERE workoutSessions.clientid = 1
    GROUP BY workoutSessions.workoutid;
    

-- chat
SELECT users.username, content, posttime
FROM wk_messages AS messages
JOIN wk_users AS users ON (messages.senderid=users.userid)
WHERE chatSessionid = 1
ORDER BY posttime;

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
    
SELECT * FROM wk_users;

SELECT height AS `Height`, weight AS `Weight`, IFNULL(BMI, 'Not added'), posttime AS `Date`
    FROM wk_tracking
    WHERE clientid = 1
    ORDER BY posttime;
    
SELECT * FROM wk_ticketInformation
WHERE wk_ticketInformation.ticketid = 1;

SELECT `Client Username`, `Employee Username`, `Description`, `Ticket Category`, `Ticket Status`, `Date and Time of Creation` FROM wk_ticketInformation
    WHERE wk_ticketInformation.ticketid = 1;
    
SELECT `Client Username`, `Ticket Status`, DATE(`Date and Time of Creation`) AS `Date`
    FROM wk_ticketInformation AS ticketInformation
    WHERE ticketInformation.employeeid = 1;

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

SELECT `Name`, `Steps`, `Video`, `Reps`, `Sets`, `Time Duration`
    FROM wk_execiseInformation AS exerciseInformation
    WHERE exerciseInformation.workoutid = 1;
    
    SELECT * FROM wk_execiseInformation;

SELECT equipmentid, equipment.name
FROM wk_equipment AS equipment;