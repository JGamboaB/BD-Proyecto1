-- Datos de wk_ticketCategories
INSERT INTO wk_ticketCategories (name)
VALUES
('Problema Tecnico'),
('Subscripcion'),
('Cuenta usuario'),
('Cancelacion');

-- Datos de wk_ticketStatus
INSERT INTO wk_ticketStatus (name)
VALUES
('Nuevo'),
('En progreso'),
('Pendiente'),
('Resuelto'),
('Cerrado');

-- Datos de wk_ticketPriorites
INSERT INTO wk_ticketPriorities (name)
VALUES
('Baja'),
('Normal'),
('Alta'),
('Grave');

-- Datos de wk_chatStatus
INSERT INTO wk_chatStatus (name)
VALUES
('En Linea'),
('Fuera'),
('Ocupado'),
('Desconectado');

-- Datos de wk_departments
INSERT INTO wk_departments (name)
VALUES
('Development'),
('Servicio al Clinte'),
('Marketing'),
('Financiero Contable'),
('Recursos Humanos'),
('Gerencia');