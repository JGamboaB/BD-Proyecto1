use MyWorkouts;

INSERT INTO wk_roles (roleid, `name`, description)
VALUES 
(1, 'Entrenador', 'Rol encargado de manejar los ejercicios pre cargados y responder
 consultas relacionadas a ejercicios.'),
(2, 'Servicio al Cliente', 'Rol encargado de asistir usuarios por chat.'),
(3, 'Contabilidad', 'Rol encargado de la supervisión del movimiento de dinero 
de la app.'),
(4, 'Gerente', 'Rol encargado del manejo y supervision general de la app, tiene 
todos los permisos.');

INSERT INTO wk_permissions (permissionid, moduleid, `name`, description, `code`, 
enabled, deleted)
VALUES 
(1, , 'Chat', 'Permiso para usar el chat.', 501, 1, 0),
(2, , 'Supervisar Chats', 'Permiso para revisar chats de usuarios.', 502, 1, 0),
(3, , 'Ejercicios Pre Cargados', 'Permiso para editar los ejercicios pre cargados.', 
503, 1, 0),
(4, , 'Transacciones', 'Permiso para ver transacciones de usuarios.', 504, 1, 0),
(5, , 'Bóveda', 'Permiso para revisar entradas y salidas de dinero de la app.', 
505, 1, 0),
(6, , 'Admin', 'Permiso para editar roles, permisos y cuentas de usuarios.', 506, 1, 0),
(7, , 'Dinero', 'Permiso para manejar el dinero de la app.', 507, 1, 0);

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
