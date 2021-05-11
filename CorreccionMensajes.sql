-- Correccion del chat sessions de messages
-- Autor: Jose Acuña Carrera
-- Fecha: 11/05/21
USE MyWorkouts;

DELETE FROM wk_messages
WHERE chatSessionid = 1;

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