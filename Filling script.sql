use MyWorkouts;

-- Datos para wk_days
INSERT INTO wk_days (`name`)
VALUES ('Sunday'), ('Monday'), ('Tuesday'),
('Wednesday'),('Thursday'),('Friday'),('Saturday');

-- Datos para wk_paymentStatus
INSERT INTO wk_paymentStatus(name)
VALUES ('Approved'),('Denied'),('In Transit');

-- Datos para wk_genders
INSERT INTO wk_genders(name)
VALUES ('Male'),('Female');

-- Datos para wk_icons
INSERT INTO wk_icons(url)
VALUES ('https://static.thenounproject.com/png/247254-200.png');

-- Datos de wk_plans. Planes disponibles para clientes.
INSERT INTO wk_plans(iconid, name, description, amount, starttime, endtime, enabled, deleted)
VALUES
(1, 'Premium', 'With this plan you can have all the benefits of the premium package.', 50.00, NOW(), null, 1, 0),
(1, 'Regular', 'With this plan you can only have up to two workout rutines.', 0, NOW(), null, 1, 0);

-- Datos de wk_roles. Roles de empleado
INSERT INTO wk_roles (roleid, `name`, description)
VALUES 
(1, 'Development', 'Role in charge of the app maintenance and improvements.'),
(2, 'Customer Service', 'Role in charge of assisting users by chat.'),
(3, 'Coach', 'Role in charge of handling the preloaded exercises and answering 
queries related to exercises.'),
(4, 'Accounting', 'Role in charge of supervising the movement of money of the app.'),
(5, 'Manager', 'Role in charge of the management and general supervision of the app, has 
all permits.');

-- Por ahora solo tenemos la app principal
INSERT INTO wk_applications (name, description)
VALUES
('My Workout', 'Main app aimed at common users where they can create and follow 
their own workouts.');

-- Module TEMPORAL para poder usar los permisos, CAMBIAR cuando se pueda
INSERT INTO wk_modules (`name`, applicationid)
VALUES ('Temporary', 1);

-- Datos de wk_permissions. Permisos de empleados
INSERT INTO wk_permissions (moduleid, `name`, description, `code`)
VALUES 
(1, 'Chat', 'Permission to use chat.', 501),
(1, 'Supervise Chats', 'Permission to supervise user chats.', 502),
(1, 'Preloaded Exercises', 'Permission to edit preloaded exercises.', 503),
(1, 'Transactions', 'Permission to view user transactions.', 504),
(1, 'Vault', 'Permission to review money inflows and outflows from the app.', 505),
(1, 'Admin', 'Permission to edit roles, permissions, and user accounts.', 506),
(1, 'Money', 'Permission to handle the money in the app.', 507);


-- Es un historial, por lo que para inciar van como editados por "Managment" con id = 0
INSERT INTO wk_permissionsPerRole (permissionid, roleid, editedby, editorid, enabled, lastupdate, `checksum`)
VALUES 
(6, 1, 'Managment', 0, 1, '2020-03-08 13:42:10', sha2(concat(permissionid,roleid,editedby,editorid,lastupdate),256)),
(1, 2, 'Managment', 0, 1, '2020-03-08 13:42:11', sha2(concat(permissionid,roleid,editedby,editorid,lastupdate),256)),
(1, 3, 'Managment', 0, 1, '2020-03-08 13:42:12', sha2(concat(permissionid,roleid,editedby,editorid,lastupdate),256)),
(3, 3, 'Managment', 0, 1, '2020-03-08 13:42:13', sha2(concat(permissionid,roleid,editedby,editorid,lastupdate),256)),
(4, 4, 'Managment', 0, 1, '2020-03-08 13:42:14', sha2(concat(permissionid,roleid,editedby,editorid,lastupdate),256)),
(5, 4, 'Managment', 0, 1, '2020-03-08 13:42:15', sha2(concat(permissionid,roleid,editedby,editorid,lastupdate),256)),
(1, 5, 'Managment', 0, 1, '2020-03-08 13:42:16', sha2(concat(permissionid,roleid,editedby,editorid,lastupdate),256)),
(2, 5, 'Managment', 0, 1, '2020-03-08 13:42:17', sha2(concat(permissionid,roleid,editedby,editorid,lastupdate),256)),
(3, 5, 'Managment', 0, 1, '2020-03-08 13:42:18', sha2(concat(permissionid,roleid,editedby,editorid,lastupdate),256)),
(4, 5, 'Managment', 0, 1, '2020-03-08 13:42:19', sha2(concat(permissionid,roleid,editedby,editorid,lastupdate),256)),
(5, 5, 'Managment', 0, 1, '2020-03-08 13:42:20', sha2(concat(permissionid,roleid,editedby,editorid,lastupdate),256)),
(6, 5, 'Managment', 0, 1, '2020-03-08 13:42:21', sha2(concat(permissionid,roleid,editedby,editorid,lastupdate),256)),
(7, 5, 'Managment', 0, 1, '2020-03-08 13:42:22', sha2(concat(permissionid,roleid,editedby,editorid,lastupdate),256));


-- Datos de wk_ticketCategories
INSERT INTO wk_ticketCategories (name)
VALUES
('Technical problem'),
('Subscription'),
('User account'),
('Cancelation');

-- Datos de wk_ticketStatus
INSERT INTO wk_ticketStatus (name)
VALUES
('New'),
('In progress'),
('Pending'),
('Resolved'),
('Closed');

-- Datos de wk_ticketPriorites
INSERT INTO wk_ticketPriorities (name)
VALUES
('Low'),
('Medium'),
('High'),
('Urgent');

-- Datos de wk_chatStatus
INSERT INTO wk_chatStatus (name)
VALUES
('Online'),
('Outside'),
('Occupied'),
('Disconnected');

-- Datos de wk_departments
INSERT INTO wk_departments (name)
VALUES
('Development'), ('Customer Service'), ('Marketing'),
('Financial Accounting'), ('Human Resources'), ('Management');

-- Datos para wk_categories. Categorías de wk_exercises
insert into wk_categories(`name`, `description`)
values ('Endurance', 'Ability of a given muscle to exert force, consistently and repetitively, over a period of time.'),
('Strength', 'Focus on strength of a specific body part'),
('Hypertrophy', 'Increase and growth of muscle cells'),
('Cardio', 'Gets your heart rate up and keeps it up for a prolonged period of time.'); 

-- Datos para wk_difficultyLevels 
insert into wk_difficultyLevels(`name`)
values ('Beginner'), ('Intermediate'), ('Expert');

-- Datos para wk_exerciseFocus
insert into wk_exerciseFocus(`name`)
values ('Biceps'), ('Triceps'), ('Lats'), ('Back'), ('Chest'), ('Legs'), ('Thighs'), ('Forearms'), ('Calves'), ('Deltoids'), ('Abs');

-- Datos para wk_equipment
insert into wk_equipment(`name`,`description`,weight)
values ('Dumbbells','A normal dumbbell (shape can vary)', 15),
('Stationary Bike','Exercise bike', 0),
('Exercise Ball','Plastic ball made for exercising', 5),
('Jump Rope','Plastic rope made for exercising', 1),
('Kettlebell', 'Cast iron/steel ball with a handle attached.',15);

-- Datos para wk_exercises
insert into wk_exercises(`name`, categoryid, focusid, difficultyid, equipmentid, steps, `description`, recommendedReps, recommendedSets, recommendedDuration)
values ('Lunges', 4, 7, 1, null, 'Stand with your feet shoulder-width apart and arms down at your sides. 
Take a step forward with your right leg and bend your right knee, stop when your thigh is parallel to the ground. 
Return to starting position. Repeat with left leg.', 'Move your torso up and down with your legs', 20, 4, null),
('Pushups', 1, 11, 1, null, 'Start in a plank position. Core should be tight, shoulders pulled down and back, and neck neutral. 
Bend your elbows and lower your body to the floor. When your chest grazes it, extend your elbows and start again. 
Keep your elbows close to your body', 'Push your body up', 15, 4, null),
('Dumbbell rows', 2, 4, 1, 1, 'Dumbbell in each hand. Bend forward at the waist so your back is at a 45° angle to the ground. 
Starting with your right arm, bend your elbow and pull the weight straight up toward your chest, stop just below your chest. 
Repeat with your left arm.', 'Like rowing on a boat, makes your back amazing.', 10, 3, null),
('Single-leg deadlifts', 1, 6, 2, 1, 'Dumbbell in your right hand and knees slightly bent. 
Kick left leg straight back, lowering the dumbbell toward the ground. 
Reach a comfortable height with your leg, slowly return to the starting position.
Move the weight to your left hand & repeat','Dead-lift your spirits.', 12, 3, null),
('Planks', 4, 11, 1, null, 'Begin in a push-up position, hand and toes firmly on the ground, back straight, and core tight.
Chin slightly tucked and gaze in front of your hands. Deep breaths while maintaining tension throughout your entire body.', 'Like Plank-ton.', 1, 2, 30),
('Alternating Incline Dumbbell Curl', 3, 1, 3, 1,'On an incline bench, lie back with a dumbbell in each hand.
Keeping elbow and shoulder stationary, slowly lift 1 weight to the front of your shoulder.
Pause, squeezing your bicep. Slowly reverse the movement.
Repeat on the opposite side. ', 'Incline and alternating', 15, 4, null),
('Diamond Push-Ups', 2, 2, 3, null, 'Assume the push-up position, but with your hands together in a diamond-like formation (i.e. index fingers and thumbs touching).
Keeping your back straight, lower your chest until it almost touches the floor. Rise and repeat.', 'Harder Push-ups', 15, 3, null),
('Chest Press', 2, 5, 1, 1, 'Sit with knees bent slightly and your feet on the floor. Grasp the handles, exhale as you push them away until arms are straight out. Keep elbows slightly bent. 
As you inhale, pull the bars toward you slowly, without letting the weights touch down.', 'Makes your chest bigger.', 15, 3, null),
('Kettlebell Rack Hold', 1, 3, 1, 5, 'Clean either a single kettlebell into a racked position. 
Pull elbow down to the hip to engage lats & pull shoulders away from ears; Resist leaning back by focusing on pulling the hips back, will bring the shoulders forward.', 'Bigger your Lats', 1, 3, 30),
('Crab Walk', 4, 8, 1, null, 'Come into reverse tabletop position.
Place your hands under your shoulders with your fingers facing forward. Align your ankles directly under your knees.
Walk forward on your hands and feet for up to a minute at a time.', 'Mr. Krabs argh agrh argh argh.', 1, 2, '00:01:00'),
('Jumping Jacks', 4, 9, 1, null, 'Stand upright with your feet together and your arms at your sides. 
Simultaneously jump and spread your legs while clapping your hands above your head. 
Jump again as you return to the starting position. Repeat.', 'Jump and feel like Jack', 20, 3, null),
('Plank with Shoulder Taps', 1, 10, 2, null, 'Start in a high plank. Alternate bringing your hand to the opposite shoulder without allowing your torso to twist.', 
'Planking with one hand at a time.', 20, 3, null);

-- Datos para wk_videos
insert into wk_videos(url)
values ('https://thumbs.gfycat.com/RequiredThinAbalone-mobile.mp4'),
('https://thumbs.gfycat.com/FittingIdenticalAtlanticspadefish-mobile.mp4'),
('https://thumbs.gfycat.com/AdvancedBestChrysalis-mobile.mp4'),
('https://thumbs.gfycat.com/CriminalMealyGar-mobile.mp4'),
('https://thumbs.gfycat.com/ClutteredEcstaticFinnishspitz-mobile.mp4'),
('https://youtu.be/bgYt7ZgFc9M'),
('https://www.youtube.com/watch?v=-F-kADNt2Ik&feature=emb_rel_pause'),
('https://hmg-h-cdn.hearstapps.com/videos/chest-press-side-1553016142.mp4'),
('https://hmg-h-cdn.hearstapps.com/videos/rw-jess-1st-move-1579794350.mp4'),
('https://www.youtube.com/watch?v=I-3r4cl4ahA&ab_channel=LivestrongWoman'),
('https://youtu.be/9gDfNpzytLo'),
('https://www.youtube.com/watch?v=QOCn3_iOAro&ab_channel=Northeastern');

-- Datos para wk_videosPerExercise
insert into wk_videosPerExercise(videoid, exerciseid)
values (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,12);

-- Datos para wk_pictures
insert into wk_pictures(url)
values ('https://julielohre.com/wp-content/uploads/2018/07/AlternatingLunges-1-1024x760.jpg'),
('https://cdn.prod.openfit.com/uploads/2017/06/01150749/how-to-get-better-at-push-ups2.jpg'),
('https://www.crossfit.com/wp-content/uploads/2019/04/03111458/Bent-Over-Row-Collage-1024x576.png'),
('https://cdn.prod.openfit.com/uploads/2019/09/05175233/deadlift.jpg'),
('https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F35%2F2020%2F02%2Flow-plank-hold.jpg'),
('https://i.pinimg.com/originals/9d/89/b0/9d89b04811556ef4cc26c57aa496b509.png'),
('https://hips.hearstapps.com/vidthumb/brightcove/57894083e694aa370d8834ff/thumb_1468612741.png'),
('https://i0.wp.com/images-prod.healthline.com/hlcmsresource/images/topic_centers/Fitness-Exercise/400x400_7_Top_Chest_Exercises_for_Men_Chest_Press.gif?w=525'),
('https://i.pinimg.com/originals/29/6e/fd/296efda0d27153eb5dccb4ff922bb1ca.jpg'),
('https://i.pinimg.com/originals/3d/0f/0d/3d0f0d046b6c0d7f917e8c36743dc636.jpg'),
('https://www.researchgate.net/profile/Mohammed-Abou-Elmagd/publication/341734848/figure/fig1/AS:896516470362114@1590757591713/Sample-of-Jumping-Jacks-Exercise-4.png'),
('https://media1.popsugar-assets.com/files/thumbor/UjRu9n3XhNilWLRUd9G86CD0SNo/fit-in/2048xorig/filters:format_auto-!!-:strip_icc-!!-/2017/06/14/784/n/1922729/4b0aa10159417724bd23c1.78911403_Plank-Shoulder-Tap/i/Plank-Shoulder-Tap.jpg');

-- Datos para wk_picturesPerExercise
insert into wk_picturesPerExercise(pictureid, exerciseid)
values (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,12);

-- Datos para wk_users
INSERT INTO wk_users (genderid, email, username, password, firstname, lastname, birthdate, registeredAt)
values
(2, 'calin@hotmail.com', 'shaquille.oatmeal', sha2(concat(email,username,'MySecretPassword123',birthdate),256), 'ADRIANA', 'HERNANDEZ', DATE(FROM_UNIXTIME(RAND() * (63075600 - 978310800) + 1230796800)), date_add(date_add(now(), INTERVAL -1 YEAR), INTERVAL floor(rand()*(9999999-1)+1) SECOND)), 
(1, 'pspoole@yahoo.ca', 'hoosier-daddy', sha2(concat(email,username,'HozierIsAwesome',birthdate),256), 'ALEJANDRO', 'RODRIGUEZ', DATE(FROM_UNIXTIME(RAND() * (63075600 - 978310800) + 1230796800)), date_add(date_add(now(), INTERVAL -1 YEAR), INTERVAL floor(rand()*(9999999-1)+1) SECOND)),
(1, 'fraser@live.com', 'BadKarma', sha2(concat(email,username,'JoeMama123',birthdate),256), 'ALEXANDER', 'JACKSON', DATE(FROM_UNIXTIME(RAND() * (63075600 - 978310800) + 1230796800)), date_add(date_add(now(), INTERVAL -1 YEAR), INTERVAL floor(rand()*(9999999-1)+1) SECOND)),
(1, 'plover@verizon.net', 'cute.as.ducks', sha2(concat(email,username,'CamiloYEvaluna',birthdate),256), 'CAMILO', 'BOTERO', DATE(FROM_UNIXTIME(RAND() * (63075600 - 978310800) + 1230796800)), date_add(date_add(now(), INTERVAL -1 YEAR), INTERVAL floor(rand()*(9999999-1)+1) SECOND)),
(2, 'chlim@yahoo.ca', 'HairyPoppins', sha2(concat(email,username,'HairyPooping45',birthdate),256), 'DANIELA', 'GUZMÁN', DATE(FROM_UNIXTIME(RAND() * (63075600 - 978310800) + 1230796800)), date_add(date_add(now(), INTERVAL -1 YEAR), INTERVAL floor(rand()*(9999999-1)+1) SECOND)),
(2, 'rbarreira@icloud.com', 'YellowSnowman', sha2(concat(email,username,'StarWars64',birthdate),256), 'DIANA', 'LOPEZ', DATE(FROM_UNIXTIME(RAND() * (63075600 - 978310800) + 1230796800)), date_add(date_add(now(), INTERVAL -1 YEAR), INTERVAL floor(rand()*(9999999-1)+1) SECOND)),
(1, 'hedwig@att.net', 'OP_rah', sha2(concat(email,username,'NietoDeOprah69',birthdate),256), 'MAURICIO', 'NIETO', DATE(FROM_UNIXTIME(RAND() * (63075600 - 978310800) + 1230796800)), date_add(date_add(now(), INTERVAL -1 YEAR), INTERVAL floor(rand()*(9999999-1)+1) SECOND)),
(1, 'tnienow@mertz.com', 'tinfoilhat', sha2(concat(email,username,'HatOfTin21',birthdate),256), 'IVÁN', 'BURBANO', DATE(FROM_UNIXTIME(RAND() * (63075600 - 978310800) + 1230796800)), date_add(date_add(now(), INTERVAL -1 YEAR), INTERVAL floor(rand()*(9999999-1)+1) SECOND)),
(2, 'omayert@yahoo.com', 'HeartTicker', sha2(concat(email,username,'HeartBreakerN',birthdate),256), 'LAURA', 'RODRÍGUEZ', DATE(FROM_UNIXTIME(RAND() * (63075600 - 978310800) + 1230796800)), date_add(date_add(now(), INTERVAL -1 YEAR), INTERVAL floor(rand()*(9999999-1)+1) SECOND)),
(2, 'della.maggio@hotmail.com', 'PawneeGoddess', sha2(concat(email,username,'PawneeYehawwww44',birthdate),256), 'NATALIA', 'TORRES', DATE(FROM_UNIXTIME(RAND() * (63075600 - 978310800) + 1230796800)), date_add(date_add(now(), INTERVAL -1 YEAR), INTERVAL floor(rand()*(9999999-1)+1) SECOND)),
(2, 'burde.ziem@hotmail.com', 'banana_hammock', sha2(concat(email,username,'BANANATIME12',birthdate),256), 'MARGARITA', 'PEREZ', DATE(FROM_UNIXTIME(RAND() * (63075600 - 978310800) + 1230796800)), date_add(date_add(now(), INTERVAL -1 YEAR), INTERVAL floor(rand()*(9999999-1)+1) SECOND)),
(2, 'srempel@bogisich.com', 'fluffycookie', sha2(concat(email,username,'FluffyTime',birthdate),256), 'MÓNICA', 'GARZÓN', DATE(FROM_UNIXTIME(RAND() * (63075600 - 978310800) + 1230796800)), date_add(date_add(now(), INTERVAL -1 YEAR), INTERVAL floor(rand()*(9999999-1)+1) SECOND)),
(2, 'esta.parisian@hotmail.com', 'ManEatsPants', sha2(concat(email,username,'PANTSeatME543',birthdate),256), 'OLGA', 'ULLOA', DATE(FROM_UNIXTIME(RAND() * (63075600 - 978310800) + 1230796800)), date_add(date_add(now(), INTERVAL -1 YEAR), INTERVAL floor(rand()*(9999999-1)+1) SECOND)),
(2, 'goodwin@tromp.com', ' bigfootisreal', sha2(concat(email,username,'nolasaben',birthdate),256), 'LUISA', 'BELTRÁN', DATE(FROM_UNIXTIME(RAND() * (63075600 - 978310800) + 1230796800)), date_add(date_add(now(), INTERVAL -1 YEAR), INTERVAL floor(rand()*(9999999-1)+1) SECOND)),
(2, 'chapowife@gmail.com', 'MomsSpaghetti', sha2(concat(email,username,'drychopsuey4',birthdate),256), 'EMA', 'CORONEL', DATE(FROM_UNIXTIME(RAND() * (63075600 - 978310800) + 1230796800)), date_add(date_add(now(), INTERVAL -1 YEAR), INTERVAL floor(rand()*(9999999-1)+1) SECOND)),
(2, 'rhoeger@gmail.com', ' coolshirtbra', sha2(concat(email,username,'cocos6531',birthdate),256), 'YURI', 'SALAZAR', DATE(FROM_UNIXTIME(RAND() * (63075600 - 978310800) + 1230796800)), date_add(date_add(now(), INTERVAL -1 YEAR), INTERVAL floor(rand()*(9999999-1)+1) SECOND)),
(1, 'caroquintero@gmail.com', 'pixie_dust', sha2(concat(email,username,'_beansncheese',birthdate),256), 'RAFAEL', 'CARO', DATE(FROM_UNIXTIME(RAND() * (63075600 - 978310800) + 1230796800)), date_add(date_add(now(), INTERVAL -1 YEAR), INTERVAL floor(rand()*(9999999-1)+1) SECOND)),
(1, 'chapoguzman@gmail.com', 'Avocadorable', sha2(concat(email,username,'ElChapoMUSULOS1',birthdate),256), 'JOAQUIN', 'GUZMAN', DATE(FROM_UNIXTIME(RAND() * (63075600 - 978310800) + 1230796800)), date_add(date_add(now(), INTERVAL -1 YEAR), INTERVAL floor(rand()*(9999999-1)+1) SECOND)),
(1, 'saby78@bartoletti.com', 'FartinLutherKing', sha2(concat(email,username,'zoey101',birthdate),256), 'SEBASTIAN', 'VEGA', DATE(FROM_UNIXTIME(RAND() * (63075600 - 978310800) + 1230796800)), date_add(date_add(now(), INTERVAL -1 YEAR), INTERVAL floor(rand()*(9999999-1)+1) SECOND));

-- Se pueden utilizar los procedimientos de abajo
INSERT INTO wk_employees (userid, departmentid)
values (1,1), (2,2), (3,3), (4,4), (5,5), (6,6);

-- Datos para wk_clients
INSERT INTO wk_clients (userid, planid)
values (7,2), (8,2), (9,2), (10,2), (11,2), (12,1), (13,1), (14,1), (15,1), (16,1), (17,1), (18,1), (19,1);

-- ///////////////////////////////////////////////////////////////////////
-- Procedimiento para agregar nuevo user-empleado
DROP PROCEDURE IF EXISTS addEmployees;
delimiter //

CREATE PROCEDURE addEmployees(IN genderid TINYINT, IN emailn VARCHAR(250), IN username VARCHAR(20), 
IN password VARBINARY(250), IN firstname VARCHAR(45), IN lastname VARCHAR(45), 
IN birthdate DATE, IN registeredAt DATETIME, departmentid TINYINT)
BEGIN
	DECLARE id BIGINT;
    SET FOREIGN_KEY_CHECKS=0;
    
    -- Inserta datos para crear nuevo User
	INSERT INTO wk_users (genderid, email, username, password, firstname, lastname, birthdate, registeredAt)
    VALUES
    (genderid, emailn, username, password, firstname, lastname, birthdate, registeredAt);

    SET @id = LAST_INSERT_ID();
   
	-- Inserta datos para crear nuevo empleado
    INSERT INTO wk_employee(userid, departmentid)
    VALUES (@id, departmentid);

	SET FOREIGN_KEY_CHECKS=1;
END //
delimiter ;


-- Procedimiento para agregar nuevo user-cliente
DROP PROCEDURE IF EXISTS addClients;
delimiter %%

CREATE PROCEDURE addClients(IN genderid TINYINT, IN emailn VARCHAR(250), IN username VARCHAR(20), 
IN password VARBINARY(250), IN firstname VARCHAR(45), IN lastname VARCHAR(45), 
IN birthdate DATE, IN registeredAt DATETIME, planid INT)
BEGIN
	DECLARE id BIGINT;
    SET FOREIGN_KEY_CHECKS=0;
    
    -- Inserta datos para crear nuevo User
	INSERT INTO wk_users (genderid, email, username, password, firstname, lastname, birthdate, registeredAt)
    VALUES
    (genderid, emailn, username, password, firstname, lastname, birthdate, registeredAt);

    SET @id = LAST_INSERT_ID();
   
	-- Inserta datos para crear nuevo cliente
    INSERT INTO wk_clients(userid, planid)
    VALUES (@id, planid);

	SET FOREIGN_KEY_CHECKS=1;
END %%
delimiter ;

-- =========== LEER ==========
-- Ticket lo crea un Employee después de conversar con un cliente y el employee decidió 
-- que sí necesita un fix más profundo o algo por el estilo, entonces para crearlo ocuparía 
-- que los datos en chatSession y Messages tengan sentido con el ticket por crer. 
-- =========================

-- Datos para wk_tickets
INSERT INTO wk_tickets (`description`, `date`, ticketCategoryid, ticketStatusid, ticketPriorityid, clientid, employeeid)
VALUES ('Temporal description', current_timestamp(), 1, 2, 2, 9, 1);

-- ///////////////////////////////////////////////////////////////////////

-- Workouts
insert into wk_workouts(`name`, preset, creationDate)
values ('Full body, no equipment', 1, date(NOW())), 
('My First Workout', 0, date(date_add(NOW(), INTERVAL -floor(rand()*(9999-1)+1) SECOND)));

insert into wk_exercisesPerWorkout (workoutid, exerciseid, sets, reps, timeDuration)
values (1, 1, 4, 20, null), (1, 2, 4, 10, null), (1, 5, 2, 1, 35), (1, 7, 3, 10, null), (1, 10, 1, 1, '00:01:00'), (1, 11, 2, 30, null), (1, 12, 3, 15, null),
(2, 3, 3, 15, null), (2, 4, 3, 15, null), (2, 6, 3, 15, null), (2, 8, 4, 10, null), (2, 9, 2, 1, 30), (2, 7, 2, 10, null);

-- Workout Sessions & Exercise logs Examples
insert into wk_workoutSessions(workoutid, clientid, started, finished)
values (2, 1, NOW(), date_add(now(), interval 20 minute)),
(1, 6, date_add(now(), interval 2 day), date_add(date_add(now(), interval 2 day), interval 25 minute));

insert into wk_exercisesLogs(workoutSessionid, exercisePerWorkoutid, `timestamp`, setsLog, repsLog, timeDurationLog)
values (1, 8, NOW(), 3, 15, null), (1, 9, date_add(NOW(), interval 3 minute), 3, 15, null), (1, 10, date_add(NOW(), interval 6 minute), 3, 15, null), 
(1, 11, date_add(NOW(), interval 9 minute), 3, 15, null), (1, 12, date_add(NOW(), interval 13 minute), 2, 1, 30), 
(1, 13, date_add(NOW(), interval 17 minute), 2, 10, null), 
(2, 1, date_add(now(), interval 2 day), 4, 20, null), (2, 2, date_add(date_add(now(), interval 2 day), interval 3 minute), 4, 10, null),
(2, 3, date_add(date_add(now(), interval 2 day), interval 6 minute), 1, 5, 30),
(2, 4, date_add(date_add(now(), interval 2 day), interval 8 minute), 3, 10, null), 
(2, 5, date_add(date_add(now(), interval 2 day), interval 13 minute), 1, 1, '00:01:00'),
(2, 6, date_add(date_add(now(), interval 2 day), interval 15 minute), 2, 30, null),
(2, 7, date_add(date_add(now(), interval 2 day), interval 20 minute), 3, 15, null);

-- Tracking Example
insert into wk_tracking(clientid, height, weight, BMI, posttime, additionalNotes)
values (1, 1.70, 50.1, null, date(now()), 'Felt cute, might delete later.');

insert into wk_pictures(url)
values ('https://cdn.discordapp.com/attachments/606668298192551941/839756108796264458/Untitled-5-5cadf7746eccd__700.png');

insert into wk_picturesPerTracking(trackingid, pictureid)
values (1,1);

-- //////////////////// NEW

-- Es un historial, por lo que para inciar van como editados por "Managment" con id = 0
-- Los empleados de marketing y human resources no estan en contacto con la app, tampoco
-- hay empleados para el rol Coach
INSERT INTO wk_rolesPerEmployee (employeeid, roleid, editedby, editorid, lastupdate, 
`checksum`)
VALUES
(1, 1, 'Managment', 0, '2020-03-08 13:45:02', sha2(concat(employeeid,roleid,editedby,editorid,lastupdate),256)),
(2, 2, 'Managment', 0, '2020-03-08 13:45:03', sha2(concat(employeeid,roleid,editedby,editorid,lastupdate),256)),
(4, 4, 'Managment', 0, '2020-03-08 13:45:04', sha2(concat(employeeid,roleid,editedby,editorid,lastupdate),256)),
(6, 5, 'Managment', 0, '2020-03-08 13:45:05', sha2(concat(employeeid,roleid,editedby,editorid,lastupdate),256));


INSERT INTO wk_chatSessions (chatStatusid, clientid, employeeid, started)
VALUES
(4, 3, 2, '2021-01-03 11:10:44'),
(2, 1, 2, '2021-01-05 10:58:00'),
(1, 7, 2, '2021-01-06 12:01:32');


INSERT INTO wk_messages (chatSessionid, senderid, content, posttime)
VALUES
(1, 9, 'Buenos días, hoy intenté hacer el pago para convertirme en premium pero 
la app me está dando error.', '2021-01-03 11:10:44'),
(1, 2, 'Hola! Mi nombre es Alejandro, para servirle. ¿Me puede decir cuál es el 
error que le aparece?', '2021-01-03 11:12:03'),
(1, 9, 'Hola! Ya arregle el problema, fue que no había puesto la tarjeta xd. Muchas 
gracias!', '2021-01-03 11:13:38'),

(2, 7, 'Hola, me gustaria hablar con servisio al cliente, es que no se como hacer un 
workout', '2021-01-05 10:58:00'),
(2, 2, 'Hola! Mi nombre es Alejandro, para servirle. Para crear un workout, haga click 
en la opción "Crear Workout" en la sección de workouts.', '2021-01-05 11:00:46'),
(2, 7, 'gracias', '2021-01-05 13:08:51'),

(3, 13, 'Buenas, ayer ví un anuncio de la app en Instagram y decía que en los Workout 
van a sacar un work para los tobillos, eso es verdad? No lo encuentro, gracias.', 
'2021-01-06 12:01:32'),
(3, 2, 'Hola! Mi nombre es Alejandro, para servirle. En el anuncio decía que se buscan 
entrenadores para añadir en un futuro ejercicios para los tobillos.', '2021-01-06 13:01:20');

-- //////////////////// THIS 2 //////////////////////////////////////////////////////////////////////////////////////
-- Recurrence Types
INSERT INTO wk_recurrenceTypes (name, datepart, valuetoadd)
VALUES ('Weekly', 'DD', 7);

-- Workout Per Recurrence
 INSERT INTO wk_recurrencePerWorkouts (setTime, recurrenceTypeid, workoutid)
 VALUES ('15:00:00', 1, 1),
		('06:30:00', 1, 2);
        
-- Days Per Recurrence Per Workout
INSERT INTO wk_daysPerRecurrencePerWorkout(dayid, recurrencePerWorkoutid)
VALUES (2, 1), (4, 1), (6, 1),
	   (2, 2), (3, 2), (4, 2), (5, 2), (6, 2);


-- Datos para Merchants
INSERT INTO wk_merchants(name, url, enabled, iconUrl)
VALUES
('Paypal', 'https://www.paypal.com/', 1, 'https://www.paypalobjects.com/webstatic/mktg/logo/pp_cc_mark_37x23.jpg'),
('BAC', 'https://www.baccredomatic.com/', 1, 'https://www.baccredomatic.com/themes/custom/bac_theme/images/logo-small.png'),
('Banco Nacional', 'https://www.bncr.fi.cr/', 1, 'https://www.bncr.fi.cr/_themesdelivery/Banco-NacionalTheme/assets/images/logo.png');

-- Datos para paymentAttemps
INSERT INTO wk_paymentAttemps(clientid, paymentStatusid, merchantid, posttime, amount, currentSymbol, errorNumber, 
	merchantTransNumber, description, paymentTimeStamp, computerName, userName, ipAdress, checkSum)
VALUES
(1, 1, 1, NOW(), 5, '$', 0, 426895983, 'Payment Completed Succesfully.', NOW(), 'DeepThought', 
'saquille.oatmeal', '209.85.231.104', 82582695),
(2, 2, 2, NOW(), 5,'$', 0, 48494948, 'The transaction was declined due to insufficient funds.',
NOW(), 'Cerebro', 'HairyPoppins', '207.46.170.123', 47458455),
(3, 2, 3, NOW(), 5, '$', 0, 33658595, 'Your card was declined, in order to resolve the issue, please contact your bank,',
NOW(), 'Duotronics', 'cute.as.ducks', '66.220.149.25', 78955182),
(4, 2, 3, NOW(), 5, '$', 0, 2547965, 'Your credit card is expaired, please update your card.', 
NOW(), 'MCP', 'YellowSnowman', '208.80.152.2', 69774235),
(5, 4, 1, NOW(), 5, '%', 0, 1234895, 'Please check your internet connection and try again.',
NOW(), 'Rasputin', 'BadKarma', '72.247.244.88', 9412567); 

-- Estado adicional en paymentStatus
INSERT INTO wk_paymentStatus(name)
VALUES ('Communication Error');
