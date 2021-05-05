use MyWorkouts;

INSERT INTO wk_roles (roleid, `name`, description)
VALUES 
(1, 'Trainer', 'Role in charge of handling the preloaded exercises and answering 
queries related to exercises.'),
(2, 'Customer Service', 'Role in charge of assisting users by chat.'),
(3, 'Accounting', 'Role in charge of supervising the movement of money 
of the app.'),
(4, 'Manager', 'Role in charge of the management and general supervision of the app, has 
all permits.');


INSERT INTO wk_permissions (permissionid, moduleid, `name`, description, `code`, 
enabled, deleted)
VALUES 
(1, 1, 'Chat', '.', 501, 1, 0),
(2, 1, 'Supervisar Chats', 'Permission to use chat.', 502, 1, 0),
(3, 1, 'Preloaded Exercises', 'Permission to edit preloaded exercises.', 
503, 1, 0),
(4, 1, 'Transactions', 'Permission to view user transactions.', 504, 1, 0),
(5, 1, 'Vault', 'Permission to review money inflows and outflows from the app.', 
505, 1, 0),
(6, 1, 'Admin', 'Permission to edit roles, permissions, and user accounts.', 506, 1, 0),
(7, 1, 'Money', 'Permission to handle the money in the app.', 507, 1, 0);


-- Es un historial, por lo que para inciar van como editados por "Managment" con id = 0
-- Checksum se llena con stored procedures
INSERT INTO wk_permissonsPerRole (permissionid, roleid, editedby, editorid, enabled
lastupdate, `checksum`)
VALUES 
(1, 1, 'Managment', 0, 1, NOW(), ' '),
(3, 1, 'Managment', 0, 1, NOW(), ' '),
(1, 2, 'Managment', 0, 1, NOW(), ' '),
(4, 3, 'Managment', 0, 1, NOW(), ' '),
(5, 3, 'Managment', 0, 1, NOW(), ' '),
(1, 4, 'Managment', 0, 1, NOW(), ' '),
(2, 4, 'Managment', 0, 1, NOW(), ' '),
(3, 4, 'Managment', 0, 1, NOW(), ' '),
(4, 4, 'Managment', 0, 1, NOW(), ' '),
(5, 4, 'Managment', 0, 1, NOW(), ' '),
(6, 4, 'Managment', 0, 1, NOW(), ' '),
(7, 4, 'Managment', 0, 1, NOW(), ' ');


-- Module TEMPORAL para poder usar los permisos, CAMBIAR cuando se pueda
INSERT INTO wk_modules (moduleid, name, applicationid)
VALUES
(1, 'Temporary', 1);


-- Por ahora solo tenemos la app principal
INSERT INTO wk_applications (applicationid, name, description)
VALUES
(1, 'My Workout', 'Main app aimed at common users where they can create and follow 
their own workouts.');