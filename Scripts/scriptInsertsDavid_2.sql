-- Por ahora solo tenemos la app principal
INSERT INTO wk_applications (name, description)
VALUES
('My Workout', 'Main app aimed at common users where they can create and follow 
their own workouts.');


-- Module TEMPORAL para poder usar los permisos, CAMBIAR cuando se pueda
INSERT INTO wk_modules (`name`, applicationid)
VALUES ('Temporary', 1);


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

(1, 7, 'Hola, me gustaria hablar con servisio al cliente, es que no se como hacer un 
workout', '2021-01-05 10:58:00'),
(1, 2, 'Hola! Mi nombre es Alejandro, para servirle. Para crear un workout, haga click 
en la opción "Crear Workout" en la sección de workouts.', '2021-01-05 11:00:46'),
(1, 7, 'gracias', '2021-01-05 13:08:51'),

(1, 13, 'Buenas, ayer ví un anuncio de la app en Instagram y decía que en los Workout 
van a sacar un work para los tobillos, eso es verdad? No lo encuentro, gracias.', 
'2021-01-06 12:01:32'),
(1, 2, 'Hola! Mi nombre es Alejandro, para servirle. En el anuncio decía que se buscan 
entrenadores para añadir en un futuro ejercicios para los tobillos.', '2021-01-06 13:01:20');