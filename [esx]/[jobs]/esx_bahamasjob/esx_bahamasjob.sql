SET @job_name = 'bahamas';
SET @society_name = 'society_bahamas';
SET @job_Name_Caps = 'bahamas';



INSERT INTO `addon_account` (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1),
  ('society_bahamas_fridge', 'nevera_bahamas', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    (@society_name, @job_Name_Caps, 1)
;

INSERT INTO `jobs` (name, label, whitelisted) VALUES
  (@job_name, @job_Name_Caps, 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  (@job_name, 0, 'barman', 'Camarero', 300, '{}', '{}'),
  (@job_name, 1, 'dancer', 'Gogo', 300, '{}', '{}'),
  (@job_name, 2, 'viceboss', 'Jefe de personal', 500, '{}', '{}'),
  (@job_name, 3, 'boss', 'Gerente', 600, '{}', '{}')
;

INSERT INTO `items` (`name`, `label`, `limit`) VALUES  
    ('jager', 'Jägermeister', 5),
    ('vodka', 'Vodka', 5),
    ('rhum', 'Ron', 5),
    ('whisky', 'Whisky', 5),
    ('tequila', 'Tequila', 5),
    ('martini', 'Martini blanco', 5),
    ('soda', 'Soda', 5),
    ('jusfruit', 'Zumo de frutas', 5),
    ('icetea', 'Te helado', 5),
    ('energy', 'Bebida energetica', 5),
    ('drpepper', 'Dr. Pepper', 5),
    ('limonade', 'Limonada', 5),
    ('bolcacahuetes', 'Bol de cacahuetes', 5),
    ('bolnoixcajou', 'Bol de anacardos', 5),
    ('bolpistache', 'Bol de pistachos', 5),
    ('bolchips', 'Bol de patatas fritas', 5),
    ('saucisson', 'Salchichon', 5),
    ('grapperaisin', 'Racimo de uvas', 5),
    ('jagerbomb', 'Jägerbomb', 5),
    ('golem', 'Golem', 5),
    ('whiskycoca', 'Whisky con cola', 5),
    ('vodkaenergy', 'Vodka con bebida energetica', 5),
    ('vodkafruit', 'Vodka con zumo de frutas', 5),
    ('rhumfruit', 'Ron con zumo de frutas', 5),
    ('teqpaf', "Chupito de tequila", 5),
    ('rhumcoca', 'Ron-cola', 5),
    ('mojito', 'Mojito', 5),
    ('ice', 'Hielo', 5),
    ('mixapero', 'Aperitivo frutos secos', 3),
    ('metreshooter', 'Chupito', 3),
    ('jagercerbere', 'Jäger Cerberus', 3),
    ('menthe', 'Menta', 10)
;
