use MyWorkouts;

insert into wk_categories(`name`, `description`)
values ('Endurance', 'Ability of a given muscle to exert force, consistently and repetitively, over a period of time.'),
('Strength', 'Focus on strength of a specific body part'),
('Hypertrophy', 'Increase and growth of muscle cells'),
('Cardio', 'Gets your heart rate up and keeps it up for a prolonged period of time.'); 

insert into wk_difficultyLevels(`name`)
values ('Beginner'), ('Intermediate'), ('Expert');

insert into wk_exerciseFocus(`name`)
values ('Biceps'), ('Triceps'), ('Lats'), ('Back'), ('Chest'), ('Legs'), ('Thighs'), ('Forearms'), ('Calves'), ('Deltoids'), ('Abs');

insert into wk_equipment(`name`,`description`,weight)
values ('Dumbbells','A normal dumbbell (shape can vary)', 15),
('Stationary Bike','Exercise bike', 0),
('Exercise Ball','Plastic ball made for exercising', 5),
('Jump Rope','Plastic rope made for exercising', 1),
('Kettlebell', 'Cast iron/steel ball with a handle attached.',15);

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

insert into wk_videos(url,deleted)
values ('https://thumbs.gfycat.com/RequiredThinAbalone-mobile.mp4',0),
('https://thumbs.gfycat.com/FittingIdenticalAtlanticspadefish-mobile.mp4',0),
('https://thumbs.gfycat.com/AdvancedBestChrysalis-mobile.mp4',0),
('https://thumbs.gfycat.com/CriminalMealyGar-mobile.mp4',0),
('https://thumbs.gfycat.com/ClutteredEcstaticFinnishspitz-mobile.mp4',0),
('https://youtu.be/bgYt7ZgFc9M',0),
('https://www.youtube.com/watch?v=-F-kADNt2Ik&feature=emb_rel_pause',0),
('https://hmg-h-cdn.hearstapps.com/videos/chest-press-side-1553016142.mp4',0),
('https://hmg-h-cdn.hearstapps.com/videos/rw-jess-1st-move-1579794350.mp4',0),
('https://www.youtube.com/watch?v=I-3r4cl4ahA&ab_channel=LivestrongWoman',0),
('https://youtu.be/9gDfNpzytLo',0),
('https://www.youtube.com/watch?v=QOCn3_iOAro&ab_channel=Northeastern',0);

insert into wk_videosPerExercise(videoid, exerciseid)
values (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,12);

insert into wk_pictures(url,deleted)
values ('https://julielohre.com/wp-content/uploads/2018/07/AlternatingLunges-1-1024x760.jpg',0),
('https://cdn.prod.openfit.com/uploads/2017/06/01150749/how-to-get-better-at-push-ups2.jpg',0),
('https://www.crossfit.com/wp-content/uploads/2019/04/03111458/Bent-Over-Row-Collage-1024x576.png',0),
('https://cdn.prod.openfit.com/uploads/2019/09/05175233/deadlift.jpg',0),
('https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F35%2F2020%2F02%2Flow-plank-hold.jpg',0),
('https://i.pinimg.com/originals/9d/89/b0/9d89b04811556ef4cc26c57aa496b509.png',0),
('https://hips.hearstapps.com/vidthumb/brightcove/57894083e694aa370d8834ff/thumb_1468612741.png',0),
('https://i0.wp.com/images-prod.healthline.com/hlcmsresource/images/topic_centers/Fitness-Exercise/400x400_7_Top_Chest_Exercises_for_Men_Chest_Press.gif?w=525',0),
('https://i.pinimg.com/originals/29/6e/fd/296efda0d27153eb5dccb4ff922bb1ca.jpg',0),
('https://i.pinimg.com/originals/3d/0f/0d/3d0f0d046b6c0d7f917e8c36743dc636.jpg',0),
('https://www.researchgate.net/profile/Mohammed-Abou-Elmagd/publication/341734848/figure/fig1/AS:896516470362114@1590757591713/Sample-of-Jumping-Jacks-Exercise-4.png',0),
('https://media1.popsugar-assets.com/files/thumbor/UjRu9n3XhNilWLRUd9G86CD0SNo/fit-in/2048xorig/filters:format_auto-!!-:strip_icc-!!-/2017/06/14/784/n/1922729/4b0aa10159417724bd23c1.78911403_Plank-Shoulder-Tap/i/Plank-Shoulder-Tap.jpg',0);

insert into wk_picturesPerExercise(pictureid, exerciseid)
values (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,12);